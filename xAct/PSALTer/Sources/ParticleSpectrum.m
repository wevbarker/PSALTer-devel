(*====================*)
(*  ParticleSpectrum  *)
(*====================*)

IncludeHeader@"ValidateTheoryName";
IncludeHeader@"ValidateMethod";
IncludeHeader@"ValidateMaxLaurentDepth";
IncludeHeader@"ValidateLagrangian";
IncludeHeader@"CombineAssociations";
IncludeHeader@"UpdateTheoryAssociation";
IncludeHeader@"SummariseResults";
IncludeHeader@"ConstructLinearAction";
IncludeHeader@"ConstructWaveOperator";
IncludeHeader@"ConstructSourceConstraints";
IncludeHeader@"ConstructSaturatedPropagator";
IncludeHeader@"ConstructMassiveAnalysis";
IncludeHeader@"ConstructMasslessAnalysis";
IncludeHeader@"ConstructUnitarityConditions";

Off[Set::write];
Off[SetDelayed::write];

Options@ParticleSpectrumActual={TheoryName->False,Method->"Easy",MaxLaurentDepth->1};
ParticleSpectrum::NoFile="The file `1` cannot be found.";
ParticleSpectrumActual[OptionsPattern[]]:=Catch@Module[{
	SummaryOfResults,
	PDFSummaryOfResults,
	Class},

	ValidateTheoryName@OptionValue@TheoryName;
	Check[Get@FileNameJoin@{$WorkingDirectory,"ParticleSpectrograph"<>OptionValue@TheoryName<>".mx"};,Throw@Message[ParticleSpectrum::NoFile,FileNameJoin@{$WorkingDirectory,"ParticleSpectrograph"<>OptionValue@TheoryName<>".mx"}]];
	Class=Evaluate@Symbol@OptionValue@TheoryName;
	SummaryOfResults=SummariseResults[
		OptionValue@TheoryName,
		Class@SavedWaveOperator,
		Class@SavedPropagator,
		Class@SavedSourceConstraints,
		Class@SavedSpectrum,
		Class@SavedMasslessSpectrum,
		Class@SavedOverallUnitarity,
		Class@SavedSummaryOfTheory];
	SummariseResultsOngoing=PrintTemporary@SummaryOfResults;
	PDFSummaryOfResults=SummariseResults[
			OptionValue@TheoryName,
			Class@SavedWaveOperator,
			Class@SavedPropagator,
			Class@SavedSourceConstraints,
			Class@SavedSpectrum,
			Class@SavedMasslessSpectrum,
			Class@SavedOverallUnitarity,
			Class@SavedSummaryOfTheory,
			SummaryType->ResultsCollage];
	Export[FileNameJoin@{$WorkingDirectory,"ParticleSpectrograph"<>OptionValue@TheoryName<>".pdf"},
		PDFSummaryOfResults
	];
	NotebookDelete@SummariseResultsOngoing;
	Print@PDFSummaryOfResults;
];

