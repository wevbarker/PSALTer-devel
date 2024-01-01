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

<<xAct`PSALTer`;

(*For when we want to only run the commentary part of the script*)
(*
Unprotect@xAct`PSALTer`ParticleSpectrum;
ClearAll@xAct`PSALTer`ParticleSpectrum;
Protect@xAct`PSALTer`ParticleSpectrum;
*)

(*For HPC*)

$NodeCPU=110;
Comment@{"The variable $NodeCPU is set to",Inline@$NodeCPU};
Comment@{"The variable $ProcessorCount is set to",Inline@$ProcessorCount};
Unprotect@$ProcessorCount;
$ProcessorCount=$NodeCPU;
Comment@{"The variable $ProcessorCount is set to",Inline@$ProcessorCount};
Comment@{"The variable $KernelCount is set to",Inline@$KernelCount};
Comment@{"Now we execute LaunchKernels[]";
LaunchKernels@$NodeCPU;
Comment@{"The variable $KernelCount is set to",Inline@$KernelCount};


(*Global settings for xAct*)
$DefInfoQ=False;
Unprotect@AutomaticRules;
Options[AutomaticRules]={Verbose->False};
Protect@AutomaticRules;

(*Global settings for PSALTer*)
$DiagnosticMode=False;
$MonitorParallel=False;
$ExportPDF=True;

Comment@"Great, so PSALTer is now loaded and we can start to do some science.";

(*Get@FileNameJoin@{$ThisDirectory,"Calibration","ScalarTheory.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Calibration","VectorTheory.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Calibration","TensorTheory.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Calibration","SymmetricTensorTheory.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Calibration","AsymmetricTensorTheory.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Calibration","BimetricTensorTheory.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Calibration","ScalarTensorTheory.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Calibration","PoincareGaugeTheory.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Calibration","WeylGaugeTheory.m"};*)
Get@FileNameJoin@{$ThisDirectory,"Calibration","MetricAffineGravity.m"};
(*Get@FileNameJoin@{$ThisDirectory,"Calibration","ZeroTorsionPalatini.m"};*)
(*Get@FileNameJoin@{$ThisDirectory,"Calibration","ErrorMessages.m"};*)

Supercomment@"We have now reached the end of the PSALTer calibration script.";

Quit[];
