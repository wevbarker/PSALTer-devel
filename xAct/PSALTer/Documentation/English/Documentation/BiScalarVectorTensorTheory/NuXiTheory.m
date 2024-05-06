(*==============*)
(*  NuXiTheory  *)
(*==============*)

Subsection@"With Nu and Xi";
DefTensor[NonlinearMetric[a,b],M4,Symmetric[{a,b}],PrintAs->"\[ScriptG]"];
DefTensor[NonlinearMeasure[],M4,PrintAs->"sG"];
LinearisedLagrangian=Sqrt[-NonlinearMeasure[]]*(
-(1/4)*NonlinearMetric[a,c]*NonlinearMetric[b,d]*CouplingXi*(CD[-a]@B[-b]-CD[-b]@B[-a])*(CD[-c]@B[-d]-CD[-d]@B[-c])
+(1/2)*NonlinearMetric[a,b]*(CD[-a]@VarPhi[]-VarPhi[]*B[-a])*(CD[-b]@VarPhi[]-VarPhi[]*B[-b])
+(1/2)*NonlinearMetric[a,b]*CouplingSigma*(CD[-a]@VarPhi[]-VarPhi[]*B[-a])*(CD[-b]@Phi[]-Phi[]*B[-b])
+(1/2)*NonlinearMetric[a,b]*CouplingNu*(CD[-a]@Phi[]-Phi[]*B[-a])*(CD[-b]@Phi[]-Phi[]*B[-b])
-(1/2)*CouplingMu^2*Phi[]^2*VarPhi[]^2
);
DisplayExpression[LinearisedLagrangian,EqnLabel->"NuXiTheory"];
DefConstantSymbol[PerturbativeParameter,PrintAs->"\[Epsilon]"];
NonlinearMetricRule=MakeRule[{NonlinearMetric[a,b],G[a,b]-PerturbativeParameter*LinearMetric[a,b]},MetricOn->All,ContractMetrics->True];
NonlinearMeasureRule=MakeRule[{NonlinearMeasure[],-1+PerturbativeParameter*LinearMetric[-a,a]},MetricOn->All,ContractMetrics->True];
TotalRules=Join[NonlinearMetricRule,NonlinearMeasureRule,{
Phi[]->CouplingPhi0+PerturbativeParameter*Phi[],
VarPhi[]->PerturbativeParameter*VarPhi[],
B[Anything___]->PerturbativeParameter*B[Anything]
}];
LinearisedLagrangian=LinearisedLagrangian/.TotalRules;
LinearisedLagrangian//=Series[#,{PerturbativeParameter,0,2}]&;
LinearisedLagrangian//=Normal;
LinearisedLagrangian=LinearisedLagrangian/.PerturbativeParameter->1;
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
DisplayExpression[LinearisedLagrangian,EqnLabel->"NuXiTheory"];
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"NuXiTheory",	
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
Comment@"This result was used in a manuscript in preparation.";
