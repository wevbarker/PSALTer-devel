(*======================*)
(*  TeleparallelTheory  *)
(*======================*)

Subsection@"Teleparallel Theory";

Quiet[
	DefConstantSymbol[Prt,PrintAs->"\[Epsilon]"];
	DefConstantSymbol[C1,PrintAs->"\*SubscriptBox[\[ScriptC],1]"];
	DefConstantSymbol[C2,PrintAs->"\*SubscriptBox[\[ScriptC],2]"];
	DefConstantSymbol[Gam,PrintAs->"\[Gamma]"];
	DefConstantSymbol[JBet0,PrintAs->"\*SubscriptBox[\[Beta],0]"];
	DefConstantSymbol[JBet1,PrintAs->"\*SubscriptBox[\[Beta],1]"];
	DefConstantSymbol[JBet2,PrintAs->"\*SubscriptBox[\[Beta],2]"];
	DefConstantSymbol[JBet3,PrintAs->"\*SubscriptBox[\[Beta],3]"];
	DefConstantSymbol[JBet4,PrintAs->"\*SubscriptBox[\[Beta],4]"];
];

DefTensor[CetE[i,-m],M4,PrintAs->"\[GothicE]"];
DefTensor[CetF[i,-m],M4,PrintAs->"\[GothicF]"];
DefTensor[TetE[-i,m],M4,PrintAs->"\[ScriptE]"];
DefTensor[TetF[-i,m],M4,PrintAs->"\[ScriptF]"];

Code[
	DefField[SymE[-m,-n],Symmetric[{-m,-n}],PrintAs->"\*OverscriptBox[\[ScriptH],\[GothicE]]",PrintSourceAs->"\*OverscriptBox[\[Tau],\[GothicE]]"];
	DefField[AntE[-m,-n],Antisymmetric[{-m,-n}],PrintAs->"\*OverscriptBox[\[ScriptB],\[GothicE]]",PrintSourceAs->"\*OverscriptBox[\[ScriptJ],\[GothicE]]"];
	DefField[SymF[-m,-n],Symmetric[{-m,-n}],PrintAs->"\*OverscriptBox[\[ScriptH],\[GothicF]]",PrintSourceAs->"\*OverscriptBox[\[Tau],\[GothicF]]"];
	DefField[AntF[-m,-n],Antisymmetric[{-m,-n}],PrintAs->"\*OverscriptBox[\[ScriptB],\[GothicF]]",PrintSourceAs->"\*OverscriptBox[\[ScriptJ],\[GothicF]]"];
];

DefTensor[TE[i,-m,-n],M4,Antisymmetric[{-m,-n}],PrintAs->"\*OverscriptBox[\[ScriptT],\[GothicE]]"];

ExpandTE=MakeRule[{TE[i,-m,-n],CD[-m]@CetE[i,-n]-CD[-n]@CetE[i,-m]},MetricOn->All,ContractMetrics->True];
ExpandCetE=MakeRule[{CetE[i,-m],G[i,-m]+(1/2)*Prt*G[i,j]*G[n,-j]*(SymE[-n,-m]+AntE[-n,-m])},MetricOn->All,ContractMetrics->True];
ExpandCetF=MakeRule[{CetF[i,-m],G[i,-m]+(1/2)*Prt*G[i,j]*G[n,-j]*(SymF[-n,-m]+AntF[-n,-m])},MetricOn->All,ContractMetrics->True];
ExpandTetE=MakeRule[{TetE[-i,m],G[-i,m]-(1/2)*Prt*G[m,s]*G[-i,n]*(SymE[-s,-n]+AntE[-s,-n]-(1/2)*Prt*(SymE[-s,l]+AntE[-s,l])*(SymE[-l,-n]+AntE[-l,-n]))},MetricOn->All,ContractMetrics->True];
ExpandTetF=MakeRule[{TetF[-i,m],G[-i,m]-(1/2)*Prt*G[m,s]*G[-i,n]*(SymF[-s,-n]+AntF[-s,-n]-(1/2)*Prt*(SymF[-s,l]+AntF[-s,l])*(SymF[-l,-n]+AntF[-l,-n]))},MetricOn->All,ContractMetrics->True];


