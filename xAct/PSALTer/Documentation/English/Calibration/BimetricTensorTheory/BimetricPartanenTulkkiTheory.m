(*================================*)
(*  BimetricPartanenTulkkiTheory  *)
(*================================*)

Section@"Partanen-Tulkki gravity";

Comment@"We want to make sure we properly understand the conventions for the various irreps. First we will decompose things.";
Expr=BimetricF[-m,-n];
DisplayExpression@Expr;
Expr//=xAct`PSALTer`BimetricTensorTheory`Private`DecomposeFields;
DisplayExpression@Expr;

Comment@"Now we will expand things.";
PresentExpansion[InputExpr_]:=Module[{Expr=InputExpr},	
	DisplayExpression@Expr;
	Expr//=xAct`PSALTer`BimetricTensorTheory`Private`ExpandFields;
	DisplayExpression@Expr;
];
PresentExpansion/@{BimetricFPara0p[],BimetricFPerp0p[],BimetricFPara1p[-m,-n],BimetricFPara1m[-m],BimetricFPerp1m[-m],BimetricFPara2p[-m,-n],BimetricLinearMetricPerp0p[],BimetricLinearMetricPara0p[],BimetricLinearMetricPerp1m[-m],BimetricLinearMetricPara2p[-m,-n]};

Comment@"We now examine the theory proposed in arXiv:2310.01460.";
LinearisedLagrangian=(1/(xAct`PSALTer`BimetricTensorTheory`EinsteinConstant))*(
	(-1/2)*(CD[-m]@xAct`PSALTer`BimetricTensorTheory`BimetricF[-r,-n]-CD[-n]@xAct`PSALTer`BimetricTensorTheory`BimetricF[-r,-m])*
	(CD[m]@xAct`PSALTer`BimetricTensorTheory`BimetricF[r,n]-CD[n]@xAct`PSALTer`BimetricTensorTheory`BimetricF[r,m])+
	(-1/2)*(CD[-m]@xAct`PSALTer`BimetricTensorTheory`BimetricLinearMetric[-r,-n]-CD[-n]@xAct`PSALTer`BimetricTensorTheory`BimetricLinearMetric[-r,-m])*
	(CD[m]@xAct`PSALTer`BimetricTensorTheory`BimetricLinearMetric[r,n]-CD[n]@xAct`PSALTer`BimetricTensorTheory`BimetricLinearMetric[r,m])+
	(1/1)*(CD[-m]@xAct`PSALTer`BimetricTensorTheory`BimetricLinearMetric[-r,-n]-CD[-n]@xAct`PSALTer`BimetricTensorTheory`BimetricLinearMetric[-r,-m])*
	(CD[m]@xAct`PSALTer`BimetricTensorTheory`BimetricF[r,n]-CD[n]@xAct`PSALTer`BimetricTensorTheory`BimetricF[r,m])
);
DisplayExpression[LinearisedLagrangian,EqnLabel->"BimetricPartanenTulkkiTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"BimetricTensorTheory",
	TheoryName->"BimetricPartanenTulkkiTheory",
	Method->"Easy",
	MaxLaurentDepth->1
];
Comment@{"So",Cref@"BimetricPartanenTulkkiTheory"," contains some ghosts. Now we try again with increased LaurentDepth."};
ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"BimetricTensorTheory",
	TheoryName->"BimetricPartanenTulkkiTheoryDeep",
	Method->"Easy",
	MaxLaurentDepth->3
];
