(*=================*)
(*  Documentation  *)
(*=================*)

(*=======*)
(*  HPC  *)
(*=======*)

(*
$NodeCPU=110;
Comment@{"The variable $NodeCPU is set to ",ToString@$NodeCPU};
Comment@{"The variable $ProcessorCount is set to ",ToString@$ProcessorCount};
Unprotect@$ProcessorCount;
$ProcessorCount=$NodeCPU;
Comment@{"The variable $ProcessorCount is set to ",ToString@$ProcessorCount};
Comment@{"The variable $KernelCount is set to ",ToString@$KernelCount};
Comment@{"Now we execute LaunchKernels[]"};
LaunchKernels@$NodeCPU;
Comment@{"The variable $KernelCount is set to ",ToString@$KernelCount};
*)

$ThisDirectory=If[NotebookDirectory[]==$Failed,Directory[],NotebookDirectory[],NotebookDirectory[]];
<<xAct`xPlain`;
Title@"PSALTer Documentation";

Get@FileNameJoin@{$ThisDirectory,"Documentation","HowToUse.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","LoadingPSALTer.m"};

(*Get@FileNameJoin@{$ThisDirectory,"Documentation","ScalarTheory.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Documentation","VectorTheory.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Documentation","BiScalarVectorTensorTheory.m"};*)
Get@FileNameJoin@{$ThisDirectory,"Documentation","TensorTheory.m"};
(*Get@FileNameJoin@{$ThisDirectory,"Documentation","AntisymmetricTensorTheory.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Documentation","SymmetricTensorTheory.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Documentation","AsymmetricTensorTheory.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Documentation","BimetricTensorTheory.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Documentation","ScalarTensorTheory.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Documentation","PoincareGaugeTheory.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Documentation","WeylGaugeTheory.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Documentation","MetricAffineGravity.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Documentation","ZeroTorsionPalatini.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Documentation","ErrorMessages.m"};*)

Supercomment@"We have now reached the end of the documentation.";
Quit[];
