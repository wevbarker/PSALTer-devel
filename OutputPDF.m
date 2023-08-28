(*=============*)
(*  OutputPDF  *)
(*=============*)

<<xAct`xPlain`;

Comment@"We try to export a pdf of the output panel.";

ParityEvenColor=RGBColor[255/255,204/255,204/255];
ParityOddColor=RGBColor[204/255,229/255,255/255];
ParityMixColor=RGBColor[255/255,204/255,255/255];
PanelColor=RGBColor[252/255,252/255,252/255];
DetailColor=RGBColor[230/255,230/255,230/255];
SummaryOfResults=Column[{
		MakeLabel@"PSALTer results panel",
		SummariseTheory@SummaryOfTheory,
		MakeLabel@"Wave operator",
		TheWaveOperator,
		MakeLabel@"Saturated propagator",
		ThePropagator,
		MakeLabel@"Source constraints",
		TheSourceConstraints,
		MakeLabel@"Massive spectrum",
		TheSpectrum,
		MakeLabel@"Massless spectrum",
		TheMasslessSpectrum,
		MakeLabel@"Gauge symmetries",
		"(Not yet implemented in PSALTer)",
		MakeLabel@"Unitarity conditions",
		TheOverallUnitarity,
		MakeLabel@"Validity assumptions",
		"(Not yet implemented in PSALTer)"
		},Spacings->{2,2},Frame->True,Background->PanelColor,Alignment->{Left,Center}];
Print@SummaryOfResults;
Export[FileNameJoin@{NotebookDirectory[],"OutputPDF.pdf"},SummaryOfResults];

Quit[];
