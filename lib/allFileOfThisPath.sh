#! /bin/bash

function allFileOfThisPath() {

    for dir in $(ls /d/)
    do
    [ -d $dir ] && echo $dir
    done
}