(*============================*)
(*  MinimalMasslessOddScalar  *)
(*============================*)

Section@"Minimal massless odd-parity scalar model";

Comment@{"We will study the minimal model set out between Eqs. (4.47) and (4.48) of arXiv:9902032. We will do this using the general coupling coefficients defined in",Cref@"CleanHayashiShirafuji","."};

NonlinearLagrangian=HSNonlinearLagrangian/.{Alp0->4*Bet1,Alp1->0,Alp2->0,Alp4->0,Alp5->0,Alp6->0,Bet2->-2*Bet1,Bet3->-Bet1/2};
DisplayExpression@CollectTensors@ToCanonical[NonlinearLagrangian];
LinearisedLagrangian=LineariseLagrangian[NonlinearLagrangian];

ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"PoincareGaugeTheory",
	TheoryName->"MinimalMasslessOddScalar",	
	Method->"Hard",
	MaxLaurentDepth->3
];

Supercomment@"Thus we see that only the odd-parity scalar mode is moving without a mass, as claimed.";