LineariseModel[InputExpr_]:=Module[{Expr=InputExpr,LinExpr},
	Comment@"Linearizing...";	
	Expr=Expr/.ExpandTE;
	Expr=Expr/.ExpandCetE;
	Expr=Expr/.ExpandCetF;
	Expr=Expr/.ExpandTetE;
	Expr=Expr/.ExpandTetF;
	Expr//=Expand;
	LinExpr=Coefficient[Expr,Prt];
	Expr=Coefficient[Expr,Prt^2];
	LinExpr//=ToCanonical;
	LinExpr//=ContractMetric;
	LinExpr//=ScreenDollarIndices;
	LinExpr//=CollectTensors;
	DisplayExpression@LinExpr;
	Expr//=ToCanonical;
	Expr//=ContractMetric;
	Expr//=ScreenDollarIndices;
	Expr//=CollectTensors;
	DisplayExpression@Expr;
Expr];

Comment@"Normalisations.";
Expr=CetE[i,-m]TetE[-i,n];
Expr//LineariseModel;

Comment@"Normalisations.";
Expr=CetF[i,-m]TetF[-i,n];
Expr//LineariseModel;

Comment@"Normalisations.";
Expr=CetE[i,-m]TetE[-j,m];
Expr//LineariseModel;

Comment@"Normalisations.";
Expr=CetF[i,-m]TetF[-j,m];
Expr//LineariseModel;

Comment@"The kinetic term.";
Expr=C1*TE[-m,-n,-s]*TE[m,n,s]+C2*TE[-m,-n,-s]*TE[n,m,s]-(2*C1+C2)*TE[-m,-n,m]*TE[s,n,-s];
Expr//=LineariseModel;
FirstExpr=Expr;

Comment@"The mass term.";
Expr=TetE[-a,b]*TetE[-c,d](Gam*G[a,c]CetF[z,-b]CetF[-z,-d]-JBet0*CetF[a,-d]CetF[c,-b]);
Expr//=LineariseModel;
SecondExpr=Expr;
(**)
Comment@"The volume four-forms.";
Expr=-2*epsilonG[-a,-b,-c,-d]*epsilonG[e,f,g,h]*(
	JBet0*CetE[a,-e]*CetE[b,-f]*CetE[c,-g]*CetE[d,-h]
	+JBet1*CetE[a,-e]*CetE[b,-f]*CetE[c,-g]*CetF[d,-h]
	+JBet2*CetE[a,-e]*CetE[b,-f]*CetF[c,-g]*CetF[d,-h]
	+JBet3*CetE[a,-e]*CetF[b,-f]*CetF[c,-g]*CetF[d,-h]
	+JBet4*CetF[a,-e]*CetF[b,-f]*CetF[c,-g]*CetF[d,-h]
);
(*
NoCRules=First@Solve[4JBet0+3JBet1+2JBet2+JBet3==0&&JBet1+2JBet2+3JBet3+4JBet4==0,{JBet3,JBet4}];
DisplayExpression@NoCRules;
Expr=Expr/.NoCRules;
*)
Expr//=LineariseModel;
ThirdExpr=Expr;
(**)
(*+SecondExpr*)
Expr=FirstExpr+ThirdExpr;
Expr//=ToCanonical;
Expr//=ContractMetric;
Expr//=ScreenDollarIndices;
Expr//=CollectTensors;
Expr//DisplayExpression;

Code[Expr,      
	ParticleSpectrum[
		Expr,
		TheoryName->"NLC",	
		Method->"Hard",
		MaxLaurentDepth->3
	];
];

