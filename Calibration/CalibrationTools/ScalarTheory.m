(*================*)
(*  ScalarTheory  *)
(*================*)

(*===========================================*)
(*  Massless scalar (shift-symmetric field)  *)
(*===========================================*)

Title@"Massless scalar (shift-symmetric field)";

Comment@"Try with a de Sitter background";

DefTensor[ScaleFactor[],M4,PrintAs->"\[ScriptA]"];
DefConstantSymbol[HubbleNumber,PrintAs->"\[ScriptCapitalH]"];
AutomaticRules[ScaleFactor,MakeRule[{CD[-a]@ScaleFactor[],HubbleNumber*ScaleFactor[]^2*V[-a]},MetricOn->All,ContractMetrics->True]]

Comment@"By a Weyl-rescaling purely of the scalar field (but not of the metric), we can obtain this version of the theory;";

LinearisedLagrangian=ScaleFactor[]^4*(ScaleFactor[]^(-2)*CD[-a]@(xAct`PSALTer`ScalarTheory`Phi[]/ScaleFactor[])CD[a]@(xAct`PSALTer`ScalarTheory`Phi[]/ScaleFactor[]));
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=ScreenDollarIndices;
Print@LinearisedLagrangian;

Comment@"And by an additional surface term we can obtain this version;";

LinearisedLagrangian=RemoveVFromLagrangian[LinearisedLagrangian,{xAct`PSALTer`ScalarTheory`Phi},{Coupling1,Coupling2,Coupling3}];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=ScreenDollarIndices;
Print@LinearisedLagrangian;

Comment@"Let's represent both of these Lagrangia using the following PSALTer-ready setup;";

LinearisedLagrangian=Coupling1*CD[-a]@xAct`PSALTer`ScalarTheory`Phi[]CD[a]@xAct`PSALTer`ScalarTheory`Phi[]+Coupling2*xAct`PSALTer`ScalarTheory`Phi[]*V[-a]CD[a]@xAct`PSALTer`ScalarTheory`Phi[](*+Coupling3*xAct`PSALTer`ScalarTheory`Phi[]^2*);
Print@LinearisedLagrangian;

Throw@"Stop here please.";

Comment@"Now we try computing the particle spectrum of this Lagrangian.";

ParticleSpectrum[
	"ScalarTheory",
	"MasslessScalar",
	LinearisedLagrangian,
	TensorFields->{xAct`PSALTer`ScalarTheory`Phi},
	CouplingConstants->{Coupling1,Coupling2,Coupling3},
	ExportTheory->True
];

Throw@"Stop here please.";

Comment@"Let's begin by looking at a massless scalar field theory.";

LinearisedLagrangian=Coupling1*CD[-a]@xAct`PSALTer`ScalarTheory`Phi[]CD[a]@xAct`PSALTer`ScalarTheory`Phi[];
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
