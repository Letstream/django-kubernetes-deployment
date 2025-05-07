#!/bin/bash

NAMESPACE=ENTER_NAMESPACE_HERE

kubectl create namespace $NAMESPACE

# App Secrets
kubectl create secret generic app-secrets --from-env-file=secrets.env -n $NAMESPACE

# Docker Secrets
kubectl create secret docker-registry registry-token \
  --docker-server=https://registry.gitlab.com \
  --docker-username=K8RegistryToken \
  --docker-password=PASSWORD \
  --namespace=$NAMESPACE

# SSL Certificate
kubectl create secret tls ssl-certificate -n $NAMESPACE --key=certs/key.pem --cert=certs/cert.crt

kubectl apply -f deploy.yaml -n $NAMESPACE
