(*=========================*)
(*  MarzoZellBarkerModel1  *)
(*=========================*)

Subsection@"Model 1";
Comment@{"We will study Model 1."};
NonlinearLagrangian=HSNonlinearLagrangian/.{Alp1->0,Alp2->0,Alp3->0,Alp4->0,Alp6->0,Bet1->0,Bet2->0,Bet3->0};
DisplayExpression@CollectTensors@ToCanonical[NonlinearLagrangian];
LinearLagrangian=LineariseLagrangian[NonlinearLagrangian];
Code[LinearLagrangian,
	ParticleSpectrum[
		LinearLagrangian,
		TheoryName->"MarzoZellBarkerModel1",	
		Method->"Hard",
		MaxLaurentDepth->3
	];
];
Comment@"Some comments can be made about Model 1.";
