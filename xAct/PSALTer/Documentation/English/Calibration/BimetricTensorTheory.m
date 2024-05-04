(*========================*)
(*  BimetricTensorTheory  *)
(*========================*)

Title@"Bimetric tensor field theory";

Comment@"Define symmetric and asymmetric tensor fields.";
Code[
	DefField[BimetricF[-a,-b],PrintAs->"\[ScriptF]",PrintSourceAs->"\[ScriptJ]"];
	DefField[BimetricLinearMetric[-a,-b],PrintAs->"\[ScriptH]",PrintSourceAs->"\[ScriptCapitalT]"];
];
Comment@"Define a constant symbol.";
Code[
	DefConstantSymbol[EinsteinConstant,PrintAs->"\[Kappa]"];
];

Get@FileNameJoin@{$ThisDirectory,"Calibration","BimetricTensorTheory",
				"BimetricPartanenTulkkiTheory.m"};
