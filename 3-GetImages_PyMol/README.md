## 3-GetImages_PyMol

The objective in this step is to generate the superfice data of every modelled complex from the [previous step](../2-ModelComplexByArenaDispatcher/README.md) molecule and save them as `PNG` files. The `speedup.sh` file can be ignored at this time, as it was used during development to observe the execution time required according to the number of processors available.

**1. Create the Output Directory**

```sh
mkdir output
```
**2. Install PyMol**

Install PyMol as described below

```sh
# Install dependencies
sudo apt-get install libgl1-mesa-glx
# Download PyMol files. If the link doesn't work, get it manually from pymol.org
wget "https://pymol.org/installers/PyMOL-2.4.1_198-Linux-x86_64-py37.tar.bz2"
# Decompress PyMol
tar -xjf PyMOL-2.4.1_198-Linux-x86_64-py37.tar.bz2
# Delete the remaining files
rm -rf  PyMOL-2.4.1_198-Linux-x86_64-py37.tar.bz2
```

You might want to add the PyMol executable binary to your `PATH`.

```sh
export PATH=$PWD/pymol/bin:$PATH
```

**3. Run PyMol**

The `run.sh` script starts a PyMol process using the pymol script `run.pml` and other files.

```sh
# Gives execution permission
chmod +x run.sh
```

The `run_parallel.sh` starts a number of `run.sh` processes. The processes do not interfere with each other, since they will skip processing any data (the complexes from the [previous step](../2-ModelComplexByArenaDispatcher/README.md)) that was already processed and exported as a `PNG`.

```sh
# Gives execution permission
chmod +x run_parallel.sh
# Run the script
nohup bash -c 'time ./run_parallel.sh' &> jobPymol_parallel.log &
```

Every script has variables defined according to the procedures described in this repository; hence, any directory or binary library path modification might also require editing these variables. 

An important observation regarding the files `mol-fit.pdb` and `run.pml` is that the latter is a script with a sequence of commands to run in PyMol. One of these commands `set_view` sets the position of the 3D molecule so that the important information can be properly exported as the resulting 2D `PNG` image. However, every `PDB` (complex description file from the [previous step](../2-ModelComplexByArenaDispatcher/README.md)) will be different when loaded in PyMol. In order to avoid manually setting every molecule different position with `set_view`, the `mol-fit.pdb` file is used with the command `extra_fit` to properly position every molecule. 

All of this is already included in the `run.pml` PyMol script, but modifications may be required in the `mol-fit.pdb` file and in the `set_view` parameters in case a different output is desired.