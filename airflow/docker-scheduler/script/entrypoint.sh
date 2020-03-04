#!/usr/bin/env bash

case "$1" in
  webserver)
    airflow initdb
    exec airflow webserver
    ;;
  scheduler)
    # To give the webserver time to run initdb.
    sleep 10
    exec airflow "$@"
    ;;
  version)
    exec airflow "$@"
    ;;
  *)
    # The command is something like bash, not an airflow subcommand. Just run it in the right environment.
    exec "$@"
    ;;
esac