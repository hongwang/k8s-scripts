#!/usr/bin/env bash

kubectl delete -f ./templates/runner-statefulset.yaml
kubectl delete -f ./templates/runner-scripts-cm.yaml
kubectl delete -f ./templates/runner-rbac.yaml
kubectl delete -f ./templates/runner-cm.yaml
kubectl delete -f ./templates/gitlab-ci-token-secret.yaml

kubectl delete namespace kube-ops
