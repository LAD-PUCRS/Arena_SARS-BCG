# Author: Felipe Pfeifer Rubin
# Contact: felipe.rubin@edu.pucrs.br
# About: Use Docker API to remotely connect to docker daemons and dispatch jobs.
import docker
import os
import time
import sys
import urllib3
import math
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

# Given a container, return the time it took to execute it.
def elapsed_time(container):
	if container.status != 'exited':
		return None
	t0 = time.strptime(container.attrs['State']['StartedAt'][:-1].split('.')[0],'%Y-%m-%dT%H:%M:%S')
	t1 = time.strptime(container.attrs['State']['FinishedAt'][:-1].split('.')[0],'%Y-%m-%dT%H:%M:%S')
	return time.strftime("%H:%M:%S",time.gmtime(time.mktime(t1)-time.mktime(t0)))

# Connects to a local or remote docker daemon.
# Returns either the client object or None
def connect_host(host,timeout=30,debug=False):
	host['client'] = None
	tls_config=None
	base_url='tcp://'+host['address']+":"+host['port']
	try:
		if host['cert'] != None and host['key'] != None:
			tls_config = docker.tls.TLSConfig(client_cert=(host['cert'], host['key']))
		if host['address'] == "127.0.0.1" or host['address'] == "localhost":
			base_url='unix://var/run/docker.sock'
		host['client'] = docker.DockerClient(base_url=base_url,tls=tls_config,timeout=timeout)
		# Grab information
		if host['cpu'] == 0:
			host['cpu'] = host['client'].info()['NCPU']
		if host['ram'] == 0:
			host['ram'] = int(host['client'].info()['MemTotal']/1000000)
	except Exception as e:
		print("Failed to connect to host",host['address'])
		if debug:
			print(e)
	return host['client'] is not None

# Verify if host is UP
def is_alive(host):
	try:
		host['client'].ping()
	# except docker.errors.APIError:
	except Exception as e:
		host['client'] = None
		# print("Trying to reconnect to",host['address'])
	return host['client'] is not None

# Download all required images
def prepare_host(host,images,auth=None):
	# print("Pulling images for Host",host['address'])
	# docker.errors.APIError
	pass
	'''
	try:
		for image in images:
			host['client'].images.pull(image,auth_config=auth)
	except docker.errors.ImageNotFound:
		print("Failed pulling image %s for host %s: Image Not Found")
		raise
	'''

# docker.errors.NotFound – If the container does not exist
# docker.errors.APIError – If the server returns an error.

# Sends (dispatches) a job
def send_job(host,job):
	print("Created container for job",job['id'])
	mem_limit = 0
	args = job['args']
	if job['ram'] > 0:
		mem_limit=str(job['ram'])+'m'
	return host['client'].containers.run(image=job['image'],command=args,labels={
		'logs':str(job['logs']),'archive':str(job['archive']),'job-id':job['id']},
		nano_cpus=job['cpu']*10**9,mem_limit=mem_limit,detach=True,stdout=True,stderr=True)

# Save Jobs
# REDO TRY CATCH TO DOCKER ERRORS VS OS ERRORS
def save_job(host,job):
	# download the logs
	# download the output
	# save the total time of execution
	# write it to jobs.cfg
	# delete the container
	# remove it from the list of running jobs
	# Careful here: If it downloads logs, crashes, then tries to download again
	# it might give an error
	ok = True
	log_path='False'
	archive_path='None'
	try:
		if job['logs'] == 'True':
			log_path='./output/'+job['id']+'.log'
			print('Saving job',job['id'],'logs')
			with open(log_path,'w') as f:
					f.write(job['container'].logs().decode('utf-8'))
		
		if job['archive'] != 'None':
			print('Saving job',job['id'],'data')
			archive_path='./output/'+job['id']+'.tar'
			bits, stat = job['container'].get_archive(job['archive'])
			with open(archive_path,'wb') as f:
				for chunk in bits:
					f.write(chunk)
		
		with open("./output/completed.txt",'a+') as f:
				f.write('%s,%s,%s,%s,%s,%s,%s,%s,%s\n' % (
					job['id'],
					job['image'],
					job['args'],
					job['cpu'],
					job['ram'],
					host['address'],
					elapsed_time(job['container']),
					log_path,
					archive_path
					))
	except Exception as e:
		print("Could not retrieve or save job",job['id'],'from host',host['address'])
		print(e)
		ok = False
	return ok


