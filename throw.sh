#!/bin/bash

#============================#
#  This is the synchroniser  #
#============================#


if [ "$1" = "--newton" ]; then
	rsync -avh -e 'ssh -A -J appcs' --force --exclude '.git' --exclude="*.mx" ./ newton:~/PSALTer-devel/ --delete
elif [ "$1" = "--green" ]; then
	rsync -avh --force --exclude '.git' --exclude="*.mx" ./ green:~/Documents/PSALTer-devel/ --delete
elif [ "$1" = "--red" ]; then
	rsync -avh --force --exclude '.git' --exclude="*.mx" ./ red:~/Documents/PSALTer-devel/ --delete
elif [ "$1" = "--Cumulus" ]; then
	rsync -avh --force --exclude '.git' --exclude="*.mx" ./ Cumulus-q:~/Documents/PSALTer-devel/ --delete
else
	echo "can you please specify a remote location from newton, green, red or Cumulus?"	
fi

exit 0
