(*============*)
(*  CLIPrint  *)
(*============*)

CLIPrint[WaveOperator_,Propagator_,SourceConstraints_,Spectrum_,MasslessSpectrum_,OverallUnitarity_]:=Module[{
	TextTotal,
	TextASCIILogo="

 ____  ____    _    _   _____         
|  _ \/ ___|  / \  | | |_   _|__ _ __ 
| |_) \___ \ / _ \ | |   | |/ _ \ '__|
|  __/ ___) / ___ \| |___| |  __/ |   
|_|   |____/_/   \_\_____|_|\___|_|   
                                      
"},
TextTotal=StringJoin@@{
TextASCIILogo,
"
Wave operator......................",
Status@WaveOperator,
"
Saturated propagator...............",
Status@Propagator,
"
Source constraints.................",
Status@SourceConstraints,
"
Massive spectrum...................",
Status@Spectrum,
"
Massless spectrum..................",
Status@MasslessSpectrum,
"
Unitarity conditions...............",
Status@OverallUnitarity};
TextTotal];
