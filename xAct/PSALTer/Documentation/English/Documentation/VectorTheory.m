(*================*)
(*  VectorTheory  *)
(*================*)

Title@"Vector field theory";

Comment@"Let's define a vector field.";
Code[
	DefField[B[-a],PrintAs->"\[ScriptCapitalB]",PrintSourceAs->"\[ScriptCapitalJ]"];
];
Comment@"Also define some more coupling constants.";
Code[
	DefConstantSymbol[Coupling1,PrintAs->"\[Alpha]"];
	DefConstantSymbol[Coupling2,PrintAs->"\[Beta]"];
	DefConstantSymbol[Coupling3,PrintAs->"\[Gamma]"];
	DefConstantSymbol[Coupling4,PrintAs->"\[Delta]"];
];

Get@FileNameJoin@{$ThisDirectory,"Documentation","VectorTheory","MaxwellTheory.m"};
(*
Get@FileNameJoin@{$ThisDirectory,"Documentation","VectorTheory","ProcaTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","VectorTheory","SickMaxwellTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","VectorTheory","SickProcaTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","VectorTheory","LongitudinalMassless.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","VectorTheory","LongitudinalMassive.m"};
*)
