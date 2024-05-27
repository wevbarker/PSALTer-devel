(*========================*)
(*  MasslessScalarTheory  *)
(*========================*)

Subsection@"Massless scalar (shift-symmetric field)";
Comment@"A massless scalar field theory.";
LinearisedLagrangian=Coupling1*CD[-a]@ScalarField[]CD[a]@ScalarField[];
DisplayExpression[LinearisedLagrangian,EqnLabel->"MasslessScalarTheory"];
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"MasslessScalarTheory",
		Method->"Hard",
		MaxLaurentDepth->3
	];
];
Comment@"There is one massless polarisation, supported by a no-ghost condition.";
