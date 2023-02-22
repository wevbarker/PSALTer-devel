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
	Print@LinearLagrangian;
	LinearLagrangian=LinearLagrangian/.ExpandStrengths/.ToF;
	Print@LinearLagrangian;
	LinearLagrangian=LinearLagrangian/.ToOrder;
	Print@LinearLagrangian;
	LinearLagrangian//=Series[#,{PerturbativeParameter,0,2}]&;
	Print@LinearLagrangian;
	LinearLagrangian//=Normal;
	Print@LinearLagrangian;
	LinearLagrangian=LinearLagrangian/.PerturbativeParameter->1;
	Print@LinearLagrangian;
	LinearLagrangian=LinearLagrangian/.PActivate;
	Print@LinearLagrangian;
	LinearLagrangian//=ToNewCanonical;
	Print@LinearLagrangian;
LinearLagrangian];
