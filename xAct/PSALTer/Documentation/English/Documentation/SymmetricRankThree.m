(*======================*)
(*  SymmetricRankThree  *)
(*======================*)

Subsection@"Singh-Hagen theory";
Comment@"We want to study the theories which are considered in Phys. Rev. D. 9, 898 (1974) and arXiv:1902.05118";

Comment@"Then we define the higher-spin field:";
Code[
	DefField[HigherSpinField[-a,-b,-c],Symmetric[{-a,-b,-c}],
		PrintAs->"\[ScriptH]",PrintSourceAs->"\[ScriptCapitalF]"];
];

Comment@"Then we define the Singh-Hagen model.";
Module[{x2=1/Coupling1,x3=1},
	LagrangianDensity=(Coupling1*HigherSpinField[-m,-n,-r]CD[s]@CD[-s]@HigherSpinField[m,n,r]-3*Coupling1*HigherSpinField[-m,-n,-r]CD[m]@CD[-a]@HigherSpinField[a,n,r]-3*Coupling1/2HigherSpinField[-n,-s,s]CD[n]@CD[-m]@HigherSpinField[m,-r,r]-3*Coupling1*HigherSpinField[n,-s,s]CD[m]@CD[-m]@HigherSpinField[-n,-r,r]+6Coupling1*HigherSpinField[-r,-s,s]CD[-m]@CD[-n]@HigherSpinField[m,n,r]+Coupling1*Coupling2^2*HigherSpinField[m,n,r]HigherSpinField[-m,-n,-r]-3*Coupling1*Coupling2^2*HigherSpinField[m,-r,r]HigherSpinField[-m,s,-s]+x2*x3^2/(3)(3)/2ScalarField[]CD[-m]@CD[m]@ScalarField[]+x3^2(1/2)(4/2)^2x2*Coupling2^2*ScalarField[]ScalarField[]+x3*Coupling2*HigherSpinField[-m,s,-s]CD[m]@ScalarField[])*Coupling1;
];

LagrangianDensity//=CollectTensors;
LagrangianDensity//=ReplaceAll[{}];
LagrangianDensity//=ToCanonical
LagrangianDensity//=CollectTensors;
LagrangianDensity//DisplayExpression;

$ReadOnly=False;
Comment@"Now we try to compute the particle spectrum:";
Code[LagrangianDensity,
	ParticleSpectrum[
		LagrangianDensity,
		TheoryName->"SinghHagenTheory",
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
