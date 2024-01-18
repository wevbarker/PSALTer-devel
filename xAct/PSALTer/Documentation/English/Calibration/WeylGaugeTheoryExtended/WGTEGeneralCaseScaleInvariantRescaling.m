(* ::Package:: *)

(*==========================================*)
(*  WGTEGeneralCaseScaleInvariantRescaling  *)
(*==========================================*)

(*==============================*)
(*  Most general eWGT, with B  *)
(*==============================*)

Section@"Most general eWGT, scale-invariant variables with B";
Comment@{"We will study the most general eWGT as defined in eqn 13 of Lin's draft paper. Here we use the scale-invariant variables, keeping B."};

DisplayExpression@CollectTensors@ToCanonical[NonlinearLagrangianWGTEOriginal];
LinearisedLagrangianWGTE=LineariseLagrangianWGTEScaleInvariantRescaling[NonlinearLagrangianWGTEScaleInvariantRescaling];

Comment@{"Here is the linearised Lagrangian before feeding into ParticleSpectrum[]."};
DisplayExpression@CollectTensors@ToCanonical[LinearisedLagrangianWGTE];

(*Diagnostic line*)
Print@"Hi there, I'm sitting between Zhiyuan's code and Will's code! Method -> easy mode.";

ParticleSpectrum[
	LinearisedLagrangianWGTE,
	ClassName->"WeylGaugeTheory",
	TheoryName->"GeneralWGTEScaleInvWithB",	
	Method->"Easy",
	MaxLaurentDepth->3
];

Supercomment@"This marks the completion of the particle spectrum analysis for the general eWGT, scale-invariant variables with B."

(*=================================*)
(*  Most general eWGT, without B  *)
(*=================================*)

Section@"Most general eWGT, scale-invariant variables without B";
Comment@{"We will study the most general eWGT as defined in eqn 13 of Lin's draft paper. Here we use the scale-invariant variables, removing B. Essentially we will get a PGT Lagrangian."};

DisplayExpression@CollectTensors@ToCanonical[NonlinearLagrangianWGTEOriginal];
LinearisedLagrangianWGTE=LineariseLagrangianWGTEScaleInvariantRescaling[NonlinearLagrangianWGTEScaleInvariantRescalingPGT];

Comment@{"Here is the linearised Lagrangian before feeding into ParticleSpectrum[]."};
DisplayExpression@CollectTensors@ToCanonical[LinearisedLagrangianWGTE];

(*Diagnostic line*)
Print@"Hi there, I'm sitting between Zhiyuan's code and Will's code! Method -> easy mode.";

ParticleSpectrum[
	LinearisedLagrangianWGTE,
	ClassName->"WeylGaugeTheory",
	TheoryName->"GeneralWGTEScaleInvWithoutBEqualsToSomePGT",	
	Method->"Easy",
	MaxLaurentDepth->3
];

Supercomment@"This marks the completion of the particle spectrum analysis for the general eWGT, scale-invariant variables with B."

(*===================================================*)
(*  Most general eWGT, killing off the quartic pole  *)
(*===================================================*)

(*
Section@"Killing off the quartic pole";
Comment@{"We will kill the quartic pole."};

DisplayExpression@CollectTensors@ToCanonical[NonlinearLagrangianWGTEOriginal/.{lXi->0}];
LinearisedLagrangianWGTE=LineariseLagrangianWGTE[NonlinearLagrangianWGTE/.{lXi->0}];

Comment@{"Here is the linearised Lagrangian before feeding into ParticleSpectrum[]."};
DisplayExpression@CollectTensors@ToCanonical[LinearisedLagrangianWGTE];

(*Diagnostic line*)
Print@"Hi there, I'm sitting between Zhiyuan's code and Will's code! Method -> easy mode.";

ParticleSpectrum[
	LinearisedLagrangianWGTE,
	ClassName->"WeylGaugeTheory",
	TheoryName->"NoQuarticWGTE",	
	Method->"Hard",
	MaxLaurentDepth->3
];

Supercomment@"This marks the completion of the particle spectrum analysis for the removed quartic pole."
*)
