#!/bin/bash

#==================================#
#  This file is a local installer  #
#==================================#

if [ "$1" = "--pull" ]; then
	rsync -avh --force ~/.Mathematica/Applications/xAct/PSALTer/Binaries/* ./xAct/PSALTer/Binaries/ --delete
elif [ "$1" = "--push" ]; then
	rsync -avh --force ./xAct/* ~/.Mathematica/Applications/xAct/ --delete
else
	rsync -avh --force --exclude '*.mx' ./xAct/* ~/.Mathematica/Applications/xAct/ --delete
fi

tree xAct > ./.direcory_tree

exit 0
