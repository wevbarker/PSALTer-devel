(*================*)
(*  ScalarTheory  *)
(*================*)

Title@"Scalar field theory";

Comment@"Let's define a scalar field.";
Code[
	DefField[Phi[],PrintAs->"\[Phi]",PrintSourceAs->"\[ScriptJ]"];
];
Comment@"Also define a pair of coupling constants.";
Code[
	DefConstantSymbol[Coupling1,PrintAs->"\[Alpha]"];
	DefConstantSymbol[Coupling2,PrintAs->"\[Beta]"];
];

Get@FileNameJoin@{$ThisDirectory,"Documentation","ScalarTheory","MasslessScalarTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","ScalarTheory","MassiveScalarTheory.m"};
