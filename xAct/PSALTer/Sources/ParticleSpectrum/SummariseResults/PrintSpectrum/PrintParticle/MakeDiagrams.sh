#!/bin/bash

#================#
#  MakeDiagrams  #
#================#

for f in Quadratic.tex Quartic.tex Hexic.tex Even0.tex Odd0.tex Even1.tex Odd1.tex Even2.tex Odd2.tex Even3.tex Odd3.tex; do latexmk -pdf -interaction=nonstopmode -pdflatex=lualatex $f; done
rm -rf *.aux
rm -rf *.fdb_latexmk
rm -rf *.fls
rm -rf *.log
 
exit 0
