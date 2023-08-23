(*=============================*)
(*  ThirdSickFierzPauliTheory  *)
(*=============================*)

Section@"Sick Fierz-Pauli (third variation)";

Comment@"This time let's wiggle the second term.";

LinearisedLagrangian=xAct`PSALTer`TensorTheory`Coupling1*(
	(1/2)*CD[-b]@LinearMetric[a,-a]*CD[b]@LinearMetric[c,-c]
	-(1/2)*CD[-c]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-b]
	+CD[-b]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-c]
)-xAct`PSALTer`TensorTheory`Coupling2*CD[a]@LinearMetric[-a,-b]*CD[b]@LinearMetric[c,-c];

DisplayExpression@LinearisedLagrangian;

LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;

ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"TensorTheory",
	TheoryName->"ThirdSickFierzPauliTheory",
	Method->"Easy",
	MaxLaurentDepth->3
];

Comment@"This time we have what looks to be a viable theory with an extra massless scalar. However the diffeomorphism gauge symmetry has been lost, and the stress-energy tensor is not conserved.";
