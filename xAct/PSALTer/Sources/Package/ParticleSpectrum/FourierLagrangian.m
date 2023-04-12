(*=====================*)
(*  FourierLagrangian  *)
(*=====================*)

FourierLagrangian[ClassName_?StringQ,Expr_,Tensors_]:=Module[{
	Class,
	CrossingRules,
	ToMomentumExpr,
	Tensors1,
	Tensors2,
	PrintVariable},

	PrintVariable={};
	PrintVariable=PrintVariable~Append~PrintTemporary@" ** FourierLagrangian...";

	Class=Evaluate@Symbol@ClassName;

	Tensors1=(#@@(ToExpression/@Alphabet[][[1;;(Length@SlotsOfTensor@#)]]))&/@(Tensors);
	Tensors2=(#@@(ToExpression/@Alphabet[][[-(Length@SlotsOfTensor@#);;-1]]))&/@(Tensors);

	CrossingRules={};(*start off without any rules*)

	(*----------------------------------------*)
	(*  Terms where surface terms are needed  *)
	(*----------------------------------------*)

	(*first the double derivatives*)
	Table[(CrossingRules=CrossingRules~Join~
	MakeRule[{Evaluate[CD[-q]@Tensor1 CD[-p]@Tensor2],Evaluate[Dagger@Tensor1 P[-p]P[-q]Tensor2]},MetricOn->All,ContractMetrics->True]),
	{Tensor1,Tensors1},{Tensor2,Tensors2}];

	Diagnostic@CrossingRules;

	(*-------------------------------------------*)
	(*  Terms where no surface terms are needed  *)
	(*-------------------------------------------*)

	(*then single derivatives*)
	Table[(CrossingRules=CrossingRules~Join~
	MakeRule[{Evaluate[Tensor1 CD[-p]@Tensor2],Evaluate[-I Dagger@Tensor1 P[-p]Tensor2]},MetricOn->All,ContractMetrics->True]),
	{Tensor1,Tensors1},{Tensor2,Tensors2}];

	(*and finally algebraic products*)
	Table[(CrossingRules=CrossingRules~Join~
	MakeRule[{Evaluate[Tensor1 Tensor2],Evaluate[Dagger@Tensor1 Tensor2]},MetricOn->All,ContractMetrics->True]),
	{Tensor1,Tensors1},{Tensor2,Tensors2}];

	(*finally the double derivative again*)
	Table[(CrossingRules=CrossingRules~Join~
	MakeRule[{Evaluate[Tensor1 CD[-q]@(CD[-p]@Tensor2)],Evaluate[-Dagger@Tensor1 P[-p]P[-q]Tensor2]},MetricOn->All,ContractMetrics->True]),
	{Tensor1,Tensors1},{Tensor2,Tensors2}];

	Diagnostic@CrossingRules;

	Diagnostic@Expr;
	ToMomentumExpr=Expr;
	ToMomentumExpr//=ToNewCanonical;
	ToMomentumExpr//=CollectTensors;

	ToMomentumExpr=ToMomentumExpr/.CrossingRules;(*now impose these rules to obtain Fourier space version*)
	Diagnostic@ToMomentumExpr;
	ToMomentumExpr=ToMomentumExpr/.CrossingRules;(*now impose these rules to obtain Fourier space version*)
	Diagnostic@ToMomentumExpr;
	ToMomentumExpr//=ToNewCanonical;
	Diagnostic@ToMomentumExpr;

	(*now move over to SO(3) decomposition*)
	ToMomentumExpr=ToMomentumExpr/.ToV;

	ToMomentumExpr//=Class@DecomposeFields;
	Diagnostic@ToMomentumExpr;

	NotebookDelete@PrintVariable;
ToMomentumExpr];
