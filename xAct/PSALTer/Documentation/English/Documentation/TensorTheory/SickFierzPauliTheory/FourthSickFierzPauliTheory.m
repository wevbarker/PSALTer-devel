(*==============================*)
(*  FourthSickFierzPauliTheory  *)
(*==============================*)

Subsection@"Sick Fierz-Pauli (fourth variation)";
Comment@{"We allow the first term in",Cref@"FierzPauliTheory"," to float."};
LinearisedLagrangian=Coupling1*(
	-CD[a]@MetricPerturbation[-a,-b]*CD[b]@MetricPerturbation[c,-c]
	-(1/2)*CD[-c]@MetricPerturbation[a,b]*CD[c]@MetricPerturbation[-a,-b]
	+CD[-b]@MetricPerturbation[a,b]*CD[c]@MetricPerturbation[-a,-c]
)+Coupling2*(1/2)*CD[-b]@MetricPerturbation[a,-a]*CD[b]@MetricPerturbation[c,-c];
DisplayExpression[LinearisedLagrangian,EqnLabel->"FourthSickFierzPauliTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"FourthSickFierzPauliTheory",
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
Comment@{"As with",Cref@"ThirdSickFierzPauliTheory",", we have a partial gauge symmetry and an extra scalar mode."};
