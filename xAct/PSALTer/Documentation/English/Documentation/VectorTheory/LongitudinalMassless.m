(*========================*)
(*  LongitudinalMassless  *)
(*========================*)

Subsection@"Pure longitudinal massless";
Comment@{"There is another special case of",Cref@"SickMaxwellTheory"," distinct from",Cref@"MaxwellTheory",", which is not pathological."};
LinearisedLagrangian=Coupling2*CD[-a]@VectorField[a]*CD[-b]@VectorField[b];
DisplayExpression[LinearisedLagrangian,EqnLabel->"LongitudinalMassless"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"LongitudinalMassless",	
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
Comment@"The spectrum in this case is entirely empty.";
