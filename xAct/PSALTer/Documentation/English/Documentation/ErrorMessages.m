(*=================*)
(*  ErrorMessages  *)
(*=================*)

DefField[Phi[],PrintAs->"\[Phi]",PrintSourceAs->"\[Rho]"];
DefField[AntisymmTensor[-a,-b],Antisymmetric[{-a,-b}],PrintAs->"\[ScriptCapitalB]",PrintSourceAs->"\[ScriptCapitalJ]"];
DefConstantSymbol[Coupling1,PrintAs->"\[Alpha]"];
DefConstantSymbol[Coupling2,PrintAs->"\[Beta]"];
DefConstantSymbol[Coupling3,PrintAs->"\[Gamma]"];
DefConstantSymbol[Coupling4,PrintAs->"\[Delta]"];
DefConstantSymbol[Coupling5,PrintAs->"\[Epsilon]"];
DefConstantSymbol[Coupling6,PrintAs->"\[Zeta]"];

Comment@"We will test the error messages.";
Comment@"Try passing a theory name that is not a string:";
Catch@Code[
	ParticleSpectrum[
		Coupling1*CD[-a]@Phi[]CD[a]@Phi[],
		TheoryName->NotStringTheory,
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
Comment@"Try passing a method that is not implemented:";
Catch@Code[
	ParticleSpectrum[
		Coupling1*CD[-a]@Phi[]CD[a]@Phi[],
		TheoryName->"MyVeryCoolTheory",	
		Method->"InfiniteMonkeys",
		MaxLaurentDepth->3
	];
];
Comment@"Try passing a maximum Laurent depth that is too great:";
Catch@Code[
	ParticleSpectrum[
		Coupling1*CD[-a]@Phi[]CD[a]@Phi[],
		TheoryName->"MyVeryCoolTheory",	
		Method->"Hard",
		MaxLaurentDepth->4
	];
];
Comment@"Try passing a Lagrangian density which is not quadratic in the fields:";
LinearLagrangian=Coupling1*CD[-a]@Phi[]CD[a]@Phi[]+Coupling2*Phi[]+Coupling3*Phi[]^3;
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
LinearLagrangian=Coupling1*CD[-a]@Phi[]CD[a]@Psi[];
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
LinearLagrangian=CD[-a]@Phi[]CD[a]@Phi[]+Coupling2^2*Phi[]^2;
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
LinearLagrangian=Coupling1*epsilonG[a,b,c,d]CD[-a]@Phi[]CD[-b]@AntisymmTensor[-c,-d];
DisplayExpression@LinearLagrangian;
Catch@Code[LinearLagrangian,
	ParticleSpectrum[
		LinearLagrangian,
		TheoryName->"MyVeryCoolTheory",	
		Method->"Hard",
		MaxLaurentDepth->3
	];
];
