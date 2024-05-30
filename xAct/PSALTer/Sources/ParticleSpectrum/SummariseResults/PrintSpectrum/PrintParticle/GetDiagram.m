(*==============*)
(*  GetDiagram  *)
(*==============*)

GetDiagram[FileName_]:=Module[{TemporaryFileName,Expr},
	TemporaryFileName=FileNameJoin@{$PSALTerInstallDirectory,
		"Sources",
		"ParticleSpectrum",
		"SummariseResults",
		"PrintSpectrum",
		"PrintParticle",FileName};
	Expr=TemporaryFileName~Import~{"PDF","PageGraphics"};
	Expr//=First;
Expr];
