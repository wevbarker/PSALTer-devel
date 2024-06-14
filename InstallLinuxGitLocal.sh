#!/bin/bash
cd ~/
sudo rm -rf /usr/share/Mathematica/Applications/xAct/PSALTer
rm -rf ~/.Mathematica/Applications/xAct/PSALTer
rm -rf ~/PSALTer-devel

git clone https://github.com/wevbarker/PSALTer-devel
cd PSALTer-devel/xAct
cp -r PSALTer ~/.Mathematica/Applications/xAct/

exit 0
