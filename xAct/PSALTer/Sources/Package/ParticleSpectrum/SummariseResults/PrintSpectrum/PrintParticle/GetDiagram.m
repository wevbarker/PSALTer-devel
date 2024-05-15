(*==============*)
(*  GetDiagram  *)
(*==============*)

GetDiagram[FileName_]:=Module[{TemporaryFileName,Expr},
	TemporaryFileName=FileNameJoin@{$PSALTerInstallDirectory,"Sources/Package/ParticleSpectrum/SummariseResults/PrintSpectrum/PrintParticle",FileName};
	Expr=TemporaryFileName~Import~{"PDF","PageGraphics"};
Expr];
