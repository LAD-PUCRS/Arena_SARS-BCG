## 2-ModelComplexByArenaDispatcher

This step requires execution of a few manual procedures in order to enable the use of `ArenaDispatcher`.

**1. Ensure in_data is Available on Every Machine**

The directory created on the [previous step](../1-MHCPredictions-ModelHLA/README.md) and its data should be copied to all machines that will be used with `ArenaDispatcher`.

**2. Build Container Image**

A container image must also be built in every machine used with `ArenaDispatcher`. Do note that this build copies the `in_data` directory to the image, so it's important to follow each procedure in order. 

```sh
docker build . -t step2
```

**3. Dispatcher Configuration**

Each line of the file `dispatcher/hosts.cfg` represents a machine that can be used with `ArenaDispatcher`. The comma-separated values of every line are described in order as comments at the begining of the file. Every machine must have been setup with the docker installation script generated during the environment [setup](../Install/README.md). In addition, the machine that will run `ArenaDispatcher` should have the directory `certs`, also generated during the environment [setup](../Install/README.md).

After editing the `dispatcher/hosts.cfg` file, the execution can begin. In case a non-default execution is desired (for example, running less tasks just as a test), the `dispatcher/start.py` file can be edited according to its comments' descriptions.

**4. Run ArenaDispatcher**

We suggest the use of `nohup` to run ArenaDispatcher as decribed below.

```sh
# Access the ArenaDispatcher directory
cd dispatcher
# Start running
nohup python3 -u start.py &
```

After it begins, it will communicate with the Docker daemons of every machine described in `dispatcher/hosts.cfg`, coordinating the creation of containers for modelling all complexes in parallel. Whenever a container finishes it exports the modelled complexes along with log files and stores it on the machine running `ArenaDispatcher`. 

In case a problem occurs while running `ArenaDispatcher` (for example machine restarts), the user should begin the execution of `dispatcher/start.py` again. It should be capable of recovering the information of its previous execution without the need to start from the begining.

**Post Processing**

The process used to model the complexes is stochastic and some times it does not converge and the modelling process fails. We defined a limit of 5 errors to give up modelling a complex in the script `Model-pepHLA-APE_Gen-LAD.py`. If a complex cannot be modelled, it will try the next in line. Therefore, not every complex can be expected to be modelled. 

Advanced users might manage to filter a list of complexes from the data available at the `../in_data` directory and configure `ArenaDispatcher` to try again to model them, with even more than a 5 error limit. Another alternative, although we do not recommend doing so as it could continue to run indefinetely, is to remove the 5 error limit from the script `Model-pepHLA-APE_Gen-LAD.py`.

