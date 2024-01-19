(* ::Package:: *)

(*===============================*)
(*  ToOrderWeylAndRescalingWGTE  *)
(*===============================*)

Off[ValidateSymbol::used];
DefConstantSymbol[PerturbativeParameterWeyl,PrintAs->"\[Epsilon]"];
On[ValidateSymbol::used];

ToOrderAWeyl = MakeRule[{WeylRotationalGaugeField[-a, -b, -c], PerturbativeParameterWeyl*WeylRotationalGaugeField[-a, -b, -c]}, 
	MetricOn -> All, ContractMetrics -> True];

ToOrderFWeyl = MakeRule[{WeylTranslationalGaugeFieldPerturbation[-a, -b], PerturbativeParameterWeyl*WeylTranslationalGaugeFieldPerturbation[-a, -b]}, 
	MetricOn -> All, ContractMetrics -> True];

ToOrderWeylVector = MakeRule[{WeylVector[-i], PerturbativeParameterWeyl*WeylVector[-i]}, 
	MetricOn -> All, ContractMetrics -> True];

(*To incoporate Einstein Gauge of Lin's paper*)
(*ToOrderCompensatorEinsteinGauge = MakeRule[{Compensator[], Scalar[lPhi0]}, MetricOn -> All, ContractMetrics -> True];*)
(*Perturbative version of the gauge, here I am making the compensator dimensionless i.e. any possible masses order 1. I do this to prevent any denominators phi/phi0.*)
ToOrderCompensatorEinsteinGauge = MakeRule[{Compensator[], lPhi0*(Scalar[1] + PerturbativeParameterWeyl*Compensator[])}, MetricOn -> All, ContractMetrics -> True];

ToOrderWeyl = Join[ToOrderAWeyl, ToOrderFWeyl, ToOrderWeylVector, ToOrderCompensatorEinsteinGauge];
(*I want to check the outputs*)
Print@"I want to check the outputs for Einstein Gauge perturbation.";
DisplayExpression[Compensator[]/.ToOrderWeyl];

(*This is a rescaling of the constants after Einstein gauge*)
xAct`PSALTer`WeylGaugeTheoryExtended`Private`RescaleEinsteinGaugeCouplingCommentWGTE = 
	"Here, we perform rescalings after application of Einstein Gauge: \[Phi]_0^2*\[Lambda] -> \[Lambda], \[Phi]_0^2*\[Nu] -> \[Nu], \[Phi]_0^2*t_i -> t_i. Also \[Phi]_0 -> 1, i.e. here I am making the compensator dimensionless, any possible masses order 1. I do this to prevent any denominators phi/phi0.";

RescaleLLambda = MakeRule[{lLambda, lLambda*lPhi0^(-2)},MetricOn -> All, ContractMetrics -> True];
RescaleLNu = MakeRule[{lNu, lNu*lPhi0^(-2)},MetricOn -> All, ContractMetrics -> True];
RescaleLT1 = MakeRule[{lT1, lT1*lPhi0^(-2)},MetricOn -> All, ContractMetrics -> True];
RescaleLT2 = MakeRule[{lT2, lT2*lPhi0^(-2)},MetricOn -> All, ContractMetrics -> True];
RescaleLT3 = MakeRule[{lT3, lT3*lPhi0^(-2)},MetricOn -> All, ContractMetrics -> True];

RescaleEinsteinGaugeCoupling = Join[RescaleLLambda,RescaleLNu,RescaleLT1,RescaleLT2,RescaleLT3];
