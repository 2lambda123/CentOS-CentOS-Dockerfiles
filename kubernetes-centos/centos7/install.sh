#!/bin/sh

set -ex

yum install -y cockpit-shell cockpit-ws cockpit-kubernetes ;

# Remove unwanted packages
rm -rf /usr/share/cockpit/realmd/ /usr/share/cockpit/system/ /usr/share/cockpit/tuned/ /usr/share/cockpit/users/ /usr/share/cockpit/dashboard/

# Remove unwanted cockpit-bridge binaries
rm -rf /usr/bin/cockpit-bridge
rm -rf /usr/lib64/security/pam_reauthorize.so
rm -rf /usr/libexec/cockpit-polkit

rm -rf /container/scripts
rm -rf /container/rpms

# Openshift will change the user
# but it will be part of gid 0
# so make the files we need group writable
rm -rf /etc/cockpit/
mkdir -p /etc/cockpit/
chmod 775 /etc
chmod 775 /etc/cockpit
chmod 775 /etc/os-release
chmod 775 /usr/share/cockpit/shell
chmod 775 /usr/share/cockpit/kubernetes

# Move kubernetes index file away so we only link it when we want it
mv /usr/share/cockpit/kubernetes/index.min.html.gz /usr/share/cockpit/kubernetes/original-index.gz
