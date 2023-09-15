<img src="xAct/PSALTer/Documentation/Logo/GitHubLogo.png" width="1000">

# Particle Spectrum for Any Tensor Lagrangian (PSALTer)
## Version 0.0.0-developer

- Pre-release version, pending completion of preprint and docs.
- Functionality for Weyl gauge theory and metric affine gravity removed due to ongoing collaborations with Tallinn and Tartu.

## License

Copyright © 2022 Will E. V. Barker

PSALTer is distributed as free software under the [GNU General Public License (GPL)](https://www.gnu.org/licenses/gpl-3.0.en.html).

PSALTer is provided without warranty, or the implied warranty of merchantibility or fitness for a particular purpose.

## About

PSALTer is an (unofficial) part of the [xAct bundle](http://www.xact.es/). 

PSALTer is designed to predict the propagating quantum particle states in any tensorial field theory, including (but not limited to) just about any theory of gravity.

$$S_{\text{F}},$$

$$S_{\text{F}}=\int\mathrm{d}^4x$$

$$S_{\text{F}}=\int\mathrm{d}^4x\ \sum_X\zeta_{{\mu}_{X}}\Big[\sum_Y\mathcal{O}^{\mu_{X}}$$

$$S_{\text{F}}=\int\mathrm{d}^4x\ \sum_X\zeta_{{\mu}_{X}}\Big[\sum_Y\mathcal{O}^{\mu_{X}}_{\nu_{Y}}\zeta^{\nu_{Y}}-j^{\nu_{Y}}\Big],$$

As a demonstration, let's say our Lagrangian is the Kretschmann curvature scalar, plus the square of the torsion tensor. We simply linearise the theory near Minkowski spacetime (in terms of the connection and tetrad perturbation), plug it into PSALTer and voilà:
<img src="xAct/PSALTer/Documentation/English/MelichevPercacciTheory.pdf.png" width="1000">

## Installation

#### Requirements 

PSALTer has been tested in the following environment(s):
- Linux x86 (64-bit) (specifically Manjaro and Arch)
- Mathematica v 13.1.0.0
- xAct v 1.2.0
- MaTeX v 1.7.9
- xPlain v 0.0.0-developer (if running the Calibration notebook)

#### Install 

1. Make sure you have [installed xAct](http://www.xact.es/download.html).
2. Make sure you have [installed MaTeX](http://szhorvat.net/pelican/latex-typesetting-in-mathematica.html).
3. Download PSALTer:
	```bash, git
	git clone https://github.com/wevbarker/PSALTer-devel
	cd PSALTer-devel 
	```
4. Place the `./xAct/PSALTer` directory relative to your xAct install. A global install might have ended up at: 
	```bash
	/usr/share/Mathematica/Applications/xAct
	```
## Quickstart 

1. In the cloned PSALTer repository, open the example notebook at `./xAct/PSALTer/Documentation/English/Calibration.nb`, scroll through *without running* to understand the capabilities and scope of PSALTer.
2. Make sure you have [installed xPlain](https://github.com/wevbarker/xPlain) if you want to run `Calibration.nb`, then simply execute the single line of code in the first (and only) input cell (you should first delete all the output using `Cell -> Delete All Output` in the Mathematica front-end).
3. The first time you run `Calibration.nb` after a fresh install, PSALTer will rebuild certain binary files. This may take some time, especially on Windows machines.
4. After the install completes successfully, delete the build output cells as before, and re-run the first input cell.
5. To see how the examples are implemented, and to test your own theories, go to the Wolfram Language file at `./xAct/PSALTer/Documentation/English/Calibration.m`, and all the various sub-files referred to therein under the path `./xAct/PSALTer/Documentation/English/Calibration/`.

## Contribute

Please do! I'm always responsive to emails (about science), so be sure to reach out at [wb263@cam.ac.uk](mailto:wb263@cam.ac.uk). I will also do my best to get your code working if you are just trying to use PSALTer.

## Acknowledgements

This work was performed using resources provided by the Cambridge Service for Data Driven Discovery (CSD3) operated by the University of Cambridge Research Computing Service ([www.csd3.cam.ac.uk](www.csd3.cam.ac.uk)), provided by Dell EMC and Intel using Tier-2 funding from the Engineering and Physical Sciences Research Council (capital grant EP/T022159/1), and DiRAC funding from the Science and Technology Facilities Council ([www.dirac.ac.uk](www.dirac.ac.uk)).

This work was also performed using the Newton server, access to which was provisioned by Will Handley.

PSALTer was improved by many useful discussions with Jaakko Annala, Stephanie Buttigieg, Mike Hobson, Manuel Hohmann, Damianos Iosifidis, Georgios Karananas, Anthony Lasenby, Yun-Cherng Lin, Carlo Marzo, Vijay Nenmeli, Roberto Percacci, Syksy Räsänen, Cillian Rew, Claire Rigouzzo, Zhiyuan Wei, David Yallup, and Sebastian Zell.

I am grateful for the kind hospitality of Leiden University and the [Lorentz Institute](https://www.lorentz.leidenuniv.nl/), and am supported by [Girton College, Cambridge](https://www.girton.cam.ac.uk/).

## Metric-affine gravity

### Metric-affine Einstein-Hilbert theory 
<img src="xAct/PSALTer/Documentation/English/MetricAffineEinsteinHilbertTheory.pdf.png" width="1000">

### Annala-Räsänen column one row one
<img src="xAct/PSALTer/Documentation/English/AnnalaRasanenCol1Row1.pdf.png" width="1000">

### Annala-Räsänen column one row two
<img src="xAct/PSALTer/Documentation/English/AnnalaRasanenCol1Row2.pdf.png" width="1000">

### Annala-Räsänen column one row three
<img src="xAct/PSALTer/Documentation/English/AnnalaRasanenCol1Row3.pdf.png" width="1000">

### Annala-Räsänen column one row four
<img src="xAct/PSALTer/Documentation/English/AnnalaRasanenCol1Row4.pdf.png" width="1000">

### Annala-Räsänen column one row five
<img src="xAct/PSALTer/Documentation/English/AnnalaRasanenCol1Row5.pdf.png" width="1000">

## Zero-torsion Palatini gravity

### Annala-Räsänen column three row one
<img src="xAct/PSALTer/Documentation/English/AnnalaRasanenCol3Row1.pdf.png" width="1000">

### Annala-Räsänen column three row two
<img src="xAct/PSALTer/Documentation/English/AnnalaRasanenCol3Row2.pdf.png" width="1000">

### Annala-Räsänen column three row two
<img src="xAct/PSALTer/Documentation/English/AnnalaRasanenCol3Row3.pdf.png" width="1000">

### Annala-Räsänen column three row four
<img src="xAct/PSALTer/Documentation/English/AnnalaRasanenCol3Row4.pdf.png" width="1000">

## Scalar-tensor theory

### Massless Fierz-Pauli theory
<img src="xAct/PSALTer/Documentation/English/FierzPauliTheory.pdf.png" width="1000">

### Massive Fierz-Pauli theory 
<img src="xAct/PSALTer/Documentation/English/MassiveGravity.pdf.png" width="1000">

### Sick massless Fierz-Pauli theory
<img src="xAct/PSALTer/Documentation/English/ThirdSickFierzPauliTheory.pdf.png" width="1000">

### Sick massless Fierz-Pauli theory
<img src="xAct/PSALTer/Documentation/English/FirstSickFierzPauliTheory.pdf.png" width="1000">

### Sick massless Fierz-Pauli theory
<img src="xAct/PSALTer/Documentation/English/FourthSickFierzPauliTheory.pdf.png" width="1000">

### Sick massless Fierz-Pauli theory
<img src="xAct/PSALTer/Documentation/English/SecondSickFierzPauliTheory.pdf.png" width="1000">

### Marzo theory 
<img src="xAct/PSALTer/Documentation/English/MarzoTheory.pdf.png" width="1000">

### Sick massive Fierz-Pauli theory
<img src="xAct/PSALTer/Documentation/English/SickMassiveGravity.pdf.png" width="1000">

### Scalar-Fierz-Pauli theory
<img src="xAct/PSALTer/Documentation/English/ScalarFierzPauliTheory.pdf.png" width="1000">

### Scalar-Einstein-Gauss-Bonnet theory
<img src="xAct/PSALTer/Documentation/English/SpecialLambda1.pdf.png" width="1000">

### Scalar-Einstein-Gauss-Bonnet theory
<img src="xAct/PSALTer/Documentation/English/SpecialLambda2.pdf.png" width="1000">

### Scalar-Einstein-Gauss-Bonnet theory
<img src="xAct/PSALTer/Documentation/English/SpecialLambda3.pdf.png" width="1000">

### Scalar-Einstein-Gauss-Bonnet theory
<img src="xAct/PSALTer/Documentation/English/GeneralLambda1.pdf.png" width="1000">

### Scalar-Einstein-Gauss-Bonnet theory
<img src="xAct/PSALTer/Documentation/English/GeneralLambda2.pdf.png" width="1000">

### Scalar-Einstein-Gauss-Bonnet theory
<img src="xAct/PSALTer/Documentation/English/GeneralLambda3.pdf.png" width="1000">

## Scalar theory

### Massive Klein-Gordon theory 
<img src="xAct/PSALTer/Documentation/English/MassiveScalarTheory.pdf.png" width="1000">

### Massless Klein-Gordon theory 
<img src="xAct/PSALTer/Documentation/English/MasslessScalarTheory.pdf.png" width="1000">

## Vector theory

### Longitudinal massless vector
<img src="xAct/PSALTer/Documentation/English/LongitudinalMassless.pdf.png" width="1000">

### Maxwell theory 
<img src="xAct/PSALTer/Documentation/English/MaxwellTheory.pdf.png" width="1000">

### Proca theory
<img src="xAct/PSALTer/Documentation/English/ProcaTheory.pdf.png" width="1000">

### Sick Maxwell theory
<img src="xAct/PSALTer/Documentation/English/SickMaxwellTheory.pdf.png" width="1000">

### Sick Proca theory
<img src="xAct/PSALTer/Documentation/English/SickProcaTheory.pdf.png" width="1000">

### Longitudinal massive vector
<img src="xAct/PSALTer/Documentation/English/LongitudinalMassive.pdf.png" width="1000">

## Poincaré gauge theory

### Einstein-Cartan theory 
<img src="xAct/PSALTer/Documentation/English/EinsteinCartanTheory.pdf.png" width="1000">

### General Poincaré gauge theory
<img src="xAct/PSALTer/Documentation/English/GeneralPGT.pdf.png" width="1000">

### General relativity 
<img src="xAct/PSALTer/Documentation/English/GeneralRelativity.pdf.png" width="1000">

### Poincaré gauge theory with massless even scalar
<img src="xAct/PSALTer/Documentation/English/MinimalEvenScalar.pdf.png" width="1000">

### Poincaré gauge theory with massive odd scalar
<img src="xAct/PSALTer/Documentation/English/MinimalMassiveOddScalar.pdf.png" width="1000">

### Poincaré gauge theory with massless odd scalar
<img src="xAct/PSALTer/Documentation/English/MinimalMasslessOddScalar.pdf.png" width="1000">

### Melichev-Percacci theory 
<img src="xAct/PSALTer/Documentation/English/MelichevPercacciTheory.pdf.png" width="1000">

### Annala-Räsänen column four 
<img src="xAct/PSALTer/Documentation/English/AnnalaRasanenColumn4.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 1
<img src="xAct/PSALTer/Documentation/English/Case1.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 2
<img src="xAct/PSALTer/Documentation/English/Case2.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 3
<img src="xAct/PSALTer/Documentation/English/Case3.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 4
<img src="xAct/PSALTer/Documentation/English/Case4.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 6
<img src="xAct/PSALTer/Documentation/English/Case6.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 7
<img src="xAct/PSALTer/Documentation/English/Case7.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 8
<img src="xAct/PSALTer/Documentation/English/Case8.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 9
<img src="xAct/PSALTer/Documentation/English/Case9.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 10
<img src="xAct/PSALTer/Documentation/English/Case10.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 12
<img src="xAct/PSALTer/Documentation/English/Case11.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 13
<img src="xAct/PSALTer/Documentation/English/Case12.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 13
<img src="xAct/PSALTer/Documentation/English/Case13.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 14
<img src="xAct/PSALTer/Documentation/English/Case14.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 15
<img src="xAct/PSALTer/Documentation/English/Case15.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 16
<img src="xAct/PSALTer/Documentation/English/Case16.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 17
<img src="xAct/PSALTer/Documentation/English/Case17.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 18
<img src="xAct/PSALTer/Documentation/English/Case18.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 19
<img src="xAct/PSALTer/Documentation/English/Case19.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 20
<img src="xAct/PSALTer/Documentation/English/Case20.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 21
<img src="xAct/PSALTer/Documentation/English/Case21.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 22
<img src="xAct/PSALTer/Documentation/English/Case22.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 23
<img src="xAct/PSALTer/Documentation/English/Case23.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 24
<img src="xAct/PSALTer/Documentation/English/Case24.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 25
<img src="xAct/PSALTer/Documentation/English/Case25.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 26
<img src="xAct/PSALTer/Documentation/English/Case26.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 27
<img src="xAct/PSALTer/Documentation/English/Case27.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 28
<img src="xAct/PSALTer/Documentation/English/Case28.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 29
<img src="xAct/PSALTer/Documentation/English/Case29.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 30
<img src="xAct/PSALTer/Documentation/English/Case30.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 31
<img src="xAct/PSALTer/Documentation/English/Case31.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 32
<img src="xAct/PSALTer/Documentation/English/Case32.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 33
<img src="xAct/PSALTer/Documentation/English/Case33.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 34
<img src="xAct/PSALTer/Documentation/English/Case34.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 35
<img src="xAct/PSALTer/Documentation/English/Case35.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 36
<img src="xAct/PSALTer/Documentation/English/Case36.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 37
<img src="xAct/PSALTer/Documentation/English/Case37.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 38
<img src="xAct/PSALTer/Documentation/English/Case38.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 39
<img src="xAct/PSALTer/Documentation/English/Case39.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 40
<img src="xAct/PSALTer/Documentation/English/Case40.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 41
<img src="xAct/PSALTer/Documentation/English/Case41.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 42
<img src="xAct/PSALTer/Documentation/English/Case42.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 43
<img src="xAct/PSALTer/Documentation/English/Case43.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 44
<img src="xAct/PSALTer/Documentation/English/Case44.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 45
<img src="xAct/PSALTer/Documentation/English/Case45.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 46
<img src="xAct/PSALTer/Documentation/English/Case46.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 47
<img src="xAct/PSALTer/Documentation/English/Case47.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 48
<img src="xAct/PSALTer/Documentation/English/Case48.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 49
<img src="xAct/PSALTer/Documentation/English/Case49.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 50
<img src="xAct/PSALTer/Documentation/English/Case50.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 51
<img src="xAct/PSALTer/Documentation/English/Case51.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 52
<img src="xAct/PSALTer/Documentation/English/Case52.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 53
<img src="xAct/PSALTer/Documentation/English/Case53.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 54
<img src="xAct/PSALTer/Documentation/English/Case54.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 55
<img src="xAct/PSALTer/Documentation/English/Case55.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 56
<img src="xAct/PSALTer/Documentation/English/Case56.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 57
<img src="xAct/PSALTer/Documentation/English/Case57.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 58
<img src="xAct/PSALTer/Documentation/English/Case58.pdf.png" width="1000">

### Lin-Hobson-Lasenby case 59
<img src="xAct/PSALTer/Documentation/English/Case5.pdf.png" width="1000">
