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

BuildPackage@"ParticleSpectrum/SummariseResults/SplitWignerGrid.m";
BuildPackage@"ParticleSpectrum/SummariseResults/PSALTerResultsCollage.m";

Options@SummariseResults={SummaryType->ResultsPanel};

SummariseResults[TheoryName_?StringQ,WaveOperator_,Propagator_,SourceConstraints_,Spectrum_,MasslessSpectrum_,OverallUnitarity_,SummaryOfTheory_,OptionsPattern[]]:=Module[{
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

	If[OptionValue@SummaryType==ResultsPanel,
		If[$CLI,
			SummaryOfResults=CLIPrint[
				TheoryName,
				WaveOperator,
				Propagator,
				SourceConstraints,
				Spectrum,
				MasslessSpectrum,
				OverallUnitarity];
		,
			Computing=Row[{ProgressIndicator[
					Appearance->"Necklace",
					ImageSize->Small],
					"Pending..."},
					Invisible@MakeLabel@"  ",Alignment->{Left,Center}];
			FullWidth=First@Rasterize[Show[Graphics[Circle[]],
							ImageSize->Full],"RasterSize"];

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
				TheSpectrum=If[ListQ@#,
				Grid[Partition[#,UpTo@2],Alignment->{Left,Top}],
				#,#]&@(PrintSpectrum@@Spectrum)];
			If[MasslessSpectrum===Null,
				TheMasslessSpectrum=Computing,
				TheMasslessSpectrum=If[ListQ@#,
				Grid[Partition[#,UpTo@2],Alignment->{Left,Top}],
				#,#]&@(PrintSpectrum@@MasslessSpectrum)];
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
				TheMasslessSpectrum,
				MakeLabel@"Unitarity conditions",
				TheOverallUnitarity},
				Spacings->{1,1},
				Frame->True,
				Background->PanelColor,
				Alignment->{Left,Center}];
		];
	];

	If[OptionValue@SummaryType==ResultsCollage,	

		FullWidth=First@Rasterize[Show[Graphics[Circle[]],
						ImageSize->Full],"RasterSize"];

		TheSummaryOfTheory=SummariseTheory@SummaryOfTheory;
		TheWaveOperator=SplitWignerGrid@@WaveOperator;
		ThePropagator=SplitWignerGrid@@Propagator;
		TheSourceConstraints=PrintSourceConstraints@@SourceConstraints;
		TheSpectrum=If[ListQ@#,#,{#},{#}]&@(PrintSpectrum@@Spectrum);
		TheMasslessSpectrum=If[ListQ@#,#,{#},{#}]&@(PrintSpectrum@@MasslessSpectrum);
		TheOverallUnitarity=DetailCell@@(PrintUnitarityConditions@OverallUnitarity);

		SummaryOfResults=PSALTerResultsCollage[
				TheSummaryOfTheory,
				TheWaveOperator,
				ThePropagator,
				TheSourceConstraints,
				TheSpectrum,
				TheMasslessSpectrum,
				TheOverallUnitarity];
	];
SummaryOfResults];
