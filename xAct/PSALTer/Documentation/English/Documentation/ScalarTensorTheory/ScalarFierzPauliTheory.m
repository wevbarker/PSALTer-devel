(*==========================*)
(*  ScalarFierzPauliTheory  *)
(*==========================*)

Subsection@"Einstein-Klein-Gordon theory";
Comment@{"We check the Fierz-Pauli theory in",Cref@"FierzPauliTheory"," accompanied by (but not coupled to) the massless scalar in",Cref@"MasslessScalarTheory","."};
LinearisedLagrangian=Coupling1*(
	(1/2)*CD[-b]@MetricPerturbation[a,-a]*CD[b]@MetricPerturbation[c,-c]
	-CD[a]@MetricPerturbation[-a,-b]*CD[b]@MetricPerturbation[c,-c]
	-(1/2)*CD[-c]@MetricPerturbation[a,b]*CD[c]@MetricPerturbation[-a,-b]
	+CD[-b]@MetricPerturbation[a,b]*CD[c]@MetricPerturbation[-a,-c]
)+Coupling2*CD[-a]@ScalarField[]*CD[a]@ScalarField[];
DisplayExpression[LinearisedLagrangian,EqnLabel->"ScalarFierzPauliTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"ScalarFierzPauliTheory",
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
Comment@"We obtain the graviton and a massless scalar.";
