(*==================*)
(*  LoadingPSALTer  *)
(*==================*)

Subsection@"Loading the package";
Comment@"The first step is to load the PSALTer package:";
Code[<<xAct`PSALTer`;];
(**)
Unprotect@xAct`PSALTer`ParticleSpectrum;
ClearAll@xAct`PSALTer`ParticleSpectrum;
ClearAll@xAct`PSALTer`DefField;
Options@DefField={PrintAs->"\[Zeta]",PrintSourceAs->"\[ScriptJ]"};
DefField[InputField_[Inds___],Opts___?OptionQ]:=DefField[InputField[Inds],GenSet[],Opts];
DefField[InputField_[Inds___],SymmExpr_,OptionsPattern[]]:=DefTensor[InputField[Inds],M4,SymmExpr,PrintAs->OptionValue@PrintAs];
Protect@xAct`PSALTer`ParticleSpectrum;
(**)
Comment@"PSALTer is now loaded. It is helpful to briefly review all the symbols which are provided by the package:";
Code[
	Print@Names@"xAct`PSALTer`*";
];
Comment@"We will now review these pre-defined symbols.";
Subsection@"Pre-defined geometry";
Comment@"We can see that the geometry of the spacetime has been pre-defined:";
Code[
	Print/@{?M4,G[-m,-n],?G,Defer@(CD[-a]@G[-m,-n]),?CD};
];
Comment@"All lower-case letters in the Latin alphabet are valid spacetime indices, but they will automatically format as lower-case Greek letters when used inside tensors.";
Code[
	Print@IndicesOfVBundle@TangentM4;
];
Comment@"Strictly, xAct views all these indices as abstract indices. The interpretation of the indices as being associated with a Cartesian chart is a convenient abuse of notation.";
Subsection@"Pre-defined physics";
Comment@"Massive particles are associated with a rest-frame defined by their timelike momenta:";
Code[
	Print/@{V[-m],?V,P[-m],?P,Def,?Def,En,?En,Mo,?Mo};
];
Comment@"The user should not have to interact with these quantities directly (though they appear in the output).";
Subsection@"Provided functions";
Comment@"The package provides only two functions:";
Code[
	Print/@{?DefField,?ParticleSpectrum};
];
Comment@"Some of the options that must be passed to these functions are defined already in xAct, but some are new:";
Code[
	Print/@{?PrintSourceAs,?TheoryName,?MaxLaurentDepth};
];
Subsection@"Global variables and settings";
Comment@"We will impose some settings which make xAct easier to use (you may have seen these in other example notebooks for xAct):";
Code[
	SetOptions[$FrontEndSession,EvaluationCompletionAction->"ScrollToOutput"];
	$DefInfoQ=False;
	Unprotect@AutomaticRules;
	Options[AutomaticRules]={Verbose->False};
	Protect@AutomaticRules;
];
Comment@"We will also impose some global settings for PSALTer:";
Code[
	Print/@{?$DiagnosticMode,?$MonitorParallel,?$ExportPDF,?$ReadOnly};
	$DiagnosticMode=False;
	$MonitorParallel=False;
	$ExportPDF=True;
	$ReadOnly=False;
];
Comment@"With these settings in place the kernel is ready for science operations.";
