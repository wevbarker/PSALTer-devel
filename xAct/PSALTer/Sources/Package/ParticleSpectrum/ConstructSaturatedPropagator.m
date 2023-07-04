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
	RaisedIndexFields,
	LoweredIndexFields,
	FieldsLeft,
	FieldsTop,
	SourcesLeft,
	SourcesTop,
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
	BlockMassSigns,
	Sizes,
	TheSpins,
	CombinedSectors,
	PrintVariable},
	
	CouplingAssumptions=(#~Element~Reals)&/@Couplings;
	CouplingAssumptions~AppendTo~(xAct`PSALTer`Def~Element~Reals);

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

	(*null spaces*)
(*
	NullSpaces=NullSpace[Transpose[#],Method->"OneStepRowReduction"]&/@MatrixLagrangian;
*)
	NullSpaces=Assuming[CouplingAssumptions,NullSpace[Transpose[#]]&/@(MatrixLagrangian)];
	Diagnostic@NullSpaces;
(*
	NullSpaces=((#)~FullSimplify~CouplingAssumptions)&/@NullSpaces;
*)
	Diagnostic@NullSpaces;

(*
	(*verify determinants*)
	Dets=Det@Transpose[#]&/@MatrixLagrangian;
	Dets=((#)~FullSimplify~CouplingAssumptions)&/@Dets;
	Diagnostic@Dets;
*)

	(*source constraints*)
(*
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
*)
	(*So we use the Moore-Penrose inverse*)
			(*MatrixLagrangian=MatrixLagrangian/.{Def->1};*)
(*
	JNF=Assuming[CouplingAssumptions,((JordanDecomposition@#))&/@MatrixLagrangian];
	Diagnostic@((MatrixForm@Second@#)&/@JNF);
*)
	Diagnostic@(MatrixForm/@MatrixLagrangian);
(*
	MatrixPropagator=Assuming[CouplingAssumptions,((PseudoInverse@#))&/@BMatricesValues];
*)


	Diagnostic@((CouplingAssumptions)&/@BMatricesValues);


	InvertWithAssumptions[InputAssumptions_,InputMatrix_]:=Assuming[InputAssumptions,PseudoInverse@InputMatrix];

ExportMatrixToMaple[InputExpr_,InputName_?StringQ]:=Module[{
	ExportString=InputExpr},
	Print@MatrixForm@ExportString;
	ExportString//=InputForm;
	ExportString//=ToString;
	WriteLine[FileNameJoin@{NotebookDirectory[],"StringStore.mpl"},(InputName<>":=Matrix("<>ExportString<>");")~StringReplace~{"xAct`PSALTer`"->"","{"->"[","}"->"]","Sqrt"->"sqrt","["->"(","]"->")"}];
];

	Print@"shortcut method";
	GiveInv[Mat_]:=Module[{Expz},
		Expz=Assuming[CouplingAssumptions,DrazinInverse@Mat];
		Print@MatrixForm@Expz;
		Expz];
	MapThread[ExportMatrixToMaple[#1,"MatrixNo"<>(ToString@#2)]&,
		{(Flatten[Values@BMatricesValues,{1,2}]),Table[i,{i,8}]}];
	AllMatrices=(Flatten[Values@BMatricesValues,{1,2}]);
	DumpSave[FileNameJoin@{NotebookDirectory[],"AllMatrices.mx"},{AllMatrices}];
Quit[];
	(*GiveInv/@(Flatten[Values@BMatricesValues,{1,2}]);*)
	Print@"end of shortcut";

	(*(xAct`PSALTer`Private`PSALTerParallelSubmit@)*)
	MatrixPropagator=MapThread[	
			((InvertWithAssumptions[#1,#2]))&,
			{({CouplingAssumptions,CouplingAssumptions})&/@BMatricesValues,
			BMatricesValues},2];
	(*Print@MatrixPropagator;*)
	MatrixPropagator=WaitAll@MatrixPropagator;
	Diagnostic@(Map[MatrixForm,MatrixPropagator,2]);
	MatrixPropagator=(#[[1]]+#[[2]])&/@MatrixPropagator;
(*	
	MatrixPropagator=Assuming[CouplingAssumptions,((PseudoInverse@#))&/@MatrixLagrangian];
*)
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

	(*saturated form of the propagator*)
	(*SaturatedPropagator=MapThread[#1 . #2 . #3&,*)
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

	NotebookDelete@PrintVariable;

	CombinedSectors=Map[Flatten,Merge[#,Identity]&/@Merge[Values@FieldSpinParityTensorHeadsValue,Identity],{2}];
	Sizes=Map[Length,Values@(Values/@(CombinedSectors)),{2}];
	TheSpins=Keys@CombinedSectors;

{SourceConstraints,Flatten[Values@SaturatedPropagator,{1,2}],Flatten[Values@BMatricesValues,{1,2}],Flatten[Values@InverseBMatricesValues,{1,2}],BlockMassSigns,Sizes,TheSpins,FieldsLeft,FieldsTop,SourcesLeft,SourcesTop}];	
