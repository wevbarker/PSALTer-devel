(*==============*)
(*  NuXiTheory  *)
(*==============*)

Section@"With Nu and Xi";

DefTensor[NonlinearMetric[a,b],M4,Symmetric[{a,b}],PrintAs->"\[ScriptG]"];
DefTensor[NonlinearMeasure[],M4,PrintAs->"sG"];

LinearisedLagrangian=Sqrt[-NonlinearMeasure[]]*(
-(1/4)*NonlinearMetric[a,c]*NonlinearMetric[b,d]*xAct`PSALTer`BiScalarVectorTensorTheory`CouplingXi*(CD[-a]@xAct`PSALTer`BiScalarVectorTensorTheory`B[-b]-CD[-b]@xAct`PSALTer`BiScalarVectorTensorTheory`B[-a])*(CD[-c]@xAct`PSALTer`BiScalarVectorTensorTheory`B[-d]-CD[-d]@xAct`PSALTer`BiScalarVectorTensorTheory`B[-c])
+(1/2)*NonlinearMetric[a,b]*(CD[-a]@xAct`PSALTer`BiScalarVectorTensorTheory`VarPhi[]-xAct`PSALTer`BiScalarVectorTensorTheory`VarPhi[]*xAct`PSALTer`BiScalarVectorTensorTheory`B[-a])*(CD[-b]@xAct`PSALTer`BiScalarVectorTensorTheory`VarPhi[]-xAct`PSALTer`BiScalarVectorTensorTheory`VarPhi[]*xAct`PSALTer`BiScalarVectorTensorTheory`B[-b])
+(1/2)*NonlinearMetric[a,b]*xAct`PSALTer`BiScalarVectorTensorTheory`CouplingNu*(CD[-a]@xAct`PSALTer`BiScalarVectorTensorTheory`Phi[]-xAct`PSALTer`BiScalarVectorTensorTheory`Phi[]*xAct`PSALTer`BiScalarVectorTensorTheory`B[-a])*(CD[-b]@xAct`PSALTer`BiScalarVectorTensorTheory`Phi[]-xAct`PSALTer`BiScalarVectorTensorTheory`Phi[]*xAct`PSALTer`BiScalarVectorTensorTheory`B[-b])
-(1/2)*xAct`PSALTer`BiScalarVectorTensorTheory`CouplingMu^2*xAct`PSALTer`BiScalarVectorTensorTheory`Phi[]^2*xAct`PSALTer`BiScalarVectorTensorTheory`VarPhi[]^2
);

DisplayExpression[LinearisedLagrangian,EqnLabel->"NuXiTheory"];
DefConstantSymbol[PerturbativeParameter,PrintAs->"\[Epsilon]"];
NonlinearMetricRule=MakeRule[{NonlinearMetric[a,b],G[a,b]-PerturbativeParameter*xAct`PSALTer`BiScalarVectorTensorTheory`LinearMetric[a,b]},MetricOn->All,ContractMetrics->True];
NonlinearMeasureRule=MakeRule[{NonlinearMeasure[],-1+PerturbativeParameter*xAct`PSALTer`BiScalarVectorTensorTheory`LinearMetric[-a,a]},MetricOn->All,ContractMetrics->True];

TotalRules=Join[NonlinearMetricRule,NonlinearMeasureRule,{
xAct`PSALTer`BiScalarVectorTensorTheory`Phi[]->xAct`PSALTer`BiScalarVectorTensorTheory`CouplingPhi0+PerturbativeParameter*xAct`PSALTer`BiScalarVectorTensorTheory`Phi[],
xAct`PSALTer`BiScalarVectorTensorTheory`VarPhi[]->PerturbativeParameter*xAct`PSALTer`BiScalarVectorTensorTheory`VarPhi[],
(*xAct`PSALTer`BiScalarVectorTensorTheory`VarPhi[]->xAct`PSALTer`BiScalarVectorTensorTheory`CouplingVarPhi0+PerturbativeParameter*xAct`PSALTer`BiScalarVectorTensorTheory`VarPhi[],*)
xAct`PSALTer`BiScalarVectorTensorTheory`B[Anything___]->PerturbativeParameter*xAct`PSALTer`BiScalarVectorTensorTheory`B[Anything]
}];
LinearisedLagrangian=LinearisedLagrangian/.TotalRules;

LinearisedLagrangian//=Series[#,{PerturbativeParameter,0,2}]&;
LinearisedLagrangian//=Normal;
LinearisedLagrangian=LinearisedLagrangian/.PerturbativeParameter->1;
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;

DisplayExpression[LinearisedLagrangian,EqnLabel->"NuXiTheory"];
(*
LinearisedLagrangian=LinearisedLagrangian/.{xAct`PSALTer`BiScalarVectorTensorTheory`CouplingMu->1,xAct`PSALTer`BiScalarVectorTensorTheory`CouplingNu->1,xAct`PSALTer`BiScalarVectorTensorTheory`CouplingVarPhi0->0};
*)
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;

DisplayExpression[LinearisedLagrangian,EqnLabel->"NuXiTheory"];

ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"BiScalarVectorTensorTheory",
	TheoryName->"NuXiTheory",	
	Method->"Hard",
	MaxLaurentDepth->3
];
Comment@"Some comment can be made.";
