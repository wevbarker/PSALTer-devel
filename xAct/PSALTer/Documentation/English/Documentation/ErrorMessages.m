(*=================*)
(*  ErrorMessages  *)
(*=================*)

Comment@"We will test the error messages.";
LinearisedLagrangian=Coupling1*CD[-a]@Phi[]CD[a]@Phi[];
Comment@"Try passing a theory name that is not a string:";
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->NotStringTheory,
		Method->"Careless",
		MaxLaurentDepth->3
	];
];
Comment@"Try passing a method that is not implemented:";
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"MyVeryCoolTheory",	
		Method->"InfiniteMonkeys",
		MaxLaurentDepth->3
	];
];
Comment@"Try passing a maximum Laurent depth that is too great:";
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"MyVeryCoolTheory",	
		Method->"Careful",
		MaxLaurentDepth->4
	];
];
