#!/bin/bash
# Creates a tar file with all files/directories needed for delivering
# the project.

set -e

TARDIR="fase3"       # Name of the compressed tar directory
TARNAME="fase3.tar"  # Name of the tar file

# Files/directories to be copied to tar
PROJECT="doc/ gamma/ sql/ README.md pyvenv.sh"

# ---------------------------------------------------------------------

mkdir -p $TARDIR
cp -rf $PROJECT $TARDIR

# Remove temporary Python files from Django server
find $TARDIR -name __pycache__ -o -name *.pyc | xargs rm -rf

tar -cvf $TARNAME $TARDIR
rm -rf $TARDIR
