# Job Dispatcher

Using Docker's Python SDK, it connects to docker daemons (local or remote) in order to run containers and later obtain their output.


**Installation**
```sh
pip3 install docker
# Or pip, but it must reference python3
```

**Generate Certificates**

```sh
chmod +x gen_certs.sh
./gen_certs.sh
```

**Documentation Needed**
- Host Connectivity: After threshold it is considered DOWN
- get_job: Function which given lists of complete and running jobs, returns a new one (or None
- host configuration: Host file to configure
- Certificates: how to generate and use certs


**sample_app**

A really simple python application that fits our use-case. It receives a string argument, prints text with it on stdout and writes the string to a file. 




