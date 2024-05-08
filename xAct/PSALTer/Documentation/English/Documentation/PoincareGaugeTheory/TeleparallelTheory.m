(*======================*)
(*  TeleparallelTheory  *)
(*======================*)

Subsection@"Teleparallel Theory";
Comment@"We would like to check the basic teleparallel theory.";
NonLinearLagrangian=kT1*(-(1/4)*T[-m, -n, -r]*T[m, n, r]-(1/2)*T[-m, -n, -r]*T[n, m, r]+T[n, -m, -n]*T[r, m, -r]);
Comment@"We will define some coupling constants:";
Code[
	DefConstantSymbol[C1,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(1\)]\)"];
	DefConstantSymbol[C2,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(2\)]\)"];
	DefConstantSymbol[C3,PrintAs->"\!\(\*SubscriptBox[\(\[ScriptA]\), \(3\)]\)"];
];
Comment@"We would like to check the new GR theory.";
NonLinearLagrangian=(C1*T[-m, -n, -r]*T[m, n, r]+C2*T[-m, -n, -r]*T[n, m, r]+C3*T[n, -m, -n]*T[r, m, -r]);
DisplayExpression@NonLinearLagrangian;
LinearLagrangian=NonLinearLagrangian;
LinearLagrangian//=LineariseLagrangian;
DisplayExpression@LinearLagrangian;
LinearLagrangian=LinearLagrangian/.{A->Zero};
DisplayExpression[LinearLagrangian,EqnLabel->"LinearTeleparallel"];
Code[LinearLagrangian,      
	ParticleSpectrum[
		LinearLagrangian,
		TheoryName->"TeleparallelTheory",	
		Method->"Hard",
		MaxLaurentDepth->3
	];
];
Supercomment@"End of script";
Quit[];
Subsection@"Extension to the two-form theory";
Code[
	DefField[B[-a,-b],Antisymmetric[{-a,-b}],PrintAs->"\[ScriptCapitalB]",PrintSourceAs->"\[ScriptCapitalJ]"];
];
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
DisplayExpression@Expr;
Expr=Expr/.DisplaceF;
DisplayExpression@Expr;
Comment@{"Now we apply this to",Cref@"LinearTeleparallel"," to see what the new spectrum is."};
LinearLagrangian=LinearLagrangian/.DisplaceF;
LinearLagrangian//=LineariseLagrangian;
DisplayExpression[LinearLagrangian,EqnLabel->"NewModel"];
Code[LinearLagrangian,      
	ParticleSpectrum[
		LinearLagrangian,
		TheoryName->"TeleparallelTheory",	
		Method->"Hard",
		MaxLaurentDepth->3
	];
];
Subsection@"Extension to kinetic terms";
Comment@"Also define some more coupling constants:";
Code[
	DefConstantSymbol[TwoFormMass,PrintAs->"\!\(\*SuperscriptBox[\(\[ScriptCapitalM]\), \(2\)]\)"];
	DefConstantSymbol[KineticCoupling,PrintAs->"\[Alpha]"];
];
LinearLagrangian+=KineticCoupling*Antisymmetrize[CD[-a]@B[-b,-c],{-a,-b,-c}]*CD[a]@B[b,c]+TwoFormMass*B[-a,-b]*B[a,b];
DisplayExpression[LinearLagrangian,EqnLabel->"TwoFormEectrodynamicsMassive"];
LinearLagrangian//=ToCanonical;
LinearLagrangian//=CollectTensors;
Code[LinearLagrangian,
	ParticleSpectrum[
		LinearLagrangian,
		TheoryName->"TwoFormEectrodynamicsMassive",
		Method->"Easy",
		MaxLaurentDepth->1
	];
];
