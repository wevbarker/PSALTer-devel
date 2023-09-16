#!/bin/bash

#======================================#
#  This converts the pdf files to png  #
#======================================#

for f in ./xAct/PSALTer/Documentation/English/*.pdf ; do 
	echo "$f" ; 
	newname=$(echo "$f" | sed 's/...$//') ; 
	echo "${newname}png" ;
	convert -density 150 "$f" "${newname}png" ; 
done


exit 0
