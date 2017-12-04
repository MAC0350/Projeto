#!/bin/bash
# Script that adds a Python 3 virtual environment to an existing
# directory.

set -e

# Requirements file
REQ="doc/requirements.txt"

# Virtualenv-related directories
ENVDIRS="bin include lib"

# --------------------------------------------------------------------
# Shows how to use the script.

function usage {
    echo -e "\e[1mUSAGE\e[0m"
    echo -e "\t$0 [\e[4mOPTIONS\e[0m]\n"

    echo -e "\e[1mDESCRIPTION\e[0m"
    echo -e "\tCreates a Python3 virtual environment in the current directory."
    echo -e "\tAlso install requirements found on '$REQ'.\n"

    echo -e "\e[1mOPTIONS\e[0m"
    echo -e "\tSeparate each option with a space.\n"
    echo -e "\t\e[1m-h, --help\e[0m\n" \
            "\t\tShows how to use the script, leaving it afterwards.\n"
    echo -e "\t\e[1m-r\e[0m\n" \
            "\t\tRemoves all virtualenv-related directories."
}

# --------------------------------------------------------------------

# Go to project root directory
cd "$(dirname "${BASH_SOURCE[0]}")"

# Command line arguments
for arg in "$@"; do
    case $arg in
    -h|--help)
        usage
        exit 0;;
    -r)
        rm -rf $ENVDIRS
        echo "Successfully removed virtualenv-related directories!"
        exit 0;;
    *)
        echo "Unknown argument '$arg'"
        exit 1;;
    esac
done

echo -e "\e[36m>> Creating virtual environment\e[0m"
virtualenv -p python3 .
source bin/activate

echo -e "\e[36m>> Installing requirements found in '$REQ'\e[0m"
if [ ! -f "$REQ" ]; then
    echo -e "\e[31m>> ERROR: '$REQ' not found!\e[0m"
else
    pip install -r $REQ
fi

echo -e "\e[36m>> Done!\e[0m"
