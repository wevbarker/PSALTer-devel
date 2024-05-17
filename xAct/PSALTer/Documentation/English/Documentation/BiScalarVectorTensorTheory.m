(*==============================*)
(*  BiScalarVectorTensorTheory  *)
(*==============================*)

Section@"Two scalars, a vector and a symmetric rank-two tensor";
Comment@"Define a second scalar:";
Code[
	DefField[Phi[],PrintAs->"\[Phi]",PrintSourceAs->"\[Rho]"];
	DefField[VarPhi[],PrintAs->"\[CurlyPhi]",PrintSourceAs->"\[CurlyRho]"];
	DefField[B[-a],PrintAs->"\[ScriptCapitalB]",PrintSourceAs->"\[ScriptCapitalJ]"];
	DefField[LinearMetric[-a,-b],Symmetric[{-a,-b}],PrintAs->"\[ScriptH]",PrintSourceAs->"\[ScriptCapitalT]"];
];
Comment@"Define some constant symbols:";
Code[
	DefConstantSymbol[CouplingXi,PrintAs->"\[Xi]"];
	DefConstantSymbol[CouplingNu,PrintAs->"\[Nu]"];
	DefConstantSymbol[CouplingMu,PrintAs->"\[Mu]"];
	DefConstantSymbol[CouplingSigma,PrintAs->"\[Sigma]"];
	DefConstantSymbol[CouplingPhi0,PrintAs->"\!\(\*SubscriptBox[\(\[Phi]\), \(0\)]\)"];
];
Get@FileNameJoin@{$ThisDirectory,"Documentation","BiScalarVectorTensorTheory","NuXiTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","BiScalarVectorTensorTheory","NuNoXiTheory.m"};
