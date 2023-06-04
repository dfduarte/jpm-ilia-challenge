#!/bin/bash

# enable ingress
# assumes that minikube is already here (tested with 1.30.x)
minikube addons enable ingress

# MINIKUBE_IP

MINIKUBE_IP=$(minikube ip)

# install cert-manager helmcharts

helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager --create-namespace --namespace cert-manager jetstack/cert-manager --set installCRDs=true


# installs the bare minimum of epinio - usese sslip.io as a auto-reference DNS - more info here
# https://www.suse.com/c/rancher_blog/meet-epinio-the-application-development-engine-for-kubernetes/
# and https://docs.epinio.io/installation/wildcardDNS_setup
#
# that will create a self-signed certificate, but it worths it for this run.

helm repo add epinio https://epinio.github.io/helm-charts
helm install epinio --create-namespace --namespace epinio epinio/epinio --set global.domain=${MINIKUBE_IP}.sslip.io

# logging into epinio, assuming everything was right
# Remember: PASSWORD MUST BE CHANGED AFTER SOME POINT!

epinio login --trust-ca -u admin -p password https://epinio.${MINIKUBE_IP}.sslip.io

# This command will show all the pods and set the security parameters for kubeconfig at same time
# good to check if epinio is running just alright!

minikube kubectl -- get pods -A
