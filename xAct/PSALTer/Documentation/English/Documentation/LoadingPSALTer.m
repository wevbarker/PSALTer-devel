(*==================*)
(*  LoadingPSALTer  *)
(*==================*)

Subsection@"Loading PSALTer";
Comment@"The first step is to load the PSALTer package.";
Code[<<xAct`PSALTer`;];
(*
Unprotect@xAct`PSALTer`ParticleSpectrum;
ClearAll@xAct`PSALTer`ParticleSpectrum;
Protect@xAct`PSALTer`ParticleSpectrum;
*)
Comment@"We will impose some settings which make xAct easier to use (you may have seen these in other example notebooks for xAct).";
Code[
	SetOptions[$FrontEndSession,EvaluationCompletionAction->"ScrollToOutput"];
	$DefInfoQ=False;
	Unprotect@AutomaticRules;
	Options[AutomaticRules]={Verbose->False};
	Protect@AutomaticRules;
];
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
