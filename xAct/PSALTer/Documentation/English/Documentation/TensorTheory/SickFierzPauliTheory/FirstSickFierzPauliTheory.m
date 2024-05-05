(*=============================*)
(*  FirstSickFierzPauliTheory  *)
(*=============================*)

Subsection@"Sick Fierz-Pauli (first variation)";

Comment@{"We allow the fourth term in",Cref@"FierzPauliTheory"," to float."};
LinearisedLagrangian=Coupling1*(
	(1/2)*CD[-b]@LinearMetric[a,-a]*CD[b]@LinearMetric[c,-c]
	-CD[a]@LinearMetric[-a,-b]*CD[b]@LinearMetric[c,-c]
	-(1/2)*CD[-c]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-b]
)+Coupling2*CD[-b]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-c];
DisplayExpression[LinearisedLagrangian,EqnLabel->"FirstSickFierzPauliTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"FirstSickFierzPauliTheory",	
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
Comment@"So this variation has no gauge symmetries, too many propagating species and no hope of unitarity.";
