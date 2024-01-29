#!/bin/bash
# tests assignment of function output to a variable inside a bash script

# importing functions from another file
source ~/$(dirname $0)/return_chpt_dirs.sh

# assigning output value of this function 'checkpoint' to a variable 'checkdir'
checkdir=$(f_return_checkpoint)
echo checkdir is $checkdir
