#!/bin/sh

kubectl create serviceaccount -n kube-system tiller

kubectl create clusterrolebinding tiller-binding \
    --clusterrole=cluster-admin \
    --serviceaccount kube-system:tiller

helm init --service-account tiller

helm repo update
