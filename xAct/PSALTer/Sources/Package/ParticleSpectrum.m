(*====================*)
(*  ParticleSpectrum  *)
(*====================*)

BuildPackage@"ParticleSpectrum/UpdateTheoryAssociation.m";
BuildPackage@"ParticleSpectrum/PSALTerParallelSubmit.m";
BuildPackage@"ParticleSpectrum/SummariseResults.m";

BuildPackage@"ParticleSpectrum/ConstructLinearAction.m";
BuildPackage@"ParticleSpectrum/ConstructWaveOperator.m";
BuildPackage@"ParticleSpectrum/ConstructSourceConstraints.m";
BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator.m";
BuildPackage@"ParticleSpectrum/ConstructMassiveAnalysis.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis.m";
BuildPackage@"ParticleSpectrum/ConstructUnitarityConditions.m";

Off[Set::write];
Off[SetDelayed::write];
Options@ParticleSpectrum={
	ClassName->False,
	TheoryName->False,
	Method->"Easy",
	MaxLaurentDepth->1
	};

ParticleSpectrum::WrongClassName="You must pass a string to the option ClassName, from the list of defined classes `1`.";
ValidateClassName[ClassNameValue_,ClassNames_]:=If[!(ClassNames~MemberQ~ClassNameValue),
			Throw@Message[ParticleSpectrum::WrongClassName,ClassNames]
			];
ParticleSpectrum::WrongTheoryName="You must pass a string to the option TheoryName.";
ValidateTheoryName[TheoryNameValue_]:=If[!(StringQ@TheoryNameValue),
			Throw@Message[ParticleSpectrum::WrongTheoryName,TheoryNameValue]
			];
ParticleSpectrum::WrongMethod="The method `1` for evaluating the source constraints and matrix pseudoinverses appears not to be either of the strings Easy, Hard or Both.";
ValidateMethod[MethodValue_]:=If[!({"Easy","Hard","Both"}~MemberQ~MethodValue),
			Throw@Message[ParticleSpectrum::WrongMethod,MethodValue]
			];
ParticleSpectrum::WrongMaxLaurentDepth="The maximum requested depth n of the 1/k^(2n) residue n=`1` appears not to be a natural number 1, 2 or 3.";
ValidateMaxLaurentDepth[MaxLaurentDepthValue_]:=If[!({1,2,3}~MemberQ~MaxLaurentDepthValue),
			Throw@Message[ParticleSpectrum::WrongMaxLaurentDepth,MaxLaurentDepthValue]
			];


ParticleSpectrum[OptionsPattern[]]:=Module[{
	SummaryOfResults,
	PDFSummaryOfResults,
	Class},

	ValidateTheoryName@OptionValue@TheoryName;

	Get@FileNameJoin@{$WorkingDirectory,OptionValue@TheoryName<>".mx"};
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
	Print@SummaryOfResults;

	If[$ExportPDF,
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
		Print@PDFSummaryOfResults;
		Export[FileNameJoin@{$WorkingDirectory,OptionValue@TheoryName<>".pdf"},
			PDFSummaryOfResults
		];
	];
];

ParticleSpectrum[Expr_,OptionsPattern[]]:=If[
	$ReadOnly,
	ParticleSpectrum[	
		ClassName->OptionValue@ClassName,
		TheoryName->OptionValue@TheoryName,
		Method->OptionValue@Method,
		MaxLaurentDepth->OptionValue@MaxLaurentDepth],
	Module[{
		SummariseResultsOngoing,
		ClassNames,
		PDFSummaryOfResults
	},

		ClassNames={"ScalarTheory",
			"VectorTheory",
			"BiScalarVectorTensorTheory",
			"TensorTheory",
			"SymmetricTensorTheory",
			"AsymmetricTensorTheory",
			"BimetricTensorTheory",
			"ScalarTensorTheory",
			"PoincareGaugeTheory",
			"WeylGaugeTheory",
			"MetricAffineGravity",
			"ZeroTorsionPalatini"};

		ValidateClassName[OptionValue@ClassName,ClassNames];
		ValidateTheoryName@OptionValue@TheoryName;
		ValidateMethod@OptionValue@Method;
		ValidateMaxLaurentDepth@OptionValue@MaxLaurentDepth;

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
			

		Quiet@CreateDirectory@FileNameJoin@{$WorkingDirectory,"tmp"};

		ConstructLinearAction[
					OptionValue@ClassName,
					Expr];


		ConstructWaveOperator[
					OptionValue@ClassName,
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
					OptionValue@ClassName,
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
		Print@"About to start";
		ConstructSaturatedPropagator[
					OptionValue@ClassName,
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

(**)
		ConstructMassiveAnalysis[
					OptionValue@ClassName,
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
					OptionValue@ClassName,
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
					OptionValue@ClassName,
					MassiveAnalysis,
					MassiveGhostAnalysis,
					MasslessAnalysisValue,
					QuarticAnalysisValue,
					HexicAnalysisValue];
		UpdateTheoryAssociation[
					OptionValue@TheoryName,
					PositiveSystem,
					PositiveSystemValue,
					ExportTheory->False];
(**)
		DeleteDirectory[FileNameJoin@{$WorkingDirectory,"tmp"},DeleteContents->True];

		If[$CLI,
			TaskRemove@SummariseResultsOngoing;
		,
			FinishDynamic[];
			NotebookDelete@SummariseResultsOngoing;
		];

		If[$CLI,
			Run@("echo -e \"\n\n"<>CLIPrint[
					OptionValue@TheoryName,
					LocalWaveOperator,
					LocalPropagator,
					LocalSourceConstraints,
					LocalSpectrum,
					LocalMasslessSpectrum,
					LocalOverallUnitarity]<>"\"");
		,
			SummaryOfResults=SummariseResults[
				OptionValue@TheoryName,
				LocalWaveOperator,
				LocalPropagator,
				LocalSourceConstraints,
				LocalSpectrum,
				LocalMasslessSpectrum,
				LocalOverallUnitarity,
				LocalSummaryOfTheory];
			Print@SummaryOfResults;
		];

		If[$ExportPDF,
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
			Print@PDFSummaryOfResults;
			Export[FileNameJoin@{$WorkingDirectory,OptionValue@TheoryName<>".pdf"},
				PDFSummaryOfResults
			];
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
Protect@ParticleSpectrum;
