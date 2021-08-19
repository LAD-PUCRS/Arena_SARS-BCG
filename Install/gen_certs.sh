#!/bin/bash

################################ STEP 1 ################################

# Generates Certificates

CDIR=$PWD/certs

mkdir -p $CDIR/ca
# CA
openssl genrsa -out $CDIR/ca/ca-key.pem 4096
openssl req -x509 -new -nodes -key $CDIR/ca/ca-key.pem -days 3650 -out $CDIR/ca/ca.pem -subj '/CN=docker-CA'
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
" > $CDIR/ca/openssl.cnf


# Client TLS
mkdir $CDIR/client
openssl genrsa -out $CDIR/client/client-key.pem 4096
openssl req -new -key $CDIR/client/client-key.pem -out $CDIR/client/client-cert.csr -subj '/CN=docker-client' -config $CDIR/ca/openssl.cnf
openssl x509 -req -in $CDIR/client/client-cert.csr -CA $CDIR/ca/ca.pem -CAkey $CDIR/ca/ca-key.pem -CAcreateserial -out $CDIR/client/client-cert.pem -days 3650 -extensions v3_req -extfile $CDIR/ca/openssl.cnf


# Docker Daemon TLS

mkdir $CDIR/daemon
chmod 700 $CDIR/daemon/

cp $CDIR/ca/ca.pem $CDIR/daemon

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
" > $CDIR/daemon/openssl.cnf

openssl genrsa -out $CDIR/daemon/daemon-key.pem 4096
openssl req -new -key $CDIR/daemon/daemon-key.pem -out $CDIR/daemon/daemon-cert.csr -subj '/CN=docker-daemon' -config $CDIR/daemon/openssl.cnf
openssl x509 -req -in $CDIR/daemon/daemon-cert.csr -CA $CDIR/daemon/ca.pem -CAkey $CDIR/ca/ca-key.pem -CAcreateserial -out $CDIR/daemon/daemon-cert.pem -days 3650 -extensions v3_req -extfile $CDIR/daemon/openssl.cnf

chmod 600 $CDIR/daemon/*

################################ STEP 2 ################################

# Generates Docker Installation Script

# Read to memory each certificate
read -r -d '' CA_PEM < certs/ca/ca.pem
read -r -d '' DAEMON_KEY < certs/daemon/daemon-key.pem
read -r -d '' DAEMON_CERT < certs/daemon/daemon-cert.pem

# Write the installation script
cat > install_docker.sh << EOF
#!/bin/bash

# If the following variables are populated, the configuration will use TLS.
# otherwise it will be insecure, anyone can access it.

## The contents of ca.pem
read -r -d '' CA_PEM <<CONTENT
$CA_PEM
CONTENT

## The contents of daemon-key.pem
read -r -d '' DAEMON_KEY <<CONTENT
$DAEMON_KEY
CONTENT

## The contents of daemon-cert.pem
read -r -d '' DAEMON_CERT <<CONTENT
$DAEMON_CERT
CONTENT

# Remove any existing installation
apt-get update
apt-get remove docker docker-engine docker.io containerd runc
apt-get update

# Set up the repository
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   \$(lsb_release -cs) \
   stable"

# Install Docker
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

# Add user to dockerfile
usermod -aG docker "\$(ls /home)"

################################## Docker TLS Setup

if [ ! -z "\$CA_PEM" ] && [ ! -z "\$DAEMON_KEY" ] && [ ! -z "\$DAEMON_CERT" ]; then

mkdir /etc/docker/ssl
chmod 700 /etc/docker/ssl

# Inject here the corresponding contents

echo "\$CA_PEM" > /etc/docker/ssl/ca.pem
echo "\$DAEMON_KEY" > /etc/docker/ssl/daemon-key.pem
echo "\$DAEMON_CERT" > /etc/docker/ssl/daemon-cert.pem

# Fix permissions
chmod 600 /etc/docker/ssl/*

# Set the tls parameters
sed -i 's/ExecStart.*/ExecStart=\nExecStart=\/usr\/bin\/dockerd -H fd:\/\/ --containerd=\/run\/containerd\/containerd.sock -H tcp:\/\/0.0.0.0:2375 --tlsverify --tlscacert=\/etc\/docker\/ssl\/ca.pem --tlskey=\/etc\/docker\/ssl\/daemon-key.pem --tlscert=\/etc\/docker\/ssl\/daemon-cert.pem/g' /lib/systemd/system/docker.service
else
# Unsecure Docker
sed -i 's/ExecStart.*/ExecStart=\nExecStart=\/usr\/bin\/dockerd -H fd:\/\/ --containerd=\/run\/containerd\/containerd.sock -H tcp:\/\/0.0.0.0:2375/g' /lib/systemd/system/docker.service
fi

# Restart docker
systemctl daemon-reload
service docker restart

exit 0
EOF

