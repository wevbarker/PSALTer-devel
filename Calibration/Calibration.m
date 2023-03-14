(*=======*)
(*  Run  *)
(*=======*)

(*============*)
(*  Preamble  *)
(*============*)

Print@"First we import some formatting...";

Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","VimFormat.m"};

Comment@"...okay, that's better, from now on any commentary written inside this Calibration.m wrapper will present as blue text (i.e. this text is not part of PSALTer, it is just a use-case). Next we load the PSALTer package:";

Comment@"Do we want diagnostic mode?";

xAct`PSALTer`$DiagnosticMode=False;

<<xAct`PSALTer`;

Comment@"Do we want diagnostic mode?";

$DiagnosticMode=False;

Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","Scalar.m"};
Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","Proca.m"};
(*Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","PGT.m"};*)

Quiet@Throw@"Hold my beer!";

