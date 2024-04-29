(* ::Package:: *)

(*==================*)
(*  LineariseWGTE  *)
(*==================*)
(*===============*)
(*  ToOrderWeyl  *)
(*===============*)

Off[ValidateSymbol::used];
DefConstantSymbol[PerturbativeParameterWeyl,PrintAs->"\[Epsilon]"];
On[ValidateSymbol::used];

ToOrderAWeyl = MakeRule[{WeylRotationalGaugeField[-a, -b, -c], PerturbativeParameterWeyl*WeylRotationalGaugeField[-a, -b, -c]}, 
	MetricOn -> All, ContractMetrics -> True];

ToOrderFWeyl = MakeRule[{WeylTranslationalGaugeFieldPerturbation[-a, -b], PerturbativeParameterWeyl*WeylTranslationalGaugeFieldPerturbation[-a, -b]}, 
	MetricOn -> All, ContractMetrics -> True];

ToOrderWeylVector = MakeRule[{WeylVector[-i], PerturbativeParameterWeyl*WeylVector[-i]}, 
	MetricOn -> All, ContractMetrics -> True];

(*Perturbative version of Einstein gauge, here I am making the compensator dimensionless i.e. any possible masses order 1. I do this to prevent any denominators phi/phi0.*)
ToOrderCompensatorEinsteinGauge = MakeRule[{Compensator[], lPhi0*(Scalar[1] + PerturbativeParameterWeyl*Compensator[])}, MetricOn -> All, ContractMetrics -> True];

ToOrderWeyl = Join[ToOrderAWeyl, ToOrderFWeyl, ToOrderWeylVector, ToOrderCompensatorEinsteinGauge];

(*We rescale the constants after applying Einstein gauge or SIV transformation*)
RescaleLLambda = MakeRule[{lLambda, lLambda*lPhi0^(-2)},MetricOn -> All, ContractMetrics -> True];
RescaleLNu = MakeRule[{lNu, lNu*lPhi0^(-2)},MetricOn -> All, ContractMetrics -> True];
RescaleLT1 = MakeRule[{lT1, lT1*lPhi0^(-2)},MetricOn -> All, ContractMetrics -> True];
RescaleLT2 = MakeRule[{lT2, lT2*lPhi0^(-2)},MetricOn -> All, ContractMetrics -> True];
RescaleLT3 = MakeRule[{lT3, lT3*lPhi0^(-2)},MetricOn -> All, ContractMetrics -> True];

RescaleEinsteinGaugeCoupling = Join[RescaleLLambda,RescaleLNu,RescaleLT1,RescaleLT2,RescaleLT3];

Comment@"In order to accommodate the Einstein gauge and also the scale-invariant variables, the coefficients";
xAct`PSALTer`WeylGaugeTheoryExtended`Private`RescaleEinsteinGaugeCouplingListOfConstants={lLambda,lNu,lT1,lT2,lT3};
DisplayExpression[xAct`PSALTer`WeylGaugeTheoryExtended`Private`RescaleEinsteinGaugeCouplingListOfConstants];
Comment@"are mapped (rescaled) to:";
DisplayExpression@ToCanonical[xAct`PSALTer`WeylGaugeTheoryExtended`Private`RescaleEinsteinGaugeCouplingListOfConstants/.RescaleEinsteinGaugeCoupling];

(*=========================*)
(*  Linearisation routine  *)
(*=========================*)

LineariseLagrangianWGTE[NonlinearLagrangianLinWeyl_]:=Module[{LinearLagrangianLinWeyl=NonlinearLagrangianLinWeyl},
	LinearLagrangianLinWeyl*=(1-WeylTranslationalGaugeFieldPerturbation[z,-z])(*Here we must rename F*);
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.WeyDaggerTHCovDtoBaseTWeylVectorHBAndDaggerRtoDaggerA;
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.WeylDaggerABaseTtoAHBWeylVector;	
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.xAct`PSALTer`WeylGaugeTheoryExtended`Private`WeylHBFieldToGF;
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.ToOrderWeyl;
	LinearLagrangianLinWeyl//=Series[#,{PerturbativeParameterWeyl,0,2}]&;
	LinearLagrangianLinWeyl//=Normal;
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.PerturbativeParameterWeyl->1;
	(*Here we do the coupling rescalings*)
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.RescaleEinsteinGaugeCoupling;
	LinearLagrangianLinWeyl//=xAct`PSALTer`Private`ToNewCanonical;
	LinearLagrangianLinWeyl//=CollectTensors;
LinearLagrangianLinWeyl];

LinearisedLagrangianWGTEOriginal=LineariseLagrangianWGTE[NonlinearLagrangianWGTEOriginal];
