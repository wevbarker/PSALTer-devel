(*=====================*)
(*  ConstructOperator  *)
(*=====================*)

BuildPackage@"ParticleSpectrum/ConstructWaveOperator/GetHermitianPart.m";

ConstructOperator[ClassName_?StringQ,Expr_,Couplings_]:=Module[{
	Class,
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
	CombinedSectors},

	LocalWaveOperator=" ** ConstructOperator...";
	
	CouplingAssumptions=(#~Element~Reals)&/@Couplings;
	CouplingAssumptions~AppendTo~(xAct`PSALTer`Def~Element~Reals);

	Class=Evaluate@Symbol@ClassName;
	FieldSpinParityTensorHeadsValue=Class@FieldSpinParityTensorHeads;
	SourceSpinParityTensorHeadsValue=Class@SourceSpinParityTensorHeads;

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

	RaisedIndexFields=<||>;
	(
		RaisedIndexFields[Spin]=((FromIndexFree@ToIndexFree@#)/.{SomeIndex_?TangentM4`Q->-SomeIndex})&@Flatten@Join[
			FieldSpinParityTensorHeadsValue[Field][Spin][Even]~Table~{Field,Class@Tensors},
			FieldSpinParityTensorHeadsValue[Field][Spin][Odd]~Table~{Field,Class@Tensors}
		];
	)~Table~{Spin,Class@Spins};
	Diagnostic@RaisedIndexFields;

	LoweredIndexFields=<||>;
	(
		LoweredIndexFields[Spin]=((FromIndexFree@ToIndexFree@#)/.{SomeIndex_?TangentM4`Q->SomeIndex})&@Flatten@Join[
			FieldSpinParityTensorHeadsValue[Field][Spin][Even]~Table~{Field,Class@Tensors},
			FieldSpinParityTensorHeadsValue[Field][Spin][Odd]~Table~{Field,Class@Tensors}
		];
	)~Table~{Spin,Class@Spins};
	Diagnostic@LoweredIndexFields;

	FieldsLeft=Dagger/@Values@RaisedIndexFields;
	FieldsTop=Values@LoweredIndexFields;
	SourcesLeft=Dagger/@Values@RaisedIndexSources;
	SourcesTop=Values@LoweredIndexSources;

	MatrixLagrangian=<||>;
	(
		MatrixLagrangian@Spin=(#[[1;;(1/2)Length@#,(1/2)Length@#+1;;Length@#]])&@If[
			SparseArrayQ@Last@CoefficientArrays[SymbolicLagrangian,#,"Symmetric"->False],
			Last@CoefficientArrays[SymbolicLagrangian,#,"Symmetric"->False],
			SparseArray@ConstantArray[0,{Length@#,Length@#}]
		]&@Symbols@Spin;
	)~Table~{Spin,Class@Spins};
	Diagnostic@(MatrixForm/@MatrixLagrangian);

	MatrixLagrangian=GetHermitianPart/@MatrixLagrangian;
	Diagnostic@(MatrixForm/@MatrixLagrangian);

	MatrixLagrangian=MapThread[
		MapThread[(#1*#2)&,{#1,#2}]&,
			{MatrixLagrangian,
			Class@InverseRescalingMatrix}
	];
	Diagnostic@(MatrixForm/@MatrixLagrangian);
	MatrixLagrangian=MatrixLagrangian/.Class@RescalingSolutions;
	Diagnostic@(MatrixForm/@MatrixLagrangian);

	MatrixLagrangian=((#)~FullSimplify~CouplingAssumptions)&/@MatrixLagrangian;
	Diagnostic@(MatrixForm/@MatrixLagrangian);

	BMatricesValues=MatrixLagrangian;

	AntiMaskMatrixValue=Class@AntiMaskMatrix;
	BMatricesValues=MapThread[
			({MapThread[Times,{#1@Even,#2}],MapThread[Times,{#1@Odd,#2}]})&,
			{AntiMaskMatrixValue,
			BMatricesValues}];
	Diagnostic@(BMatricesValues);
	Diagnostic@(Flatten[Values@BMatricesValues,{1,2}]);
];
