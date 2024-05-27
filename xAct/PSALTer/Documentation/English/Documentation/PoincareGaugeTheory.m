(*=======================*)
(*  PoincareGaugeTheory  *)
(*=======================*)

Section@"An asymmetric rank-two tensor and a pair-antisymmetric rank-three tensor";
Comment@"This is the kinematic setup which is used in Poincaré gauge theory (PGT).";
Comment@"We will set up an antisymmetric rank-three tensor field (the perturbation of the spin connection).";
Code[
	DefField[SpinConnection[-a,-b,-c],Antisymmetric[{-a,-b}],PrintAs->"\[Omega]",PrintSourceAs->"\[Sigma]"];
];
Comment@"We will also set up an asymmetric tensor field (the perturbation of the tetrad).";
Code[
	DefField[TetradPerturbation[-a,-b],PrintAs->"\[ScriptF]",PrintSourceAs->"\[Tau]"];
];

Comment@"Here is the inverse translational gauge field, or tetrad.";
DefTensor[H[-a,c],M4,PrintAs->"\[ScriptH]"];
DisplayExpression[H[-a,c]];
Comment@"Here is the translational gauge field, or inverse tetrad.";
DefTensor[BField[a,-c],M4,PrintAs->"\[ScriptB]"];
DisplayExpression[BField[a,-c]];
HBFieldToGF=Join[
	MakeRule[{H[-i,-j],G[-i,-j]+TetradPerturbation[-i,-j]},MetricOn->All,ContractMetrics->True],
	MakeRule[{BField[-i,-j],G[-i,-j]-TetradPerturbation[-j,-i]+TetradPerturbation[-i,-m]TetradPerturbation[m,-j]},MetricOn->All,ContractMetrics->True]
];
AutomaticRules[H,MakeRule[{H[-a,i]BField[a,-j],G[i,-j]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[H,MakeRule[{H[-a,i]BField[c,-i],G[-a,c]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[H,MakeRule[{CD[-a][H[-j,n]],Evaluate[-H[-i,n]H[-j,m]CD[-a][BField[i,-m]]]},MetricOn->All,ContractMetrics->True]];

DefTensor[R[a, b, -d, -e], M4, {Antisymmetric[{a, b}], Antisymmetric[{-d, -e}]},PrintAs->"\[ScriptCapitalR]"]; 
DefTensor[T[a, -b, -c], M4, Antisymmetric[{-b, -c}],PrintAs->"\[ScriptCapitalT]"]; 
RTToHBFieldACDBFieldCDA=Join[	
	MakeRule[{R[a,b,-d,-e],H[-d,i]H[-e,j](CD[-i][SpinConnection[a,b,-j]]-CD[-j][SpinConnection[a,b,-i]]+SpinConnection[a,-k,-i]SpinConnection[k,b,-j]-SpinConnection[a,-k,-j]SpinConnection[k,b,-i])},MetricOn->All,ContractMetrics->True],
	MakeRule[{T[a,-b,-c],H[-b,i]H[-c,j](CD[-i][BField[a,-j]]-CD[-j][BField[a,-i]]+SpinConnection[a,-k,-i]BField[k,-j]-SpinConnection[a,-k,-j]BField[k,-i])},MetricOn->All,ContractMetrics->True]
];

Comment@"Here is the Riemann-Cartan tensor.";
Expr=R[a, b, -d, -e];
DisplayExpression[Expr];
Expr=Expr/.RTToHBFieldACDBFieldCDA;
Expr//=ToCanonical;
Expr//=ScreenDollarIndices;
DisplayExpression[Expr];

Comment@"Here is the torsion tensor.";
Expr=T[a, -b, -c];
DisplayExpression[Expr];
Expr=Expr/.RTToHBFieldACDBFieldCDA;
Expr//=ToCanonical;
Expr//=ScreenDollarIndices;
DisplayExpression[Expr];

Comment@"Now we set up the general Lagrangian. In the first instance we will do this with some coupling constants which are proportional to those used by Hayashi and Shirafuji in Prog. Theor. Phys. 64 (1980) 2222, and identical to those used in arXiv:2205.13534 and (up to re-labelling) arXiv:gr-qc/9902032.";
Code[
	DefConstantSymbol[Alp0,PrintAs->"\!\(\*SubscriptBox[\(\[Alpha]\), \(0\)]\)"];
	DefConstantSymbol[Alp1,PrintAs->"\!\(\*SubscriptBox[\(\[Alpha]\), \(1\)]\)"];
	DefConstantSymbol[Alp2,PrintAs->"\!\(\*SubscriptBox[\(\[Alpha]\), \(2\)]\)"];
	DefConstantSymbol[Alp3,PrintAs->"\!\(\*SubscriptBox[\(\[Alpha]\), \(3\)]\)"];
	DefConstantSymbol[Alp4,PrintAs->"\!\(\*SubscriptBox[\(\[Alpha]\), \(4\)]\)"];
	DefConstantSymbol[Alp5,PrintAs->"\!\(\*SubscriptBox[\(\[Alpha]\), \(5\)]\)"];
	DefConstantSymbol[Alp6,PrintAs->"\!\(\*SubscriptBox[\(\[Alpha]\), \(6\)]\)"];
	DefConstantSymbol[Bet1,PrintAs->"\!\(\*SubscriptBox[\(\[Beta]\), \(1\)]\)"];
	DefConstantSymbol[Bet2,PrintAs->"\!\(\*SubscriptBox[\(\[Beta]\), \(2\)]\)"];
	DefConstantSymbol[Bet3,PrintAs->"\!\(\*SubscriptBox[\(\[Beta]\), \(3\)]\)"];
];

Get@FileNameJoin@{$ThisDirectory,"Documentation","PoincareGaugeTheory",
					"LagrangianHayashiShirafujiCouplings.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","PoincareGaugeTheory",
					"LagrangianKarananasCouplings.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","PoincareGaugeTheory",
					"Linearise.m"};

BasicCriticalCases={
	kR1==kR2==kR3==kR4==kR5==kLambda/4+kT1/3+kT2/12==-kLambda/2-kT1/3+kT2/6==-kLambda-kT1/3+2*kT3/3==0,
	kR1==kR2==kR3==kR4==kR5==kT1==kT2==kT3==0
};
Get@FileNameJoin@{$ThisDirectory,"Documentation","PoincareGaugeTheory",
					"EinsteinCartanTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","PoincareGaugeTheory",
					"GeneralRelativity.m"};
(*
Get@FileNameJoin@{$ThisDirectory,"Documentation","PoincareGaugeTheory",
					"NevilleTheory.m"};
*)
Get@FileNameJoin@{$ThisDirectory,"Documentation","PoincareGaugeTheory",
					"YoNesterTheories.m"};
(*
Get@FileNameJoin@{$ThisDirectory,"Documentation","PoincareGaugeTheory",
					"AnnalaRasanenTheory.m"};
*)
$ReadOnly=False;
Get@FileNameJoin@{$ThisDirectory,"Documentation","PoincareGaugeTheory",
					"GeneralPGT.m"};
$ReadOnly=True;
(*
Get@FileNameJoin@{$ThisDirectory,"Documentation","PoincareGaugeTheory",
					"LinHobsonLasenbyTheories.m"};
*)
