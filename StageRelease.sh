#!/bin/bash

echo ">>>>> moving to PSALTer-devel"
cd ~/Documents/PSALTer-devel
echo ">>>>> copying FieldKinematics PDF"
cp xAct/PSALTer/Documentation/English/FieldKinematicsMetricPerturbation.pdf xAct/PSALTer/Logos/FieldKinematics.pdf
echo ">>>>> copying ParticleSpectrograph PDF"
cp xAct/PSALTer/Documentation/English/ParticleSpectrographMassiveGravity.pdf xAct/PSALTer/Logos/ParticleSpectrograph.pdf
echo ">>>>> moving to Logos directory"
cd xAct/PSALTer/Logos
echo ">>>>> converting FieldKinematics"
convert -density 400 FieldKinematics.pdf FieldKinematics.png 
echo ">>>>> converting ParticleSpectrograph"
convert -density 400 ParticleSpectrograph.pdf ParticleSpectrograph.png 
echo ">>>>> git add ."
git add .
echo ">>>>> git commit"
git commit -m "push for merge with master"
echo ">>>>> git push GitHubOrigin README"
git push GitHubOrigin README
echo ">>>>> moving to stager"
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
