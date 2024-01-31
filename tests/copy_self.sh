parent=~/$(dirname $0)
cd $parent

output_dir=$parent/temp_copy_self
if ! [ -d $output_dir ]; then
        mkdir $output_dir
fi

cp ~/$(dirname $0)/$0 $output_dir/
#rm -rd $output_dir