(*==================================*)
(*  AsymmetricPartanenTulkkiTheory  *)
(*==================================*)

Section@"Partanen-Tulkki gravity";

Comment@"We now examine the theory proposed in arXiv:2310.01460.";
LinearisedLagrangian=-(1/(8*xAct`PSALTer`AsymmetricTensorTheory`EinsteinConstant))*(
	(CD[-m]@xAct`PSALTer`AsymmetricTensorTheory`F[-r,-n]-CD[-n]@xAct`PSALTer`AsymmetricTensorTheory`F[-r,-m])*
	(CD[m]@xAct`PSALTer`AsymmetricTensorTheory`F[r,n]-CD[n]@xAct`PSALTer`AsymmetricTensorTheory`F[r,m])
);
DisplayExpression[LinearisedLagrangian,EqnLabel->"AsymmetricPartanenTulkkiTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"AsymmetricTensorTheory",
	TheoryName->"AsymmetricPartanenTulkkiTheory",
	Method->"Easy",
	MaxLaurentDepth->3
];
Comment@{"Some comment about",Cref@"AsymmetricPartanenTulkkiTheory","."};
