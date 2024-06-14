#!/bin/bash
cd ~/
sudo rm -rf /usr/share/Mathematica/Applications/xAct/PSALTer
rm -rf ~/.Mathematica/Applications/xAct/PSALTer
rm -rf ~/PSALTer-devel

unzip ~/Downloads/wevbarker-PSALTer-devel-* ~/
mv ~/wevbarker-PSALTer-devel-* ~/PSALTer-devel
cd PSALTer-devel/xAct
sudo cp -r PSALTer /usr/share/Mathematica/Applications/xAct/

exit 0
