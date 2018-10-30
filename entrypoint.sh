#!/bin/bash

# Sets script to fail if any command fails.
set -e

jupyterlab() {
	echo Starting jupyterlab. $@
  	jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --notebook-dir=/opt/app/data --allow-root
}

print_usage() {
echo "

Usage:	$0 COMMAND

ETL Container

Options:
  help		        Print this help
  jupyterlab		Start Jupyterlab
"
}

case "$1" in
    help)
        print_usage
        ;;
    jupyterlab)
	shift 1
        jupyterlab "$@"
        ;;
    *)
        exec "$@"
esac
