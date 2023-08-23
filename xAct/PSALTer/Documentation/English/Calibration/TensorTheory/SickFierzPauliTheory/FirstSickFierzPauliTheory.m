(*=============================*)
(*  FirstSickFierzPauliTheory  *)
(*=============================*)

Subsection@"Sick Fierz-Pauli (first variation)";

Comment@"Returning to the case without any mass terms, we should check that deviations to the Fierz-Pauli action are unacceptable. Let's vary the fourth term to some degree.";

LinearisedLagrangian=xAct`PSALTer`TensorTheory`Coupling1*(
	(1/2)*CD[-b]@LinearMetric[a,-a]*CD[b]@LinearMetric[c,-c]
	-CD[a]@LinearMetric[-a,-b]*CD[b]@LinearMetric[c,-c]
	-(1/2)*CD[-c]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-b]
)+xAct`PSALTer`TensorTheory`Coupling2*CD[-b]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-c];

DisplayExpression@LinearisedLagrangian;

LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;

ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"TensorTheory",
	TheoryName->"FirstSickFierzPauliTheory",	
	Method->"Easy",
	MaxLaurentDepth->3
];

Comment@"So this variation has no gauge symmetries, too many propagating species and no hope of unitarity.";
