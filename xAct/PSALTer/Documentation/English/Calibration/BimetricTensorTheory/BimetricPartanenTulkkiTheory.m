(*================================*)
(*  BimetricPartanenTulkkiTheory  *)
(*================================*)

Section@"Partanen-Tulkki gravity";

Comment@"We now examine the theory proposed in arXiv:2310.01460.";
Code[
	LinearisedLagrangian=(1/(EinsteinConstant))*(
		(-1/2)*(CD[-m]@BimetricF[-r,-n]-CD[-n]@BimetricF[-r,-m])*
		(CD[m]@BimetricF[r,n]-CD[n]@BimetricF[r,m])+
		(-1/2)*(CD[-m]@BimetricLinearMetric[-r,-n]-CD[-n]@BimetricLinearMetric[-r,-m])*
		(CD[m]@BimetricLinearMetric[r,n]-CD[n]@BimetricLinearMetric[r,m])+
		(1/1)*(CD[-m]@BimetricLinearMetric[-r,-n]-CD[-n]@BimetricLinearMetric[-r,-m])*
		(CD[m]@BimetricF[r,n]-CD[n]@BimetricF[r,m])
	);
];
DisplayExpression[LinearisedLagrangian,EqnLabel->"BimetricPartanenTulkkiTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Code[
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"BimetricPartanenTulkkiTheory",
		Method->"Easy",
		MaxLaurentDepth->1
	];
];
Comment@{"So",Cref@"BimetricPartanenTulkkiTheory"," contains some ghosts. Now we try again with increased LaurentDepth."};
Code[
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"BimetricPartanenTulkkiTheoryDeep",
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
