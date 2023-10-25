(*=================================*)
(*  SymmetricPartanenTulkkiTheory  *)
(*=================================*)

Section@"Partanen-Tulkki gravity";

Comment@"We now examine the theory proposed in arXiv:2310.01460.";
LinearisedLagrangian=-(1/(8*xAct`PSALTer`SymmetricTensorTheory`EinsteinConstant))*(
	(CD[-m]@xAct`PSALTer`SymmetricTensorTheory`LinearMetric[-r,-n]-CD[-n]@xAct`PSALTer`SymmetricTensorTheory`LinearMetric[-r,-m])*
	(CD[m]@xAct`PSALTer`SymmetricTensorTheory`LinearMetric[r,n]-CD[n]@xAct`PSALTer`SymmetricTensorTheory`LinearMetric[r,m])
);
DisplayExpression[LinearisedLagrangian,EqnLabel->"SymmetricPartanenTulkkiTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"SymmetricTensorTheory",
	TheoryName->"SymmetricPartanenTulkkiTheory",
	Method->"Easy",
	MaxLaurentDepth->3
];
Comment@{"Some comment about",Cref@"SymmetricPartanenTulkkiTheory","."};