######### LOAD HOSTS SPEC AND JOBS SNAPSHOT (Stores completed jobs)

# Load Completed Jobs
# config: A file (which may not exist yet) with the completed jobs data
def load_jobs():
	completed = set()
	# Create output directory if it does not exist
	if not os.path.exists('./output'):
		os.makedirs('./output')
	# If still doesnt exist, create an example
	if not os.path.exists('./output/completed.txt'):
		with open('./output/completed.txt','w') as f:
			f.writelines(
				["#job-id: unique job identifier\n",
				"#image: The container image\n",
				"#args: Arguments used\n",
				"#cpu: Number of vCPUs\n",
				"#ram: Memory in MB\n",
				"#host: which one hosted this job\n",
				"#duration: time it took to run it\n",
				"#logs: Path or nothing\n",
				"#archive: Path or nothing\n"])
	else:
		with open('./output/completed.txt','r') as f:
			for line in f.read().splitlines():
				if line[0] != '#':
					completed.add(line.split(',')[0])
	return completed

# Load a file with information on the docker hosts.
# config: A file containing the hosts configurations
def load_hosts(config):
	hosts = []
	with open(config,'r') as f:
		for line in f.read().splitlines():
			# Skip comment
			if line[0] != '#':
				parts = line.split(',')
				if len(parts) == 4:
					hosts.append({'address':parts[0],
						'port':parts[1],'cpu':int(parts[2]),'ram':int(parts[3]),
						'cert':None,'key':None,
						'client':None,'jobs':[],'noanswer':0,
						'conntry':0.0,'state':'down'})
				elif len(parts) == 6:
					hosts.append({'address':parts[0],
						'port':parts[1],'cpu':int(parts[2]),'ram':int(parts[3]),
						'cert':parts[4],'key':parts[5],
						'client':None,'jobs':[],'noanswer':0,
						'conntry':0.0,'state':'down'})
				else:
					print("Failed to interprete line: ",line)
					exit(0)
	return hosts

# Verify if host has enough resources to run container
def job_fits(host,job):
	# If no specified requirement was specified
	if job['cpu'] == 0 and job['ram'] == 0:
		return True
	else:
		if job['cpu'] > max(0,host['cpu'] - sum([j['cpu'] for j in host['jobs']])):
			# print('Host',host['address'],'does not fit CPU needs of Job',job['id'])
			# print('CPUxRAM: Job(%s,%s) Host(%s,%s)'%(job['cpu'],job['ram'],host['cpu'],host['ram']))
			return False
		if job['ram'] > max(0,host['ram'] - sum([j['ram'] for j in host['jobs']])):
			# print('Host',host['address'],'does not fit RAM needs of Job',job['id'])
			# print('CPUxRAM: Job(%s,%s) Host(%s,%s)'%(job['cpu'],job['ram'],host['cpu'],host['ram']))
			return False
	return True


# def container_job(container):
# 	args_str=container.attrs['Path']
# 	if len(args_str) > 0:
# 		args_str+=' '
# 	job = {
# 	'id':container.labels['job-id'],
# 	'image':container.attrs['Config']['Image'],
# 	'args':args_str+' '.join(container.attrs['Args']),
# 	'cpu':round(int(container.attrs['HostConfig']['NanoCpus'])/1000000000),
# 	'ram':math.ceil(int(container.attrs['HostConfig']['Memory'])/1000000),
# 	'logs':container.labels['logs'],
# 	'archive':container.labels['archive'],
# 	'container':container}
# 	return job

# Creates a job structure from a given container
def container_job(container):
	args_str=container.attrs['Path']
	job = {
	'id':container.labels['job-id'],
	'image':container.attrs['Config']['Image'],
	'args':' '.join(container.attrs['Config']['Cmd']),
	'cpu':round(int(container.attrs['HostConfig']['NanoCpus'])/1000000000),
	'ram':math.ceil(int(container.attrs['HostConfig']['Memory'])/1000000),
	'logs':container.labels['logs'],
	'archive':container.labels['archive'],
	'container':container}
	return job



def fetch_jobs(host,completed,running):
	containers = host['client'].containers.list(all=True,filters={'label':"job-id"})
	host['jobs'] = []
	for container in containers:
		job = container_job(container)
		job['container'] = container
		if job['id'] in completed or job['id'] in running:
			try:
				job['container'].remove(force=True)
				print('Removed invalid job',job['id'])
			except docker.errors.APIError:
				print('Could not remove host',host['address'],'job',job['id'],'please remove it manualy')
				raise
		else:
			host['jobs'].append(job)
			running.add(job['id'])
			print('Found Job',job['id'],'at Host',host['address'])


