(*=============*)
(*  Linearise  *)
(*=============*)

Off[ValidateSymbol::used];
DefConstantSymbol[PerturbativeParameter,PrintAs->"\[Epsilon]"];
On[ValidateSymbol::used];
ToOrderA = MakeRule[{SpinConnection[-a, -b, -c], PerturbativeParameter SpinConnection[-a, -b, -c]}, 
	MetricOn -> All, ContractMetrics -> True];
ToOrderF = MakeRule[{TetradPerturbation[-a, -b], PerturbativeParameter TetradPerturbation[-a, -b]}, 
	MetricOn -> All, ContractMetrics -> True];
ToOrder = Join[ToOrderA, ToOrderF];

LineariseLagrangian[NonlinearLagrangian_]:=Module[{LinearLagrangian=NonlinearLagrangian},	
	LinearLagrangian*=(1-TetradPerturbation[z,-z]);
	LinearLagrangian=LinearLagrangian/.RTToHBFieldACDBFieldCDA;
	LinearLagrangian=LinearLagrangian/.HBFieldToGF;
	LinearLagrangian=LinearLagrangian/.ToOrder;
	LinearLagrangian//=Series[#,{PerturbativeParameter,0,2}]&;
	LinearLagrangian//=Normal;
	LinearLagrangian=LinearLagrangian/.PerturbativeParameter->1;
	LinearLagrangian//=xAct`PSALTer`Private`ToNewCanonical;
LinearLagrangian];
