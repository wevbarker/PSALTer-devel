(*======================================*)
(*  ZeroTorsionPalatiniRicciTypeTheory  *)
(*======================================*)

Section@"Ricci-type";

Comment@"We will study the general Ricci-type theory.";

RelevantModel=Measure*NonlinearLagrangian/.{xAct`PSALTer`ZeroTorsionPalatini`A1->0,xAct`PSALTer`ZeroTorsionPalatini`A2->0,xAct`PSALTer`ZeroTorsionPalatini`A3->0,xAct`PSALTer`ZeroTorsionPalatini`A4->0,xAct`PSALTer`ZeroTorsionPalatini`A5->0,xAct`PSALTer`ZeroTorsionPalatini`A6->0,xAct`PSALTer`ZeroTorsionPalatini`A7->0,xAct`PSALTer`ZeroTorsionPalatini`A8->0,xAct`PSALTer`ZeroTorsionPalatini`A9->0,xAct`PSALTer`ZeroTorsionPalatini`A10->0,xAct`PSALTer`ZeroTorsionPalatini`A11->0,xAct`PSALTer`ZeroTorsionPalatini`H1->0,xAct`PSALTer`ZeroTorsionPalatini`H2->0,xAct`PSALTer`ZeroTorsionPalatini`H3->0,xAct`PSALTer`ZeroTorsionPalatini`H4->0,xAct`PSALTer`ZeroTorsionPalatini`H5->0,xAct`PSALTer`ZeroTorsionPalatini`H6->0,xAct`PSALTer`ZeroTorsionPalatini`H16->0};

DisplayExpression[RelevantModel,EqnLabel->"ZeroTorsionPalatiniEinsteinHilbertTheory"];
RelevantModel//=LineariseLagrangian;
ParticleSpectrum[RelevantModel,
		ClassName->"ZeroTorsionPalatini",
		TheoryName->"ZeroTorsionPalatiniRicciTypeTheory",	
		Method->"Hard",
		MaxLaurentDepth->1];
Comment@{"Some comments can be made about Ricci-type."};
Throw@"Pause here for further considerations";
