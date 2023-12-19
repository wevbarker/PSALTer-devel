(*====================*)
(*  SummariseResults  *)
(*====================*)

BuildPackage@"ParticleSpectrum/SummariseResults/Status.m";
BuildPackage@"ParticleSpectrum/SummariseResults/CLIPrint.m";
BuildPackage@"ParticleSpectrum/SummariseResults/ShowIfSmall.m";
BuildPackage@"ParticleSpectrum/SummariseResults/Colours.m";
BuildPackage@"ParticleSpectrum/SummariseResults/DetailCell.m";
BuildPackage@"ParticleSpectrum/SummariseResults/MakeLabel.m";
BuildPackage@"ParticleSpectrum/SummariseResults/WignerGrid.m";
BuildPackage@"ParticleSpectrum/SummariseResults/RaggedBlock.m";
BuildPackage@"ParticleSpectrum/SummariseResults/PrintSourceConstraints.m";
BuildPackage@"ParticleSpectrum/SummariseResults/ReMagnify.m";
BuildPackage@"ParticleSpectrum/SummariseResults/ParallelGrid.m";
BuildPackage@"ParticleSpectrum/SummariseResults/MonitorParallel.m";
BuildPackage@"ParticleSpectrum/SummariseResults/SummariseTheory.m";
BuildPackage@"ParticleSpectrum/SummariseResults/PrintSpectrum.m";
BuildPackage@"ParticleSpectrum/SummariseResults/PrintUnitarityConditions.m";

SummariseResults[WaveOperator_,Propagator_,SourceConstraints_,Spectrum_,MasslessSpectrum_,OverallUnitarity_,SummaryOfTheory_]:=Module[{
	Computing,
	TheSummaryOfTheory,
	TheWaveOperator,
	ThePropagator,
	TheSourceConstraints,
	TheSpectrum,
	TheMasslessSpectrum,
	TheOverallUnitarity,
	SummaryOfResults
	},

	If[$CLI,
		SummaryOfResults=CLIPrint[
			WaveOperator,
			Propagator,
			SourceConstraints,
			Spectrum,
			MasslessSpectrum,
			OverallUnitarity];
	,
		Computing=Row[{ProgressIndicator[Appearance->"Necklace",ImageSize->Small],"Pending..."},Invisible@MakeLabel@"  ",Alignment->{Left,Center}];
		FullWidth=First@Rasterize[Show[Graphics[Circle[]],ImageSize->Full],"RasterSize"];

		TheSummaryOfTheory=SummariseTheory@SummaryOfTheory;
		If[WaveOperator===Null,
			TheWaveOperator=Computing,
			TheWaveOperator=WignerGrid@@WaveOperator];
		If[Propagator===Null,
			ThePropagator=Computing,
			ThePropagator=WignerGrid@@Propagator];
		If[SourceConstraints===Null,
			TheSourceConstraints=Computing,
			TheSourceConstraints=PrintSourceConstraints@@SourceConstraints];
		If[Spectrum===Null,
			TheSpectrum=Computing,
			TheSpectrum=PrintSpectrum@@Spectrum];
		If[MasslessSpectrum===Null,
			TheMasslessSpectrum=Computing,
			TheMasslessSpectrum=PrintSpectrum@@MasslessSpectrum];
		If[OverallUnitarity===Null,
			TheOverallUnitarity=Computing,
			TheOverallUnitarity=DetailCell@@(PrintUnitarityConditions@OverallUnitarity)];

		SummaryOfResults=Column[{
			MakeLabel@"PSALTer results panel",
			TheSummaryOfTheory,
			MakeLabel@"Wave operator",
			TheWaveOperator,
			MakeLabel@"Saturated propagator",
			ThePropagator,
			MakeLabel@"Source constraints",
			TheSourceConstraints,
			MakeLabel@"Massive spectrum",
			TheSpectrum,
			MakeLabel@"Massless spectrum",
			TheMasslessSpectrum(*,
			MakeLabel@"Gauge symmetries",
			"(Not yet implemented in PSALTer)"*),
			MakeLabel@"Unitarity conditions",
			TheOverallUnitarity(*,
			MakeLabel@"Validity assumptions",
			"(Not yet implemented in PSALTer)"*)
			},Spacings->{1,1},Frame->True,Background->PanelColor,Alignment->{Left,Center}];
	];
SummaryOfResults];
