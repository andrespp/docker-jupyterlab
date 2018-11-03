#!/bin/bash

# Sets script to fail if any command fails.
set -e

CODEMIRROR=~/.jupyter/lab/user-settings/\@jupyterlab/codemirror-extension

user_settings() {
	CodeMirror_settings
}

CodeMirror_settings() {
	# Test variables
	if [ -z "$KEYMAP" ]; then
		KEYMAP=default
	fi
	if [ -z "$TEXT_THEME" ]; then
		TEXT_THEME=default
	fi

	# Test if directory exists
	if [ ! -d $CODEMIRROR ] ; then
		mkdir -p "$CODEMIRROR"
	fi
	# Write custom settings
	echo '
{
    // CodeMirror
    // @jupyterlab/codemirror-extension:commands
    // Text editor settings for all CodeMirror editors.
    // ************************************************
    // Key Map
    "keyMap": "'$KEYMAP'"
}' > $CODEMIRROR/commands.jupyterlab-settings

	echo "Keymap set to: $KEYMAP"
}

jupyterlab() {
	echo Applying custom settings. $@
	user_settings
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
