(*=========================*)
(*  MarzoZellBarkerModel4  *)
(*=========================*)

Subsection@"Model 4";

Comment@"We will study Model 4.";
Model4=NonlinearLagrangian/.{H1->0,H2->0,H3->0,H4->0,H7->-H8,H9->0,H10->0,H11->0,H12->0,H16->0,xAct`PSALTer`ZeroTorsionPalatini`A4->0,xAct`PSALTer`ZeroTorsionPalatini`A5->0,xAct`PSALTer`ZeroTorsionPalatini`A6->0,xAct`PSALTer`ZeroTorsionPalatini`A7->0,xAct`PSALTer`ZeroTorsionPalatini`A8->0};
DisplayExpression@Model4;
LinearLagrangian=Measure*Model4//LineariseLagrangian;
ParticleSpectrum[LinearLagrangian,
		ClassName->"ZeroTorsionPalatini",
		TheoryName->"MarzoZellBarkerModel4",	
		Method->"Hard",
		MaxLaurentDepth->3];
Comment@"Some comments can be made about Model 4.";
