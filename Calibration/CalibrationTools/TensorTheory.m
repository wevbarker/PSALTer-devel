(*================*)
(*  TensorTheory  *)
(*================*)

Title@"Tensor field theory";

Supercomment@"We will test the TensorTheory module.";

(*================================*)
(*  Fierz-Pauli (linear gravity)  *)
(*================================*)

Section@"Fierz-Pauli (linear gravity)";

Comment@"The natural theory to check will be the Fierz-Pauli theory.";

LinearisedLagrangian=xAct`PSALTer`TensorTheory`Coupling1*(
	(1/2)*CD[-b]@LinearMetric[a,-a]*CD[b]@LinearMetric[c,-c]
	-CD[a]@LinearMetric[-a,-b]*CD[b]@LinearMetric[c,-c]
	-(1/2)*CD[-c]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-b]
	+CD[-b]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-c]
);
DisplayExpression@LinearisedLagrangian;

LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;

ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"TensorTheory",
	TheoryName->"FierzPauli",	
	Method->"Careless",
	MaxLaurentDepth->3
];

Comment@"The Fierz-Pauli theory thus propagates two massless polarisations, and the no-ghost condition is consistent with a positive Einstein or Newton-Cavendish constant, or a positive square Planck mass. The diffeomorphism invariance of the theory is manifest as a gauge symmetry, whose constraints on the source currents are commensurate with the conservation of the matter stress-energy tensor.";

(*===================*)
(*  Massive gravity  *)
(*===================*)

Section@"Massive gravity";

Comment@"We now include the unique mass term which corresponds to massive gravity, i.e. `Fierz-Pauli tuning'.";

LinearisedLagrangian=xAct`PSALTer`TensorTheory`Coupling1*(
	(1/2)*CD[-b]@LinearMetric[a,-a]*CD[b]@LinearMetric[c,-c]
	-CD[a]@LinearMetric[-a,-b]*CD[b]@LinearMetric[c,-c]
	-(1/2)*CD[-c]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-b]
	+CD[-b]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-c]
)+xAct`PSALTer`TensorTheory`Coupling2*(LinearMetric[-a,-b]*LinearMetric[a,b]-LinearMetric[a,-a]*LinearMetric[b,-b]);
DisplayExpression@LinearisedLagrangian;

LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;

ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"TensorTheory",
	TheoryName->"MassiveGravity",	
	Method->"Careless",
	MaxLaurentDepth->3
];

Comment@"There is no massless sector. The propagator develops a massive pole in the positive-parity tensor sector. The no-ghost condition is as before, but now a no-tachyon condition protects the graviton mess.";

(*====================*)
(*  Sick Fierz-Pauli  *)
(*====================*)

Section@"Sick Fierz-Pauli (first variation)";

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
	TheoryName->"FirstSickFierzPauli",	
	Method->"Careless",
	MaxLaurentDepth->3
];

Comment@"So this variation has no gauge symmetries, too many propagating species and no hope of unitarity.";

Section@"Sick Fierz-Pauli (second variation)";

Comment@"This time let's wiggle the third term.";

LinearisedLagrangian=xAct`PSALTer`TensorTheory`Coupling1*(
	(1/2)*CD[-b]@LinearMetric[a,-a]*CD[b]@LinearMetric[c,-c]
	-CD[a]@LinearMetric[-a,-b]*CD[b]@LinearMetric[c,-c]	
	+CD[-b]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-c]
)-xAct`PSALTer`TensorTheory`Coupling2*(1/2)*CD[-c]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-b];

DisplayExpression@LinearisedLagrangian;

LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;

ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"TensorTheory",
	TheoryName->"SecondSickFierzPauli",	
	Method->"Careless",
	MaxLaurentDepth->3
];

Comment@"Again this variation has no gauge symmetries, too many propagating species and no hope of unitarity.";

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
	TheoryName->"ThirdSickFierzPauli",	
	Method->"Careless",
	MaxLaurentDepth->3
];

Comment@"This time we have what looks to be a viable theory with an extra massless scalar. However the diffeomorphism gauge symmetry has been lost, and the stress-energy tensor is not conserved.";

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
	TheoryName->"FourthSickFierzPauli",	
	Method->"Careless",
	MaxLaurentDepth->3
];

Comment@"Another case with a partial gauge symmetry and an extra scalar mode.";

(*========================*)
(*  Sick massive gravity  *)
(*========================*)

Section@"Sick massive gravity";

Comment@"Finally, let's break the `Fierz-Pauli tuning'.";

LinearisedLagrangian=xAct`PSALTer`TensorTheory`Coupling1*(
	(1/2)*CD[-b]@LinearMetric[a,-a]*CD[b]@LinearMetric[c,-c]
	-CD[a]@LinearMetric[-a,-b]*CD[b]@LinearMetric[c,-c]
	-(1/2)*CD[-c]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-b]
	+CD[-b]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-c]
)+xAct`PSALTer`TensorTheory`Coupling2*LinearMetric[-a,-b]*LinearMetric[a,b]-xAct`PSALTer`TensorTheory`Coupling3*LinearMetric[a,-a]*LinearMetric[b,-b];

DisplayExpression@LinearisedLagrangian;

LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;

ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"TensorTheory",
	TheoryName->"SickMassiveGravity",	
	Method->"Careless",
	MaxLaurentDepth->3
];

Comment@"The consequence is seen in the positive-parity scalar sector, which develops a massive pole. This is the Boulware-Deser ghost, which always spoils the unitarity of the theory.";
