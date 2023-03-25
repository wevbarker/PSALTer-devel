(*================*)
(*  ScalarTheory  *)
(*================*)

(*===========================================*)
(*  Massless scalar (shift-symmetric field)  *)
(*===========================================*)

Title@"Massless scalar (shift-symmetric field)";

Comment@"Let's begin by looking at a massless scalar field theory.";

LinearisedLagrangian=Coupling1*CD[-a]@xAct`PSALTer`ScalarTheory`Phi[]CD[a]@xAct`PSALTer`ScalarTheory`Phi[]+Coupling2*xAct`PSALTer`ScalarTheory`Phi[]*V[-a]CD[a]@xAct`PSALTer`ScalarTheory`Phi[];
(*LinearisedLagrangian=Coupling1*CD[-a]@xAct`PSALTer`ScalarTheory`Phi[]CD[a]@xAct`PSALTer`ScalarTheory`Phi[];*)
Print@LinearisedLagrangian;

Comment@"Now we shove the Lagrangian into PSALTer.";

ParticleSpectrum[
	"ScalarTheory",
	"MasslessScalar",
	LinearisedLagrangian,
	TensorFields->{xAct`PSALTer`ScalarTheory`Phi},
	CouplingConstants->{Coupling1},
	ExportTheory->True
];

Comment@"The result is much as you would expect. There is one massless polarisation, supported by a no-ghost condition which bounds the kinetic part of the Hamiltonian from below.";

(*=======================================*)
(*  Massive scalar (Higgs field, pions)  *)
(*=======================================*)

Title@"Massive scalar (Higgs field, pions)";

Comment@"Now for the massive case.";

LinearisedLagrangian=Coupling1*CD[-a]@xAct`PSALTer`ScalarTheory`Phi[]CD[a]@xAct`PSALTer`ScalarTheory`Phi[]-Coupling2*Phi[]*Phi[];
Print@LinearisedLagrangian;

Comment@"We apply PSALTer again.";

ParticleSpectrum[
	"ScalarTheory",
	"MasslessScalar",
	LinearisedLagrangian,
	TensorFields->{xAct`PSALTer`ScalarTheory`Phi},
	CouplingConstants->{Coupling1,Coupling2},
	ExportTheory->True
];

Comment@"We find that the massless eigenvalue has disappeared, but the propagator develops a massive pole whose no-ghost condition is equivalent. There is an additional no-tachyon condition on the Klein-Gordon mass.";
