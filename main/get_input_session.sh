#!/bin/bash

function f_prompt_input_session {

        parent=$1
        input_session=""

        # user input prompt with -p
        while ! [ -d $parent$input_session ]
        do
                read -p "No/invalid input session. Enter the input session in the form of 240226-0 (yymmdd-x): " input_session
        done

        echo $input_session
}

function f_get_input_session {

        input_session=$1
        parent=/home/dwalth/data/outputs/chpt-
        input_dir=$parent$input_session

        if [ $# -eq 0 ] || ! [ -d $input_dir ]
        then
                input_session=$(f_prompt_input_session $parent)
        fi

        echo $input_session
}

# <if name == main:>
#   input_session=$(f_get_input_session $1)
#   echo $input_session