(*=======*)
(*  Run  *)
(*=======*)

(*============*)
(*  Preamble  *)
(*============*)

Print@"First we import some formatting...";

Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","VimFormat.m"};

Comment@"...okay, that's better, from now on any commentary written inside this Calibration.m wrapper will present as blue text (i.e. this text is not part of PSALTer, it is just a use-case). Next we load the PSALTer package:";

<<xAct`PSALTer`;

Comment@"Do we want diagnostic mode?";

$DiagnosticMode=False;

Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","ScalarTheory.m"};
Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","VectorTheory.m"};
Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","TensorTheory.m"};
Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","PoincareGaugeTheory.m"};

Quiet@Throw@"Hold my beer!";
