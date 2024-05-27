(*======================*)
(*  SickMassiveGravity  *)
(*======================*)

Subsection@"Sick massive gravity";
Comment@{"We now break the Fierz-Pauli tuning in",Cref@"MassiveGravity","."};
LinearisedLagrangian=Coupling1*(
	(1/2)*CD[-b]@MetricPerturbation[a,-a]*CD[b]@MetricPerturbation[c,-c]
	-CD[a]@MetricPerturbation[-a,-b]*CD[b]@MetricPerturbation[c,-c]
	-(1/2)*CD[-c]@MetricPerturbation[a,b]*CD[c]@MetricPerturbation[-a,-b]
	+CD[-b]@MetricPerturbation[a,b]*CD[c]@MetricPerturbation[-a,-c]
)+Coupling2*MetricPerturbation[-a,-b]*MetricPerturbation[a,b]-Coupling3*MetricPerturbation[a,-a]*MetricPerturbation[b,-b];
DisplayExpression[LinearisedLagrangian,EqnLabel->"SickMassiveGravity"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"SickMassiveGravity",	
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
Comment@"The consequence is seen in the positive-parity scalar sector, which develops a massive pole. This is the Boulware-Deser ghost, which always spoils the unitarity of the theory.";