(*
Comment@"We will define some coupling constants to parameterise the sector which is quadratic in the torsion:";
Code[
	DefConstantSymbol[C1,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptC]\), \(1\)]\)"];
	DefConstantSymbol[C2,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptC]\), \(2\)]\)"];
	DefConstantSymbol[C3,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptC]\), \(3\)]\)"];
];
Comment@"Also we define some more coupling constants to parameterise the two-form sector:";
Code[
	DefConstantSymbol[KineticCoupling,PrintAs->"\[Alpha]"];
	DefConstantSymbol[TwoFormMassSquare,PrintAs->"\[Beta]"];
];
Comment@"Apart from the tetrad and the spin connection, we define also a two-form field.";
Code[
	DefField[B[-a,-b],Antisymmetric[{-a,-b}],PrintAs->"\[ScriptCapitalB]",PrintSourceAs->"\[ScriptCapitalJ]"];
];
Comment@"Here is the two-form sector on its own.";
TwoFormSector=KineticCoupling*Antisymmetrize[CD[-a]@B[-b,-c],{-a,-b,-c}]*CD[a]@B[b,c]+TwoFormMassSquare*B[-a,-b]*B[a,b];
(*
TwoFormSector=KineticCoupling*Antisymmetrize[CD[-a]@B[-b,-c],{-a,-b,-c}]*CD[a]@B[b,c];
TwoFormSector=TwoFormMassSquare*B[-a,-b]*B[a,b];
*)
DisplayExpression[TwoFormSector,EqnLabel->"TwoFormSector"];
Comment@"We want a rule which can displace the tetrad perturbation by a two-form-valued field.";
DisplaceF=MakeRule[{F[-a,-b],F[-a,-b]+B[-a,-b]},MetricOn->All,ContractMetrics->True];
ToOrderB = MakeRule[{B[-a, -b], PerturbativeParameter B[-a, -b]}, 
	MetricOn -> All, ContractMetrics -> True];
ToOrder = Join[ToOrder, ToOrderB];
LineariseLagrangian[NonlinearLagrangian_]:=Module[{LinearLagrangian=NonlinearLagrangian},	
	LinearLagrangian*=(1-F[z,-z]);
	LinearLagrangian=LinearLagrangian/.RTToHBFieldACDBFieldCDA;
	LinearLagrangian=LinearLagrangian/.HBFieldToGF;
	LinearLagrangian=LinearLagrangian/.ToOrder;
	LinearLagrangian//=Series[#,{PerturbativeParameter,0,2}]&;
	LinearLagrangian//=Normal;
	LinearLagrangian=LinearLagrangian/.PerturbativeParameter->1;
	LinearLagrangian//=xAct`PSALTer`Private`ToNewCanonical;
LinearLagrangian];
Expr=F[-a,-b]
DisplayExpression[Expr,EqnLabel->"BeforeTransformation"];
Expr=Expr/.DisplaceF;
DisplayExpression[Expr,EqnLabel->"AfterTransformation"];
ProcessModel[InputLagrangian_,ModelName_]:=Module[{
	InternalLinearLagrangian=InputLagrangian,
	InternalLinearLagrangian2,
	InternalLinearLagrangian4,
	FullLinearise,
	Weitzenbock,
	Displaced,
	Added},

	Supercomment@"First we try the model without the two-form field.";	
	Comment@"Here is the Lagrangian to second order in perturbative fields.";
	InternalLinearLagrangian//=LineariseLagrangian;
	DisplayExpression[InternalLinearLagrangian,EqnLabel->ToString@FullLinearise];
	Comment@{"Here is the Lagrangian",Cref@ToString@FullLinearise," in the Weitzenbock gauge."};
	InternalLinearLagrangian=InternalLinearLagrangian/.{A->Zero};
	DisplayExpression[InternalLinearLagrangian,EqnLabel->ToString@Weitzenbock];
	Comment@{"Now we compute the particle spectrum of",Cref@ToString@Weitzenbock,":"};
	Code[InternalLinearLagrangian,      
		ParticleSpectrum[
			InternalLinearLagrangian,
			TheoryName->ModelName,	
			Method->"Hard",
			MaxLaurentDepth->3
		];
	];
	Supercomment@"Next we try the model with the two-form field.";
	Comment@{"Here is the Lagrangian in",Cref@ToString@Weitzenbock," where we used the rules in",Cref@{"BeforeTransformation","AfterTransformation"}," to introduce the two form."};
	InternalLinearLagrangian=InternalLinearLagrangian/.DisplaceF;
	InternalLinearLagrangian//=LineariseLagrangian;
	DisplayExpression[InternalLinearLagrangian,EqnLabel->ToString@Displaced];
	Comment@{"And here is the Lagrangian in",Cref@ToString@Displaced," when we add the pure two-form sector in",Cref@"TwoFormSector","."};
	InternalLinearLagrangian+=TwoFormSector;
	InternalLinearLagrangian//=ToCanonical;
	InternalLinearLagrangian//=CollectTensors;
	DisplayExpression[InternalLinearLagrangian,EqnLabel->ToString@Added];
	Comment@{"Now we compute the particle spectrum of",Cref@ToString@Added,":"};
	Code[InternalLinearLagrangian,      
		ParticleSpectrum[
			InternalLinearLagrangian,
			TheoryName->ModelName<>"WithB",	
			Method->"Hard",
			MaxLaurentDepth->3
		];
	];
	Comment@"Without the kinetic part.";
	InternalLinearLagrangian2=InternalLinearLagrangian/.{KineticCoupling->0};
	Code[InternalLinearLagrangian2,      
		ParticleSpectrum[
			InternalLinearLagrangian2,
			TheoryName->ModelName<>"WithBNoKinetic",	
			Method->"Hard",
			MaxLaurentDepth->3
		];
	];
	Comment@"Without the mass part.";
	InternalLinearLagrangian4=InternalLinearLagrangian/.{TwoFormMassSquare->0};
	Code[InternalLinearLagrangian4,      
		ParticleSpectrum[
			InternalLinearLagrangian4,
			TheoryName->ModelName<>"WithBNoMass",	
			Method->"Hard",
			MaxLaurentDepth->3
		];
	];
];

