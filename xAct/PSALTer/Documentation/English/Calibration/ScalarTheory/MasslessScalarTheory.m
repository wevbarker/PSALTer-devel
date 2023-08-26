(*========================*)
(*  MasslessScalarTheory  *)
(*========================*)

Section@"Massless scalar (shift-symmetric field)";

Comment@"Let's begin by looking at a massless scalar field theory.";
LinearisedLagrangian=Coupling1*CD[-a]@xAct`PSALTer`ScalarTheory`Phi[]CD[a]@xAct`PSALTer`ScalarTheory`Phi[];
DisplayExpression@LinearisedLagrangian;
Comment@"Now we shove the Lagrangian into PSALTer.";
ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"ScalarTheory",
	TheoryName->"MasslessScalarTheory",
	Method->"Easy",
	MaxLaurentDepth->3
];
Comment@"The result is much as you would expect. There is one massless polarisation, supported by a no-ghost condition which bounds the kinetic part of the Hamiltonian from below.";
