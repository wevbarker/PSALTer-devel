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

(*=========================*)
(*  Linearisation routine  *)
(*=========================*)

LineariseLagrangianWGTE[NonlinearLagrangianLinWeyl_]:=Module[{LinearLagrangianLinWeyl=NonlinearLagrangianLinWeyl},
	Print@"Diagnostic: linearisation routine called on to linearise eWGT Lagrangian w.r.t. original variables.";
	LinearLagrangianLinWeyl*=(1-WeylTranslationalGaugeFieldPerturbation[z,-z])(*Here we must rename F*);
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.WeyDaggerTHCovDtoBaseTWeylVectorHBAndDaggerRtoDaggerA;
	(*Print@"Diagnostic: successfully expanded to A+ fields.";*)
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.WeylDaggerABaseTtoAHBWeylVector;
	(*Print@"Diagnostic: successfully expanded to h,b,A,B fields.";*)
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.xAct`PSALTer`WeylGaugeTheoryExtended`Private`WeylHBFieldToGF;
	(*Print@"Diagnostic: successfully expanded to f field.";*)	
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.ToOrderWeyl;
	(*Print@"Diagnostic: successfully tagged with epsilon.";*)
	LinearLagrangianLinWeyl//=Series[#,{PerturbativeParameterWeyl,0,2}]&;
	LinearLagrangianLinWeyl//=Normal;
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.PerturbativeParameterWeyl->1;
	(*Print@"Diagnostic: series successfully truncated. The rest is window-dressing.";*)
	(*Here we do the coupling rescalings*)
	Print@xAct`PSALTer`WeylGaugeTheoryExtended`Private`RescaleEinsteinGaugeCouplingCommentWGTE;
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.RescaleEinsteinGaugeCoupling;
	LinearLagrangianLinWeyl//=xAct`PSALTer`Private`ToNewCanonical;
	LinearLagrangianLinWeyl//=CollectTensors;
	Print@"Diagnostic: linearised Lagrangian generated successfully!";	
LinearLagrangianLinWeyl];

LinearisedLagrangianWGTEOriginal=LineariseLagrangianWGTE[NonlinearLagrangianWGTEOriginal];
Comment@{"Diagnostic: We have linearised the original eWGT Lagrangian and stored it for later use."};
(*DisplayExpression[LinearisedLagrangianWGTEOriginal,EqnLabel->"WGTEOriginalExpanded"];*)

Comment@"For the original (A,f,B,\[Phi]) variables to natural variables (A+,f,\[Phi]), this is accomplished by setting B to 0. This is the TSG symmetry; see footnote 4, Hobson and Lasenby 2021, Phys. Rev. D 103, 104042.";
Comment@"At the free Lagrangian level, SIV variables are equivalent to using natural variables + Einstein gauge. The following section (loaded optionally) shows this.";
