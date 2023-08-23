(*==============================*)
(*  FourthSickFierzPauliTheory  *)
(*==============================*)

Section@"Sick Fierz-Pauli (fourth variation)";

Comment@"This time let's wiggle the first term.";

LinearisedLagrangian=xAct`PSALTer`TensorTheory`Coupling1*(
	-CD[a]@LinearMetric[-a,-b]*CD[b]@LinearMetric[c,-c]
	-(1/2)*CD[-c]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-b]
	+CD[-b]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-c]
)+xAct`PSALTer`TensorTheory`Coupling2*(1/2)*CD[-b]@LinearMetric[a,-a]*CD[b]@LinearMetric[c,-c];

DisplayExpression@LinearisedLagrangian;

LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;

ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"TensorTheory",
	TheoryName->"FourthSickFierzPauliTheory",
	Method->"Easy",
	MaxLaurentDepth->3
];

Comment@"Another case with a partial gauge symmetry and an extra scalar mode.";
