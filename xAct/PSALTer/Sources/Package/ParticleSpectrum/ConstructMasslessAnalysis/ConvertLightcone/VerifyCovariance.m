VerifyCovariance[InputLightconePropagator_]:=Module[{Expr=InputLightconePropagator},
	Expr//=Total;
	Expr//=ToNewCanonical;
	Diagnostic@Expr;
	Quit[];
];
