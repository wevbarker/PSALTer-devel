(*==================================*)
(*  AsymmetricPartanenTulkkiTheory  *)
(*==================================*)

Section@"Partanen-Tulkki gravity";

Comment@"We now examine the theory proposed in arXiv:2310.01460.";
Code[
	LinearisedLagrangian=-(1/(8*EinsteinConstant))*(
		(CD[-m]@AsymmetricF[-r,-n]-CD[-n]@AsymmetricF[-r,-m])*
		(CD[m]@AsymmetricF[r,n]-CD[n]@AsymmetricF[r,m])
	);
];
DisplayExpression[LinearisedLagrangian,EqnLabel->"AsymmetricPartanenTulkkiTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Code[
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"AsymmetricPartanenTulkkiTheory",
		Method->"Easy",
		MaxLaurentDepth->1
	];
];
Comment@{"So",Cref@"AsymmetricPartanenTulkkiTheory"," contains some ghosts. Now we try again with increased LaurentDepth."};
Code[
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"AsymmetricPartanenTulkkiTheoryDeep",
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
