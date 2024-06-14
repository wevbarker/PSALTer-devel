#!/bin/bash
cd ~/
sudo rm -rf /Library/Mathematica/Applications/xAct/PSALTer
rm -rf ~/Library/Mathematica/Applications/xAct/PSALTer
rm -rf ~/PSALTer-devel

unzip ~/Downloads/wevbarker-PSALTer-devel-* ~/
mv ~/wevbarker-PSALTer-devel-* ~/PSALTer-devel
cd PSALTer-devel/xAct
sudo cp -r PSALTer /Library/Mathematica/Applications/xAct/

exit 0
