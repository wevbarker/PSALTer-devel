(*==================================*)
(*  AsymmetricPartanenTulkkiTheory  *)
(*==================================*)

Section@"Asymmetric Partanen-Tulkki gravity";

Comment@"We now examine the theory proposed in arXiv:2310.01460.";
LinearisedLagrangian=xAct`PSALTer`PoincareGaugeTheory`kR1*(
	(CD[-m]@F[-r,-n]-CD[-n]@F[-r,-m])*
	(CD[m]@F[r,n]-CD[n]@F[r,m])
);
DisplayExpression[LinearisedLagrangian,EqnLabel->"AsymmetricPartanenTulkkiTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"PoincareGaugeTheory",
	TheoryName->"AsymmetricPartanenTulkkiTheory",
	Method->"Easy",
	MaxLaurentDepth->3
];
Comment@{"What to say about",Cref@"AsymmetricPartanenTulkkiTheory","."};
