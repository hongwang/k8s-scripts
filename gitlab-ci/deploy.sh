#!/usr/bin/env bash

kubectl create namespace kube-ops

kubectl apply -f ./templates/gitlab-ci-token-secret.yaml
kubectl apply -f ./templates/runner-cm.yaml
kubectl apply -f ./templates/runner-rbac.yaml
kubectl apply -f ./templates/runner-scripts-cm.yaml
kubectl apply -f ./templates/runner-statefulset.yaml

