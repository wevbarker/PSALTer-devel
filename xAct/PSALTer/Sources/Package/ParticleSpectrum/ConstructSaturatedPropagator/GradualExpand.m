(*=================*)
(*  GradualExpand  *)
(*=================*)

GradualExpand[Expr_,SetOfRules_]:=Module[{ExpandedExpr=Expr,PrintVariable},
	(PrintVariable=PrintTemporary["Attempting to substitute and expand with ",#];
	ExpandedExpr=Expand@(ExpandedExpr/.#);
	NotebookDelete@PrintVariable)&/@Table[Take[SetOfRules,i],{i,Length@SetOfRules}];
ExpandedExpr];
