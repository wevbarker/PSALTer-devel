(*=========================*)
(*  MarzoZellBarkerModel4  *)
(*=========================*)

Subsection@"Model 4";

Comment@"We will study Model 4.";
Model4=NonlinearLagrangian/.{H1->0,H2->0,H3->0,H4->0,H7->-H8,H9->0,H10->0,H11->0,H12->0,H16->0,xAct`PSALTer`ZeroTorsionPalatini`ZeroTorsionPalatiniA4->0,xAct`PSALTer`ZeroTorsionPalatini`ZeroTorsionPalatiniA5->0,xAct`PSALTer`ZeroTorsionPalatini`ZeroTorsionPalatiniA6->0,xAct`PSALTer`ZeroTorsionPalatini`ZeroTorsionPalatiniA7->0,xAct`PSALTer`ZeroTorsionPalatini`ZeroTorsionPalatiniA8->0};
DisplayExpression@Model4;
LinearLagrangian=Measure*Model4//ZeroTorsionPalatiniLineariseLagrangian;
ParticleSpectrum[LinearLagrangian,
		ClassName->"ZeroTorsionPalatini",
		TheoryName->"MarzoZellBarkerModel4",	
		Method->"Hard",
		MaxLaurentDepth->3];
Comment@"Some comments can be made about Model 4.";
