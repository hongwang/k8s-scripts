#!/bin/bash

docker build . -t docker-registry.51uuabc.com/airflow:1.10.5 --no-cache
docker push docker-registry.51uuabc.com/airflow:1.10.5
