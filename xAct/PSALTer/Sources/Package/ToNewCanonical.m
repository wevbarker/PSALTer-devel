(*==================*)
(*  ToNewCanonical  *)
(*==================*)

ToNewCanonical[Expr_]:=Module[{
	CanonicalisedExpr=Expr,
	PrintVariable},

	PrintVariable=PrintTemporary[" ** ToNewCanonical..."];

	CanonicalisedExpr//=ToCanonical;
	CanonicalisedExpr//=ContractMetric;
	CanonicalisedExpr//=ScreenDollarIndices;

	NotebookDelete@PrintVariable;
CanonicalisedExpr];
