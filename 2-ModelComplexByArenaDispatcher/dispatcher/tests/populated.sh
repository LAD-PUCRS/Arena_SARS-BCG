#!/bin/bash

# Change the following values if enabling remote access with TLS, otherwise it will be open to anyone.

# ca.pem
read -r -d '' CA_PEM <<CONTENT
-----BEGIN CERTIFICATE-----
MIIFCTCCAvGgAwIBAgIUMoNVp04YJc621KnhASIWxnRJuAMwDQYJKoZIhvcNAQEL
BQAwFDESMBAGA1UEAwwJZG9ja2VyLUNBMB4XDTIwMDgyOTIyNTUyMVoXDTMwMDgy
NzIyNTUyMVowFDESMBAGA1UEAwwJZG9ja2VyLUNBMIICIjANBgkqhkiG9w0BAQEF
AAOCAg8AMIICCgKCAgEA5ZDyd1/TrineJr0IVjtw99qWdpOENzRNVe6WjcHQkcdF
qjBhp+zgrpIEw32YqxqWFBtQn3qJ50Ng8f8NBndSw2K02JiM/qp4hFHn94okPQgd
/1F29BqCK97DLMn7A3XqXnIyAQAg81MHCw+ytpkC9WidY4eT3xOwSNBdsXjTEBNe
Fj22IoHAd4C3++kfSPs2OZMjAgFauQOeTE/iRGJgIoVXKLQhaQirbDMswrHZw4e8
tXuXIn1ZduFL1m7+C1VWo3Qe2TIOP6RRqwdAHeVHeVc7nx+VRzUv9/Oc8hr9vJFh
y9rSTjwN87rAgOsZXw/D69axOTIgZS0WNdqV2skRMF7S+n43a+BGbdhlMnw+IeVu
LYCGXve/8MHSEe0zaK4Y62WGt4D6Bwn5gRWWjZZwN7HlOrprPibEt/zZyhth4Hhw
eG4oAc0nQAF0K7J9oHyfwHDCrsXV8l4nuRtn3o6yj4zukvsWGQ4Hixc5MTwwMWRm
KNFJOpSXiNFtLP/jr3lfjmp7kH6st+Cdb1O+xjv00BtfYShg51gOX6HI4fwvwclN
RUohSsyP/Z0OijRK92ybiGDT1JlJWWhwGTVRjUheKJKqkXN+5lSUcZGlDTk0Kz0Y
w0ZOQ5/Sra+JcHKn4B/ie3Yt7GtS1pXhpuQC+4UAUnlWfgoq2oMjK8/+7i4uVpsC
AwEAAaNTMFEwHQYDVR0OBBYEFBHhB2l++87L5qJXMXNVDH578ImPMB8GA1UdIwQY
MBaAFBHhB2l++87L5qJXMXNVDH578ImPMA8GA1UdEwEB/wQFMAMBAf8wDQYJKoZI
hvcNAQELBQADggIBAKHnVVAA61QKL4ZtJtQgrxKDdawLjD7zK0Bg6UYFB9iauu9+
A6RZ6reM4NB1djL0edRG5/UR2Jl/HMQNDSfaUKf1DyyyD69q59/nx7khPZ6D7Mru
cDWEj/LFnQD1vexwLph1rF7QMYQjqJhzjER1u79e18Qj5L+GRUZC/U4I6UEtZtu8
nzdf2xrofbRxpRp5tE/42CtHN88BUeuuTMSArbstrWA71t8fsF+l5UQabfcReFWL
o70kH97ewBKV2WPB43jwNUgelR+E8sDYv0VWT5mWK2Opqj0ItGyKhMHn0ZLGtDqm
GOL2A0+zj6fPLUTldBw6PPlbtaqdiUxQw5JtwgOK7Z8j64NBvy42axWql5C4+T42
KP2SPDH4+IjcOk48PmftlYP9h/0WzZVGpn41cc9bV4kz5T43Jre1YWq+iMFCoqou
/Tj9rZy9APUulPeWjy/JPTg2J+AabUgghf16SzngNOUTjY0xhGusxS5dtMBOTfpT
BpKmpLCSoVa9wtYGXOlhdNoKzIBpK7QPWal88QqXvn/qe9kVF+r2I+ap3XgzZvat
D23N2ieX+0A0P+mrpbwRTgkhHrkYGoMyKCTUNGsRLNRpEeSv9QT0wSq1wSgRIwci
ESgr4Uj0ZxgPq8yQgD0YANQUfyFHJnzS+tzh6BSTII0/uayiJmIH1RE6+1xz
-----END CERTIFICATE-----
CONTENT

# daemon-key.pem
read -r -d '' DAEMON_KEY <<CONTENT
-----BEGIN RSA PRIVATE KEY-----
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
-----END RSA PRIVATE KEY-----
CONTENT

