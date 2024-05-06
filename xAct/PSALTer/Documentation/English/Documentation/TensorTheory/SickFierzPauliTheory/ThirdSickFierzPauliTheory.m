(*=============================*)
(*  ThirdSickFierzPauliTheory  *)
(*=============================*)

Subsection@"Sick Fierz-Pauli (third variation)";
Comment@{"We allow the second term in",Cref@"FierzPauliTheory"," to float."};
LinearisedLagrangian=Coupling1*(
	(1/2)*CD[-b]@LinearMetric[a,-a]*CD[b]@LinearMetric[c,-c]
	-(1/2)*CD[-c]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-b]
	+CD[-b]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-c]
)-Coupling2*CD[a]@LinearMetric[-a,-b]*CD[b]@LinearMetric[c,-c];
DisplayExpression[LinearisedLagrangian,EqnLabel->"ThirdSickFierzPauliTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"ThirdSickFierzPauliTheory",
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
Comment@{"Contrary to",Cref@{"FirstSickFierzPauliTheory","SecondSickFierzPauliTheory"},", there is now a viable theory with an extra massless scalar. However the diffeomorphism gauge symmetry has been lost, and the stress-energy tensor is not conserved."};
