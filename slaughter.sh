#!/bin/bash

#==========================================#
#  This purges the .Mathematica directory  #
#==========================================#

rm -rf ~/.Mathematica/Autoload
rm -rf ~/.Mathematica/FrontEnd
rm -rf ~/.Mathematica/Kernel
rm -rf ~/.Mathematica/Paclets
rm -rf ~/.Mathematica/SystemFiles

exit 0