# daemon-cert.pem
read -r -d '' DAEMON_CERT <<CONTENT
-----BEGIN CERTIFICATE-----
MIIFCjCCAvKgAwIBAgIUNTLccNrwxoa0KGkOQn6z8GhmaNQwDQYJKoZIhvcNAQEL
BQAwFDESMBAGA1UEAwwJZG9ja2VyLUNBMB4XDTIwMDgyOTIyNTUyMVoXDTMwMDgy
NzIyNTUyMVowGDEWMBQGA1UEAwwNZG9ja2VyLWRhZW1vbjCCAiIwDQYJKoZIhvcN
AQEBBQADggIPADCCAgoCggIBAMdVah/ueu9R+meSzTJExw0C2uvX5n/FRA1zRSvY
A1dYtLTOzaq1HOWug4xCiU/POK1c8IQ6NJMEAaQaSs3islApuXXJMv1uGUJBBPBg
9zKYMeC74QzzvDWbrB8m7UJVCsCbIimh7WAdjH8K36LK3c0mTfXLaYgq7dN0RSzR
gNFT+iaCLAo3+fS7ItKD8v9tiVpxiqr9qaFjr6ZEpXamWDNI9+p+6JhVOesJ8Tn9
5jLFhxTDNbBOTP9XG3ZlqZJ5rHjp6DAYgFJRzkTvxMIl5Gtgj318psvYo8qAd6UE
iIuQ5hLSOaI2JG/NPvxqLidp4VLxjJH8DnslaURa+5ZaQUq8XluDmJ4w51Cw47z0
DpS57+Yfbd7Jx97VtM+Iiq2e/lwyYCiqKANhozYK5cEGqDBp5Mhy4uXyoYgaawq4
CDdUsq3Prjeek99EvacjGXXN9iR/1I69Mp/VFlLWgLo3CRtSBYtWrsI5jSlOa2QB
/GePTDrOvqs0LOoz6gRsPHIbTGfaWUG3HN/95ujvYIcgI3/1mhZPuGdhzeAyo4DU
FLsUBMIrdYJG34Tyn0HPUx8sy6H4P/lTILzzGKEotsoqT0R1jveUa84eBJIqJCdQ
uOMzJR3ZGtWKlVV531iw/5kaUXYKpshrEeBtewHhC3ERmoBDznSE7AOidU6nVMaH
fvjhAgMBAAGjUDBOMAkGA1UdEwQCMAAwCwYDVR0PBAQDAgXgMB0GA1UdJQQWMBQG
CCsGAQUFBwMBBggrBgEFBQcDAjAVBgNVHREEDjAMhwR/AAABhwQKAAACMA0GCSqG
SIb3DQEBCwUAA4ICAQBV5go40cBT+erwmqq2Dq4MJFa11EuO7EjPy41XdWnvln8R
B7zQQ0abc8xJ4CdijPNJAeM24DIU5SqgrT2kAYMpHKLCeNit+/G4AeadVWy9Szmb
q1Y/2LYhcSN8d4OuIiCGGZ5wQdm9mf6MAl8VFETpFL5p8uQ7r+s3d/WnGWLzrDsv
6iPXLR1Si/WhyQwhSSsLr7D8RshnBrH4TeI5R19u1p4jAv8/siz+tHDe1XwXgrYp
1grzVJwj90CcU/hrjmx/0jiy5BePt0IbDZymQpueXsWQ8cceGjy0BKQhbmY/xP5u
RKeGsvKVtbIjqL3Dhkl5/rZUtmygt/jIX8k/jOdR4TDW+h09X49XTIcmHbFjRPAA
DYPtnULVM//73FK7YFBFhULnFcqqbhAe52qPVOGzPy3MR6Ep0e+u3JUdEkV4B6NF
GH74RUEUUoWzpCDEOkKrclcrsNZNF+S6l4iH8z2nc7X6xZ4ySDT9ZX4VqInnTq8g
iP3BYaDFC/dIOeOSRZSJwvJpg/md8f8BhODFE3i2wYd/Eyw5ahLEY8n/RDphSBKJ
ysWEe4KPq/efBMV4xkG2Mj91gaHz+dk2DSDUpUvFwdkaXR69FSA398ykYpibckBg
VF89YxWCUv+Hhr3si5b+V4t5OMcdQpDlizCWhLkPi2duUj2hEnMWNmWY4HpcEw==
-----END CERTIFICATE-----
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
   $(lsb_release -cs) \
   stable"

# Install Docker
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

# Add user to dockerfile
usermod -aG docker "$(ls /home)"

################################## Docker TLS Setup

if [ ! -z "$CA_PEM" ] && [ ! -z "$DAEMON_KEY" ] && [ ! -z "$DAEMON_CERT" ]; then

mkdir /etc/docker/ssl
chmod 700 /etc/docker/ssl

# Inject here the corresponding contents

echo "$CA_PEM" > /etc/docker/ssl/ca.pem
echo "$DAEMON_KEY" > /etc/docker/ssl/daemon-key.pem
echo "$DAEMON_CERT" > /etc/docker/ssl/daemon-cert.pem

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
