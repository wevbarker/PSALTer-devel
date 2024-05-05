(*======================*)
(*  ZeroTorsionGeneral  *)
(*======================*)

Subsection@"General Ricci-type";

Comment@"We will study the general Ricci-type theory.";

RelevantModel=NonlinearLagrangian/.{xAct`PSALTer`ZeroTorsionPalatini`ZeroTorsionPalatiniA4->0,xAct`PSALTer`ZeroTorsionPalatini`ZeroTorsionPalatiniA5->0,xAct`PSALTer`ZeroTorsionPalatini`ZeroTorsionPalatiniA6->0,xAct`PSALTer`ZeroTorsionPalatini`ZeroTorsionPalatiniA7->0,xAct`PSALTer`ZeroTorsionPalatini`ZeroTorsionPalatiniA8->0,xAct`PSALTer`ZeroTorsionPalatini`H1->0,xAct`PSALTer`ZeroTorsionPalatini`H2->0,xAct`PSALTer`ZeroTorsionPalatini`H3->0,xAct`PSALTer`ZeroTorsionPalatini`H4->0,xAct`PSALTer`ZeroTorsionPalatini`H5->0,xAct`PSALTer`ZeroTorsionPalatini`H6->0,xAct`PSALTer`ZeroTorsionPalatini`H16->0};

DisplayExpression[RelevantModel,EqnLabel->"ZeroTorsionGeneral"];

RelevantModel*=Measure;
RelevantModel//=ZeroTorsionPalatiniLineariseLagrangian;
ParticleSpectrum[RelevantModel,
		ClassName->"ZeroTorsionPalatini",
		TheoryName->"ZeroTorsionGeneralFirstOrder",	
		Method->"Hard",
		MaxLaurentDepth->3];
Comment@{"Some comments can be made..."};

RelevantModel//=ZeroTorsionPalatiniLineariseLagrangian[#,Formulation->SecondOrder]&;
ParticleSpectrum[RelevantModel,
		ClassName->"ZeroTorsionPalatini",
		TheoryName->"ZeroTorsionGeneralSecondOrder",	
		Method->"Hard",
		MaxLaurentDepth->3];
