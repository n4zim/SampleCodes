#!/bin/sh

helm install stable/cert-manager \
  --namespace kube-system \
  --name cert-manager
