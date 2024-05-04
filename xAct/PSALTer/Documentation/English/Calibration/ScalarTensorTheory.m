(*======================*)
(*  ScalarTensorTheory  *)
(*======================*)

Title@"Scalar tensor theory";

Comment@"We will define scalar and symmetric tensor fields.";
Code[
	DefField[LinearMetric[-a,-b],Symmetric[{-a,-b}],PrintAs->"\[ScriptH]",PrintSourceAs->"\[ScriptCapitalT]"];
	DefField[Phi[],PrintAs->"\[Phi]",PrintSourceAs->"\[ScriptCapitalJ]"];
];
Comment@"Some more coupling constants.";
Code[
	DefConstantSymbol[Coupling1,PrintAs->"\[Alpha]"];
	DefConstantSymbol[Coupling2,PrintAs->"\[Beta]"];
	DefConstantSymbol[Coupling3,PrintAs->"\[Gamma]"];
	DefConstantSymbol[Coupling4,PrintAs->"\[Delta]"];
	DefConstantSymbol[Coupling5,PrintAs->"\[Epsilon]"];
	DefConstantSymbol[Coupling6,PrintAs->"\[Zeta]"];
	DefConstantSymbol[Coupling7,PrintAs->"\[Zeta]"];
	DefConstantSymbol[Coupling9,PrintAs->"\[Zeta]"];
	DefConstantSymbol[Coupling10,PrintAs->"\[Zeta]"];
];

Get@FileNameJoin@{$ThisDirectory,"Calibration","ScalarTensorTheory",
					"ScalarFierzPauliTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Calibration","ScalarTensorTheory",
					"ScalarGaussBonnetTheory.m"};
