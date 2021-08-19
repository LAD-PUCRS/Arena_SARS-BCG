import dispatcher
import os
#### THIS IS JUST AN EXAMPLE OF A get_job function
# Get the 'next' job given set of id's of jobs either completed and running


curr_peptide = 1
grannularity = 100
stop_at_peptide = 400000
def process_peptides(completed,running=[]):
	global curr_peptide
	global grannularity
	global stop_at_peptide
	if curr_peptide >= stop_at_peptide:
		return None
	start = curr_peptide
	stop = curr_peptide+grannularity-1
	curr_peptide = stop+1
	job = {
	'id':'job_%s-%s'%(start,stop), # ID
	'image':'step2', # Image
	'args':'%d %d'%(start,stop),
	'cpu':6, # Requires 6 vCPU and decrements available cpus
	'ram':0, # No limitation
	'logs':'True',
	'archive':'/imunocovid/selected_structures',
	'container':None}
	# Optional, since dispatcher force-check if the 
	# job has already been executed before dispatching it
	# if job['id'] not in completed and job['id'] not in running:
	# 	return job
	return job

def main():
	print("####################")
	# If not using credentials, just uncomment this try except block
	dockerhub_user = None
	dockerhub_pass = None
	try:
		dockerhub_user = os.environ["dockerhub_user"]
		dockerhub_pass = os.environ["dockerhub_pass"]
	except KeyError as e:
		print("Continuing without dockerhub credentials")
		# print('export dockerhub_user=my_username')
		# print('export dockerhub_pass=my_password')
		exit(0)
	finally:
		dispatcher.start_dispatcher(
			config='hosts.cfg', # Host configuration file
			images=['step2'], # Dockerhub image
			next_job=process_peptides, # Get job function
			conn_timeout=30, # Timeout for host answer
			conn_wait=600, # Not responding at first (or failing to respond 2x) try connecting in 5 min
			reconn_wait=60, # if it was responding, then failed once, try again in 1 minute
			dockerhub_user=dockerhub_user, # Environment variable, only required from private repos 
			dockerhub_pass=dockerhub_pass) # Environment variable, only required from private repos
		print("####################")
		print("Dispatcher Ended.")

if __name__ == "__main__":
	main()


