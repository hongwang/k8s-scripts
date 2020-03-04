#!/usr/bin/env bash

kubectl create namespace airflow
kubectl apply -f ./templates/secrets.yaml
kubectl apply -f ./templates/configmaps.yaml
kubectl apply -f ./templates/configmap-git-clone.yaml
kubectl apply -f ./templates/volumes.yaml
kubectl apply -f ./templates/airflow.yaml

