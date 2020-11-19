#!/usr/bin/env bash

# Remove any existing application processes
skaffold delete
 
# Delete any persistent volumes
kubectl delete pvc --all
 
# Terminate the minikube VM process
minikube stop
 
# Delete the minikube VM
minikube delete
 
# This releases the IP dedicated to VB, and other things
rm ~/Library/VirtualBox/HostInterfaceNetworking-vboxnet0-Dhcpd.leases