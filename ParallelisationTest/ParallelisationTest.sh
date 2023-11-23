#!/bin/bash
#	this file runs the jobs specified in jobs.m 
echo "welcome to ParallelisationTest.sh"

#	first make sure we are in the correct directory
echo "moving to directory"
cd /home/wb263/Documents/PSALTer-devel

echo "commencing run"
math -run < ParallelisationTest.m

echo "killing processes with pkill"
pkill -9 "Mathematica"
pkill -9 "Wolfram"
pkill -9 "xPert"
pkill -9 "xperm"

echo "the following processes are still running on this node:"
ps -u wb263

echo "exiting with code 0"
exit 0
