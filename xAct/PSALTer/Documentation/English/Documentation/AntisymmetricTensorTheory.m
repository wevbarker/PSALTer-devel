(*=============================*)
(*  AntisymmetricTensorTheory  *)
(*=============================*)

Section@"A single antisymmetric rank-two tensor";
Comment@"Let's define an antisymmetric tensor field:";
Code[
	DefField[AntisymmTensor[-a,-b],Antisymmetric[{-a,-b}],PrintAs->"\[ScriptCapitalB]",PrintSourceAs->"\[ScriptCapitalJ]"];
	DefField[Phi[],PrintAs->"\[Phi]",PrintSourceAs->"\[Rho]"];
];
Comment@"Also define some more coupling constants:";
Code[
	DefConstantSymbol[Coupling1,PrintAs->"\[Alpha]"];
	DefConstantSymbol[Coupling2,PrintAs->"\[Beta]"];
	DefConstantSymbol[Coupling3,PrintAs->"\[Gamma]"];
	DefConstantSymbol[Coupling4,PrintAs->"\[Delta]"];
	DefConstantSymbol[Coupling5,PrintAs->"\[Epsilon]"];
	DefConstantSymbol[Coupling6,PrintAs->"\[Zeta]"];
];
(*
Get@FileNameJoin@{$ThisDirectory,"Documentation","AntisymmetricTensorTheory",
				"TwoFormTheory.m"};
*)
Get@FileNameJoin@{$ThisDirectory,"Documentation","AntisymmetricTensorTheory",
				"MassiveTwoFormTheory.m"};