def purge_jobs(host):
	containers = host['client'].containers.list(all=True,filters={'label':"job-id"})
	host['jobs'] = []
	for container in containers:
		try:
			container.remove(force=True)
		except docker.errors.APIError:
			print('Could not remove host',host['address'],'job',container.labels['job-id'],'please remove it manualy')
			raise

# Start Dispatcher execution
# [ARGS]
# config: hosts.cfg file path
# images: docker images to download on each host
# next_job: Function that returns new job with unique id
# sleep_time: Wait between iterations
# conn_timeout: Timeout for connecting to a host
# conn_wait: Time (s) to wait before trying to connect to a host that is down
# reconn_wait: Time (s) to wait before trying to connect to a host that is unknown
# [STATE MACHINE]
# up: Host is connected
# unknown: Host might be alive, but during the last iteration wasn't alive
# down: Host is not connected, if there were jobs they must be migrated
def start_dispatcher(config,images,next_job,sleep_time=3,conn_timeout=30,conn_wait=300,reconn_wait=60,dockerhub_user=None,dockerhub_pass=None,debug=False):
	dockerhub_credentials = None
	if dockerhub_user is not None and dockerhub_pass is not None:
		dockerhub_credentials = {'username':dockerhub_user,'password':dockerhub_pass}

	hosts = load_hosts(config) # Load hosts configuration
	completed = load_jobs() # # Load completed jobs [job-id]
	running = set() # Running on any host [job-id]
	pending = [] # # Dispatch again since original host is DOWN [job object]

	print("Setting up Hosts")
	for host in hosts:
		print("Conneting to host",host['address'])
		if connect_host(host,timeout=conn_timeout,debug=debug):
			try:
				print("Pulling images",images)
				prepare_host(host,images,dockerhub_credentials)
				print("Fetching completed jobs")
				fetch_jobs(host,completed,running)
				host['state'] = 'up'
			except:
				host['state'] = 'down'
		if host['state'] == 'down':
			host['conntry'] = time.time()+conn_wait
		print("Host",host['address'],'is',host['state'])

	changed = True # There is still jobs to dispatch or to wait for
	new_job = next_job(completed,running)
	# Does not need to check if all jobs were successfully executed
	if new_job is None and len(running) == 0:
		return

	print("Dispatcher has started")
	while changed:
		changed = False
		for host in hosts:
			# State Machine for Host Behaviour
			if host['state'] == 'up':
				if not is_alive(host):
					host['state'] = 'unknown'
					host['conntry'] = time.time()+reconn_wait
					print("Host",host['address'],'is',host['state'])
			elif host['state'] == 'unknown'and time.time() > host['conntry']:
				if connect_host(host,timeout=conn_timeout,debug=debug):
					host['state'] = 'up'
					print("Host",host['address'],'is',host['state'])
				else:
					pending.extend(host['jobs'])
					host['state'] = 'down'
					host['conntry'] = time.time()+conn_wait
					print("Host",host['address'],'is',host['state'])
			elif host['state'] == 'down' and time.time() > host['conntry']:
				if connect_host(host,timeout=conn_timeout,debug=debug):
					try:
						purge_jobs(host)
						prepare_host(host,images,dockerhub_credentials)
						host['state'] = 'up'
						print("Host",host['address'],'is',host['state'])
					except:
						host['conntry'] = time.time()+conn_wait
				else:
					host['conntry'] = time.time()+conn_wait
			
			# if host['state'] != 'up':
			# 	continue
			# Now the main program
			i = 0 # To iterate
			while host['state'] == 'up' and i < len(host['jobs']):
				job = host['jobs'][i]
				# Update container information
				try:
					job['container'].reload()
				except docker.errors.APIError:
					# Maybe some bug/manual change occured
					# A scenario of this happening is:
					# host was unknown for a few moments and somehow
					# containers were deleted
					if is_alive(host):
						job['container'] = None
						pending.append(host['jobs'].pop(i))
					else:
						host['state'] = 'unknown'
						host['conntry'] = time.time()+reconn_wait

				# IF FINISHED: save and delete
				if host['state'] == 'up' and job['container'].status == 'exited' and job['container'].attrs['State']['ExitCode'] == 0:
					print("Job",job['id'],'has finished')
					if save_job(host,job):
						try:
							job['container'].remove(force=True)
						except docker.errors.APIError:
							# Maybe some bug/manual change occured
							if not is_alive(host):
								host['state'] = 'unknown'
								host['conntry'] = time.time()+reconn_wait
								# NOTE: RUN INTEGRITY CHECK
						finally:
							# container is no more, but job was executed							
							host['jobs'].pop(i)
							i=-1 #Remove while iterating
							running.remove(job['id'])
							completed.add(job['id'])
					else:
						#####  IMPLEMENT ME !!!!!!!!!!!!
						print("Could not save job",job['id'])
				
				# IF FAILED: add to pending for reschedule
				elif job['container'].status in ('paused','exited','restarting'):
					try:
						job['container'].remove(force=True)
						job['container'] = None
						pending.insert(0,host['jobs'].pop(i))
						i=-1
					except docker.errors.APIError:
						if not is_alive(host):
							host['state'] = 'unknown'
							host['conntry'] = time.time()+reconn_wait
					print('Job %s failed, added to pending:',job)
				# IF RUNNING: then will check on it later
				else:
					# print('Job',job['id'],'still running at Host',host['address'])
					changed=True # Running/Created
				i+=1 # Increment
			
			####### FROM HERE ON THERE MIGHT STILL BE A NEED FOR ADDING TRY EXCEPT
			# Dispatch Pending Job
			pending_i = 0
			while host['state'] == 'up' and pending_i < len(pending):
				if job_fits(host,pending[pending_i]):
					job = pending[pending_i]
					try:
						job['container'] = send_job(host,job)
						host['jobs'].append(job)
						# note: it already is in the running list
						pending.pop(pending_i)
						changed = True
						print('Dispatched pending job',job['id'],'to host',host['address'])
						pending_i-=1						
					except docker.errors.ImageNotFound:
						print('Could not find image',job['image'],'for job',job['id'],'at host',host['address'])
						raise
					except docker.errors.APIError:
						if not is_alive(host):
							host['state'] = 'unknown'
							host['conntry'] = time.time()+reconn_wait
						else:
							print('An error occurred when trying to run job',job['id'],'at host',host['address'])
							raise
				pending_i+=1
			
			# Dispatch Next Job
			while host['state'] == 'up' and new_job is not None and job_fits(host,new_job):
				# Enforce new_job must have unique id for not running twice
				if new_job['id'] in completed or new_job['id'] in running:
					new_job = next_job(completed,running)
				else:
					try:
						new_job['container'] = send_job(host,new_job)
						host['jobs'].append(new_job)
						running.add(new_job['id'])
						print('Dispatched new job',new_job['id'],'to host',host['address'])
						new_job=next_job(completed,running)
						changed = True

					except docker.errors.ImageNotFound:
						print('Could not find image',job['image'],'for job',job['id'],'at host',host['address'])
						raise
					except docker.errors.APIError:
						if not is_alive(host):
							host['state'] = 'unknown'
							host['conntry'] = time.time()+reconn_wait
						else:
							print('An error occurred when trying to run job',job['id'],'at host',host['address'])
							raise
			# Last check
			if len(pending) > 0 or new_job is not None:
				changed = True

		# Using if here to avoid any possible unknown behaviour
		if sleep_time > 0:
			time.sleep(sleep_time)


######################################## IMUNO COVID Specific starts here

#### THIS IS JUST AN EXAMPLE OF A get_job function
# Get the 'next' job given set of id's of jobs either completed and running
def example_next_job(completed,running=[]):	
	job_number=0
	stop_at_job=11
	while job_number < stop_at_job:
		job_number+=1
		job = {
		'id':'example_next_job-%s'%(job_number),
		'image':'feliperubin/sample_app',
		'args':'python3 /app/job.py %d'%(job_number),
		'cpu':2,
		'ram':2048,
		'logs':'True',
		'archive':'/app/output_%s.txt'%(job_number),
		'container':None}
		if job['id'] not in completed and job['id'] not in running:
			return job
	return None

def main():
	start_dispatcher(config='hosts.cfg',
		images=['feliperubin/sample_app:latest'],
		next_job=example_next_job,
		conn_wait=15,
		reconn_wait=10,
		dockerhub_user=None,
		dockerhub_pass=None)
	print("####################")
	print("Dispatcher Ended. All Jobs were executed.\nOutput At: ./output/")
	

if __name__ == "__main__":
	main()

