#!/bin/bash

cd ~/Documents/PSALTer-devel
cp xAct/PSALTer/Documentation/English/FieldKinematicsMetricPerturbation.pdf xAct/PSALTer/Logos/FieldKinematics.pdf
cp xAct/PSALTer/Documentation/English/ParticleSpectrographMassiveGravity.pdf xAct/PSALTer/Logos/ParticleSpectrograph.pdf
cd xAct/PSALTer/Logos
convert -density 400 FieldKinematics.pdf FieldKinematics.png 
convert -density 400 ParticleSpectrograph.pdf ParticleSpectrograph.png 
cd ~/Documents/PSALTer-devel
git add .
git commit -m "push for merge with master"
git push GitHubOrigin README
cd ~/Documents/PSALTer-stage
git checkout README
git pull
git checkout master 
rm -rf README.md xAct/PSALTer/Logos xAct/PSALTer/Sources xAct/PSALTer/Kernel xAct/PSALTer/Documentation
git checkout README README.md
git checkout README xAct/PSALTer/Logos
git checkout README xAct/PSALTer/Sources
git checkout README xAct/PSALTer/Kernel
git checkout README xAct/PSALTer/Documentation/English/Documentation.pdf
git checkout README xAct/PSALTer/Documentation/English/Documentation.nb
git add .
git commit -m "upgrade of master for Claire and Carlo"
git push GitHubOrigin master 
cd ~/Documents/PSALTer-devel
git pull --all

exit 0
