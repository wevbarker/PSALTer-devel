(*=======================*)
(*  MassiveScalarTheory  *)
(*=======================*)

Subsection@"Massive scalar (Higgs field, pions)";
Comment@"A massive scalar field theory.";
LinearisedLagrangian=Coupling1*CD[-a]@ScalarField[]CD[a]@ScalarField[]-Coupling2*ScalarField[]*ScalarField[];
DisplayExpression@LinearisedLagrangian;
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"MassiveScalarTheory",
		Method->"Hard",
		MaxLaurentDepth->3
	];
];
Comment@"We find that the massless eigenvalue has disappeared, but the propagator develops a massive pole whose no-ghost condition is equivalent. There is an additional no-tachyon condition on the Klein-Gordon mass.";
