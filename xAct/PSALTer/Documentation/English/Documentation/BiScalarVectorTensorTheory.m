(*==============================*)
(*  BiScalarVectorTensorTheory  *)
(*==============================*)

Title@"Bi-scalar-vector-tensor field theory";

Comment@"Define a symmetric tensor, a vector and a scalar.";
Code[
	DefField[LinearMetric[-a,-b],Symmetric[{-a,-b}],PrintAs->"\[ScriptH]",PrintSourceAs->"\[ScriptCapitalT]"];
	DefField[B[-a],PrintAs->"\[ScriptCapitalB]",PrintSourceAs->"\[ScriptCapitalJ]"];
	DefField[Phi[],PrintAs->"\[Phi]",PrintSourceAs->"\[Rho]"];
	DefField[VarPhi[],PrintAs->"\[CurlyPhi]",PrintSourceAs->"\[CurlyRho]"];
];
Comment@"Define some constant symbols.";
Code[
	DefConstantSymbol[CouplingXi,PrintAs->"\[Xi]"];
	DefConstantSymbol[CouplingNu,PrintAs->"\[Nu]"];
	DefConstantSymbol[CouplingMu,PrintAs->"\[Mu]"];
	DefConstantSymbol[CouplingSigma,PrintAs->"\[Sigma]"];
	DefConstantSymbol[CouplingPhi0,PrintAs->"\[Phi]0"];
];

Get@FileNameJoin@{$ThisDirectory,"Documentation","BiScalarVectorTensorTheory","NuXiTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","BiScalarVectorTensorTheory","NuNoXiTheory.m"};
