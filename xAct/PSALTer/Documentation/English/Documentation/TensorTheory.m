(*================*)
(*  TensorTheory  *)
(*================*)

Section@"A single symmetric rank-two tensor field";
Comment@"Let's define a symmetric tensor field, which we want to interpret as the metric perturbation:";
Code[
	DefField[MetricPerturbation[-a,-b],Symmetric[{-a,-b}],PrintAs->"\[ScriptH]",PrintSourceAs->"\[ScriptCapitalT]"];
];
Get@FileNameJoin@{$ThisDirectory,"Documentation","TensorTheory","FierzPauliTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","TensorTheory","MassiveGravity.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","TensorTheory","SickFierzPauliTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","TensorTheory","MarzoTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","TensorTheory","SickMassiveGravity.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","TensorTheory","SquareRicciTheory.m"};
