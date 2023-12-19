(* ::Package:: *)

(*=====================*)
(*  CalibrationLinWeyl  *)
(*=====================*)

<<xAct`xPlain`;

Title@"PSALTer Calibration for the Lin critical WGT cases";

Subsection@"About xPlain and formatting";

Comment@"Welcome to the calibration file for the PSALTer package. Commentary is provided in this green text throughout by virtue of the xPlain package.";

Expression@"xPlain also allows you to format numbered equations.";

Supercomment@"Occasionally, more important points will be highlighted in boxes like this.";

Comment@"The xPlain package is not part of PSALTer, so the output from PSALTer itself will contrast with this formatting and be quite distinctive.";

Subsection@"The structure of this file";

Comment@"The calibration file runs PSALTer on a very long list of theories, whose particle spectra are already known.";

Comment@"The first step is to load the PSALTer package.";

<<xAct`PSALTer`;

(*Global settings for xAct*)
$DefInfoQ=False;
Unprotect@AutomaticRules;
Options[AutomaticRules]={Verbose->False};
Protect@AutomaticRules;

(*Global settings for PSALTer*)
$DiagnosticMode=False;
$MonitorParallel=False;

Comment@"Great, so PSALTer is now loaded and we can start to do some science.";

(*Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","ScalarTheory.m"};
Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","VectorTheory.m"};
Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","TensorTheory.m"};
Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","PoincareGaugeTheory.m"};*)
Get@FileNameJoin@{NotebookDirectory[],"Calibration","WeylGaugeTheory.m"};
(*Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","MetricAffineGaugeTheory.m"};*)
(*Get@FileNameJoin@{NotebookDirectory[],"Calibration","ErrorMessages.m"};*)

Supercomment@"We have now reached the end of the PSALTer calibration script.";

Quit[];
