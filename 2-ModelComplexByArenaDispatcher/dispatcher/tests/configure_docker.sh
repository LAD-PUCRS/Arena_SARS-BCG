#!/bin/bash

# Abstracts OS, but will not be used
# vim /etc/docker/daemon.json
# Used for ubuntu 18
# vim /lib/systemd/system/docker.service

# STEP: Modify Docker Service

# Change ExecStart line adding both an empty 'ExecStart' line before, 
# and then append to the original a tcp socket




mkdir -p ~/docker-tls/ca
# CA
openssl genrsa -out ~/docker-tls/ca/ca-key.pem 4096
openssl req -x509 -new -nodes -key ~/docker-tls/ca/ca-key.pem -days 3650 -out ~/docker-tls/ca/ca.pem -subj '/CN=docker-CA'
echo "
[added]

[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[ v3_req]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth, clientAuth
" > ~/docker-tls/ca/openssl.cnf


# Client TLS
mkdir ~/docker-tls/client
openssl genrsa -out ~/docker-tls/client/client-key.pem 4096
openssl req -new -key ~/docker-tls/client/client-key.pem -out ~/docker-tls/client/client-cert.csr -subj '/CN=docker-client' -config ~/docker-tls/ca/openssl.cnf
openssl x509 -req -in ~/docker-tls/client/client-cert.csr -CA ~/docker-tls/ca/ca.pem -CAkey ~/docker-tls/ca/ca-key.pem -CAcreateserial -out ~/docker-tls/client/client-cert.pem -days 3650 -extensions v3_req -extfile ~/docker-tls/ca/openssl.cnf


# Docker Daemon TLS

mkdir /etc/docker/ssl
chmod 700 /etc/docker/ssl/

cp ~/docker-tls/ca/ca.pem /etc/docker/ssl

echo "
[added]

[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth, clientAuth
subjectAltName = @alt_names

[alt_names]
IP.1 = 127.0.0.1
IP.2 = 10.0.0.2
" > /etc/docker/ssl/openssl.cnf



openssl genrsa -out /etc/docker/ssl/daemon-key.pem 4096
openssl req -new -key /etc/docker/ssl/daemon-key.pem -out /etc/docker/ssl/daemon-cert.csr -subj '/CN=docker-daemon' -config /etc/docker/ssl/openssl.cnf
openssl x509 -req -in /etc/docker/ssl/daemon-cert.csr -CA /etc/docker/ssl/ca.pem -CAkey ~/docker-tls/ca/ca-key.pem -CAcreateserial -out /etc/docker/ssl/daemon-cert.pem -days 3650 -extensions v3_req -extfile /etc/docker/ssl/openssl.cnf

chmod 600 /etc/docker/ssl/*



# sed -i 's/ExecStart.*/ExecStart=\nExecStart=\/usr\/bin\/dockerd -H fd:\/\/ --containerd=\/run\/containerd\/containerd.sock -H tcp:\/\/0.0.0.0:2375/g' /lib/systemd/system/docker.service
sed -i 's/ExecStart.*/ExecStart=\nExecStart=\/usr\/bin\/dockerd -H fd:\/\/ --containerd=\/run\/containerd\/containerd.sock -H tcp:\/\/0.0.0.0:2375 --tlsverify --tlscacert=\/etc\/docker\/ssl\/ca.pem --tlskey=\/etc\/docker\/ssl\/daemon-key.pem --tlscert=\/etc\/docker\/ssl\/daemon-cert.pem/g' /lib/systemd/system/docker.service
systemctl daemon-reload
service docker restart

# Add the following






