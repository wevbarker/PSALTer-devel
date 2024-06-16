#!/bin/bash

echo ">>>>> cd ~/Documents/PSALTer-devel"
cd ~/Documents/PSALTer-devel
echo ">>>>> cp xAct/PSALTer/Documentation/English/FieldKinematicsMetricPerturbation.pdf xAct/PSALTer/Logos/FieldKinematics.pdf"
cp xAct/PSALTer/Documentation/English/FieldKinematicsMetricPerturbation.pdf xAct/PSALTer/Logos/FieldKinematics.pdf
echo ">>>>> cp xAct/PSALTer/Documentation/English/ParticleSpectrographMassiveGravity.pdf xAct/PSALTer/Logos/ParticleSpectrograph.pdf"
cp xAct/PSALTer/Documentation/English/ParticleSpectrographMassiveGravity.pdf xAct/PSALTer/Logos/ParticleSpectrograph.pdf
echo ">>>>> cd xAct/PSALTer/Logos"
cd xAct/PSALTer/Logos
echo ">>>>> convert -density 400 FieldKinematics.pdf FieldKinematics.png"
convert -density 400 FieldKinematics.pdf FieldKinematics.png 
echo ">>>>> convert -density 400 ParticleSpectrograph.pdf ParticleSpectrograph.png"
convert -density 400 ParticleSpectrograph.pdf ParticleSpectrograph.png 
echo ">>>>> git add ."
git add .
echo ">>>>> git commit"
git commit -m "push for merge with master"
echo ">>>>> git push GitHubOrigin README"
git push GitHubOrigin README
echo ">>>>> cd ~/Documents/PSALTer-stager"
cd ~/Documents/PSALTer-stager
echo ">>>>> git checkout README"
git checkout README
echo ">>>>> git pull"
git pull
echo ">>>>> git checkout master"
git checkout master 
echo ">>>>> rm -rf README.md xAct/PSALTer/Logos xAct/PSALTer/Sources xAct/PSALTer/Kernel xAct/PSALTer/Documentation"
rm -rf README.md xAct/PSALTer/Logos xAct/PSALTer/Sources xAct/PSALTer/Kernel xAct/PSALTer/Documentation
echo ">>>>> git checkout README README.md"
git checkout README README.md
echo ">>>>> git checkout README xAct/PSALTer/Logos"
git checkout README xAct/PSALTer/Logos
echo ">>>>> git checkout README xAct/PSALTer/Sources"
git checkout README xAct/PSALTer/Sources
echo ">>>>> git checkout README xAct/PSALTer/Kernel"
git checkout README xAct/PSALTer/Kernel
echo ">>>>> git checkout README xAct/PSALTer/Documentation/English/Documentation.pdf"
git checkout README xAct/PSALTer/Documentation/English/Documentation.pdf
echo ">>>>> git checkout README xAct/PSALTer/Documentation/English/Documentation.nb"
git checkout README xAct/PSALTer/Documentation/English/Documentation.nb
echo ">>>>> git add ."
git add .
echo ">>>>> git commit -m "
git commit -m "upgrade of master for Claire and Carlo"
echo ">>>>> git push GitHubOrigin master"
git push GitHubOrigin master 
echo ">>>>> cd ~/Documents/PSALTer-devel"
cd ~/Documents/PSALTer-devel
echo ">>>>> git pull --all"
git pull --all

exit 0
