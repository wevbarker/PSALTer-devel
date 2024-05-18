(*==================================*)
(*  AsymmetricPartanenTulkkiTheory  *)
(*==================================*)

Subsection@"Partanen-Tulkki gravity";
Comment@"We now examine the theory proposed in arXiv:2310.01460.";
LinearisedLagrangian=-(EinsteinConstant/(8))*(
	(CD[-m]@AsymmetricF[-r,-n]-CD[-n]@AsymmetricF[-r,-m])*
	(CD[m]@AsymmetricF[r,n]-CD[n]@AsymmetricF[r,m])
);
DisplayExpression[LinearisedLagrangian,EqnLabel->"AsymmetricPartanenTulkkiTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"AsymmetricPartanenTulkkiTheory",
		Method->"Easy",
		MaxLaurentDepth->1
	];
];
Comment@{"So",Cref@"AsymmetricPartanenTulkkiTheory"," contains some ghosts. Now we try again but probe for higher-order poles."};
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"AsymmetricPartanenTulkkiTheoryDeep",
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
Comment@"We see that the ghosts are indeed caused by higher-order poles.";
