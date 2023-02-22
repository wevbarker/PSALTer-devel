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
	Print@Symbols;

	Rescalings=<||>;
	(
		Rescalings[Spin]=Flatten@(((1/#)&)/@Join[
			SpinParityRescalingSymbols[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors},
			SpinParityRescalingSymbols[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}
		]);
	)~Table~{Spin,Class@Spins};
	Print@Rescalings;

	RaisedIndexSources=<||>;
	(
		RaisedIndexSources[Spin]=((FromIndexFree@ToIndexFree@#)/.{SomeIndex_?TangentM4`Q->-SomeIndex})&@Flatten@Join[
			SourceSpinParityTensorHeadsValue[Source][Spin][Even]~Table~{Source,Class@Sources},
			SourceSpinParityTensorHeadsValue[Source][Spin][Odd]~Table~{Source,Class@Sources}
		];
	)~Table~{Spin,Class@Spins};
	Print@RaisedIndexSources;

	LoweredIndexSources=<||>;
	(
		LoweredIndexSources[Spin]=((FromIndexFree@ToIndexFree@#)/.{SomeIndex_?TangentM4`Q->SomeIndex})&@Flatten@Join[
			SourceSpinParityTensorHeadsValue[Source][Spin][Even]~Table~{Source,Class@Sources},
			SourceSpinParityTensorHeadsValue[Source][Spin][Odd]~Table~{Source,Class@Sources}
		];
	)~Table~{Spin,Class@Spins};
	Print@LoweredIndexSources;

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
	Print@(MatrixForm/@MatrixLagrangian);

	(*Hermitian versions of coefficient matrices*)
	MatrixLagrangian=GetHermitianPart/@MatrixLagrangian;
	Print@(MatrixForm/@MatrixLagrangian);

	(*rescaled versions of matrices*)
	MatrixLagrangian=MapThread[
		MapThread[(#1*#2)&,{#1,#2}]&,
			{MatrixLagrangian,
			Class@InverseRescalingMatrix}
	];
	Print@(MatrixForm/@MatrixLagrangian);
	MatrixLagrangian=MatrixLagrangian/.Class@RescalingSolutions;
	Print@(MatrixForm/@MatrixLagrangian);

	BMatricesValues=MatrixLagrangian;

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
	Print@SourceConstraints;

	(*matrix form of the propagator*)
	CouplingAssumptions=(#~Element~Reals)&/@Couplings;
	CouplingAssumptions~AppendTo~(xAct`PSALTer`Def~Element~Reals);

	(*So we use the Moore-Penrose inverse*)
	MatrixPropagator=Assuming[CouplingAssumptions,((PseudoInverse@#))&/@MatrixLagrangian];
	MatrixPropagator=((#)~FullSimplify~CouplingAssumptions)&/@MatrixPropagator;
	Print@(MatrixForm/@MatrixPropagator);

	InverseBMatricesValues=MatrixPropagator;

	(*descale the propagator ready for multiplication by sources*)
	MatrixPropagator=MapThread[
		MapThread[(#1*#2)&,{#1,#2}]&,
			{MatrixPropagator,
			Class@RescalingMatrix}
	]/.Class@RescalingSolutions;
	Print@(MatrixForm/@MatrixPropagator);

	(*saturated form of the propagator*)
	SaturatedPropagator=MapThread[#1 . #2 . #3&,
			{Dagger/@RaisedIndexSources,
			MatrixPropagator,
			LoweredIndexSources}];
	Print@(MatrixForm/@SaturatedPropagator);
	SaturatedPropagator=ToNewCanonical/@SaturatedPropagator;
	SaturatedPropagator=CollectTensors/@SaturatedPropagator;
	Print@(MatrixForm/@SaturatedPropagator);

	NotebookDelete@PrintVariable;
{SourceConstraints,Values@SaturatedPropagator,Values@BMatricesValues,Values@InverseBMatricesValues}];
