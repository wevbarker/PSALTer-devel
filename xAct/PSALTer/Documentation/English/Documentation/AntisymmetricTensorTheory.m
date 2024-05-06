(*=============================*)
(*  AntisymmetricTensorTheory  *)
(*=============================*)

Section@"A single antisymmetric rank-two tensor";
Comment@"Let's define an antisymmetric tensor field:";
Code[
	DefField[AntisymmTensor[-a,-b],Antisymmetric[{-a,-b}],PrintAs->"\[ScriptCapitalB]",PrintSourceAs->"\[ScriptCapitalJ]"];
];
Comment@"Also define some more coupling constants:";
Code[
	DefConstantSymbol[TwoFormMass,PrintAs->"\!\(\*SuperscriptBox[\(\[ScriptCapitalM]\), \(2\)]\)"];
	DefConstantSymbol[KineticCoupling,PrintAs->"\[Alpha]"];
];
Get@FileNameJoin@{$ThisDirectory,"Documentation","AntisymmetricTensorTheory",
				"TwoFormTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","AntisymmetricTensorTheory",
				"MassiveTwoFormTheory.m"};
