(* ::Package:: *)

(*===================*)
(*  CalibrationWGTE  *)
(*===================*)

$ThisDirectory=If[NotebookDirectory[]==$Failed,Directory[],NotebookDirectory[],NotebookDirectory[]];
<<xAct`xPlain`;

Title@"Equivalence of the original, natural and scale-invariant formulations of eWGT";
Supercomment@"In this script, we illustrate how the original, natural and scale-invariant formulations are equivalent by producing the same particle spectra for test cases, up to a difference in residue.";

Comment@"We first load the package PSALTer.";
<<xAct`PSALTer`;
(*
(*For HPC*)
$NodeCPU=110;
Comment@{"The variable \$NodeCPU is set to ",ToString@$NodeCPU};
Comment@{"The variable \$ProcessorCount is set to ",ToString@$ProcessorCount};
Unprotect@$ProcessorCount;
$ProcessorCount=$NodeCPU;
Comment@{"The variable \$ProcessorCount is set to ",ToString@$ProcessorCount};
Comment@{"The variable \$KernelCount is set to ",ToString@$KernelCount};
Comment@{"Now we execute LaunchKernels[]"};
LaunchKernels@$NodeCPU;
Comment@{"The variable \$KernelCount is set to ",ToString@$KernelCount};
*)
(*Global settings for xAct*)
$DefInfoQ=False;
Unprotect@AutomaticRules;
Options[AutomaticRules]={Verbose->False};
Protect@AutomaticRules;

(*Global settings for PSALTer*)
$DiagnosticMode=False;
$MonitorParallel=False;
(*$ExportPDF=False;*)
$ReadOnly=False;

(*Here we load the files required to generate the Lagrangian*)
Get@FileNameJoin@{$ThisDirectory,"DefineFieldsWGTE.m"};
Get@FileNameJoin@{$ThisDirectory,"LagrangianWGTECouplings.m"};
Get@FileNameJoin@{$ThisDirectory,"LineariseWGTE.m"};
Get@FileNameJoin@{$ThisDirectory,"LagrangianWGTEScaleInvariantRescaling.m"};
Get@FileNameJoin@{$ThisDirectory,"GaugeSelectorWGTE.m"};
Get@FileNameJoin@{$ThisDirectory,"WGTEGeneralCase.m"};

Supercomment@"In conclusion, we have used our test cases to demonstrate how the original, natural and scale-invariant formulations are equivalent and produce the same spectra, up to a difference in residue.";
Quit[];
