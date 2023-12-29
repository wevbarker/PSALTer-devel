#!/bin/bash
echo "welcome to Calibration.sh"

echo "Attempting to recompile xperm.c on the native architecture"
cd /home/wb263/.Mathematica/Applications/xAct/xPerm/mathlink
/usr/local/software/mathematica/13.1/SystemFiles/Links/WSTP/DeveloperKit/Linux-x86-64/CompilerAdditions/wsprep -o xpermtm.c xperm.tm
/usr/local/software/mathematica/13.1/bin/mcc xperm.tm -luuid -O3 -o xperm.linux.64-bit
echo "Completed attempt to recompile xperm.c on the native architecture"

#	first make sure we are in the correct directory
echo "moving to directory"
cd /home/wb263/Documents/PSALTer-devel/xAct/PSALTer/Documentation/English

echo "commencing run"
math -run < Calibration.m

echo "killing processes with pkill"
pkill -9 "Mathematica"
pkill -9 "Wolfram"
pkill -9 "xPert"
pkill -9 "xperm"

echo "the following processes are still running on this node:"
ps -u wb263

echo "exiting with code 0"
exit 0
