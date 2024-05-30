(*==================*)
(*  ToNewCanonical  *)
(*==================*)

ToNewCanonical[Expr_]:=Module[{
	CanonicalisedExpr=Expr,
	PrintVariable},

	CanonicalisedExpr//=NoScalar;
	CanonicalisedExpr//=ToCanonical;
	CanonicalisedExpr//=ContractMetric;
	CanonicalisedExpr//=ScreenDollarIndices;
CanonicalisedExpr];
