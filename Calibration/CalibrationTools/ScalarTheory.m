(*================*)
(*  ScalarTheory  *)
(*================*)

Title@"Scalar field theory";

Supercomment@"We will test the ScalarTheory module.";

(*===========================================*)
(*  Massless scalar (shift-symmetric field)  *)
(*===========================================*)

Section@"Massless scalar (shift-symmetric field)";

Comment@"Let's begin by looking at a massless scalar field theory.";

LinearisedLagrangian=Coupling1*CD[-a]@xAct`PSALTer`ScalarTheory`Phi[]CD[a]@xAct`PSALTer`ScalarTheory`Phi[];
DisplayExpression@LinearisedLagrangian;

Comment@"Now we shove the Lagrangian into PSALTer.";

ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"PoincareGaugeTheory",
	TheoryName->"MasslessScalar",	
	Method->"Careless",
	MaxLaurentDepth->3
];

Comment@"The result is much as you would expect. There is one massless polarisation, supported by a no-ghost condition which bounds the kinetic part of the Hamiltonian from below.";

(*=======================================*)
(*  Massive scalar (Higgs field, pions)  *)
(*=======================================*)

Section@"Massive scalar (Higgs field, pions)";

Comment@"Now for the massive case.";

LinearisedLagrangian=Coupling1*CD[-a]@xAct`PSALTer`ScalarTheory`Phi[]CD[a]@xAct`PSALTer`ScalarTheory`Phi[]-Coupling2*Phi[]*Phi[];
DisplayExpression@LinearisedLagrangian;

Comment@"We apply PSALTer again.";

ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"PoincareGaugeTheory",
	TheoryName->"MassiveScalar",	
	Method->"Careless",
	MaxLaurentDepth->3
];

Comment@"We find that the massless eigenvalue has disappeared, but the propagator develops a massive pole whose no-ghost condition is equivalent. There is an additional no-tachyon condition on the Klein-Gordon mass.";
