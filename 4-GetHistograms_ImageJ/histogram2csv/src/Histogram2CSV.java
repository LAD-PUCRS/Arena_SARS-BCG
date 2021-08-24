/*
 * About: (Bulk) Image Processing Histogram to CSV
 * Author: imunoCOVID
 * Contact: felipe.rubin@edu.pucrs.br
 */
import java.nio.file.FileSystems;
import java.io.File;
import ij.plugin.*;
import ij.plugin.frame.*;
import ij.*;
import ij.process.*;
import ij.measure.ResultsTable;

import java.util.List;
import java.util.ArrayList;
import java.util.LinkedList;

public class Histogram2CSV implements PlugIn {
    /*
    * header: Array specifying what data to get from the histogram
    * roimgr: A RoiManager with Roi data loaded
    * img: The target image
    * cprefix: Column Names for RGB Channels
    *
    * Given an Image and a Roi set, process it and return a results table
    */
    public ResultsTable processImage(String header[],RoiManager roimgr, ImagePlus img,String cprefix[]){
        ResultsTable rt = new ResultsTable();
        // Reference for the data to be collected from each Roi
        ImageStatistics st;
        // Iteration variables
        int i,j,k;
        // Results Table Header
        ColorProcessor cp = (ColorProcessor)img.getProcessor();
        // Table Generation
        for(i = 0; i < roimgr.getCount(); i++){
            // Select Roi i from the list
            img.setRoi(roimgr.getRoi(i));
            // Add new Row to the table
            rt.incrementCounter();
            // Add Roi name at first column
            rt.addValue("Roi",roimgr.getName(i));
            for(j = 0; j < 3; j++){
                // Enable RGB channels accordingly
                if(j == 0) cp.setRGBWeights(1,0,0);
                else if(j == 1) cp.setRGBWeights(0,1,0);
                else cp.setRGBWeights(0,0,1);
                // Get Statistics (Histogram)
                st = img.getStatistics();
                // Add relevant information to the table
                for (k = 0; k < header.length;k++){
                    switch(header[k]){
                        case "area":rt.addValue(cprefix[j]+"area",st.area);break;
                        case "min":rt.addValue(cprefix[j]+"min",st.min);break;
                        case "max":rt.addValue(cprefix[j]+"max",st.max);break;
                        case "mean":rt.addValue(cprefix[j]+"mean",st.mean);break;
                        case "stdDev":rt.addValue(cprefix[j]+"stdDev",st.stdDev);break;
                    }
                }
            }
        }  
        return rt;
    }
    /*
    * path: A file path
    *
    * Given a path for a file, verify if the file format is supported
    */
    public boolean supportedImgFormat(String path){
        String parts[] = path.split("\\.");
        if (parts.length == 0) return false;
        String fileFormat = parts[parts.length-1].toLowerCase();        
        return fileFormat.equals("tiff") || fileFormat.equals("tiff") 
        || fileFormat.equals("gif") || fileFormat.equals("jpeg")
        || fileFormat.equals("png") || fileFormat.equals("dicom")
        || fileFormat.equals("bmp") || fileFormat.equals("pgm");        
    }

