(*========================*)
(*  PartanenTulkkiTheory  *)
(*========================*)

Subsection@"Partanen-Tulkki gravity";
Comment@"We now examine the theory proposed in arXiv:2310.01460.";
LinearisedLagrangian=Coupling1*(
	(CD[-m]@MetricPerturbation[-r,-n]-CD[-n]@MetricPerturbation[-r,-m])*
	(CD[m]@MetricPerturbation[r,n]-CD[n]@MetricPerturbation[r,m])
);
DisplayExpression[LinearisedLagrangian,EqnLabel->"PartanenTulkkiTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"PartanenTulkkiTheory",
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
Comment@{"Evidently there are some problems with",Cref@"PartanenTulkkiTheory","."};
