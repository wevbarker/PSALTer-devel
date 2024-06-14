#!/bin/bash
cd ~/
ls /Library/Mathematica/Applications/xAct
sudo rm -rf /Library/Mathematica/Applications/xAct/PSALTer
ls /Library/Mathematica/Applications/xAct
ls ~/Library/Mathematica/Applications/xAct
rm -rf ~/Library/Mathematica/Applications/xAct/PSALTer
ls ~/Library/Mathematica/Applications/xAct
rm -rf ~/PSALTer-devel

git clone https://github.com/wevbarker/PSALTer-devel
cd PSALTer-devel/xAct
cp -r PSALTer ~/Library/Mathematica/Applications/xAct/
ls ~/Library/Mathematica/Applications/xAct
cd ~/Documents/PSALTer-devel

exit 0
