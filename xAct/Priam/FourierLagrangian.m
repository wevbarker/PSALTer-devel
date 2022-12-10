(*=====================*)
(*  FourierLagrangian  *)
(*=====================*)

FourierLagrangian[Expr_,Tensors__]:=Catch@Module[{CrossingRules,ToMomentumExpr,Tensors1,Tensors2,printer},
printer={};
printer=printer~Append~PrintTemporary@" ** FourierLagrangian...";
Tensors1=(#@@(ToExpression/@Alphabet[][[1;;(Length@SlotsOfTensor@#)]]))&/@(List@Tensors);
Tensors2=(#@@(ToExpression/@Alphabet[][[-(Length@SlotsOfTensor@#);;-1]]))&/@(List@Tensors);
CrossingRules={};(*start off without any rules*)
(*first the double derivatives*)
Table[(CrossingRules=CrossingRules~Join~
MakeRule[{Evaluate[Global`CD[-Global`q]@Tensor1 Global`CD[-Global`p]@Tensor2],Evaluate[Dagger@Tensor1 Global`P[-Global`p]Global`P[-Global`q]Tensor2]},MetricOn->All,ContractMetrics->True]),
{Tensor1,Tensors1},{Tensor2,Tensors2}];
(*then single derivatives*)
Table[(CrossingRules=CrossingRules~Join~
MakeRule[{Evaluate[Tensor1 Global`CD[-Global`p]@Tensor2],Evaluate[-I Dagger@Tensor1 Global`P[-Global`p]Tensor2]},MetricOn->All,ContractMetrics->True]),
{Tensor1,Tensors1},{Tensor2,Tensors2}];
(*and finally algebraic products*)
Table[(CrossingRules=CrossingRules~Join~
MakeRule[{Evaluate[Tensor1 Tensor2],Evaluate[Dagger@Tensor1 Tensor2]},MetricOn->All,ContractMetrics->True]),
{Tensor1,Tensors1},{Tensor2,Tensors2}];
ToMomentumExpr=Expr/.CrossingRules;(*now impose these rules to obtain Fourier space version*)
ToMomentumExpr=ToMomentumExpr//ToNewCanonical;
printer=printer~Append~PrintTemporary@ToMomentumExpr;
(*now move over to SO(3) decomposition*)
ToMomentumExpr=ToMomentumExpr/.Global`ToV;
ToMomentumExpr=ToMomentumExpr//ToNewCanonical;
ToMomentumExpr=ToMomentumExpr/.Global`GaugeDecompose//ToNewCanonical;
ToMomentumExpr=ToMomentumExpr/.Global`GaugePToGaugePO3/.Global`GaugePerpToGaugePO3//ToNewCanonical;
ToMomentumExpr=ToMomentumExpr//CollectTensors;
ToMomentumExpr=ToMomentumExpr/.Global`Patch2m;
ToMomentumExpr=ToMomentumExpr/.Global`ManualAll;
ToMomentumExpr=ToMomentumExpr/.Global`ManualAll;
ToMomentumExpr=ToMomentumExpr//ToNewCanonical;
ToMomentumExpr=ToMomentumExpr//CollectTensors;

Print@" ** FourierLagrangian: Lagrangian in Fourier space, decomposed among the SO(3) irreducible representations of the fields:";
Print["\!\(\*SuperscriptBox[OverscriptBox[\(\[Zeta]\), \(^\)], \(\[Dagger]\)]\)(\[ScriptK])\[CenterDot]\!\(\*OverscriptBox[\(\[ScriptCapitalO]\), \(^\)]\)(\[ScriptK])\[CenterDot]\!\(\*OverscriptBox[\(\[Zeta]\), \(^\)]\)(\[ScriptK]) = ",ToMomentumExpr];

NotebookDelete@printer;
ToMomentumExpr];
