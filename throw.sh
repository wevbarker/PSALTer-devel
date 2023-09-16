#!/bin/bash

#============================#
#  This is the synchroniser  #
#============================#


if [ "$1" = "--newton" ]; then
	rsync -avh -e 'ssh -A -J appcs' --force --exclude '.git' ./ newton:~/PSALTer-devel/ --delete
elif [ "$1" = "--green" ]; then
	rsync -avh --force ./ green:~/Documents/PSALTer-devel/ --delete
elif [ "$1" = "--red" ]; then
	rsync -avh --force --exclude '.git' ./ red:~/Documents/PSALTer-devel/ --delete
else
	echo "can you please specify a remote location from newton, green or red?"	
fi

exit 0
