(*======================*)
(*  TeleparallelTheory  *)
(*======================*)

Subsection@"Teleparallel Theory";
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
TwoFormSector=KineticCoupling*Antisymmetrize[CD[-a]@B[-b,-c],{-a,-b,-c}]*CD[a]@B[b,c];
TwoFormSector=TwoFormMassSquare*B[-a,-b]*B[a,b];
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
(*
	Code[InternalLinearLagrangian,      
		ParticleSpectrum[
			InternalLinearLagrangian,
			TheoryName->ModelName<>"WithB",	
			Method->"Hard",
			MaxLaurentDepth->3
		];
	];
*)
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
Quit[];
(*
	LinearLagrangian=NonLinearLagrangian;
	LinearLagrangian//=LineariseLagrangian;
	DisplayExpression[LinearLagrangian,EqnLabel->ToString@FullLinearise];
	Comment@{"Here is the Lagrangian",Cref@ToString@FullLinearise," in the Weitzenbock gauge."};
	LinearLagrangian=LinearLagrangian/.{A->Zero};
	DisplayExpression[LinearLagrangian,EqnLabel->ToString@Weitzenbock];
	Comment@{"Now we compute the particle spectrum of",Cref@ToString@Weitzenbock,":"};
	Code[LinearLagrangian,      
		ParticleSpectrum[
			LinearLagrangian,
			TheoryName->ModelName,	
			Method->"Hard",
			MaxLaurentDepth->3
		];
	];
*)

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
	(*TheNonlinearLagrangian=NonLinearLagrangian/.InputRule;	*)
	TheNonlinearLagrangian=NonLinearLagrangian/.C2->2*C1;	
	DisplayExpression@TheNonlinearLagrangian;
	ProcessModel[TheNonlinearLagrangian,"TeleparallelCase"<>ToString@CaseNumber];
	CaseNumber+=1;
];
TryCombo/@Eqs;
