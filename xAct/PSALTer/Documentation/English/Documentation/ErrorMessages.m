(*=================*)
(*  ErrorMessages  *)
(*=================*)

Comment@"We will test the error messages.";
Comment@"Try passing a theory name that is not a string:";
Catch@Code[
	ParticleSpectrum[
		Coupling1*CD[-a]@ScalarField[]CD[a]@ScalarField[],
		TheoryName->NotStringTheory,
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
Comment@"Try passing a method that is not implemented:";
Catch@Code[
	ParticleSpectrum[
		Coupling1*CD[-a]@ScalarField[]CD[a]@ScalarField[],
		TheoryName->"MyVeryCoolTheory",	
		Method->"InfiniteMonkeys",
		MaxLaurentDepth->3
	];
];
Comment@"Try passing a maximum Laurent depth that is too great:";
Catch@Code[
	ParticleSpectrum[
		Coupling1*CD[-a]@ScalarField[]CD[a]@ScalarField[],
		TheoryName->"MyVeryCoolTheory",	
		Method->"Hard",
		MaxLaurentDepth->4
	];
];
Comment@"Try passing a Lagrangian density which is not quadratic in the fields:";
LinearLagrangian=Coupling1*CD[-a]@ScalarField[]CD[a]@ScalarField[]+Coupling2*ScalarField[]+Coupling3*ScalarField[]^3;
DisplayExpression@LinearLagrangian;
Catch@Code[LinearLagrangian,
	ParticleSpectrum[
		LinearLagrangian,
		TheoryName->"MyVeryCoolTheory",	
		Method->"Hard",
		MaxLaurentDepth->3
	];
];
Comment@"Try passing a Lagrangian density with a field which was not defined using DefField:";
Code[
	DefTensor[Psi[],M4,PrintAs->"\[Psi]"];
];
LinearLagrangian=Coupling1*CD[-a]@ScalarField[]CD[a]@Psi[];
DisplayExpression@LinearLagrangian;
Catch@Code[LinearLagrangian,
	ParticleSpectrum[
		LinearLagrangian,
		TheoryName->"MyVeryCoolTheory",	
		Method->"Hard",
		MaxLaurentDepth->3
	];
];
Comment@"Try passing a Lagrangian density which is not linear in the coupling constants:";
LinearLagrangian=CD[-a]@ScalarField[]CD[a]@ScalarField[]+Coupling2^2*ScalarField[]^2;
DisplayExpression@LinearLagrangian;
Catch@Code[LinearLagrangian,
	ParticleSpectrum[
		LinearLagrangian,
		TheoryName->"MyVeryCoolTheory",	
		Method->"Hard",
		MaxLaurentDepth->3
	];
];
Comment@"Try passing a Lagrangian density which is not parity-even:";
LinearLagrangian=Coupling1*epsilonG[a,b,c,d]CD[-a]@ScalarField[]CD[-b]@TwoFormField[-c,-d];
DisplayExpression@LinearLagrangian;
Catch@Code[LinearLagrangian,
	ParticleSpectrum[
		LinearLagrangian,
		TheoryName->"MyVeryCoolTheory",	
		Method->"Hard",
		MaxLaurentDepth->3
	];
];
