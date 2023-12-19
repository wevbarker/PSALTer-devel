(* ::Package:: *)

(*==================*)
(*  WeylGeneralCase *)
(*==================*)

(*=====================*)
(*  Most general WGT  *)
(*=====================*)
Section@"Most general WGT";
Comment@{"We will study the most general WGT as defined in eqn 10 of Lin et. al. 2021, PHYS. REV. D 104, 024034."};

DisplayExpression@CollectTensors@ToCanonical[NonlinearLagrangianLinWeyl];
LinearisedLagrangianLinWeyl=LineariseLagrangianLinWeyl[NonlinearLagrangianLinWeyl];

Comment@{"Here is the linearised Lagrangian before feeding into ParticleSpectrum[]."};
DisplayExpression@CollectTensors@ToCanonical[LinearisedLagrangianLinWeyl];

(*Diagnostic line*)
Print@"Hi there, I'm sitting between Zhiyuan's code and Will's code! Method -> easy mode.";

ParticleSpectrum[
	LinearisedLagrangianLinWeyl,
	ClassName->"WeylGaugeTheory",
	TheoryName->"GeneralWGT",	
	Method->"Easy",
	MaxLaurentDepth->3
];

Supercomment@"This marks the completion of the particle spectrum analysis for the general WGT."
