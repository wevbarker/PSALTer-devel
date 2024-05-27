(*=======================*)
(*  LongitudinalMassive  *)
(*=======================*)

Subsection@"Pure longitudinal massive";
Comment@{"Similarly, there is a healthy special case of",Cref@"SickProcaTheory",", which is distinct from",Cref@"ProcaTheory",", and which is just the massive case of",Cref@"LongitudinalMassless","."};
LinearisedLagrangian=Coupling2*CD[-a]@VectorField[a]*CD[-b]@VectorField[b]+Coupling3*VectorField[-a]*VectorField[a];
DisplayExpression@LinearisedLagrangian;
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"LongitudinalMassive",	
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
Comment@"The theory propagates a single, healthy massive scalar.";
