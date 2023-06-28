#! /bin/bash
IFS=$'\n'

dest_dir=$1
all_dirs=$(ls -d $dest_dir/*/)

conf_file=$2

all_imported="pass"

for dir in $all_dirs
do
    dir_name=$(echo $dir | rev | cut -d'/' -f 2 | rev)
    echo "Importing $dir"
    all_imported="$all_imported !$dir_name"
    echo "dest $dir_name {" >> $conf_file
    
    if [ -f "$dir/domains" ]; then
        echo "    domainlist      dest/$dir_name/domains" >> $conf_file
    fi

    if [ -f "$dir/urls" ]; then
        echo "    urllist         dest/$dir_name/urls" >> $conf_file
    fi

    if [ -f "$dir/expressions" ]; then
        echo "    expressionlist  dest/$dir_name/expressions" >> $conf_file
    fi

echo "}

" >> $conf_file

done

echo "$all_imported" >> $conf_file