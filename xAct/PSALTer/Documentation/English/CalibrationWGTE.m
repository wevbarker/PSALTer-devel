(* ::Package:: *)

(*===================*)
(*  CalibrationWGTE  *)
(*===================*)

$ThisDirectory=If[NotebookDirectory[]==$Failed,Directory[],NotebookDirectory[],NotebookDirectory[]];

<<xAct`xPlain`;

Title@"PSALTer Calibration for the WGTE cases based on Lin's draft";

Subsection@"About xPlain and formatting";

Comment@"Welcome to the calibration file for the PSALTer package. Commentary is provided in this green text throughout by virtue of the xPlain package.";

Expression@"xPlain also allows you to format numbered equations.";

Supercomment@"Occasionally, more important points will be highlighted in boxes like this.";

Comment@"The xPlain package is not part of PSALTer, so the output from PSALTer itself will contrast with this formatting and be quite distinctive.";

Subsection@"The structure of this file";

Comment@"The calibration file runs PSALTer on a very long list of theories, whose particle spectra are already known.";

Comment@"The first step is to load the PSALTer package.";

<<xAct`PSALTer`;

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


(*Global settings for xAct*)
$DefInfoQ=False;
Unprotect@AutomaticRules;
Options[AutomaticRules]={Verbose->False};
Protect@AutomaticRules;

(*Global settings for PSALTer*)
$DiagnosticMode=False;
$MonitorParallel=False;

Comment@"Great, so PSALTer is now loaded and we can start to do some science.";

(*Get@FileNameJoin@{$ThisDirectory,"CalibrationTools","ScalarTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"CalibrationTools","VectorTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"CalibrationTools","TensorTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"CalibrationTools","PoincareGaugeTheory.m"};*)
Get@FileNameJoin@{$ThisDirectory,"Calibration","WeylGaugeTheoryExtended.m"};
(*Get@FileNameJoin@{$ThisDirectory,"CalibrationTools","MetricAffineGaugeTheory.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Calibration","ErrorMessages.m"};*)

Supercomment@"We have now reached the end of the PSALTer calibration script.";

Quit[];
