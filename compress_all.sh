#!/bin/bash
for folder in $(ls .)
do
    if [ -d "$folder" ]; then
        pushd $folder > /dev/null
        for dt in $(ls .)
        do
            if [ -d "$dt" ]; then
                tar -zcvf ${dt}.tar.gz ${dt}
            fi
        done
        popd > /dev/null
    fi
done