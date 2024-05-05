(*================*)
(*  TensorTheory  *)
(*================*)

Title@"Tensor field theory";

Comment@"Let's define another symmetric tensor field.";
Code[
	DefField[LinearMetric[-a,-b],Symmetric[{-a,-b}],PrintAs->"\[ScriptH]",PrintSourceAs->"\[ScriptCapitalT]"];
];
Comment@"Some more coupling constants.";
Code[
	DefConstantSymbol[Coupling1,PrintAs->"\[Alpha]"];
	DefConstantSymbol[Coupling2,PrintAs->"\[Beta]"];
	DefConstantSymbol[Coupling3,PrintAs->"\[Gamma]"];
	DefConstantSymbol[Coupling4,PrintAs->"\[Delta]"];
	DefConstantSymbol[Coupling5,PrintAs->"\[Epsilon]"];
	DefConstantSymbol[Coupling6,PrintAs->"\[Zeta]"];
];

Get@FileNameJoin@{$ThisDirectory,"Documentation","TensorTheory","FierzPauliTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","TensorTheory","MassiveGravity.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","TensorTheory","SickFierzPauliTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","TensorTheory","MarzoTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","TensorTheory","SickMassiveGravity.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","TensorTheory","PartanenTulkkiTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","TensorTheory","SquareRicciTheory.m"};
