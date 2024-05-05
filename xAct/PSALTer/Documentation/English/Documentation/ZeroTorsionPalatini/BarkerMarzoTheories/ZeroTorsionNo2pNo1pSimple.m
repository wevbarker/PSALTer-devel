(*=============================*)
(*  ZeroTorsionNo2pNo1pSimple  *)
(*=============================*)

Subsection@"Removing both the spin-two and spin-one particles and the dipole";

Comment@"We will study the theory with the positive-parity spin-two and spin-one particles removed, and the dipole removed the simple way.";

RelevantModel=NonlinearLagrangian/.{xAct`PSALTer`ZeroTorsionPalatini`ZeroTorsionPalatiniA4->0,xAct`PSALTer`ZeroTorsionPalatini`ZeroTorsionPalatiniA5->0,xAct`PSALTer`ZeroTorsionPalatini`ZeroTorsionPalatiniA6->0,xAct`PSALTer`ZeroTorsionPalatini`ZeroTorsionPalatiniA7->0,xAct`PSALTer`ZeroTorsionPalatini`ZeroTorsionPalatiniA8->0,xAct`PSALTer`ZeroTorsionPalatini`H1->0,xAct`PSALTer`ZeroTorsionPalatini`H2->0,xAct`PSALTer`ZeroTorsionPalatini`H3->0,xAct`PSALTer`ZeroTorsionPalatini`H4->0,xAct`PSALTer`ZeroTorsionPalatini`H5->0,xAct`PSALTer`ZeroTorsionPalatini`H6->0,xAct`PSALTer`ZeroTorsionPalatini`H16->0,xAct`PSALTer`ZeroTorsionPalatini`H10->0,xAct`PSALTer`ZeroTorsionPalatini`H9->0,xAct`PSALTer`ZeroTorsionPalatini`H11->0,xAct`PSALTer`ZeroTorsionPalatini`H12->0};

DisplayExpression[RelevantModel,EqnLabel->"ZeroTorsionNo2pNo1pSimple"];

RelevantModel*=Measure;
RelevantModel//=ZeroTorsionPalatiniLineariseLagrangian;
ParticleSpectrum[RelevantModel,
		ClassName->"ZeroTorsionPalatini",
		TheoryName->"ZeroTorsionNo2pNo1pSimpleFirstOrder",	
		Method->"Hard",
		MaxLaurentDepth->3];
Comment@{"Some comments can be made..."};

RelevantModel//=ZeroTorsionPalatiniLineariseLagrangian[#,Formulation->SecondOrder]&;
ParticleSpectrum[RelevantModel,
		ClassName->"ZeroTorsionPalatini",
		TheoryName->"ZeroTorsionNo2pNo1pSimpleSecondOrder",	
		Method->"Hard",
		MaxLaurentDepth->3];
