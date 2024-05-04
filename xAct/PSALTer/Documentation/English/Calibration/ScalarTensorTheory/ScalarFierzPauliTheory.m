(*==========================*)
(*  ScalarFierzPauliTheory  *)
(*==========================*)

Section@"Einstein-Klein-Gordon theory";

Comment@{"We check the Fierz-Pauli theory in",Cref@"FierzPauliTheory"," accompanied by (but not coupled to) the massless scalar in",Cref@"MasslessScalarTheory","."};
Code[
	LinearisedLagrangian=Coupling1*(
		(1/2)*CD[-b]@LinearMetric[a,-a]*CD[b]@LinearMetric[c,-c]
		-CD[a]@LinearMetric[-a,-b]*CD[b]@LinearMetric[c,-c]
		-(1/2)*CD[-c]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-b]
		+CD[-b]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-c]
	)+Coupling2*CD[-a]@Phi[]*CD[a]@Phi[];
];
DisplayExpression[LinearisedLagrangian,EqnLabel->"ScalarFierzPauliTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Code[
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"ScalarFierzPauliTheory",
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
Comment@"We obtain the graviton and a massless scalar.";
