(*=============*)
(*  Linearise  *)
(*=============*)

DefConstantSymbol[PerturbativeParameter,PrintAs->"\[Epsilon]"];
ToOrderA = MakeRule[{A[-a, -b, -c], PerturbativeParameter A[-a, -b, -c]}, 
	MetricOn -> All, ContractMetrics -> True];
ToOrderF = MakeRule[{F[-a, -b], PerturbativeParameter F[-a, -b]}, 
	MetricOn -> All, ContractMetrics -> True];
ToOrder = Join[ToOrderA, ToOrderF];

LineariseLagrangian[NonlinearLagrangian_]:=Module[{LinearLagrangian=NonlinearLagrangian},	
	LinearLagrangian=LinearLagrangian/.ExpandStrengths/.ToF;
	LinearLagrangian=LinearLagrangian/.ToOrder;
	LinearLagrangian//=Series[#,{PerturbativeParameter,0,2}]&;
	LinearLagrangian//=Normal;
	LinearLagrangian=LinearLagrangian/.PerturbativeParameter->1;
	LinearLagrangian=LinearLagrangian/.PActivate;
	LinearLagrangian//=ToNewCanonical;
LinearLagrangian];
