#!/usr/bin/env bash

VERSION=7.0

minikube start --memory=8192 --disk-size=40g --cpus=4 --vm-driver=virtualbox --bootstrapper kubeadm --kubernetes-version=1.17.4

minikube addons enable ingress

#kubectl apply -f https://github.com/ForgeRock/secret-agent/releases/latest/download/secret-agent.yaml

# kubectl create namespace default

# kubens default

minikube ssh sudo ip link set docker0 promisc on

eval $(minikube docker-env)

skaffold config set --kube-context minikube local-cluster true

./bin/config.sh init --profile sdks --version $VERSION

# Set all passwords to "Passw0rd1!"
# echo "Passw0rd1!" > docker/forgeops-secrets/forgeops-secrets-image/config/OVERRIDE_ALL_PASSWORDS.txt

#mkcert "*.iam.example.com"
#kubectl create secret tls sslcert --cert=_wildcard.iam.example.com.pem --key=_wildcard.iam.example.com-key.pem
kubectl create secret tls sslcert --cert /etc/letsencrypt/live/jenkins.petrov.ca/fullchain.pem --key=/etc/letsencrypt/live/jenkins.petrov.ca/privkey.pem

# Port-forward https port 
#vboxmanage controlvm "minikube" natpf1 "https,tcp,,443,,443"

skaffold dev