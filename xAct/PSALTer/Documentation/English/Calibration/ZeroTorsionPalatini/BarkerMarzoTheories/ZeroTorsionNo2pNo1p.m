(*=======================*)
(*  ZeroTorsionNo2pNo1p  *)
(*=======================*)

Subsection@"Removing both the spin-two and spin-one particles";

Comment@"We will study the theory with the positive-parity spin-two and spin-one particles removed.";

RelevantModel=NonlinearLagrangian/.{xAct`PSALTer`ZeroTorsionPalatini`ZeroTorsionPalatiniA4->0,xAct`PSALTer`ZeroTorsionPalatini`ZeroTorsionPalatiniA5->0,xAct`PSALTer`ZeroTorsionPalatini`ZeroTorsionPalatiniA6->0,xAct`PSALTer`ZeroTorsionPalatini`ZeroTorsionPalatiniA7->0,xAct`PSALTer`ZeroTorsionPalatini`ZeroTorsionPalatiniA8->0,xAct`PSALTer`ZeroTorsionPalatini`H1->0,xAct`PSALTer`ZeroTorsionPalatini`H2->0,xAct`PSALTer`ZeroTorsionPalatini`H3->0,xAct`PSALTer`ZeroTorsionPalatini`H4->0,xAct`PSALTer`ZeroTorsionPalatini`H5->0,xAct`PSALTer`ZeroTorsionPalatini`H6->0,xAct`PSALTer`ZeroTorsionPalatini`H16->0,xAct`PSALTer`ZeroTorsionPalatini`H10->0,xAct`PSALTer`ZeroTorsionPalatini`H9->0};

DisplayExpression[RelevantModel,EqnLabel->"ZeroTorsionNo2pNo1p"];

RelevantModel*=Measure;
RelevantModel//=ZeroTorsionPalatiniLineariseLagrangian;
ParticleSpectrum[RelevantModel,
		ClassName->"ZeroTorsionPalatini",
		TheoryName->"ZeroTorsionNo2pNo1pFirstOrder",	
		Method->"Hard",
		MaxLaurentDepth->3];
Comment@{"Some comments can be made..."};

RelevantModel//=ZeroTorsionPalatiniLineariseLagrangian[#,Formulation->SecondOrder]&;
ParticleSpectrum[RelevantModel,
		ClassName->"ZeroTorsionPalatini",
		TheoryName->"ZeroTorsionNo2pNo1pSecondOrder",	
		Method->"Hard",
		MaxLaurentDepth->3];
