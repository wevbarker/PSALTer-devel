(*================================*)
(*  BimetricPartanenTulkkiTheory  *)
(*================================*)

Subsection@"Partanen-Tulkki gravity";
Comment@"We now examine the theory proposed in arXiv:2310.01460:";
LinearisedLagrangian=(1/(EinsteinConstant))*(
	(-1/2)*(CD[-m]@AsymmetricF[-r,-n]-CD[-n]@AsymmetricF[-r,-m])*
	(CD[m]@AsymmetricF[r,n]-CD[n]@AsymmetricF[r,m])+
	(-1/2)*(CD[-m]@LinearMetric[-r,-n]-CD[-n]@LinearMetric[-r,-m])*
	(CD[m]@LinearMetric[r,n]-CD[n]@LinearMetric[r,m])+
	(1/1)*(CD[-m]@LinearMetric[-r,-n]-CD[-n]@LinearMetric[-r,-m])*
	(CD[m]@AsymmetricF[r,n]-CD[n]@AsymmetricF[r,m])
);
DisplayExpression[LinearisedLagrangian,EqnLabel->"BimetricPartanenTulkkiTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"BimetricPartanenTulkkiTheory",
		Method->"Easy",
		MaxLaurentDepth->1
	];
];
Comment@{"So",Cref@"BimetricPartanenTulkkiTheory"," contains some ghosts. Now we try again with increased LaurentDepth."};
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"BimetricPartanenTulkkiTheoryDeep",
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
