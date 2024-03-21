#!/bin/bash

# navigating directories and pulling newest committed files
dir_cloud=/home/dwalth/data/cloud
dir_parent=$(dirname $0)  # no trailing slash
cd $dir_cloud
# bash pull-script.sh  # in case that got forgotten

# creating the session string (makes it possible to give a custom session name as input, defaults to current date and a number yymmdd-id)
# session example: '230930-0'
if ! [ $# -eq 0 ]; then
    input_session=$1
else
    input_session=""  # this is interpreted as not a variable and is just ignored in bash when calling $input_session
fi
source $dir_parent/../main/get_next_session.sh  # static symlink
session=$(f_get_next_session)

# defining the checkpoint directory conditionally (in case of input, sub bash scripts will create a <current_session> subfolder in the <input_session> folder)
if ! [ $# -eq 0 ]; then
    checkdir="/home/dwalth/data/outputs/chpt-${input_session}"  # static link
    slurmout=$checkdir/$session/slurm-$session.out  # static link
    if ! [ -d $checkdir ]; then
        checkdir="/home/dwalth/data/outputs/chpt-${session}"  # static link
        slurmout=$checkdir/slurm-$session.out  # static link
    fi
else
    checkdir="/home/dwalth/data/outputs/chpt-${session}"  # static link
    slurmout=$checkdir/slurm-$session.out  # static link
fi

# create checkdir if it does not exist
if ! [ -d $checkdir ]; then
    mkdir $checkdir
fi
# create the empty would-be-current_session dir for f_get_next_session() to work.
current_session_dir="/home/dwalth/data/outputs/chpt-${session}"
if ! [ -d $current_session_dir ]; then
    mkdir $current_session_dir
fi

# calling the slurm job file (containing the train3dunet command, for example)
if [ -f $slurmout ]; then
    echo Error. Slurm output file should not already exist. Exiting program to prevent overwriting previous slurm output file contents.
    exit
fi
sbatch_job=/home/dwalth/data/cloud/slurmJobs/named_copies/sbatch-$session.sh  # static link
sbatch --output=$slurmout $sbatch_job $input_session $session $checkdir $slurmout