    /*
    * currentDir: Either a file path or a directory path
    *
    * Given a path, recursively return a list containing itself or all files within
    */
    public List<String> recursiveWalk(String currentDir){
        // FileSystems.getDefault().getPath(args[i]).normalize().toAbsolutePath().toString();
        String aux;
        File file = new File(currentDir);
        List<String> fp = new LinkedList<>();
        if(file.isFile()){
            if(this.supportedImgFormat(currentDir)) fp.add(currentDir);
        }else{
            for (String s : file.list()){
                aux = currentDir+"/"+s;
                File fileAux = new File(aux);
                if(fileAux.isFile() && this.supportedImgFormat(aux)) fp.add(aux);
                else fp.addAll(recursiveWalk(aux));
            }
        }
        return fp;
    }
    /*
    * InteractiveMode arg: Depends on ImageJ implementation
    * ScriptMode arg: Multiple arguments concatenated with newlines
    *
    * Required for ImageJ Plugins 
    */
    public void run(String arg) {
        // True if interactiveMode, otherwise false
        boolean interactiveMode = IJ.getInstance() != null || arg == "";
        // Where to store the file
        String savePath = "";
        // Roi Manager (used to load Roi Set)
        RoiManager roimgr = RoiManager.getInstance();
        // Show how to export to CSV tip
        boolean showExportTip = false;
        // A reference to the loaded image
        ImagePlus img = null;
        // Headers for the Results Table
        String header[] = new String[]{"area","min","max","mean","stdDev"};
        // ResultsTable
        ResultsTable rt;
        // Color Prefix for the column name
        String cprefix[]= new String[]{"R","G","B"};
        // Path to roi.zip
        String roiFile = null;
        // Path to image(s)
        List<String> imgFiles = new LinkedList<>();
        // File object to verify if paths are correct
        File file;
        if (roimgr == null){
            // roimgr = RoiManager.getInstance2();
            if(interactiveMode) roimgr = new RoiManager();
            else roimgr = new RoiManager(false);
        }
        // If running in interactive mode
		if (interactiveMode){
            // IF there's no image, ask to open it
            try{
                img = IJ.getImage();
                imgFiles.add(IJ.getDirectory("image")+"/"+img.getTitle());
            }catch(RuntimeException e){
                String imgFileName = IJ.getFilePath("Select the PNG File");
                if(imgFileName == null) return;
                imgFiles.add(imgFileName);
            }

            // If there's no Roi, ask to open it
            if(roimgr.getCount() == 0){
                IJ.showMessage("No Available Roi");
    			// Open ROI File
    			roiFile = IJ.getFilePath("Select the ROI File");
    			if (roiFile == null) return;   
                // roimgr.runCommand(img,"Show All with labels");
            }
        }else{
            String args[] = arg.split("\n");
            roiFile = args[0];
            // Last image index of all args, last arg might be output dir
            int lastImg = args.length-2;
            // Use last arg if path, otherwise current path to store output
            savePath = args[args.length-1];
            if (!(new File(savePath)).isDirectory()){
                // Use local running path instead
                savePath = System.getProperty("user.dir"); 
                // Update last index, since last arg is not output dir
                lastImg = args.length-2;
            }
            // For each argument, add the image or recursively add images
            for(int i = 1; i <= lastImg; i++){
                if ( (new File(args[i])).isFile()){
                    imgFiles.add(args[i]);
                }else{
                    List<String> s = recursiveWalk(args[i]);
                    imgFiles.addAll(s);
                }
            }            
        }
        // Open Roi zip
        if (roimgr.getCount() == 0) roimgr.runCommand("Open",roiFile);
        // For each Image
        for(String imgFile : imgFiles){
            System.out.println("Processing "+imgFile);
            // Load Image
            if(img == null){
                try{
                    IJ.open(imgFile);
                }catch(Exception e){
                    continue;
                }
            }
            // Get Image Reference
            img = IJ.getImage();
            // Mark all Regions of interest at the image
            if(interactiveMode) roimgr.runCommand(img,"Show All with labels");
            // Ensure img RGB 0-255
            img.setDefault16bitRange(8);
            // Start Processing
            rt = processImage(header,roimgr,img,cprefix);
            // If running in interactive mode, show results
            if (interactiveMode){
                // Show Results Table
                rt.show(img.getShortTitle()+" RGB Histogram");
                // If enabled, export tip for the table
                if(showExportTip) IJ.showMessage("Histogram generated successfully.\n"+
                        "Export: File > Save As...");
            }else{
                System.out.println("Saving results...");
                System.out.println("Saving at: "+savePath+"/"+img.getShortTitle()+".csv");
                try{
                    rt.saveAs(savePath+"/"+img.getShortTitle()+".csv");
                    System.out.println("Stored results at "+savePath+"/"+img.getShortTitle()+".csv");
                }catch(Exception e){
                    System.out.println("Fatal Error: "+e.getMessage());
                    System.exit(1);
                }
            }
            if(!interactiveMode) img.close();
            img = null;
        }
        if(!interactiveMode) System.exit(0);
	}
    
    public static void main(String args[]){
        // System.out.println(">Headless Mode");
        Histogram2CSV h = new Histogram2CSV();
        if(args.length < 2){
            System.out.println("Usage: java Histogram2CSV roi.zip img.png\n"+
                "Note: Ensure that full path is passed on");
            System.exit(0);
        }
        String argstr="";
        for(int i = 0; i < args.length; i++){
            argstr+=FileSystems.getDefault().getPath(args[i]).normalize().toAbsolutePath().toString();
            if(i+1 < args.length) argstr+="\n";
        }
        // System.gc();
        h.run(argstr);
    }
}












