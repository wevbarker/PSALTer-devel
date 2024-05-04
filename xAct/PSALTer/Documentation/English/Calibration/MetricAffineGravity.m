(*=======================*)
(*  MetricAffineGravity  *)
(*=======================*)

Title@"Metric affine gravity (MAG)";

(*
Comment@"We will define a connection field.";
Code[
	DefField[Connection[-a,-b,-c],PrintAs->"\[ScriptCapitalA]",PrintSourceAs->"\[CapitalDelta]"];
];
Comment@"Let's define another symmetric tensor field.";
Code[
	DefField[MetricPerturbation[-a,-b],Symmetric[{-a,-b}],PrintAs->"\[ScriptH]",PrintSourceAs->"\[ScriptCapitalT]"];
];
Comment@"We will define some coupling constants.";
*)
	DefTensor[Connection[-a,-b,-c],M4,PrintAs->"\[ScriptCapitalA]"];
	DefTensor[MetricPerturbation[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->"\[ScriptH]"];

Code[
	DefConstantSymbol[A0,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[A1,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[A2,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[A3,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[A4,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[A5,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[A6,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[A7,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[A8,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[A9,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[A10,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[A11,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[C0,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[C1,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[C2,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[C3,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[C4,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[C5,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[C6,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[C7,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[C8,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[C9,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[C10,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[C11,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[C12,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[C13,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[C14,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[C15,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[C16,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
];

Get@FileNameJoin@{$ThisDirectory,"Calibration","MetricAffineGravity",
					"FieldStrengthTensors.m"};
Get@FileNameJoin@{$ThisDirectory,"Calibration","MetricAffineGravity",
					"NonlinearLagrangian.m"};
Get@FileNameJoin@{$ThisDirectory,"Calibration","MetricAffineGravity",
					"MetricAffineEinsteinHilbertTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Calibration","MetricAffineGravity",
					"BarkerMarzoTheories.m"};
Get@FileNameJoin@{$ThisDirectory,"Calibration","MetricAffineGravity",
					"MarzoZellBarkerModel3.m"};
Get@FileNameJoin@{$ThisDirectory,"Calibration","MetricAffineGravity",
					"VectorSymmetricTheories.m"};
Get@FileNameJoin@{$ThisDirectory,"Calibration","MetricAffineGravity",
					"AnnalaRasanenTheories.m"};
(*
Get@FileNameJoin@{$ThisDirectory,"Calibration","MetricAffineGravity",
					"IosifidisBarkerTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Calibration","MetricAffineGravity",
					"MetricAffineGaussBonnetTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Calibration","MetricAffineGravity",
					"QuadraticSymmetricRiemannTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Calibration","MetricAffineGravity",
					"BarkerKarananasZellTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Calibration","MetricAffineGravity",
					"CarloTheories.m"};
Get@FileNameJoin@{$ThisDirectory,"Calibration","MetricAffineGravity",
					"TypeI.m"};
Get@FileNameJoin@{$ThisDirectory,"Calibration","MetricAffineGravity",
					"TypeII.m"};
*)
