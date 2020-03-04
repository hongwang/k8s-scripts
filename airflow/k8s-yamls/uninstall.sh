#!/usr/bin/env bash

kubectl delete -f ./templates/airflow.yaml
kubectl delete -f ./templates/volumes.yaml
kubectl delete -f ./templates/configmap-git-clone.yaml
kubectl delete -f ./templates/configmaps.yaml
kubectl delete -f ./templates/secrets.yaml

kubectl delete namespace airflow
