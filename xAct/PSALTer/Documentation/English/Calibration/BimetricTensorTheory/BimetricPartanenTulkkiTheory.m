(*================================*)
(*  BimetricPartanenTulkkiTheory  *)
(*================================*)

Section@"Partanen-Tulkki gravity";

Comment@"We now examine the theory proposed in arXiv:2310.01460.";
LinearisedLagrangian=-(1/(8*xAct`PSALTer`BimetricTensorTheory`EinsteinConstant))*(
	(CD[-m]@xAct`PSALTer`BimetricTensorTheory`BimetricF[-r,-n]-CD[-n]@xAct`PSALTer`BimetricTensorTheory`BimetricF[-r,-m])*
	(CD[m]@xAct`PSALTer`BimetricTensorTheory`BimetricF[r,n]-CD[n]@xAct`PSALTer`BimetricTensorTheory`BimetricF[r,m])+
	(CD[-m]@xAct`PSALTer`BimetricTensorTheory`BimetricLinearMetric[-r,-n]-CD[-n]@xAct`PSALTer`BimetricTensorTheory`BimetricLinearMetric[-r,-m])*
	(CD[m]@xAct`PSALTer`BimetricTensorTheory`BimetricLinearMetric[r,n]-CD[n]@xAct`PSALTer`BimetricTensorTheory`BimetricLinearMetric[r,m])
);
DisplayExpression[LinearisedLagrangian,EqnLabel->"BimetricPartanenTulkkiTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"BimetricTensorTheory",
	TheoryName->"BimetricPartanenTulkkiTheory",
	Method->"Easy",
	MaxLaurentDepth->3
];
Comment@{"Some comment about",Cref@"BimetricPartanenTulkkiTheory","."};
