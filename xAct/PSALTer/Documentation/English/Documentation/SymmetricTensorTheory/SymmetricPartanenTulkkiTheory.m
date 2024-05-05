(*=================================*)
(*  SymmetricPartanenTulkkiTheory  *)
(*=================================*)

Section@"Partanen-Tulkki gravity";

Comment@"We now examine the theory proposed in arXiv:2310.01460.";
Code[
	LinearisedLagrangian=-(1/(8*EinsteinConstant))*(
		(CD[-m]@SymmTensor[-r,-n]-CD[-n]@SymmTensor[-r,-m])*
		(CD[m]@SymmTensor[r,n]-CD[n]@SymmTensor[r,m])
	);
];
DisplayExpression[LinearisedLagrangian,EqnLabel->"SymmetricPartanenTulkkiTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Code[
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"SymmetricPartanenTulkkiTheory",
		Method->"Easy",
		MaxLaurentDepth->1
	];
];
Comment@{"So",Cref@"SymmetricPartanenTulkkiTheory"," contains some ghosts. Now we try again with increased LaurentDepth."};
Code[
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"SymmetricPartanenTulkkiTheoryDeep",
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
