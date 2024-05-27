(*=============================*)
(*  FirstSickFierzPauliTheory  *)
(*=============================*)

Subsection@"Sick Fierz-Pauli (first variation)";
Comment@{"We allow the fourth term in",Cref@"FierzPauliTheory"," to float."};
LinearisedLagrangian=Coupling1*(
	(1/2)*CD[-b]@MetricPerturbation[a,-a]*CD[b]@MetricPerturbation[c,-c]
	-CD[a]@MetricPerturbation[-a,-b]*CD[b]@MetricPerturbation[c,-c]
	-(1/2)*CD[-c]@MetricPerturbation[a,b]*CD[c]@MetricPerturbation[-a,-b]
)+Coupling2*CD[-b]@MetricPerturbation[a,b]*CD[c]@MetricPerturbation[-a,-c];
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
