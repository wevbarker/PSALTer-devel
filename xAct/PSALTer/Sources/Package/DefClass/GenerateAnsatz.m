(*==================*)
(*  GenerateAnsatz  *)
(*==================*)

BuildPackage@"DefClass/CatalogueInvariant.m";

GenerateAnsatz[ClassName_?StringQ]:=Catch@Module[{
	Class,
	EvenEven,
	EvenEvenMask,
	EvenOdd,
	EvenOddMask,
	OddEven,
	OddEvenMask,
	OddOdd,
	OddOddMask,
	SpinParityConstantSymbols,
	SpinParityRescalingSymbols,
	SpinParityRescalingRulesValue,
	FieldSpinParityTensorHeadsValue,
	InverseRescalingMatrixValue,
	RescalingMatrixValue,
	InvariantMatrixValue,
	MaskMatrixValue
	},

	Class=Evaluate@Symbol@ClassName;
	FieldSpinParityTensorHeadsValue=Class@FieldSpinParityTensorHeads;

	RescalingMatrixValue=<||>;
	InverseRescalingMatrixValue=<||>;
	InvariantMatrixValue=<||>;
	MaskMatrixValue=<||>;

	Block[{Print},
	Unprotect@Print;
	Print[Expr_]:=NoPrint[Expr];
	SpinParityConstantSymbols=Map[(DefConstantSymbol[ToExpression@((ToString@#)<>"ConstantSymbol"),Dagger->Complex];ToExpression@((ToString@#)<>"ConstantSymbol"))&,FieldSpinParityTensorHeadsValue,{4}];

	SpinParityRescalingSymbols=Map[(DefConstantSymbol[ToExpression@((ToString@#)<>"RescalingSymbol"),Dagger->Complex];ToExpression@((ToString@#)<>"RescalingSymbol"))&,FieldSpinParityTensorHeadsValue,{4}];

	Protect@Print;
	];

	SpinParityRescalingRulesValue=Flatten@MapThread[
			{#1[AnyIndices___]->#2*#1[AnyIndices]}&,
			{
				(#~Join~(Dagger/@#))&@Flatten@Map[Values,FieldSpinParityTensorHeadsValue,{0,2}],
				(#~Join~#)&@Flatten@Map[Values,SpinParityRescalingSymbols,{0,2}]
			}
		];

	UpdateClassAssociation[ClassName,SpinParityRescalingRules,SpinParityRescalingRulesValue];

	UpdateClassAssociation[ClassName,InvariantToConstantRules,{}];

	(

	EvenEven=Outer[CatalogueInvariant[
			ClassName,
			Dagger@(#1[[1]]),
			Dagger@(#1[[2]]),
			#2[[1]],
			#2[[2]],Mixed->False]&,
	{#1,#2}&~MapThread~{
		Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors}
	},
	{#1,#2}&~MapThread~{
		Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors}
	},
	1];

	EvenEvenMask=Outer[(0)&,	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors},	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors}];

	EvenOdd=Outer[CatalogueInvariant[
			ClassName,
			Dagger@(#1[[1]]),
			Dagger@(#1[[2]]),
			#2[[1]],
			#2[[2]],Mixed->True]&,
	{#1,#2}&~MapThread~{
		Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors}
	},
	{#1,#2}&~MapThread~{
		Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}
	},
	1];

	EvenOddMask=Outer[(1)&,	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors},	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}];

	OddEven=Outer[CatalogueInvariant[
			ClassName,
			Dagger@(#1[[1]]),
			Dagger@(#1[[2]]),
			#2[[1]],
			#2[[2]],Mixed->True]&,
	{#1,#2}&~MapThread~{
		Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}
	},
	{#1,#2}&~MapThread~{
		Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors}
	},
	1];

	OddEvenMask=Outer[(1)&,	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors},	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors}];

	OddOdd=Outer[CatalogueInvariant[
			ClassName,
			Dagger@(#1[[1]]),
			Dagger@(#1[[2]]),
			#2[[1]],
			#2[[2]],Mixed->False]&,
	{#1,#2}&~MapThread~{
		Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}
	},
	{#1,#2}&~MapThread~{
		Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}
	},
	1];

	OddOddMask=Outer[(0)&,	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors},	
	Join@@FieldSpinParityTensorHeadsValue[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}];

	InvariantMatrixValue[Spin]=ArrayFlatten@{{EvenEven,EvenOdd},{OddEven,OddOdd}};
	Print@MatrixForm@InvariantMatrixValue[Spin];

	MaskMatrixValue[Spin]=ArrayFlatten@{{EvenEvenMask,EvenOddMask},{OddEvenMask,OddOddMask}};
	Print@MatrixForm@MaskMatrixValue[Spin];

	RescalingMatrixValue[Spin]=TensorProduct[#,#]&@Flatten@Join[
		SpinParityRescalingSymbols[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors},
		SpinParityRescalingSymbols[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}
	];

	InverseRescalingMatrixValue[Spin]=TensorProduct[1/#,1/#]&@Flatten@Join[
		SpinParityRescalingSymbols[Tensor][Spin][Even]~Table~{Tensor,Class@Tensors},
		SpinParityRescalingSymbols[Tensor][Spin][Odd]~Table~{Tensor,Class@Tensors}
	];

	)~Table~{Spin,Class@Spins};


	UpdateClassAssociation[ClassName,InvariantMatrix,InvariantMatrixValue];
	UpdateClassAssociation[ClassName,MaskMatrix,MaskMatrixValue];
	UpdateClassAssociation[ClassName,RescalingMatrix,RescalingMatrixValue];
	UpdateClassAssociation[ClassName,InverseRescalingMatrix,InverseRescalingMatrixValue];
];
