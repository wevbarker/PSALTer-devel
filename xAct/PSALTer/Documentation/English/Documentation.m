(*=================*)
(*  Documentation  *)
(*=================*)

$ThisDirectory=If[NotebookDirectory[]==$Failed,Directory[],NotebookDirectory[],NotebookDirectory[]];
SetOptions[$FrontEndSession, PrintingStyleEnvironment -> "Working"];

Get@FileNameJoin@{$ThisDirectory,"Documentation","xPlain.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","HPC.m"};

Title@"PSALTer Documentation";

Chapter@"Getting started";
Get@FileNameJoin@{$ThisDirectory,"Documentation","HowToUse.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","LoadingPSALTer.m"};

Chapter@"Science applications";
xAct`PSALTer`Private`$Disabled=True;
(*xAct`PSALTer`Private`$DiagnosticMode=True;*)
$ReadOnly=False;
Get@FileNameJoin@{$ThisDirectory,"Documentation","ScalarTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","VectorTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","AntisymmetricTensorTheory.m"};
xAct`PSALTer`Private`$Disabled=False;
Get@FileNameJoin@{$ThisDirectory,"Documentation","TensorTheory.m"};
xAct`PSALTer`Private`$Disabled=True;
Get@FileNameJoin@{$ThisDirectory,"Documentation","ScalarTensorTheory.m"};
xAct`PSALTer`Private`$Disabled=False;
Get@FileNameJoin@{$ThisDirectory,"Documentation","PoincareGaugeTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","MetricAffineGravity.m"};
$ReadOnly=False;
(*xAct`PSALTer`Private`$Disabled=False;*)

Chapter@"Error messages";
$ReadOnly=False;
Get@FileNameJoin@{$ThisDirectory,"Documentation","ErrorMessages.m"};

Supercomment@"We have now reached the end of the documentation.";
Quit[];
