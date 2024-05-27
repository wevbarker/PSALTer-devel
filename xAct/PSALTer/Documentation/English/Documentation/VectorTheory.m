(*================*)
(*  VectorTheory  *)
(*================*)

Section@"A single vector";
Comment@"Let's define a vector field:";
Code[
	DefField[VectorField[-a],PrintAs->"\[ScriptCapitalB]",PrintSourceAs->"\[ScriptCapitalJ]"];
];
Get@FileNameJoin@{$ThisDirectory,"Documentation","VectorTheory","MaxwellTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","VectorTheory","ProcaTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","VectorTheory","SickMaxwellTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","VectorTheory","SickProcaTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","VectorTheory","LongitudinalMassless.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","VectorTheory","LongitudinalMassive.m"};
