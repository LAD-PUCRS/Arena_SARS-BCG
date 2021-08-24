# Histogram 2 CSV Plugin

Building the Plugin

```sh
cd histogram2csv
bash build.sh
```

Standalone Scripted Execution 

```sh
java -jar Histogram_2_CSV.jar <roi.zip> <imgdir> <img.png> <imgdir-2> <optional-output-dir>
```

Running on Ubuntu Server (Since there's no display)

```sh
sudo apt install -y xvfb
xvfb-run java -jar Histogram_2_CSV.jar <roi.zip> <imgdir> <img.png> <imgdir-2> <optional-output-dir>
```

Running background processing all files on Ubuntu Server (Since there's no display)
```sh
sudo apt install -y xvfb
nohup bash -c 'time ./run.sh' &> imagej_plugin.log &
```


**Notes on Scripted Mode**

- All output is in the format of original_name.csv

- When passing a directory, a pre-processing step is done which recursively discovers files in the given directory and subdirectories aswell.

- If a directory is passed as an argument for source images, only files with an image format supported by ImageJ will be considered. If one file fails, the execution halts due to ImageJ exception treatment.

- Para execução em background é necessário revisar variáveis do script run.sh

- O roiset neste repositório foi criado manualmente dentro do ImageJ depois exportado para o arquivo zip. Talvez seja necessário uma revisão do mesmo.




