(*===================*)
(*  KarananasTheory  *)
(*===================*)

Section@"Gaorgios's quadratic Weyl theory";
Comment@{"We will study the square of the Ricci in Weyl gauge theory."};

NonlinearLagrangianLinWeyl=xAct`PSALTer`WeylGaugeTheory`lR1*WeylBaseR[a,b,-a,-b]*WeylBaseR[c,d,-c,-d];
NonlinearLagrangianLinWeyl=NonlinearLagrangianLinWeyl/.xAct`PSALTer`LagrangianLinWeylCouplings`Private`WeylQuantitiesExpand;
NonlinearLagrangianLinWeyl//=xAct`PSALTer`Private`ToNewCanonical;

DisplayExpression@CollectTensors@ToCanonical[NonlinearLagrangianLinWeyl];
LinearisedLagrangianLinWeyl=LineariseLagrangianLinWeyl[NonlinearLagrangianLinWeyl];

Comment@{"Here is the linearised Lagrangian before feeding into ParticleSpectrum[]."};
DisplayExpression@CollectTensors@ToCanonical[LinearisedLagrangianLinWeyl];

(*Diagnostic line*)
Print@"Hi there, I'm sitting between Zhiyuan's code and Will's code! Method -> easy mode.";

ParticleSpectrum[
	LinearisedLagrangianLinWeyl,
	ClassName->"WeylGaugeTheory",
	TheoryName->"KarananasTheory",	
	Method->"Easy",
	MaxLaurentDepth->3
];

Supercomment@"This marks the completion of the particle spectrum analysis for the square of the Ricci."
