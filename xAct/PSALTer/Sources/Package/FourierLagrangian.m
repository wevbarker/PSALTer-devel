(*=====================*)
(*  FourierLagrangian  *)
(*=====================*)

FourierLagrangian[Expr_,Tensors__]:=Catch@Module[{CrossingRules,ToMomentumExpr,Tensors1,Tensors2,PrintVariable},
PrintVariable={};
PrintVariable=PrintVariable~Append~PrintTemporary@" ** FourierLagrangian...";
Tensors1=(#@@(ToExpression/@Alphabet[][[1;;(Length@SlotsOfTensor@#)]]))&/@(List@Tensors);
Tensors2=(#@@(ToExpression/@Alphabet[][[-(Length@SlotsOfTensor@#);;-1]]))&/@(List@Tensors);
CrossingRules={};(*start off without any rules*)
(*first the double derivatives*)
Table[(CrossingRules=CrossingRules~Join~
MakeRule[{Evaluate[CD[-q]@Tensor1 CD[-p]@Tensor2],Evaluate[Dagger@Tensor1 P[-p]P[-q]Tensor2]},MetricOn->All,ContractMetrics->True]),
{Tensor1,Tensors1},{Tensor2,Tensors2}];
(*then single derivatives*)
Table[(CrossingRules=CrossingRules~Join~
MakeRule[{Evaluate[Tensor1 CD[-p]@Tensor2],Evaluate[-I Dagger@Tensor1 P[-p]Tensor2]},MetricOn->All,ContractMetrics->True]),
{Tensor1,Tensors1},{Tensor2,Tensors2}];
(*and finally algebraic products*)
Table[(CrossingRules=CrossingRules~Join~
MakeRule[{Evaluate[Tensor1 Tensor2],Evaluate[Dagger@Tensor1 Tensor2]},MetricOn->All,ContractMetrics->True]),
{Tensor1,Tensors1},{Tensor2,Tensors2}];
ToMomentumExpr=Expr/.CrossingRules;(*now impose these rules to obtain Fourier space version*)
ToMomentumExpr=ToMomentumExpr//ToNewCanonical;
PrintVariable=PrintVariable~Append~PrintTemporary@ToMomentumExpr;
(*now move over to SO(3) decomposition*)
ToMomentumExpr=ToMomentumExpr/.ToV;
ToMomentumExpr=ToMomentumExpr//ToNewCanonical;
ToMomentumExpr=ToMomentumExpr/.GaugeDecompose//ToNewCanonical;
ToMomentumExpr=ToMomentumExpr/.GaugePToGaugePO3/.GaugePerpToGaugePO3//ToNewCanonical;
ToMomentumExpr=ToMomentumExpr//CollectTensors;
ToMomentumExpr=ToMomentumExpr/.Patch2m;
ToMomentumExpr=ToMomentumExpr/.ManualAll;
ToMomentumExpr=ToMomentumExpr/.ManualAll;
ToMomentumExpr=ToMomentumExpr//ToNewCanonical;
ToMomentumExpr=ToMomentumExpr//CollectTensors;

Print@" ** FourierLagrangian: Lagrangian in Fourier space, decomposed among the SO(3) irreducible representations of the fields:";
Print["\!\(\*SuperscriptBox[OverscriptBox[\(\[Zeta]\), \(^\)], \(\[Dagger]\)]\)(\[ScriptK])\[CenterDot]\!\(\*OverscriptBox[\(\[ScriptCapitalO]\), \(^\)]\)(\[ScriptK])\[CenterDot]\!\(\*OverscriptBox[\(\[Zeta]\), \(^\)]\)(\[ScriptK]) = ",ToMomentumExpr];

NotebookDelete@PrintVariable;
ToMomentumExpr];
