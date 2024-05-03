(*===============*)
(*  Calibration  *)
(*===============*)

$ThisDirectory=If[NotebookDirectory[]==$Failed,Directory[],NotebookDirectory[],NotebookDirectory[]];

<<xAct`xPlain`;

Title@"PSALTer Calibration";

Subsection@"About xPlain and formatting";

Comment@"Welcome to the calibration file for the PSALTer package. Commentary is provided in this green text throughout by virtue of the xPlain package.";

Expression@"xPlain also allows you to format numbered equations.";

Supercomment@"Occasionally, more important points will be highlighted in boxes like this.";

Comment@"The xPlain package is not part of PSALTer, so the output from PSALTer itself will contrast with this formatting and be quite distinctive.";

Subsection@"The structure of this file";

Comment@"The calibration file runs PSALTer on a very long list of theories, whose particle spectra are already known.";

Comment@"The first step is to load the PSALTer package.";

Code[<<xAct`PSALTer`;];

(*===================*)
(*  Commentary only  *)
(*===================*)

(*
Unprotect@xAct`PSALTer`ParticleSpectrum;
ClearAll@xAct`PSALTer`ParticleSpectrum;
Protect@xAct`PSALTer`ParticleSpectrum;
*)

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

(*============================*)
(*  Global settings for xAct  *)
(*============================*)

Comment@"We will impose some settings which make xAct easier to use (you may have seen these in other example notebooks for xAct).";

Code[
	SetOptions[$FrontEndSession,EvaluationCompletionAction->"ScrollToOutput"];
	$DefInfoQ=False;
	Unprotect@AutomaticRules;
	Options[AutomaticRules]={Verbose->False};
	Protect@AutomaticRules;
];

(*===============================*)
(*  Global settings for PSALTer  *)
(*===============================*)

Comment@"We will also impose some global settings for PSALTer.";
Comment@"We can use this setting to run diagnostics. It will give a running commentary of the calculation.";
Code[$DiagnosticMode=False;];
Comment@"We can use this setting to get more information about ongoing parallel computations.";
Code[$MonitorParallel=False;];
Comment@"We can use this setting to export the spectral analyses to a PDF file.";
Code[$ExportPDF=True;];
Comment@"We can use this setting to read in binary results and print them, without actually computing them. This is useful for when you ran the job on the cluster before hand.";
Code[$ReadOnly=False;];

Comment@"Great, so PSALTer is now loaded and we can start to do some science.";

(*Get@FileNameJoin@{$ThisDirectory,"Calibration","ScalarTheory.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Calibration","VectorTheory.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Calibration","BiScalarVectorTensorTheory.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Calibration","TensorTheory.m"};*)
Get@FileNameJoin@{$ThisDirectory,"Calibration","AntisymmetricTensorTheory.m"};
(*Get@FileNameJoin@{$ThisDirectory,"Calibration","SymmetricTensorTheory.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Calibration","AsymmetricTensorTheory.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Calibration","BimetricTensorTheory.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Calibration","ScalarTensorTheory.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Calibration","PoincareGaugeTheory.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Calibration","WeylGaugeTheory.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Calibration","MetricAffineGravity.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Calibration","ZeroTorsionPalatini.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Calibration","ErrorMessages.m"};*)

Supercomment@"We have now reached the end of the PSALTer calibration script.";

Quit[];
