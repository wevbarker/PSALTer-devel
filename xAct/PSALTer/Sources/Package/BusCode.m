(*--------------------------------------------------------*)
(*  Speculative code written on the bus from the airport  *)
(*--------------------------------------------------------*)

SpinParityTensorHeads=<|
		A-><|
			0-><|Even->{AP0p},Odd->{AP0m}|>,
			1-><|Even->{AP1p,APerp1p},Odd->{AP1m,APerp1m}|>,
			2-><|Even->{AP2p},Odd->{AP2m}|>
		|>,
		F-><|
			0-><|Even->{FP0p,FPerp0p},Odd->{}|>,
			1-><|Even->{FP1p},Odd->{FP1m,FPerp1m}|>,
			2-><|Even->{FP2p},Odd->{}|>
		|>
|>;

ExecuteRules[]:=(

Tensors=Keys@SpinParityTensorHeads;
Spins=Sort@DeleteDuplicates@Flatten@(Keys/@(Values@SpinParityTensorHeads));

AutomaticRules[AP2m,MakeRule[{Evaluate[AP2m[-a,-c,-b]Dagger@AP2m[a,b,c]],Evaluate[(1/2)AP2m[-a,-b,-c]Dagger@AP2m[a,b,c]]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[Evaluate[Dagger@AP2m],MakeRule[{Evaluate[Dagger@AP2m[-a,-c,-b]AP2m[a,b,c]],Evaluate[(1/2)Dagger@AP2m[-a,-b,-c]AP2m[a,b,c]]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[Evaluate[Dagger@AP2m],MakeRule[{Evaluate[Dagger@AP2m[-a,-b,-c]Eps[d,b,c]],Evaluate[-(1/2)Dagger@AP2m[-b,-c,-a]Eps[d,b,c]]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[AP2m,MakeRule[{Evaluate[AP2m[-a,-b,-c]Eps[d,b,c]],Evaluate[-(1/2)AP2m[-b,-c,-a]Eps[d,b,c]]},MetricOn->All,ContractMetrics->True]];

SpinParityConstantSymbols=Map[(DefConstantSymbol[ToExpression@((ToString@#)<>"ConstantSymbol"),Dagger->Complex];ToExpression@((ToString@#)<>"ConstantSymbol"))&,SpinParityTensorHeads,{4}];

SpinParityRescalingSymbols=Map[(DefConstantSymbol[ToExpression@((ToString@#)<>"RescalingSymbol"),Dagger->Complex];ToExpression@((ToString@#)<>"RescalingSymbol"))&,SpinParityTensorHeads,{4}];

SpinParityRescalingRules=Flatten@MapThread[
		{#1[AnyIndices___]->#2*#1[AnyIndices]}&,
		{
			(#~Join~(Dagger/@#))&@Flatten@Map[Values,SpinParityTensorHeads,{0,2}],
			(#~Join~#)&@Flatten@Map[Values,SpinParityConstantSymbols,{0,2}]
		}
	];
);

Options@CatalogueInvariant={Mixed->False};
CatalogueInvariant[
	LeftTensor_,
	LeftTensorConstantSymbol_,
	RightTensor_,
	RightTensorConstantSymbol_,
	OptionsPattern[]]:=Module[{TensorContraction},
	
	If[Evaluate@Total@((Length@SlotsOfTensor@#)&/@({LeftTensor,RightTensor}))>0,
		Off[$RecursionLimit::reclim2];
		Off[$IterationLimit::itlim];
		Off[ToCanonical::noident];
		If[OptionValue@Mixed,
		If[Head@#===List,TensorContraction=First@#,TensorContraction=#]&@AllContractions[
				IndexFree@((LeftTensor~Times~RightTensor)~Times~Eps),
				Parallelization->False];,
		If[Head@#===List,TensorContraction=First@#,TensorContraction=#]&@AllContractions[
				IndexFree@(LeftTensor~Times~RightTensor),
				Parallelization->False];
		];
		On[ToCanonical::noident];
		On[$IterationLimit::itlim];
		On[$RecursionLimit::reclim2];,
		TensorContraction=Times@@((#[])&/@({LeftTensor,RightTensor}));
	];

	InvariantToConstantRules=InvariantToConstantRules~Join~
			MakeRule[{
				Evaluate@TensorContraction,
				LeftTensorConstantSymbol~Times~RightTensorConstantSymbol
			},MetricOn->All,ContractMetrics->True];
TensorContraction];

InvariantToConstantRules={};
RescalingMatrix=<||>;
InverseRescalingMatrix=<||>;
InvariantMatrix=<||>;

GenerateAnsatz[]:=Catch@Module[{
	EvenEven,
	EvenOdd,
	OddEven,
	OddOdd
	},

	(

	EvenEven=Outer[CatalogueInvariant[
			Dagger@(#1[[1]]),
			Dagger@(#1[[2]]),
			#2[[1]],
			#2[[2]],Mixed->False]&,
	{#1,#2}&~MapThread~{
		Join@@SpinParityTensorHeads[Tensor][Spin][Even]~Table~{Tensor,Tensors},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Even]~Table~{Tensor,Tensors}
	},
	{#1,#2}&~MapThread~{
		Join@@SpinParityTensorHeads[Tensor][Spin][Even]~Table~{Tensor,Tensors},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Even]~Table~{Tensor,Tensors}
	},
	1];

	EvenOdd=Outer[CatalogueInvariant[
			Dagger@(#1[[1]]),
			Dagger@(#1[[2]]),
			#2[[1]],
			#2[[2]],Mixed->True]&,
	{#1,#2}&~MapThread~{
		Join@@SpinParityTensorHeads[Tensor][Spin][Even]~Table~{Tensor,Tensors},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Even]~Table~{Tensor,Tensors}
	},
	{#1,#2}&~MapThread~{
		Join@@SpinParityTensorHeads[Tensor][Spin][Odd]~Table~{Tensor,Tensors},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Odd]~Table~{Tensor,Tensors}
	},
	1];

	OddEven=Outer[CatalogueInvariant[
			Dagger@(#1[[1]]),
			Dagger@(#1[[2]]),
			#2[[1]],
			#2[[2]],Mixed->True]&,
	{#1,#2}&~MapThread~{
		Join@@SpinParityTensorHeads[Tensor][Spin][Odd]~Table~{Tensor,Tensors},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Odd]~Table~{Tensor,Tensors}
	},
	{#1,#2}&~MapThread~{
		Join@@SpinParityTensorHeads[Tensor][Spin][Even]~Table~{Tensor,Tensors},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Even]~Table~{Tensor,Tensors}
	},
	1];

	OddOdd=Outer[CatalogueInvariant[
			Dagger@(#1[[1]]),
			Dagger@(#1[[2]]),
			#2[[1]],
			#2[[2]],Mixed->False]&,
	{#1,#2}&~MapThread~{
		Join@@SpinParityTensorHeads[Tensor][Spin][Odd]~Table~{Tensor,Tensors},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Odd]~Table~{Tensor,Tensors}
	},
	{#1,#2}&~MapThread~{
		Join@@SpinParityTensorHeads[Tensor][Spin][Odd]~Table~{Tensor,Tensors},
		Join@@SpinParityConstantSymbols[Tensor][Spin][Odd]~Table~{Tensor,Tensors}
	},
	1];

	InvarinatMatrix[Spin]=ArrayFlatten@{{EvenEven,EvenOdd},{OddEven,OddOdd}};

	RescalingMatrix[Spin]=TensorProduct[#,#]&@Flatten@Join[
		SpinParityRescalingSymbols[Tensor][Spin][Even]~Table~{Tensor,Tensors},
		SpinParityRescalingSymbols[Tensor][Spin][Odd]~Table~{Tensor,Tensors}
	];

	InverseRescalingMatrix[Spin]=TensorProduct[1/#,1/#]&@Flatten@Join[
		SpinParityRescalingSymbols[Tensor][Spin][Even]~Table~{Tensor,Tensors},
		SpinParityRescalingSymbols[Tensor][Spin][Odd]~Table~{Tensor,Tensors}
	];

	)~Table~{Spin,Spins};
];

NormaliseRescalings[]:=Module[{Expr,SystemOfEquations,SolutionsToEquations},
	
	Expr=Total@((Tr@InvarinatMatrix[Spin])~Table~{Spin,Spins});
	Expr-=Evaluate@Dagger@F[-a,-b]F[a,b]+Evaluate@Dagger@A[-a,-b,-c]A[a,b,c];
	Expr=Expr/.SpinParityRescalingRules;
	Expr=Expr/.GaugePO3Activate;
	Expr//=ToNewCanonical;
	Expr=Expr/.GaugePerpO3Activate;
	Expr//=ToNewCanonical;
	Expr=Expr/.PADMPiActivate;
	Expr//=ToNewCanonical;
	Expr=Expr/.PO3PiActivate;
	Expr//=ToNewCanonical;
	Expr=Expr/.PADMActivate;
	Expr//=ToNewCanonical;
	Expr//=ToNewCanonical;
	Expr=Expr/.GaugeCompose;
	Expr//=ToNewCanonical;
	Expr//=CollectTensors;

	SystemOfEquations=Expr==0//ToConstantSymbolEquations;
	SolutionsToEquations=Solve@SystemOfEquations;

	RescalingSolutions=SolutionsToEquations[[1]];
	Print@RescalingSolutions;
];
