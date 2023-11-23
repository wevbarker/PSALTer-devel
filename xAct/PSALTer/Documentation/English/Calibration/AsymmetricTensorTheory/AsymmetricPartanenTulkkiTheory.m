(*==================================*)
(*  AsymmetricPartanenTulkkiTheory  *)
(*==================================*)

Section@"Partanen-Tulkki gravity";

Comment@"We now examine the theory proposed in arXiv:2310.01460.";
LinearisedLagrangian=-(1/(8*xAct`PSALTer`AsymmetricTensorTheory`EinsteinConstant))*(
	(CD[-m]@xAct`PSALTer`AsymmetricTensorTheory`AsymmetricF[-r,-n]-CD[-n]@xAct`PSALTer`AsymmetricTensorTheory`AsymmetricF[-r,-m])*
	(CD[m]@xAct`PSALTer`AsymmetricTensorTheory`AsymmetricF[r,n]-CD[n]@xAct`PSALTer`AsymmetricTensorTheory`AsymmetricF[r,m])
);
DisplayExpression[LinearisedLagrangian,EqnLabel->"AsymmetricPartanenTulkkiTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"AsymmetricTensorTheory",
	TheoryName->"AsymmetricPartanenTulkkiTheory",
	Method->"Easy",
	MaxLaurentDepth->1
];
Comment@{"So",Cref@"AsymmetricPartanenTulkkiTheory"," contains some ghosts. Now we try again with increased LaurentDepth."};
ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"AsymmetricTensorTheory",
	TheoryName->"AsymmetricPartanenTulkkiTheoryDeep",
	Method->"Easy",
	MaxLaurentDepth->3
];
