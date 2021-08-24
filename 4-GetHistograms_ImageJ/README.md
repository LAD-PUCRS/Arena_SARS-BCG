## 4-GetHistograms_ImageJ

This step involves the use of ImageJ to extract the histogram data of complexes' superfices. We developed a plugin [historam2csv](histogram2csv/README.md) which can be run either using a shell or from ImageJ UI menu, allowing multiple PNGs to be processed at once and storing their histogram information into CSVs.


**1. Create an Output Directory**

Create an output directory which will store a corresponding `CSV` for each complex `PNG` obtained from the [PyMol step](../3-GetImages_PyMol/README.md).

```sh
mkdir output
```

**2. Run ImageJ Standalone JAR**

To run this JAR, we recommend at least Java `v1.8`.

```sh
java -jar histogram2csv/Histogram_2_CSV.jar RoiSet_46diag.zip ../3-GetImages_PyMol/output output
```

Alternatively, if there is any problem related to java, you may want to install `xvfb` and run it using the method below with `nohup`.

```sh
# install xvfb
sudo apt-get install xvfb
# Give permission
chmod +x run.sh
# Run it using
nohup bash -c 'time ./run.sh' &> imagej_plugin.log &
```

More information on how to build and run the plugin is available on [histogram2csv/README.md](histogram2csv/README.md).