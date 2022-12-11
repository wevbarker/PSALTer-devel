# Particle Spectrum for Any Lagrangian with Tensors (PSALTer)
## Version 1.0.0-developer

## License

Copyright © 2022 Will E. V. Barker

PSALTer is distributed as free software under the [GNU General Public License (GPL)](https://www.gnu.org/licenses/gpl-3.0.en.html).

PSALTer is provided without warranty, or the implied warranty of merchantibility or fitness for a particular purpose.

## About

PSALTer is an (unofficial) part of the [xAct bundle](http://www.xact.es/). The current version is designed to compute the particle spectrum of parity-preserving Poincaré gauge theories, and as such it is currently dependent on HiGGS. In the longer term, I see no reason why the PSALTer programme cannot be extended to any tensor lagrangian (hence the name), ranging from electromagnetism to higher-derivative models.

## Installation

#### Requirements 
PSALTer has been tested in the following environment(s):
- Linux x86 (64-bit), specifically Manjaro
- Mathematica v 13.1.0.0
- xAct v 1.2.0
- HiGGS v 2.0.0-developer
#### Install 
1. Make sure you have [installed xAct](http://www.xact.es/download.html).
2. Download HiGGS:
	```bash, git
	git clone https://github.com/wevbarker/PSALTer-devel
	cd PSALTer-devel 
	```
3. Place the `./xAct/PSALTer` directory relative to your xAct install. A global install might have ended up at: 
	```bash
	/usr/share/Mathematica/Applications/xAct
	```
## Quickstart 

The current example calculation is given in the `Calibration.nb` notebook, this is still the only theory for which I have tried running the computation. In the near future I will generate more examples.

## Contribute

Please do! I'm always responsive to emails (about science), so be sure to reach out at [wb263@cam.ac.uk](mailto:wb263@cam.ac.uk). I will also do my best to get your code working if you are just trying to use PSALTer.

## Acknowledgements

This work was performed using resources provided by the Cambridge Service for Data Driven Discovery (CSD3) operated by the University of Cambridge Research Computing Service ([www.csd3.cam.ac.uk](www.csd3.cam.ac.uk)), provided by Dell EMC and Intel using Tier-2 funding from the Engineering and Physical Sciences Research Council (capital grant EP/T022159/1), and DiRAC funding from the Science and Technology Facilities Council ([www.dirac.ac.uk](www.dirac.ac.uk)).

I am grateful for the kind hospitality of Leiden University and the [Lorentz Institute](https://www.lorentz.leidenuniv.nl/), and am supported by [Girton College, Cambridge](https://www.girton.cam.ac.uk/).
