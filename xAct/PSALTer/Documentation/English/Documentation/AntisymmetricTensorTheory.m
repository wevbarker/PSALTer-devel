(*=============================*)
(*  AntisymmetricTensorTheory  *)
(*=============================*)

Title@"Antisymmetric tensor field theory";

Comment@"Let's define an antisymmetric tensor field.";
Code[
	DefField[AntisymmTensor[-a,-b],Antisymmetric[{-a,-b}],PrintAs->"\[ScriptCapitalB]",PrintSourceAs->"\[ScriptCapitalJ]"];
];
Comment@"Also define some more coupling constants.";
Code[
	DefConstantSymbol[TwoFormMass,PrintAs->"\[ScriptCapitalM]"];
	DefConstantSymbol[KineticCoupling,PrintAs->"\[Alpha]"];
];

Get@FileNameJoin@{$ThisDirectory,"Documentation","AntisymmetricTensorTheory",
				"TwoFormTheory.m"};
