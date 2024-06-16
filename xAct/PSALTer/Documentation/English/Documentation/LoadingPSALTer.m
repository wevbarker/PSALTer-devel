(*==================*)
(*  LoadingPSALTer  *)
(*==================*)

Subsection@"Loading the package";
Supercomment@"Please make sure that you have read README.md carefully, ideally as it appears on the GitHub website (i.e. with markdown formatting). There, you can find installation instructions specific to your operating system.";
Comment@"If not already installed, you will probably require the following dependency:";
Code[PacletInstall["JasonB/RectanglePacking"];];
Supercomment@"As explained in README.md, the only reason why we need RectanglePacking is to improve the formatting of the final output graphic. If you are having problems with the production of this graphic (this especially applies to macOS or Microsoft Windows users), you should set the following global variable equal to \"True\" (this is a temporary fix in the current version of the software):";
Code[xAct`PSALTer`Private`$NoExport=False;];
Comment@"The first step after installing is to load the PSALTer package:";
Code[<<xAct`PSALTer`;];
Comment@"PSALTer is now loaded. It is helpful to briefly review all the symbols which are provided by the package:";
Code[
	Print@Names@"xAct`PSALTer`*";
];
Comment@"To use the package we only need to know about a handful of these pre-defined symbols.";
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
Supercomment@"Unlike for the case of the pre-defined geometry symbols, the user should not have to interact with these pre-defined physics symbols directly (we mention them only because they appear in the output).";
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
Comment@"We will impose some \"personal\" settings which make xAct easier to use (you may have seen these in other example notebooks for xAct, which can be found on the internet):";
Code[
	SetOptions[$FrontEndSession,EvaluationCompletionAction->"ScrollToOutput"];
	$DefInfoQ=False;
	Unprotect@AutomaticRules;
	Options[AutomaticRules]={Verbose->False};
	Protect@AutomaticRules;
];
Comment@"We will also impose a global setting for PSALTer:";
Code[
	Print@?$ReadOnly;
	$ReadOnly=False;
];
Comment@"With these settings in place, the kernel is ready for science operations.";