Subsection@"TEGR";
Comment@"We run the analysis on TEGR.";
NonLinearLagrangian=kT1*(-(1/4)*T[-m, -n, -r]*T[m, n, r]-(1/2)*T[-m, -n, -r]*T[n, m, r]+T[n, -m, -n]*T[r, m, -r]);
DisplayExpression@NonLinearLagrangian;
ProcessModel[NonLinearLagrangian,"TEGR"];

Subsection@"New GR (completely general)";
Comment@"We run the analysis on new GR without any constraints.";
NonLinearLagrangian=(C1*T[-m, -n, -r]*T[m, n, r]+C2*T[-m, -n, -r]*T[n, m, r]+C3*T[n, -m, -n]*T[r, m, -r]);
DisplayExpression[NonLinearLagrangian,EqnLabel->"FullNewGR"];
ProcessModel[NonLinearLagrangian,"FullNewGR"];

Comment@"Now we notice from the above analysis that the following conditions may be useful.";
Eqs={2*C1+C2+3*C3==0,2*C1-C2==0,2*C1+C2==0,2*C1+C2+C3==0};
DisplayExpression/@Eqs;
Eqs//=Subsets;
Eqs=(#~Reduce~{C1,C2,C3})&/@Eqs;
Eqs//=DeleteDuplicates;
Eqs=Quiet[(First@(#~Solve~{C1,C2,C3}))&/@Eqs];
Eqs=Drop[Eqs,1];
Comment@"There appear to be nine (or eight) independent, non-trivial combinations of rules which you can apply, which variously impose these conditions.";
DisplayExpression/@Eqs;

CaseNumber=1;
TryCombo[InputRule_]:=Module[{CaseRule,TheNonlinearLagrangian},
	Subsection@("Case "<>ToString@CaseNumber<>" of New GR");
	Comment@"Consider the following rule.";
	DisplayExpression[InputRule,EqnLabel->ToString@CaseRule];
	Comment@{"We take the general Lagrangian in",Cref@"FullNewGR"," and we impose the constraint",Cref@ToString@CaseRule," to give the following."};
	TheNonlinearLagrangian=NonLinearLagrangian/.InputRule;
	(*TheNonlinearLagrangian=NonLinearLagrangian/.C2->2*C1;	*)
	DisplayExpression@TheNonlinearLagrangian;
	ProcessModel[TheNonlinearLagrangian,"TeleparallelCase"<>ToString@CaseNumber];
	CaseNumber+=1;
];
TryCombo/@Eqs;
*)
