#!/bin/bash
cd ~/
sudo rm -rf /Library/Mathematica/Applications/xAct/PSALTer
rm -rf ~/Library/Mathematica/Applications/xAct/PSALTer
rm -rf ~/PSALTer-devel

git clone https://github.com/wevbarker/PSALTer-devel
cd PSALTer-devel/xAct
sudo cp -r PSALTer /Library/Mathematica/Applications/xAct/

exit 0
