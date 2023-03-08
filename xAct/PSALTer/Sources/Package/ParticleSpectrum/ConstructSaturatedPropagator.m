(*================================*)
(*  ConstructSaturatedPropagator  *)
(*================================*)

BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator/GetHermitianPart.m";
BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator/NonTrivialDot.m";

ConstructSaturatedPropagator[ClassName_?StringQ,Expr_,Couplings_]:=Module[{
	Class,
	FieldSpinParityTensorHeadsValue,
	SourceSpinParityTensorHeadsValue,
	CouplingAssumptions,
	SymbolicLagrangian,
	Symbols,
	Rescalings,
	RaisedIndexSources,
	LoweredIndexSources,
	SpinParityConstantSymbols,
	SpinParityRescalingSymbols,
	MatrixLagrangian,
	ImaginaryParts,
	RealParts,
	BMatricesValues,
	NullSpaces,
	SourceConstraints,
	MatrixPropagator,
	InverseBMatricesValues,
	SaturatedPropagator,
	PrintVariable},

	PrintVariable={};
	PrintVariable=PrintVariable~Append~PrintTemporary@" ** ConstructSaturatedPropagator...";

	Class=Evaluate@Symbol@ClassName;
	FieldSpinParityTensorHeadsValue=Class@FieldSpinParityTensorHeads;
	SourceSpinParityTensorHeadsValue=Class@SourceSpinParityTensorHeads;

	(*coefficient matrices*)
	SymbolicLagrangian=Expr/.Class@InvariantToConstantRules;
	Diagnostic@SymbolicLagrangian;

	SpinParityConstantSymbols=Map[
		(ToExpression@((ToString@#)<>"ConstantSymbol"))&,
		FieldSpinParityTensorHeadsValue,{4}
	];

	SpinParityRescalingSymbols=Map[
		(ToExpression@((ToString@#)<>"RescalingSymbol"))&,
		FieldSpinParityTensorHeadsValue,{4}
	];

	Symbols=<||>;
	(
		Symbols[Spin]=(#~Join~((Evaluate@Dagger[#])&/@#))&@Flatten@Join[
			SpinParityConstantSymbols[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors},
			SpinParityConstantSymbols[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}
		];
	)~Table~{Spin,Class@Spins};
	Diagnostic@Symbols;

	Rescalings=<||>;
	(
		Rescalings[Spin]=Flatten@(((1/#)&)/@Join[
			SpinParityRescalingSymbols[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors},
			SpinParityRescalingSymbols[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}
		]);
	)~Table~{Spin,Class@Spins};
	Diagnostic@Rescalings;

	RaisedIndexSources=<||>;
	(
		RaisedIndexSources[Spin]=((FromIndexFree@ToIndexFree@#)/.{SomeIndex_?TangentM4`Q->-SomeIndex})&@Flatten@Join[
			SourceSpinParityTensorHeadsValue[Source][Spin][Even]~Table~{Source,Class@Sources},
			SourceSpinParityTensorHeadsValue[Source][Spin][Odd]~Table~{Source,Class@Sources}
		];
	)~Table~{Spin,Class@Spins};
	Diagnostic@RaisedIndexSources;

	LoweredIndexSources=<||>;
	(
		LoweredIndexSources[Spin]=((FromIndexFree@ToIndexFree@#)/.{SomeIndex_?TangentM4`Q->SomeIndex})&@Flatten@Join[
			SourceSpinParityTensorHeadsValue[Source][Spin][Even]~Table~{Source,Class@Sources},
			SourceSpinParityTensorHeadsValue[Source][Spin][Odd]~Table~{Source,Class@Sources}
		];
	)~Table~{Spin,Class@Spins};
	Diagnostic@LoweredIndexSources;

	(*------------------------*)
	(*  Coefficient matrices  *)
	(*------------------------*)

	(*accommodating for zero and dimension-one matrices*)
	MatrixLagrangian=<||>;
	(
		MatrixLagrangian@Spin=(#[[1;;(1/2)Length@#,(1/2)Length@#+1;;Length@#]])&@If[
			SparseArrayQ@Last@CoefficientArrays[SymbolicLagrangian,#,"Symmetric"->False],
			Last@CoefficientArrays[SymbolicLagrangian,#,"Symmetric"->False],
			SparseArray@ConstantArray[0,{Length@#,Length@#}]
		]&@Symbols@Spin;
	)~Table~{Spin,Class@Spins};
	Diagnostic@(MatrixForm/@MatrixLagrangian);

	(*Hermitian versions of coefficient matrices*)
	MatrixLagrangian=GetHermitianPart/@MatrixLagrangian;
	Diagnostic@(MatrixForm/@MatrixLagrangian);

	(*rescaled versions of matrices*)
	MatrixLagrangian=MapThread[
		MapThread[(#1*#2)&,{#1,#2}]&,
			{MatrixLagrangian,
			Class@InverseRescalingMatrix}
	];
	Diagnostic@(MatrixForm/@MatrixLagrangian);
	MatrixLagrangian=MatrixLagrangian/.Class@RescalingSolutions;
	Diagnostic@(MatrixForm/@MatrixLagrangian);

	BMatricesValues=MatrixLagrangian;

	AntiMaskMatrixValue=Class@AntiMaskMatrix;
	BMatricesValues=MapThread[
			({MapThread[Times,{#1@Even,#2}],MapThread[Times,{#1@Odd,#2}]})&,
			{AntiMaskMatrixValue,
			BMatricesValues}];
	Diagnostic@(MatrixForm/@BMatricesValues);
	Diagnostic@(Flatten[Values@BMatricesValues,{1,2}]);


	(*null spaces*)
	NullSpaces=NullSpace@Transpose[#]&/@MatrixLagrangian;

	(*source constraints*)
	SourceConstraints=Quiet@DeleteCases[
		Flatten@Values@MapThread[(#1~NonTrivialDot~#2)&,
			{NullSpaces,
			MapThread[
				MapThread[(#2/#1)&,{#1,#2}]&,
					{Rescalings,
					RaisedIndexSources}
				]}
		],0,Infinity]/.Class@RescalingSolutions;
	SourceConstraints=Numerator@Together[#/Sqrt[2^5*3^5*5^5*7^5]]&/@SourceConstraints;
	Diagnostic@SourceConstraints;

	(*matrix form of the propagator*)
	CouplingAssumptions=(#~Element~Reals)&/@Couplings;
	CouplingAssumptions~AppendTo~(xAct`PSALTer`Def~Element~Reals);

	(*So we use the Moore-Penrose inverse*)
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

	(*descale the propagator ready for multiplication by sources*)
	MatrixPropagator=MapThread[
		MapThread[(#1*#2)&,{#1,#2}]&,
			{MatrixPropagator,
			Class@RescalingMatrix}
	]/.Class@RescalingSolutions;
	Diagnostic@(MatrixForm/@MatrixPropagator);

	MaskMatrixValue=Class@MaskMatrix;
	MaskedMatrixPropagator=MapThread[
			MapThread[Times,{#1,#2}]&,
			{MaskMatrixValue,
			MatrixPropagator}];
	Diagnostic@(MatrixForm/@MaskedMatrixPropagator);

	AntiMaskMatrixValue=Class@AntiMaskMatrix;
	MatrixPropagator=MapThread[
			({MapThread[Times,{#1@Even,#2}],MapThread[Times,{#1@Odd,#2}]})&,
			{AntiMaskMatrixValue,
			MatrixPropagator}];
	Diagnostic@(MatrixForm/@MatrixPropagator);

	(*saturated form of the propagator*)
	(*SaturatedPropagator=MapThread[#1 . #2 . #3&,*)
	SaturatedPropagator=MapThread[{#1 . #2[[1]] . #3,#1 . #2[[2]] . #3}&,
			{Dagger/@RaisedIndexSources,
			MatrixPropagator,
			LoweredIndexSources}];
	Diagnostic@(MatrixForm/@SaturatedPropagator);
	SaturatedPropagator=ToNewCanonical/@SaturatedPropagator;
	SaturatedPropagator=CollectTensors/@SaturatedPropagator;
	Diagnostic@(MatrixForm/@SaturatedPropagator);

	NotebookDelete@PrintVariable;
			(*{SourceConstraints,Values@SaturatedPropagator,Values@BMatricesValues,Values@InverseBMatricesValues}];*)
{SourceConstraints,First/@Flatten[Values@SaturatedPropagator,{1,2}],First/@Flatten[Values@BMatricesValues,{1,2}],First/@Flatten[Values@InverseBMatricesValues,{1,2}]}];
