import docker
import os
import time

import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)
# print("Reminder: Disabled Warnings")

# https://docs.docker.com/engine/api/sdk/examples/
# https://docker-py.readthedocs.io/en/stable/


# Instantiate a connection
# timeout (int) – Default timeout for API calls, in seconds.
# ssl_version (int) – A valid SSL version.
# assert_hostname (bool) – Verify the hostname of the server.
# environment (dict) – The environment to read environment variables from. Default: the value of os.environ
# credstore_env (dict) – Override environment variables when calling the credential store process.

# client = docker.from_env(timeout=5)

# client = docker.DockerClient(base_url='unix://var/run/docker.sock')


# for container in client.containers.list():
# 	print(help(container))

# get_archive(path, chunk_size=2097152, encode_stream=False)
# Retrieve a file or folder from the container in the form of a tar archive.
# https://docker-py.readthedocs.io/en/stable/containers.html


# Example: Dispatches 3 Containers and waits for all of them to complete their execution.

# def prepare_unsafe_host(address):
# 	client = docker.DockerClient(base_url='tcp://'+address+':2375')
# 	client.images.pull("alpine:latest") # Same as pull('alpine',tag='latest')
# 	return client
	


client_cert = "./client-cert.pem"
client_key = "./client-key.pem"

def connect_host(address,port="2375",cert=None,key=None):
	tls_config=None
	if cert != None and key != None:
		tls_config = docker.tls.TLSConfig(client_cert=(cert, key))
	if h == "127.0.0.1" or h == "localhost":
		return docker.DockerClient(base_url='unix://var/run/docker.sock',tls=tls_config)
	return docker.DockerClient(base_url='tcp://'+address+":"+port,tls=tls_config)

def prepare_host(host):
	return 0

def send_job():
	client.containers.run()
	# auto_remove=



hosts = ["127.0.0.1"]


# hosts = [{'address':'10.0.0.2','client':None}]



# Lifecycle:
# Run Job
# Wait for it to complete
# Export Logs
# Export Zip
# Delete container
# mark as complete





job_id = 0

if not os.path.exists('./output'):
    os.makedirs('./output')



for h in hosts:
	# h['client'] = prepare_safe_host(h['address'],client_cert,client_key)
	# print(h['client'])
	client = connect_host(h)
	# print(client.images.list())

	print("Create Container")
	container = client.containers.run("feliperubin/sample_app","python3 /app/job.py %d" % (job_id),detach=True,stdout=True,stderr=True)
	
	print("Wait to Finish Execution")
	while container.status != "exited":
		time.sleep(1)
		container.reload()
	
	print("Store Logs")
	with open('./output/job_%s_logs.txt' % (job_id),'w') as f:
			f.write(container.logs().decode('utf-8'))

	print("Downloading Data")
	bits, stat = container.get_archive("/app/output_%s.txt" % (job_id))
	with open('./output/job_%s_data.tar' % (job_id),'wb') as f:
		for chunk in bits:
			f.write(chunk)

	print("Deleting Container")
	container.remove()
	job_id+=1

# container.logs()

# complete = []
# incomplete = []
# for i in range(0,3):
# 	container = client.containers.run("alpine",["echo","container %d completed" % (i)],detach=True)
# 	incomplete.append(container)

# while len(incomplete) > 0:
# 	for container in incomplete:
# 		if client.containers.get(container.id).status == "exited":
# 			complete.append(container)
# 			incomplete.remove(container)
# 			print("Container %s Exited!" % (container.id))
# 			print("Incomplete List Length: ",len(incomplete))
# time.sleep(1)






# image

# image (str) – The image to run.
# command (str or list) – The command to run in the container.
# auto_remove (bool) – enable auto-removal of the container on daemon side when the container’s process exits.
# cpu_count (int) – Number of usable CPUs (Windows only).
# cpu_percent (int) – Usable percentage of the available CPUs (Windows only).
# cpu_period (int) – The length of a CPU period in microseconds.
# cpuset_cpus (str) – CPUs in which to allow execution (0-3, 0,1).
# cpuset_mems (str) – Memory nodes (MEMs) in which to allow execution (0-3, 0,1). Only effective on NUMA systems.
# detach (bool) – Run container in the background and return a Container object.
# device_cgroup_rules (list) – A list of cgroup rules to apply to the container.

# dns (list) – Set custom DNS servers.
# dns_opt (list) – Additional options to be added to the container’s resolv.conf file.
# dns_search (list) – DNS search domains.
# domainname (str or list) – Set custom DNS search domains.
# entrypoint (str or list) – The entrypoint for the container.
# environment (dict or list) – Environment variables to set inside the container, as a dictionary or a list of strings in the format ["SOMEVARIABLE=xxx"].
# healthcheck (dict) – Specify a test to perform to check that the container is healthy.
# hostname (str) – Optional hostname for the container.
# log_config (LogConfig) – Logging configuration.
# mac_address (str) – MAC address to assign to the container.
# mem_limit (int or str) – Memory limit. Accepts float values (which represent the memory limit of the created container in bytes) or a string with a units identification char (100000b, 1000k, 128m, 1g). If a string is specified without a units character, bytes are assumed as an intended unit.
# mem_reservation (int or str) – Memory soft limit.
# mem_swappiness (int) – Tune a container’s memory swappiness behavior. Accepts number between 0 and 100.
# memswap_limit (str or int) – Maximum amount of memory + swap a container is allowed to consume.
# name (str) – The name for this container.
# nano_cpus (int) – CPU quota in units of 1e-9 CPUs.
# remove (bool) – Remove the container when it has finished running. Default: False.
# stdout (bool) – Return logs from STDOUT when detach=False. Default: True.
# stderr (bool) – Return logs from STDERR when detach=False. Default: False.











