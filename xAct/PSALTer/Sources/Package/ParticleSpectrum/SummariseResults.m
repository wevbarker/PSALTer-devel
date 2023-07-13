(*====================*)
(*  SummariseResults  *)
(*====================*)

ParallelGrid[Expr_]:=Quiet@Check[Grid[((#~Partition~(Ceiling@(0.5*Sqrt@Length@#)))&@Flatten@{Expr}),Frame->All],Null];

ReMagnify[Object_]:=Module[{
	FullWidth,
	DesiredWidth,
	ActualWidth,
	RequiredMagnification},

FullWidth=First@Rasterize[Show[Graphics[Circle[]],ImageSize->Full],"RasterSize"];
DesiredWidth=0.4*FullWidth;
ActualWidth=First@Rasterize[Object,"RasterSize"];
RequiredMagnification=Piecewise[{{1,ActualWidth<=DesiredWidth},{DesiredWidth/ActualWidth,ActualWidth>DesiredWidth}}];
Magnify[Object,RequiredMagnification]];

SummariseTheory[Theory_?StringQ]:=Theory;

NotStringQ[InputExpr_]:=!StringQ@InputExpr;

SummariseTheory[Theory_?NotStringQ]:=Module[{DisplayVersion},
	DisplayVersion=(Action==Integrate@@({((CollectConstants@Theory))@@#}~Join~(#[[1;;4]]))&@{TCoordinate,XCoordinate,YCoordinate,ZCoordinate});
	DisplayVersion//=Evaluate;
DisplayVersion];

SummariseResults[WaveOperator_,Propagator_,SourceConstraints_,Spectrum_,OverallUnitarity_,SummaryOfTheory_]:=Module[{
	Computing,
	TheWaveOperator,
	ThePropagator,
	TheSourceConstraints,
	TheSpectrum,
	TheOverallUnitarity,
	SummaryOfResults
	},

(*Computing=HoldForm@(DynamicModule[{StartTime=AbsoluteTime[]},Dynamic@Refresh[ProgressIndicator[Tanh[N@(AbsoluteTime[]-StartTime)/100],Appearance->"Necklace"],UpdateInterval->1]]);*)

	MakeLabel[SomeString_]:=Style[SomeString,Large];
	Computing=Row[{ProgressIndicator[Appearance->"Necklace",ImageSize->Large],MakeLabel@"Pending..."},Invisible@MakeLabel@"  ",Alignment->{Left,Center}];
	FullWidth=First@Rasterize[Show[Graphics[Circle[]],ImageSize->Full],"RasterSize"];

	If[WaveOperator===Null,
		TheWaveOperator=Computing,
		TheWaveOperator=ReMagnify[WaveOperator]];
	If[Propagator===Null,
		ThePropagator=Computing,
		ThePropagator=ReMagnify[Propagator]];
	If[SourceConstraints===Null,
		TheSourceConstraints=Computing,
		If[SourceConstraints==={},
			TheSourceConstraints=MakeLabel["(None)"],
			TheSourceConstraints=ReMagnify[SourceConstraints]];
		];
	If[Spectrum===Null,
		TheSpectrum=Computing,
		TheSpectrum=ReMagnify[Spectrum]];
	If[OverallUnitarity===Null,
		TheOverallUnitarity=Computing,
		If[OverallUnitarity===False,
			TheOverallUnitarity=MakeLabel["(Impossible)"],
			TheOverallUnitarity=ReMagnify[OverallUnitarity]];
	];

	SummaryOfResults=Grid[{
		{MakeLabel["PSALTer results panel"],SpanFromLeft},
		{SummariseTheory[SummaryOfTheory],SpanFromLeft},
		{MakeLabel["Wave operator"],
		MakeLabel["Saturated propagator"]},
		{TheWaveOperator,
		ThePropagator},
		{MakeLabel["Source constraints"],
		MakeLabel["Particle spectrum"]},
		{TheSourceConstraints,
		TheSpectrum},
		{MakeLabel["Gauge symmetries"],
		SpanFromAbove},
		{MakeLabel["(Not yet implemented)"],
		SpanFromAbove},
		{MakeLabel["Unitarity conditions"],MakeLabel["Assumptions"]},
		{TheOverallUnitarity,MakeLabel["(Not yet implemented)"]}
		},Spacings->{2,2},Frame->True,Background->RGBColor[250/255,250/255,250/255],Alignment->{Center,Center}];
SummaryOfResults];
