(*=============================*)
(*  AntisymmetricTensorTheory  *)
(*=============================*)

Section@"A single antisymmetric rank-two tensor";
Comment@"Let's define an antisymmetric tensor field:";
Code[
	DefField[TwoFormField[-a,-b],Antisymmetric[{-a,-b}],PrintAs->"\[ScriptCapitalB]",PrintSourceAs->"\[ScriptCapitalJ]"];
];
Get@FileNameJoin@{$ThisDirectory,"Documentation","AntisymmetricTensorTheory",
				"TwoFormTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","AntisymmetricTensorTheory",
				"MassiveTwoFormTheory.m"};
