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
echo ">>>>> cd ~/Documents/PSALTer-devel"
cd ~/Documents/PSALTer-devel
echo ">>>>> git add ."
git add .
echo ">>>>> git commit"
git commit -m "push for merge with master"
echo ">>>>> git push GitHubOrigin Parallel"
git push GitHubOrigin Parallel 

exit 0
