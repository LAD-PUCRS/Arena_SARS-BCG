Stress Test



{'ID': 'COSS:7NXT:SIWJ:LXMV:NWZ3:IIIS:H4XS:RIAQ:E7IE:6WDX:NVZF:CJCA', 'Containers': 0, 'ContainersRunning': 0, 'ContainersPaused': 0, 'ContainersStopped': 0, 'Images': 1, 'Driver': 'overlay2', 'DriverStatus': [['Backing Filesystem', 'extfs'], ['Supports d_type', 'true'], ['Native Overlay Diff', 'true']], 'SystemStatus': None, 'Plugins': {'Volume': ['local'], 'Network': ['bridge', 'host', 'ipvlan', 'macvlan', 'null', 'overlay'], 'Authorization': None, 'Log': ['awslogs', 'fluentd', 'gcplogs', 'gelf', 'journald', 'json-file', 'local', 'logentries', 'splunk', 'syslog']}, 'MemoryLimit': True, 'SwapLimit': False, 'KernelMemory': True, 'KernelMemoryTCP': True, 'CpuCfsPeriod': True, 'CpuCfsQuota': True, 'CPUShares': True, 'CPUSet': True, 'PidsLimit': True, 'IPv4Forwarding': True, 'Bridge
Iptables': True, 'BridgeNfIp6tables': True, 'Debug': False, 'NFd': 22, 'OomKillDisable': True, 'NGoroutines': 36, 'SystemTime': '2020-09-02T19:17:04.574516859-07:00', 'LoggingDriver': 'json-file', 'CgroupDriver': 'cgroupfs', 'NEventsListener': 0, 'KernelVersion': '4.15.0-112-generic', 'OperatingSystem': 'Ubuntu 18.04.5 LTS', 'OSType': 'linux', 'Architecture': 'x86_64', 'IndexServerAddress': 'https://index.docker.io/v1/', 'RegistryConfig': 
	{'AllowNondistributableArtifactsCIDRs': [], 'AllowNondistributableArtifactsHostnames': [], 'InsecureRegistryCIDRs': ['127.0.0.0/8'], 'IndexConfigs': {'docker.io': {'Name': 'docker.io', 'Mirrors': [], 'Secure': True, 'Official': True}}, 'Mirrors': []}, 'NCPU': 2, 'MemTotal': 2084225024, 'GenericResources': None, 'DockerRootDir': '/var/lib/docker', 'HttpProxy': '', 'HttpsProxy': '', 'NoProxy': '', 'Name': 'n1', 'Labels': [], 'ExperimentalBuild': False, 'ServerVersion': '19.03.12', 'ClusterStore': '', 'ClusterAdvertise': '', 'Runtimes': {'runc': {'path': 'runc'}}, 'DefaultRuntime': 'runc', 'Swarm': {'NodeID': '', 'NodeAddr': '', 'LocalNodeState': 'inactive', 'ControlAvailable': False, 'Error': '', 'RemoteManagers': None}, 'LiveRestoreEnabled': False, 'Isolation': '', 'InitBinary': 'docker-init', 'ContainerdCommit': {'ID': '7ad184331fa3e55e52b890ea95e65ba581ae3429', 'Expected': '7ad184331fa3e55e52b890ea95e65ba581ae3429'}, 'RuncCommit': {'ID': 'dc9208a3303feef5b3839f4323d9beb36df0a9dd', 'Expected': 'dc9208a3303feef5b3839f4323d9beb36df0a9dd'}, 'InitCommit': {'ID': 'fec3683', 'Expected': 'fec3683'}, 'SecurityOptions': ['name=apparmor', 'name=seccomp,profile=default'], 'Warnings': ['WARNING: No swap limit support']}
[Finished in 0.2s]

CPU=12
MEM=16.00
NCPU

	NCPU
	MemTotal


docker run -it --name 'job-16' -l "job-id=12345" -l "logs=True" -l "archive=None" feliperubin/sample_app

            "Labels": {
                "archive": "None",
                "job-id": "12345",
                "logs": "True"
            }




Object: Container:
.name
.attrs

.attrs.


