(*=======*)
(*  Run  *)
(*=======*)

(*============*)
(*  Preamble  *)
(*============*)

<<VimFormat`;

(*Title@"PSALTer Calibration";*)
Title@"Zhiyuan's and Stephanie's metric affine theory";

Comment@"During the calibration run, we need to write some commentary, which will appear in this green text, or as numbered equations/expressions with a green background. The output of the PSALTer package (specifically the function called ParticleSpectrum) is not in green, thus wherever we are using PSALTer the output should be quite distinctive.";

Comment@"The first step is to load the PSALTer package.";

<<xAct`PSALTer`;

$DiagnosticMode=False;

Comment@"Great, so PSALTer is now loaded and we can start to do some science.";

(*$DefaultKernels=6;*)

Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","MetricAffineGaugeTheory.m"};

Quit[];

Comment@"Do we want diagnostic mode?";

$DiagnosticMode=False;

Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","ScalarTheory.m"};
Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","TensorTheory.m"};
Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","VectorTheory.m"};
Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","PoincareGaugeTheory.m"};

Quiet@Throw@"Hold my beer!";
