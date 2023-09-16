#!/bin/bash

#============================#
#  This is the synchroniser  #
#============================#

rsync -avh --force --exclude '.git' --exclude 'release.sh' ./ ~/PSALTer/ --delete

exit 0
