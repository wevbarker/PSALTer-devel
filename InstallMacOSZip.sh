#!/bin/bash
cd ~/
ls /Library/Mathematica/Applications/xAct
sudo rm -rf /Library/Mathematica/Applications/xAct/PSALTer
ls /Library/Mathematica/Applications/xAct
ls ~/Library/Mathematica/Applications/xAct
rm -rf ~/Library/Mathematica/Applications/xAct/PSALTer
ls ~/Library/Mathematica/Applications/xAct
rm -rf ~/PSALTer-devel

unzip ~/Downloads/wevbarker-PSALTer-devel-* ~/
mv ~/wevbarker-PSALTer-devel-* ~/PSALTer-devel
cd PSALTer-devel/xAct
sudo cp -r PSALTer /Library/Mathematica/Applications/xAct/
ls /Library/Mathematica/Applications/xAct
cd ~/Documents/PSALTer-devel

exit 0