ParticleSpectrumActual[Expr_,OptionsPattern[]]:=Catch@If[
	$ReadOnly,
	ParticleSpectrumActual[		
		TheoryName->OptionValue@TheoryName,
		Method->OptionValue@Method,
		MaxLaurentDepth->OptionValue@MaxLaurentDepth],
	Module[{
		SummariseResultsOngoing,	
		TheoryContext,
		PDFSummaryOfResults},

		ValidateTheoryName@OptionValue@TheoryName;
		ValidateMethod@OptionValue@Method;
		ValidateMaxLaurentDepth@OptionValue@MaxLaurentDepth;
		ValidateLagrangian@Expr;

		LocalWaveOperator=Null;
		LocalPropagator=Null;
		LocalSourceConstraints=Null;
		LocalSpectrum=Null;
		LocalMasslessSpectrum=Null;
		LocalOverallUnitarity=Null;
		LocalSummaryOfTheory=Null;

		If[$CLI,
			SummariseResultsOngoing=SessionSubmit[ScheduledTask[(
			Run@("echo -e \"\n\n"<>CLIPrint[
					OptionValue@TheoryName,
					LocalWaveOperator,
					LocalPropagator,
					LocalSourceConstraints,
					LocalSpectrum,
					LocalMasslessSpectrum,
					LocalOverallUnitarity]<>"\"");
			), Quantity[1, "Seconds"]]];
		,
			SummariseResultsOngoing=PrintTemporary@Dynamic[Refresh[SummariseResults[
					OptionValue@TheoryName,
					LocalWaveOperator,
					LocalPropagator,
					LocalSourceConstraints,
					LocalSpectrum,
					LocalMasslessSpectrum,
					LocalOverallUnitarity,
					LocalSummaryOfTheory],
				TrackedSymbols->{
					LocalWaveOperator,
					LocalPropagator,
					LocalSourceConstraints,
					LocalSpectrum,
					LocalMasslessSpectrum,
					LocalOverallUnitarity,
					LocalSummaryOfTheory}]];
		];

		Catch[
			CombineAssociations[Expr,TheoryContext];
			ConstructLinearAction[
						"xAct`PSALTer`Private`ClassName",
						Expr];
			ConstructWaveOperator[
						"xAct`PSALTer`Private`ClassName",
						Expr];
			UpdateTheoryAssociation[
						OptionValue@TheoryName,
						BMatrices,
						ValuesAllMatrices,
						ExportTheory->False];
			UpdateTheoryAssociation[
						OptionValue@TheoryName,
						MomentumSpaceLagrangian,
						DecomposeFieldsdLagrangian,
						ExportTheory->False];
			ConstructSourceConstraints[
						"xAct`PSALTer`Private`ClassName",
						CouplingAssumptions,
						Rescalings,
						RaisedIndexSources,
						MatrixLagrangian,
						Method->OptionValue@Method];
			UpdateTheoryAssociation[
						OptionValue@TheoryName,
						SourceConstraints,
						ValuesOfSourceConstraints,
						ExportTheory->False];

			ConstructSaturatedPropagator[
						"xAct`PSALTer`Private`ClassName",
						MatrixLagrangian,
						CouplingAssumptions,
						BMatricesValues,
						RaisedIndexSources,
						LoweredIndexSources,
						Method->OptionValue@Method];
			UpdateTheoryAssociation[
						OptionValue@TheoryName,
						InverseBMatrices,
						ValuesInverseBMatricesValues,
						ExportTheory->False];
			ConstructMassiveAnalysis[
						"xAct`PSALTer`Private`ClassName",
						ValuesSaturatedPropagator,
						ValuesInverseBMatricesValues,
						BlockMassSigns,
						Method->OptionValue@Method];
			UpdateTheoryAssociation[
						OptionValue@TheoryName,
						SquareMasses,
						MassiveAnalysis,
						ExportTheory->False];
			ConstructMasslessAnalysis[
						"xAct`PSALTer`Private`ClassName",
						ValuesOfSourceConstraints,
						ValuesSaturatedPropagator,
						MaxLaurentDepth->OptionValue@MaxLaurentDepth];
			UpdateTheoryAssociation[
						OptionValue@TheoryName,
						SecularSystem,
						SecularSystemValue,
						ExportTheory->False];
			UpdateTheoryAssociation[
						OptionValue@TheoryName,
						MasslessEigenvalues,
						MasslessAnalysisValue,
						ExportTheory->False];
			UpdateTheoryAssociation[
						OptionValue@TheoryName,
						SecularEquation,
						SecularEquationValue,
						ExportTheory->False];
			UpdateTheoryAssociation[
						OptionValue@TheoryName,
						SourceConstraintComponents,
						ConstraintComponentList,
						ExportTheory->False];
			ConstructUnitarityConditions[
						"xAct`PSALTer`Private`ClassName",
						MassiveAnalysis,
						MassiveGhostAnalysis,
						MasslessAnalysisValue,
						QuarticAnalysisValue,
						HexicAnalysisValue];
			UpdateTheoryAssociation[
						OptionValue@TheoryName,
						PositiveSystem,
						LocalOverallUnitarity,
						ExportTheory->False];
		];

		If[$CLI,
			TaskRemove@SummariseResultsOngoing;
			Run@("echo -e \"\n\n"<>CLIPrint[
					OptionValue@TheoryName,
					LocalWaveOperator,
					LocalPropagator,
					LocalSourceConstraints,
					LocalSpectrum,
					LocalMasslessSpectrum,
					LocalOverallUnitarity]<>"\"");
		,
			Check[
				PDFSummaryOfResults=SummariseResults[
						OptionValue@TheoryName,
						LocalWaveOperator,
						LocalPropagator,
						LocalSourceConstraints,
						LocalSpectrum,
						LocalMasslessSpectrum,
						LocalOverallUnitarity,
						LocalSummaryOfTheory,
						SummaryType->ResultsCollage];
			,
				PDFSummaryOfResults=SummariseResults[
						OptionValue@TheoryName,
						LocalWaveOperator,
						LocalPropagator,
						LocalSourceConstraints,
						LocalSpectrum,
						LocalMasslessSpectrum,
						LocalOverallUnitarity,
						LocalSummaryOfTheory];
			];
			Export[FileNameJoin@{$WorkingDirectory,"ParticleSpectrograph"<>OptionValue@TheoryName<>".pdf"},
				PDFSummaryOfResults
			];
			FinishDynamic[];
			NotebookDelete@SummariseResultsOngoing;
			Print@PDFSummaryOfResults;
		];

		MapThread[
		UpdateTheoryAssociation[
					OptionValue@TheoryName,
					#1,
					#2,
					ExportTheory->True]&,
		{{		
			SavedWaveOperator,
			SavedPropagator,
			SavedSourceConstraints,
			SavedSpectrum,
			SavedMasslessSpectrum,
			SavedOverallUnitarity,
			SavedSummaryOfTheory},
		{
			LocalWaveOperator,
			LocalPropagator,
			LocalSourceConstraints,
			LocalSpectrum,
			LocalMasslessSpectrum,
			LocalOverallUnitarity,
			LocalSummaryOfTheory}}
		];
	];
];

On[Set::write];
On[SetDelayed::write];

Unprotect@ParticleSpectrum;
Options@ParticleSpectrum={TheoryName->False,Method->"Easy",MaxLaurentDepth->1};
ParticleSpectrum[Args___,Opts:OptionsPattern[]]:=If[!$Disabled,ParticleSpectrumActual[Args,Opts]];
Protect@ParticleSpectrum;
