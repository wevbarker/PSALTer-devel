(*========================*)
(*  EinsteinCartanTheory  *)
(*========================*)

Subsection@"Einstein-Cartan theory (ECT)";
Comment@"We would like to check the basic Einstein-Cartan theory.";
DisplayExpression[CollectTensors@ToCanonical[HSNonlinearLagrangian/.{Alp1->0,Alp2->0,Alp3->0,Alp4->0,Alp5->0,Alp6->0,Bet1->0,Bet2->0,Bet3->0}],
			EqnLabel->"EinsteinCartanTheory"];
LinearLagrangian=LineariseLagrangian[HSNonlinearLagrangian/.{Alp1->0,Alp2->0,Alp3->0,Alp4->0,Alp5->0,Alp6->0,Bet1->0,Bet2->0,Bet3->0}];
Code[LinearLagrangian,
	ParticleSpectrum[
		LinearLagrangian,
		TheoryName->"EinsteinCartanTheory",	
		Method->"Hard",
		MaxLaurentDepth->3
	];
];
Comment@{"What we find are no propagating massive modes, but instead two degrees of freedom in the massive sector. The no-ghost conditions on these massless d.o.f restrict the sign in front of the Einstein-Hilbert term to be negative (which is what we expect for our conventions). Note that this results is essentially the same as",Cref@"FierzPauliTheory","."};
