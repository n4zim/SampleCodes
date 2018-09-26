#!/bin/sh

IP="" # REGIONAL static IP
IP="35.205.84.30"

helm install stable/nginx-ingress \
  --namespace kube-system \
  --name nginx-ingress \
  --set rbac.create=true \
  --set controller.service.loadBalancerIP=${IP}
