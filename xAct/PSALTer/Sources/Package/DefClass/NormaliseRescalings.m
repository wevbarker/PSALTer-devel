(*=======================*)
(*  NormaliseRescalings  *)
(*=======================*)

NormaliseRescalings[ClassName_?StringQ]:=Module[{
	Class,
	Expr,
	SystemOfEquations,
	SolutionsToEquations,
	OriginalTerms,
	InvariantMatrixValue
	},

	Class=Evaluate@Symbol@ClassName;
	InvariantMatrixValue=Class@InvariantMatrix;
	
	Expr=Total@((Tr@InvariantMatrixValue[Spin])~Table~{Spin,Class@Spins});
	OriginalTerms=((Evaluate@Dagger@FromIndexFree@ToIndexFree@#)*((FromIndexFree@ToIndexFree@#)/.{SomeIndex_?TangentM4`Q->-SomeIndex}))&/@Class@Tensors;
	Expr-=Total@OriginalTerms;
	Expr=Expr/.Class@SpinParityRescalingRules;

	Expr//=Class@ExpandFields;

	SystemOfEquations=Expr==0//ToConstantSymbolEquations;
	SolutionsToEquations=Solve@SystemOfEquations;

	RescalingSolutionsValue=SolutionsToEquations[[1]];

	UpdateClassAssociation[ClassName,RescalingSolutions,RescalingSolutionsValue];
];
