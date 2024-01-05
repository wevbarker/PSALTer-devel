(* ::Package:: *)

(*==================*)
(*  WGTEGeneralCase *)
(*==================*)

(*=====================*)
(*  Most general WGT  *)
(*=====================*)
Section@"Most general eWGT";
Comment@{"We will study the most general eWGT as defined in eqn 13 of Lin's draft paper."};

DisplayExpression@CollectTensors@ToCanonical[NonlinearLagrangianWGTE];
LinearisedLagrangianWGTE=LineariseLagrangianWGTE[NonlinearLagrangianWGTE];

Comment@{"Here is the linearised Lagrangian before feeding into ParticleSpectrum[]."};
DisplayExpression@CollectTensors@ToCanonical[LinearisedLagrangianWGTE];

(*Diagnostic line*)
Print@"Hi there, I'm sitting between Zhiyuan's code and Will's code! Method -> easy mode.";

ParticleSpectrum[
	LinearisedLagrangianWGTE,
	ClassName->"WeylGaugeTheory",
	TheoryName->"GeneralWGTE",	
	Method->"Hard",
	MaxLaurentDepth->1
];

Supercomment@"This marks the completion of the particle spectrum analysis for the general WGT."
