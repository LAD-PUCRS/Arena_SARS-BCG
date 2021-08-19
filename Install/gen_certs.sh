#!/bin/bash

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
