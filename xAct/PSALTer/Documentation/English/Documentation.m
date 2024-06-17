(*=================*)
(*  Documentation  *)
(*=================*)

$ThisDirectory=If[NotebookDirectory[]==$Failed,Directory[],NotebookDirectory[],NotebookDirectory[]];
SetOptions[$FrontEndSession, PrintingStyleEnvironment -> "Working"];

Get@FileNameJoin@{$ThisDirectory,"Documentation","xPlain.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","HPC.m"};

Title@"PSALTer v 1.0.0 Documentation";
Comment@"W. Barker, C. Marzo and C. Rigouzzo";
Comment@"Please reach out to Will Barker at wb263@cam.ac.uk with all queries.";

Chapter@"Introduction";
Get@FileNameJoin@{$ThisDirectory,"Documentation","HowToUse.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","LoadingPSALTer.m"};

Chapter@"Examples with code";
xAct`PSALTer`Private`$Disabled=False;
xAct`PSALTer`Private`$DiagnosticMode=False;
$ReadOnly=False;
xAct`PSALTer`Private`$NoExport=False;
Get@FileNameJoin@{$ThisDirectory,"Documentation","ScalarTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","VectorTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","AntisymmetricTensorTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","TensorTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","ScalarTensorTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","PoincareGaugeTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","SymmetricRankThree.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","MetricAffineGravity.m"};
$ReadOnly=False;
xAct`PSALTer`Private`$Disabled=False;

Chapter@"Examples of bad usage";
$ReadOnly=False;
Get@FileNameJoin@{$ThisDirectory,"Documentation","ErrorMessages.m"};

Supercomment@"We have now reached the end of the documentation.";
Quit[];
