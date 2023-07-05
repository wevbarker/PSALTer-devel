(*================================*)
(*  ConstructSaturatedPropagator  *)
(*================================*)

ConstructSaturatedPropagator[ClassName_?StringQ,MatrixLagrangian_,CouplingAssumptions_,BMatricesValues_,RaisedIndexSources_,LoweredIndexSources_,FieldSpinParityTensorHeadsValue_,SourceConstraints_,FieldsLeft_,FieldsTop_,SourcesLeft_,SourcesTop_]:=Module[{
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
	InverseBMatricesValues,
	BlockMassSigns,
	Sizes,
	TheSpins,
	CombinedSectors,
	Class},

	LocalSaturatedPropagator=" ** ConstructSaturatedPropagator...";

	Class=Evaluate@Symbol@ClassName;

	Diagnostic@(MatrixForm/@MatrixLagrangian);
	Diagnostic@((CouplingAssumptions)&/@BMatricesValues);

	MatrixPropagator=Assuming[CouplingAssumptions,((PseudoInverse@#))&/@MatrixLagrangian];

	MatrixPropagator=((#)~FullSimplify~CouplingAssumptions)&/@MatrixPropagator;
	Diagnostic@(MatrixForm/@MatrixPropagator);

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
	Diagnostic@(Flatten[Values@BMatricesValues,{1,2}]);
	Diagnostic@(First/@Flatten[Values@BMatricesValues,{1,2}]);

	BlockMassSigns=Table[-(-1)^n,{n,1,2*Length@SaturatedPropagator}];
	Diagnostic@BlockMassSigns;

	CombinedSectors=Map[Flatten,Merge[#,Identity]&/@Merge[Values@FieldSpinParityTensorHeadsValue,Identity],{2}];
	Sizes=Map[Length,Values@(Values/@(CombinedSectors)),{2}];
	TheSpins=Keys@CombinedSectors;

SaturatedPropagator={SourceConstraints,Flatten[Values@SaturatedPropagator,{1,2}],Flatten[Values@BMatricesValues,{1,2}],Flatten[Values@InverseBMatricesValues,{1,2}],BlockMassSigns,Sizes,TheSpins,FieldsLeft,FieldsTop,SourcesLeft,SourcesTop};
];
