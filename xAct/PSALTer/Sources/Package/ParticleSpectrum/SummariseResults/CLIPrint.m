(*============*)
(*  CLIPrint  *)
(*============*)

CLIPrint[WaveOperator_,Propagator_,SourceConstraints_,Spectrum_,MasslessSpectrum_,OverallUnitarity_]:=Module[{
	TextTotal,
	TextASCIILogo=Import@FileNameJoin@{$PSALTerInstallDirectory,"Documentation/Logo/TextASCIILogo.txt"}},
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
