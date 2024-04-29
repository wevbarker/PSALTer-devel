(*========================*)
(*  LongitudinalMassless  *)
(*========================*)

Section@"Pure longitudinal massless";

Comment@{"There is another (more obscure) special case of",Cref@"SickMaxwellTheory"," distinct from",Cref@"MaxwellTheory",", which is not pathological."};
Code[
	LinearisedLagrangian=Coupling2*CD[-a]@B[a]*CD[-b]@B[b];
];
DisplayExpression[LinearisedLagrangian,EqnLabel->"LongitudinalMassless"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Code[
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"LongitudinalMassless",	
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
Comment@"The spectrum is entirely empty.";
