(*=================================*)
(*  SymmetricPartanenTulkkiTheory  *)
(*=================================*)

Section@"Partanen-Tulkki gravity";

Comment@"We now examine the theory proposed in arXiv:2310.01460.";
LinearisedLagrangian=-(1/(8*xAct`PSALTer`SymmetricTensorTheory`EinsteinConstant))*(
	(CD[-m]@xAct`PSALTer`SymmetricTensorTheory`SymmetricLinearMetric[-r,-n]-CD[-n]@xAct`PSALTer`SymmetricTensorTheory`SymmetricLinearMetric[-r,-m])*
	(CD[m]@xAct`PSALTer`SymmetricTensorTheory`SymmetricLinearMetric[r,n]-CD[n]@xAct`PSALTer`SymmetricTensorTheory`SymmetricLinearMetric[r,m])
);
DisplayExpression[LinearisedLagrangian,EqnLabel->"SymmetricPartanenTulkkiTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"SymmetricTensorTheory",
	TheoryName->"SymmetricPartanenTulkkiTheory",
	Method->"Easy",
	MaxLaurentDepth->1
];
Comment@{"So",Cref@"SymmetricPartanenTulkkiTheory"," contains some ghosts. Now we try again with increased LaurentDepth."};
ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"SymmetricTensorTheory",
	TheoryName->"SymmetricPartanenTulkkiTheoryDeep",
	Method->"Easy",
	MaxLaurentDepth->1
];
