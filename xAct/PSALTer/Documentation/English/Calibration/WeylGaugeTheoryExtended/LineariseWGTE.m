(* ::Package:: *)

(*==================*)
(*  LineariseWGTE  *)
(*==================*)

LineariseLagrangianWGTE[NonlinearLagrangianLinWeyl_]:=Module[{LinearLagrangianLinWeyl=NonlinearLagrangianLinWeyl},
	LinearLagrangianLinWeyl*=(1-WeylTranslationalGaugeFieldPerturbation[z,-z])(*Here we must rename F*);
	(*
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.WeyDaggerTHCovDtoBaseTWeylVectorHBAndDaggerRtoDaggerA;
	LinearLagrangianLinWeyl//=xAct`PSALTer`Private`ToNewCanonical;
	(*Print@"I want to check the outputs to A+ fields";
	DisplayExpression@CollectTensors@ToCanonical[LinearLagrangianLinWeyl];*)
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.WeylDaggerABaseTtoAHBWeylVector;
	LinearLagrangianLinWeyl//=xAct`PSALTer`Private`ToNewCanonical;			
	(*Print@"I want to check the outputs to h,b,A fields";
	DisplayExpression@CollectTensors@ToCanonical[LinearLagrangianLinWeyl];*)
	*)
	(*In new version of the code, expansion to A,h,B done at the non-linear level. Only need to start from h,b to f expansion.*)
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.xAct`PSALTer`WeylGaugeTheoryExtended`Private`WeylHBFieldToGF;
	(*Print@"I want to check the outputs to f field";
	DisplayExpression@CollectTensors@ToCanonical[LinearLagrangianLinWeyl];*)
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.ToOrderWeyl;
	(*Print@"I want to check the outputs to order epsilon";
	DisplayExpression@CollectTensors@ToCanonical[LinearLagrangianLinWeyl];*)
	LinearLagrangianLinWeyl//=Series[#,{PerturbativeParameterWeyl,0,2}]&;
	LinearLagrangianLinWeyl//=Normal;
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.PerturbativeParameterWeyl->1;
	(*Here we do the coupling rescalings*)
	Print@xAct`PSALTer`WeylGaugeTheoryExtended`Private`RescaleEinsteinGaugeCouplingCommentWGTE;
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.RescaleEinsteinGaugeCoupling;
	LinearLagrangianLinWeyl//=xAct`PSALTer`Private`ToNewCanonical;	
LinearLagrangianLinWeyl];
