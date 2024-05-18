(*==================*)
(*  MassiveGravity  *)
(*==================*)

Subsection@"Massive gravity";
Comment@{"We now add to",Cref@"FierzPauliTheory"," the unique mass term which corresponds to massive gravity (i.e. Fierz-Pauli tuning)."};
LinearisedLagrangian=Coupling1*(
	(1/2)*CD[-b]@LinearMetric[a,-a]*CD[b]@LinearMetric[c,-c]
	-CD[a]@LinearMetric[-a,-b]*CD[b]@LinearMetric[c,-c]
	-(1/2)*CD[-c]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-b]
	+CD[-b]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-c]
)+Coupling2*(LinearMetric[-a,-b]*LinearMetric[a,b]-LinearMetric[a,-a]*LinearMetric[b,-b]);
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
