#!/bin/bash

DECOMPRESS=false

while getopts d flag
do
    case "${flag}" in
        d) DECOMPRESS=true;;
    esac
done

for folder in $(ls .)
do
    if [ -d "$folder" ]; then
        pushd $folder > /dev/null
        for dt in $(ls .)
        do
            if [ "$DECOMPRESS" = true ] ; then
                if [[ ${dt} == *.tar.xz ]]; then
                    if [[ "$folder" == "compute" ]]; then # Compute data was not compressed as a separate folder
                        y=${dt%.tar.xz}
                        mkdir -p ${y##*/}
                        tar -xvf ${dt} --directory ${y##*/}
                    else
                        tar -xvf ${dt}  
                    fi
                fi
            else
                # Compress only folders
                if [ -d "$dt" ]; then         
                    if [[ "$folder" == "compute" ]]; then # Compute data was not compressed as a separate folder
                        pushd ${dt}
                        tar vcfJ ../${dt}.tar.xz *
                        popd
                    else
                        tar vcfJ ${dt}.tar.xz ${dt}
                    fi
                fi
            fi
        done
        popd > /dev/null
    fi
done