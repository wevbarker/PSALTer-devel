(*==================*)
(*  MassiveGravity  *)
(*==================*)

Subsection@"Massive gravity";
Comment@{"We now add to",Cref@"FierzPauliTheory"," the unique mass term which corresponds to massive gravity (i.e. Fierz-Pauli tuning)."};
LinearisedLagrangian=Coupling1*(
	(1/2)*CD[-b]@MetricPerturbation[a,-a]*CD[b]@MetricPerturbation[c,-c]
	-CD[a]@MetricPerturbation[-a,-b]*CD[b]@MetricPerturbation[c,-c]
	-(1/2)*CD[-c]@MetricPerturbation[a,b]*CD[c]@MetricPerturbation[-a,-b]
	+CD[-b]@MetricPerturbation[a,b]*CD[c]@MetricPerturbation[-a,-c]
)+Coupling2*(MetricPerturbation[-a,-b]*MetricPerturbation[a,b]-MetricPerturbation[a,-a]*MetricPerturbation[b,-b]);
DisplayExpression[LinearisedLagrangian,EqnLabel->"MassiveGravity"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"MassiveGravity",	
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
Comment@"There is no massless sector. The propagator develops a massive pole in the positive-parity tensor sector. The no-ghost condition is as before, but now a no-tachyon condition protects the graviton mass.";
