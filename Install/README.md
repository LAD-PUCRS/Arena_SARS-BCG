## Environment Setup 

The following setup is required for executing several steps following our methodology.

**1. Certificate Generation**

Begin the environment setup as follows.

```sh
# Give permission to execute the script
chmod +x gen_certs.sh 
# Run the script
./gen_certs.sh
```

The execution of `gen_certs.sh` will generate certificates and store them in a new directory (`certs`). These certificates are used to setup Docker to allow the management of containers from remote hosts (a requirement of `ArenaDispatcher`).

In addition to the generation of certificates, an installation script for docker, `install_docker.sh`, will also be generated with certificates embedded on it. 

**2. Docker Setup**

In order to use `ArenaDispatcher`, some additonal configuration are required during the installation of Docker. Therefore, the script `install_docker.sh` (generated previously) should be copied and executed on every machine that will be used by `ArenaDispatcher`.

To install it on every machine, do the following:

```sh
# Give permission to execute the script
chmod +x install_docker.sh
# Or run with sudo, permission required for installing packages
sudo ./install_docker.sh 
```