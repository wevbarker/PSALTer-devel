(*===============*)
(*  ScalarField  *)
(*===============*)

(*===========================================*)
(*  Massless scalar (shift-symmetric field)  *)
(*===========================================*)

Title@"Massless scalar (shift-symmetric field)";

Comment@"Let's begin by looking at a massless scalar field theory.";

LinearisedLagrangian=Coupling1*CD[-a]@xAct`PSALTer`KG`Phi[]CD[a]@xAct`PSALTer`KG`Phi[];
Print@LinearisedLagrangian;

Comment@"Now we shove the Lagrangian into PSALTer.";

ParticleSpectrum[
	"KG",
	"MasslessScalar",
	LinearisedLagrangian,
	TensorFields->{xAct`PSALTer`KG`Phi},
	CouplingConstants->{Coupling1},
	ExportTheory->True
];

(*=======================================*)
(*  Massive scalar (Higgs field, pions)  *)
(*=======================================*)

Title@"Massive scalar (Higgs field, pions)";

Comment@"Now for the massive case.";

LinearisedLagrangian=Coupling1*CD[-a]@xAct`PSALTer`KG`Phi[]CD[a]@xAct`PSALTer`KG`Phi[]-Coupling2*Phi[]*Phi[];
Print@LinearisedLagrangian;

Comment@"Now we apply PSALTer again.";

ParticleSpectrum[
	"KG",
	"MasslessScalar",
	LinearisedLagrangian,
	TensorFields->{xAct`PSALTer`KG`Phi},
	CouplingConstants->{Coupling1,Coupling2},
	ExportTheory->True
];
