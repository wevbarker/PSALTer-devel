(* ::Package:: *)

(*========================================*)
(*  LineariseWGTEScaleInvariantRescaling  *)
(*========================================*)

LineariseLagrangianWGTEScaleInvariantRescaling[NonlinearLagrangianLinWeyl_]:=Module[{LinearLagrangianLinWeyl=NonlinearLagrangianLinWeyl},	
	LinearLagrangianLinWeyl*=(1-WeylTranslationalGaugeFieldPerturbation[z,-z])(*Here we must rename F*);
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.xAct`PSALTer`WeylGaugeTheoryExtended`Private`WeylHBFieldToGF;
	(*Print@"I want to check the outputs to f field";
	DisplayExpression@CollectTensors@ToCanonical[LinearLagrangianLinWeyl];*)
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.ToOrderWeyl;
	(*Print@"I want to check the outputs to order epsilon";
	DisplayExpression@CollectTensors@ToCanonical[LinearLagrangianLinWeyl];*)
	LinearLagrangianLinWeyl//=Series[#,{PerturbativeParameterWeyl,0,2}]&;
	LinearLagrangianLinWeyl//=Normal;
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.PerturbativeParameterWeyl->1;
	LinearLagrangianLinWeyl//=xAct`PSALTer`Private`ToNewCanonical;	
LinearLagrangianLinWeyl];
