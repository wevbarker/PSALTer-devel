(*==============================*)
(*  SecondSickFierzPauliTheory  *)
(*==============================*)

Subsection@"Sick Fierz-Pauli (second variation)";
Comment@{"We allow the third term in",Cref@"FierzPauliTheory"," to float."};
LinearisedLagrangian=Coupling1*(
	(1/2)*CD[-b]@MetricPerturbation[a,-a]*CD[b]@MetricPerturbation[c,-c]
	-CD[a]@MetricPerturbation[-a,-b]*CD[b]@MetricPerturbation[c,-c]	
	+CD[-b]@MetricPerturbation[a,b]*CD[c]@MetricPerturbation[-a,-c]
)-Coupling2*(1/2)*CD[-c]@MetricPerturbation[a,b]*CD[c]@MetricPerturbation[-a,-b];
DisplayExpression[LinearisedLagrangian,EqnLabel->"SecondSickFierzPauliTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"SecondSickFierzPauliTheory",	
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
Comment@{"Again, as with",Cref@"FirstSickFierzPauliTheory",", this variation has no gauge symmetries, too many propagating species and no hope of unitarity."};
