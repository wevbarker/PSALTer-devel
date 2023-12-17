(*========*)
(*  Test  *)
(*========*)

Status[InputExpr_]:=Module[{TextPending="Pending...",TextDone="Done!",OutputString},
	If[InputExpr==Null,
		OutputString=TextPending,
		If[StringQ@InputExpr,
			OutputString=InputExpr,
			OutputString=TextDone,
			OutputString=TextDone
		];,
		If[StringQ@InputExpr,
			OutputString=InputExpr,
			OutputString=TextDone,
			OutputString=TextDone
		];
	];
OutputString];

CLIPrint[WaveOperator_,Propagator_,SourceConstraints_,Spectrum_,MasslessSpectrum_,OverallUnitarity_]:=Module[{
	TextTotal,
	TextASCIILogo=Import@FileNameJoin@{"xAct","PSALTer","Documentation","Logo","ASCIILogo.txt"}
	},
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


SessionSubmit[ScheduledTask[(
TextTotal=CLIPrint[
		WaveOperator,
		Propagator,
		SourceConstraints,
		Spectrum,
		MasslessSpectrum,
		OverallUnitarity];
Print@TextTotal;
), Quantity[1, "Seconds"]]];


WaveOperator=Null;
Propagator=Null;
SourceConstraints=Null;
Spectrum=Null;
MasslessSpectrum=Null;
OverallUnitarity=Null;

Pause@4;
WaveOperator="working";
Pause@4;
WaveOperator="working harder";
Pause@4;
WaveOperator=13;


Quit[];
