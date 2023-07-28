(* ::Package:: *)

(*=============*)
(*  LineariseLinWeyl  *)
(*=============*)

Off[ValidateSymbol::used];
DefConstantSymbol[PerturbativeParameterWeyl,PrintAs->"\[Epsilon]"];
On[ValidateSymbol::used];

ToOrderAWeyl = MakeRule[{A[-a, -b, -c], PerturbativeParameterWeyl A[-a, -b, -c]}, 
	MetricOn -> All, ContractMetrics -> True];

ToOrderFWeyl = MakeRule[{F[-a, -b], PerturbativeParameterWeyl F[-a, -b]}, 
	MetricOn -> All, ContractMetrics -> True];

ToOrderWeylVector = MakeRule[{WeylVector[-i], PerturbativeParameterWeyl WeylVector[-i]}, 
	MetricOn -> All, ContractMetrics -> True];

ToOrderCompensator = MakeRule[{Compensator[], PerturbativeParameterWeyl Compensator[]}, 
	MetricOn -> All, ContractMetrics -> True];	
	
ToOrderWeyl = Join[ToOrderAWeyl, ToOrderFWeyl, ToOrderWeylVector, ToOrderCompensator];

LineariseLagrangianLinWeyl[NonlinearLagrangianLinWeyl_]:=Module[{LinearLagrangianLinWeyl=NonlinearLagrangianLinWeyl},	
	LinearLagrangianLinWeyl*=(1-F[z,-z]);
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.xAct`PSALTer`WeylGaugeTheory`Private`RTToHBACDBCDA;
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.xAct`PSALTer`WeylGaugeTheory`Private`HBToGF;
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.ToOrderWeyl;
	LinearLagrangianLinWeyl//=Series[#,{PerturbativeParameterWeyl,0,2}]&;
	LinearLagrangianLinWeyl//=Normal;
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.PerturbativeParameterWeyl->1;
	LinearLagrangianLinWeyl//=xAct`PSALTer`Private`ToNewCanonical;
LinearLagrangianLinWeyl];
