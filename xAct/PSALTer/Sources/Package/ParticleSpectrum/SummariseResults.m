(*====================*)
(*  SummariseResults  *)
(*====================*)

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

SummariseResults[WaveOperator_,Propagator_,SourceConstraints_,Spectrum_,OverallUnitarity_]:=Module[{
	Computing,
	TheWaveOperator,
	ThePropagator,
	TheSourceConstraints,
	TheSpectrum,
	TheOverallUnitarity,
	SummaryOfResults
	},

	MakeLabel[SomeString_]:=Style[SomeString,Large];

	If[WaveOperator===Null,
		TheWaveOperator=MakeLabel["(Computing...)"],
		TheWaveOperator=ReMagnify[WaveOperator]];
	If[Propagator===Null,
		ThePropagator=MakeLabel["(Computing...)"],
		ThePropagator=ReMagnify[Propagator]];
	If[SourceConstraints===Null,
		TheSourceConstraints=MakeLabel["(Computing...)"],
		If[SourceConstraints==={},
			TheSourceConstraints=MakeLabel["(None)"],
			TheSourceConstraints=ReMagnify[SourceConstraints]];
		];
	If[Spectrum===Null,
		TheSpectrum=MakeLabel["(Computing...)"],
		TheSpectrum=ReMagnify[Spectrum]];
	If[OverallUnitarity===Null,
		TheOverallUnitarity=MakeLabel["(Computing...)"],
		If[OverallUnitarity===False,
			TheOverallUnitarity=MakeLabel["(Unitarity is impossible)"],
			TheOverallUnitarity=ReMagnify[OverallUnitarity]];
	];

	SummaryOfResults=Grid[{
		{MakeLabel["Wave operator"],
		MakeLabel["Propagator"]},
		{TheWaveOperator,
		ThePropagator},
		{MakeLabel["Source constraints"],
		MakeLabel["Spectrum"]},
		{TheSourceConstraints,
		TheSpectrum},
		{MakeLabel["Overall unitarity conditions"],SpanFromLeft},
		{TheOverallUnitarity,SpanFromLeft}
		},Spacings->{2,2},Frame->True,Background->RGBColor[240/255,240/255,240/255]];
SummaryOfResults];