Host[10.0.0.4]: (

container.name,
container.attrs.Path+''+container.attrs.Args,
container.status,
container.attrs.State.ExitCode,
container.attrs.State.StartedAt,
container.attrs.State.FinishedAt



attrs
	.Args
	.State
		.Status
		.ExitCode
		.Error
		.StartedAt
		.FinishedAt

{'Id': '46aaa003bed9b8e90642a665c3f8326599ffdd604bc4a61bc0097c6362ac738e', 'Created': '2020-09-01T22:35:57.120153387Z', 'Path': 'python3', 'Args': ['/app/job.py', 'n1-job'], 

'State': 
	{'Status': 'exited', 'Running': False, 'Paused': False, 'Restarting': False, 'OOMKilled': False, 'Dead': False, 'Pid': 0, 'ExitCode': 0, 'Error': '', 'StartedAt': '2020-09-01T22:35:57.581973785Z', 'FinishedAt': '2020-09-01T22:35:57.660723109Z'}, 'Image': 'sha256:6a3ac95b389228c8b533da813766f1594a4c5ff86b07055bc2fd2340b81299fc', 'ResolvConfPath': '/var/lib/docker/containers/46aaa003bed9b8e90642a665c3f8326599ffdd604bc4a61bc0097c6362ac738e/resolv.conf', 'HostnamePath': '/var/lib/docker/containers/46aaa003bed9b8e90642a665c3f8326599ffdd604bc4a61bc0097c6362ac738e/hostname', 'HostsPath': '/var/lib/docker/containers/46aaa003bed9b8e90642a665c3f8326599ffdd604bc4a61bc0097c6362ac738e/hosts', 'LogPath': '/var/lib/docker/containers/46aaa003bed9b8e90642a665c3f8326599ffdd604bc4a61bc0097c6362ac738e/46aaa003bed9b8e90642a665c3f8326599ffdd604bc4a61bc0097c6362ac738e-json.log', 'Name': '/job-3', 'RestartCount': 0, 'Driver': 'overlay2', 'Platform': 'linux', 'MountLabel': '', 'ProcessLabel': '', 'AppArmorProfile': 'docker-default', 'ExecIDs': None, 
	'HostConfig': 
		{'Binds': None, 'ContainerIDFile': '', 
		'LogConfig': 
			{'Type': 'json-file', 'Config': {}
		}, 'NetworkMode': 'default', 'PortBindings': {}, 
		'RestartPolicy': 
			{'Name': 'no', 'MaximumRetryCount': 0}, 'AutoRemove': False, 'VolumeDriver': '', 'VolumesFrom': None, 'CapAdd': None, 'CapDrop': None, 'Capabilities': None, 'Dns': [], 'DnsOptions': [], 'DnsSearch': [], 'ExtraHosts': None, 'GroupAdd': None, 'IpcMode': 'private', 'Cgroup': '', 'Links': None, 'OomScoreAdj': 0, 'PidMode': '', 'Privileged': False, 'PublishAllPorts': False, 'ReadonlyRootfs': False, 'SecurityOpt': None, 'UTSMode': '', 'UsernsMode': '', 'ShmSize': 67108864, 'Runtime': 'runc', 'ConsoleSize': [0, 0], 'Isolation': '', 'CpuShares': 0, 'Memory': 0, 'NanoCpus': 0, 'CgroupParent': '', 'BlkioWeight': 0, 'BlkioWeightDevice': [], 'BlkioDeviceReadBps': None, 'BlkioDeviceWriteBps': None, 'BlkioDeviceReadIOps': None, 'BlkioDeviceWriteIOps': None, 'CpuPeriod': 0, 'CpuQuota': 0, 'CpuRealtimePeriod': 0, 'CpuRealtimeRuntime': 0, 'CpusetCpus': '', 'CpusetMems': '', 'Devices': [], 'DeviceCgroupRules': None, 'DeviceRequests': None, 'KernelMemory': 0, 'KernelMemoryTCP': 0, 'MemoryReservation': 0, 'MemorySwap': 0, 'MemorySwappiness': None, 'OomKillDisable': False, 'PidsLimit': None, 'Ulimits': None, 'CpuCount': 0, 'CpuPercent': 0, 'IOMaximumIOps': 0, 'IOMaximumBandwidth': 0, 'MaskedPaths': ['/proc/asound', '/proc/acpi', '/proc/kcore', '/proc/keys', '/proc/latency_stats', '/proc/timer_list', '/proc/timer_stats', '/proc/sched_debug', '/proc/scsi', '/sys/firmware'], 'ReadonlyPaths': ['/proc/bus', '/proc/fs', '/proc/irq', '/proc/sys', '/proc/sysrq-trigger']}, 
			'GraphDriver': 
				{'Data': 
					{'LowerDir': '/var/lib/docker/overlay2/4123d8474a4b8be73742416a80febd04785197e4dcc23689cd9378379d86568c-init/diff:/var/lib/docker/overlay2/7778cca76ccb444c3d171b163ae63d4219be03bb893b92a0a0ee800563d71840/diff:/var/lib/docker/overlay2/dfff334b7354c5bbc65e1cacb8635ceab673a5a8b8505c344846d4c96c5764ab/diff:/var/lib/docker/overlay2/abb718614eaf61aca4274fafb6fad96731109a016f5171970f6c9cb69af059a8/diff:/var/lib/docker/overlay2/323c15bb6c82ecd95106acbe4373240ecf267996f0f3bf0c4c62a473400fabdc/diff:/var/lib/docker/overlay2/fa3002818237c9c768577de99c5e4fe3500eb7750d93463e9485197346b9818e/diff:/var/lib/docker/overlay2/2421149eff4c9622429179f7ce51bb928be71d8e0b18bbdf69c678fe91d21b61/diff:/var/lib/docker/overlay2/410ba727fc24ac479644323c116e78db09b7b49a70f2cbb616995545fb83c946/diff:/var/lib/docker/overlay2/772dda9e248a2bb05045448989b7580933be0163098cf83c58dc5f1c00ce8d1e/diff:/var/lib/docker/overlay2/554e650814bb6828eccb0815b1b2202d2ec6a85098ae68bb9f630852d34b6602/diff:/var/lib/docker/overlay2/529538a6da66b750f59c9faebe05f8bd32efac1b28ce119fbefddd020da2fe29/diff:/var/lib/docker/overlay2/7c6d32de8732d56943baf01bff9d71e66d1a2ccf8cd0f4251bcbc8f963df9798/diff', 'MergedDir': '/var/lib/docker/overlay2/4123d8474a4b8be73742416a80febd04785197e4dcc23689cd9378379d86568c/merged', 'UpperDir': '/var/lib/docker/overlay2/4123d8474a4b8be73742416a80febd04785197e4dcc23689cd9378379d86568c/diff', 'WorkDir': '/var/lib/docker/overlay2/4123d8474a4b8be73742416a80febd04785197e4dcc23689cd9378379d86568c/work'}, 'Name': 'overlay2'}, 'Mounts': [], 
						'Config': {'Hostname': '46aaa003bed9', 'Domainname': '', 'User': '', 'AttachStdin': False, 'AttachStdout': True, 'AttachStderr': True, 'Tty': False, 'OpenStdin': False, 'StdinOnce': False, 'Env': ['PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin', 'LANG=C.UTF-8', 'GPG_KEY=E3FF2839C048B25C084DEBE9B26995E310250568', 'PYTHON_VERSION=3.8.5', 'PYTHON_PIP_VERSION=20.2.2', 'PYTHON_GET_PIP_URL=https://github.com/pypa/get-pip/raw/5578af97f8b2b466f4cdbebe18a3ba2d48ad1434/get-pip.py', 'PYTHON_GET_PIP_SHA256=d4d62a0850fe0c2e6325b2cc20d818c580563de5a2038f917e3cb0e25280b4d1'], 'Cmd': ['python3', '/app/job.py', 'n1-job'], 'Image': 'feliperubin/sample_app', 'Volumes': None, 'WorkingDir': '/app', 'Entrypoint': None, 'OnBuild': None, 'Labels': {}}, 'NetworkSettings': {'Bridge': '', 'SandboxID': 'f8f127200a586102d27d0930d23cebaa725f4bef638e0cea6d9d1f12657be109', 'HairpinMode': False, 'LinkLocalIPv6Address': '', 'LinkLocalIPv6PrefixLen': 0, 'Ports': {}, 'SandboxKey': '/var/run/docker/netns/f8f127200a58', 'SecondaryIPAddresses': None, 'SecondaryIPv6Addresses': None, 'EndpointID': '', 'Gateway': '', 'GlobalIPv6Address': '', 'GlobalIPv6PrefixLen': 0, 'IPAddress': '', 'IPPrefixLen': 0, 'IPv6Gateway': '', 'MacAddress': '', 'Networks': {'bridge': {'IPAMConfig': None, 'Links': None, 'Aliases': None, 'NetworkID': 'db899413b386b82639c131f38aa213ad0ff1d5ca5677ad442274eb3d53d512e9', 'EndpointID': '', 'Gateway': '', 'IPAddress': '', 'IPPrefixLen': 0, 'IPv6Gateway': '', 'GlobalIPv6Address': '', 'GlobalIPv6PrefixLen': 0, 'MacAddress': '', 'DriverOpts': None}}}})
