#!/bin/bash

cd ~
mkdir super_dir_empty
cd ~/super_dir_empty

echo "pwd = set to a different dir than this file: $(pwd)"
echo "path in ~/path/\$0:" $(dirname $0)
echo "this file's parent:" ~/$(dirname $0)  # returns path in ~/path/$0
echo "this file's file path:" ~/$(dirname $0)/$0
cd ~/$(dirname $0)  # changes directory to this script's parent
echo "pwd = parent of this file: $(pwd)"

cd ~
rm -d super_dir_empty