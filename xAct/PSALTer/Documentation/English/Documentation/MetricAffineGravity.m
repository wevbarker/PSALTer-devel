(*=======================*)
(*  MetricAffineGravity  *)
(*=======================*)

Section@"A symmetric rank-two tensor and an asymmetric rank-three tensor";
Comment@"This is the kinematic setup which is used in metric-affine gravity (MAG).";
Comment@"Let's define a connection field:";
Code[
	DefField[Connection[-a,-b,-c],PrintAs->"\[CapitalGamma]",PrintSourceAs->"\[CapitalDelta]"];
];
Supercojment@"This time there are two negative-parity spin-two modes, so there are two error messages. As before, these do not signal a real problem.";
Comment@"We will define some more coupling constants:";
Code[
	DefConstantSymbol[A0,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(0\)]\)"];
	DefConstantSymbol[A1,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(1\)]\)"];
	DefConstantSymbol[A2,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(2\)]\)"];
	DefConstantSymbol[A3,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(3\)]\)"];
	DefConstantSymbol[A4,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(4\)]\)"];
	DefConstantSymbol[A5,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(5\)]\)"];
	DefConstantSymbol[A6,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(6\)]\)"];
	DefConstantSymbol[A7,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(7\)]\)"];
	DefConstantSymbol[A8,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(8\)]\)"];
	DefConstantSymbol[A9,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(9\)]\)"];
	DefConstantSymbol[A10,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(10\)]\)"];
	DefConstantSymbol[A11,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(11\)]\)"];
	DefConstantSymbol[C1,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptC]\), \(1\)]\)"];
	DefConstantSymbol[C2,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptC]\), \(2\)]\)"];
	DefConstantSymbol[C3,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptC]\), \(3\)]\)"];
	DefConstantSymbol[C4,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptC]\), \(4\)]\)"];
	DefConstantSymbol[C5,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptC]\), \(5\)]\)"];
	DefConstantSymbol[C6,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptC]\), \(6\)]\)"];
	DefConstantSymbol[C7,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptC]\), \(7\)]\)"];
	DefConstantSymbol[C8,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptC]\), \(8\)]\)"];
	DefConstantSymbol[C9,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptC]\), \(9\)]\)"];
	DefConstantSymbol[C10,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptC]\), \(10\)]\)"];
	DefConstantSymbol[C11,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptC]\), \(11\)]\)"];
	DefConstantSymbol[C12,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptC]\), \(12\)]\)"];
	DefConstantSymbol[C13,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptC]\), \(13\)]\)"];
	DefConstantSymbol[C14,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptC]\), \(14\)]\)"];
	DefConstantSymbol[C15,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptC]\), \(15\)]\)"];
	DefConstantSymbol[C16,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptC]\), \(16\)]\)"];
];
Get@FileNameJoin@{$ThisDirectory,"Documentation","MetricAffineGravity",
					"FieldStrengthTensors.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","MetricAffineGravity",
					"NonlinearLagrangian.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","MetricAffineGravity",
					"MetricAffineEinsteinHilbertTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","MetricAffineGravity",
					"VectorSymmetricTheories.m"};
