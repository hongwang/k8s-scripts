#!/bin/bash

export SSH_PRIVATE_KEY=`cat id_rsa`
docker build . -t docker-registry.51uuabc.com/airflow-worker:1.10.5 --build-arg SSH_PRIVATE_KEY="$SSH_PRIVATE_KEY" --no-cache
docker push docker-registry.51uuabc.com/airflow-worker:1.10.5