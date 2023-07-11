(*================================*)
(*  ConstructSaturatedPropagator  *)
(*================================*)

BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator/ConjectureInverse.m";
BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator/CompareManualAutomatic.m";

Options@ConstructSaturatedPropagator={
	Method->"Careful"};

ConstructSaturatedPropagator[ClassName_?StringQ,MatrixLagrangian_,CouplingAssumptions_,BMatricesValues_,RaisedIndexSources_,LoweredIndexSources_,FieldSpinParityTensorHeadsValue_,FieldsLeft_,FieldsTop_,SourcesLeft_,SourcesTop_,Couplings_,OptionsPattern[]]:=Module[{
	SourceSpinParityTensorHeadsValue,
	SymbolicLagrangian,
	Symbols,
	RaisedIndexFields,
	LoweredIndexFields,
	SpinParityConstantSymbols,
	SpinParityRescalingSymbols,
	ImaginaryParts,
	RealParts,
	NullSpaces,
	MatrixPropagator,
	ManualMatrixPropagator,
	AutomaticMatrixPropagator,
	InverseBMatricesValues,
	BlockMassSigns,
	Sizes,
	TheSpins,
	CombinedSectors,
	Class},

	LocalSaturatedPropagator=" ** ConstructSaturatedPropagator...";

	Class=Evaluate@Symbol@ClassName;

	Diagnostic@(MatrixForm/@MatrixLagrangian);
	Diagnostic@(BMatricesValues);

	ManualMatrixPropagator=Map[ConjectureInverse[#,
					Couplings,
					CouplingAssumptions]&,
					BMatricesValues,{2}];
	ManualMatrixPropagator=(#[[1]]+#[[2]])&/@ManualMatrixPropagator;
	Diagnostic@(MatrixForm/@ManualMatrixPropagator);

	Switch[OptionValue@Method,
		"Careful",
		(
		AutomaticMatrixPropagator=Assuming[CouplingAssumptions,
					((PseudoInverse@#))&/@MatrixLagrangian];
		AutomaticMatrixPropagator=
			((#)~FullSimplify~CouplingAssumptions)&/@AutomaticMatrixPropagator;
		Diagnostic@(MatrixForm/@AutomaticMatrixPropagator);
		MatrixPropagator=ManualMatrixPropagator;
		),
		"Careless",
		MatrixPropagator=ManualMatrixPropagator;
	];

	InverseBMatricesValues=MatrixPropagator;

	AntiMaskMatrixValue=Class@AntiMaskMatrix;
	InverseBMatricesValues=MapThread[
			({MapThread[Times,{#1@Even,#2}],MapThread[Times,{#1@Odd,#2}]})&,
			{AntiMaskMatrixValue,
			InverseBMatricesValues}];
	Diagnostic@(MatrixForm/@InverseBMatricesValues);

	MatrixPropagator=MapThread[
		MapThread[(#1*#2)&,{#1,#2}]&,
			{MatrixPropagator,
			Class@RescalingMatrix}
	]/.Class@RescalingSolutions;
	Diagnostic@(MatrixForm/@MatrixPropagator);

	MaskMatrixValue=Class@MaskMatrix;
	Diagnostic@(MatrixForm/@MaskMatrixValue);
	MaskedMatrixPropagator=MapThread[
			MapThread[Times,{#1,#2}]&,
			{MaskMatrixValue,
			MatrixPropagator}];
	Diagnostic@(MatrixForm/@MaskedMatrixPropagator);

	AntiMaskMatrixValue=Class@AntiMaskMatrix;
	Diagnostic@(MatrixForm/@AntiMaskMatrixValue);
	MatrixPropagator=MapThread[
			({MapThread[Times,{#1@Even,#2}],MapThread[Times,{#1@Odd,#2}]})&,
			{AntiMaskMatrixValue,
			MatrixPropagator}];
	Diagnostic@(Map[MatrixForm,MatrixPropagator,{2}]);

	SaturatedPropagator=MapThread[{#1 . #2[[1]] . #3,#1 . #2[[2]] . #3}&,
			{Dagger/@RaisedIndexSources,
			MatrixPropagator,
			LoweredIndexSources}];
	Diagnostic@(MatrixForm/@SaturatedPropagator);
	SaturatedPropagator=ToNewCanonical/@SaturatedPropagator;
	SaturatedPropagator=CollectTensors/@SaturatedPropagator;
	Diagnostic@(SaturatedPropagator);
	Diagnostic@(Map[MatrixForm,SaturatedPropagator,{2}]);

	Diagnostic@(Flatten[Values@SaturatedPropagator,{1,2}]);
	Diagnostic@(First/@Flatten[Values@SaturatedPropagator,{1,2}]);
	Diagnostic@(ValuesAllMatrices);

	BlockMassSigns=Table[-(-1)^n,{n,1,2*Length@SaturatedPropagator}];
	Diagnostic@BlockMassSigns;

	CombinedSectors=Map[Flatten,Merge[#,Identity]&/@Merge[Values@FieldSpinParityTensorHeadsValue,Identity],{2}];
	Sizes=Map[Length,Values@(Values/@(CombinedSectors)),{2}];
	TheSpins=Keys@CombinedSectors;

SaturatedPropagator={
		ValuesOfSourceConstraints,
		Flatten[Values@SaturatedPropagator,{1,2}],
		ValuesAllMatrices,
		Flatten[Values@InverseBMatricesValues,{1,2}],
		BlockMassSigns,
		Sizes,
		TheSpins,
		FieldsLeft,
		FieldsTop,
		SourcesLeft,
		SourcesTop};
];
