(* ::Package:: *)

(*=====================*)
(*  GaugeMapperWGTE  *)
(*=====================*)
(*Here we make functions to map the linearised Lagrangians to their appopriate PSALTer classes*)

WGTEToEinsteinGaugeOriginalVariables=Join[
	MakeRule[{WeylRotationalGaugeField[-a,-b,-c], xAct`PSALTer`WeylEinsteinGaugeTheory`WeylEinsteinRotationalGaugeField[-a,-b,-c]}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{WeylTranslationalGaugeFieldPerturbation[-a,-b], xAct`PSALTer`WeylEinsteinGaugeTheory`WeylEinsteinTranslationalGaugeFieldPerturbation[-a,-b]}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{WeylVector[-i], xAct`PSALTer`WeylEinsteinGaugeTheory`WeylEinsteinVector[-i]}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{lLambda, xAct`PSALTer`WeylEinsteinGaugeTheory`leLambda}, MetricOn -> All, ContractMetrics -> True],	
	MakeRule[{lR1, xAct`PSALTer`WeylEinsteinGaugeTheory`leR1}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{lR2, xAct`PSALTer`WeylEinsteinGaugeTheory`leR2}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{lR3, xAct`PSALTer`WeylEinsteinGaugeTheory`leR3}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{lR4, xAct`PSALTer`WeylEinsteinGaugeTheory`leR4}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{lR5, xAct`PSALTer`WeylEinsteinGaugeTheory`leR5}, MetricOn -> All, ContractMetrics -> True],	
	MakeRule[{lC1, xAct`PSALTer`WeylEinsteinGaugeTheory`leC1}, MetricOn -> All, ContractMetrics -> True],	
	MakeRule[{lT1, xAct`PSALTer`WeylEinsteinGaugeTheory`leT1}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{lT2, xAct`PSALTer`WeylEinsteinGaugeTheory`leT2}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{lT3, xAct`PSALTer`WeylEinsteinGaugeTheory`leT3}, MetricOn -> All, ContractMetrics -> True],	
	MakeRule[{lXi, xAct`PSALTer`WeylEinsteinGaugeTheory`leXi}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{lNu, xAct`PSALTer`WeylEinsteinGaugeTheory`leNu}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{lPhi0, xAct`PSALTer`WeylEinsteinGaugeTheory`lePhi0}, MetricOn -> All, ContractMetrics -> True]
];

WGTEToNaturalVariables=Join[
	MakeRule[{WeylRotationalGaugeField[-a,-b,-c], xAct`PSALTer`WeylNaturalGaugeTheory`WeylNaturalRotationalGaugeField[-a,-b,-c]}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{WeylTranslationalGaugeFieldPerturbation[-a,-b], xAct`PSALTer`WeylNaturalGaugeTheory`WeylNaturalTranslationalGaugeFieldPerturbation[-a,-b]}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{Compensator[], xAct`PSALTer`WeylNaturalGaugeTheory`WeylNaturalCompensator[]}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{lLambda, xAct`PSALTer`WeylNaturalGaugeTheory`lnLambda}, MetricOn -> All, ContractMetrics -> True],	
	MakeRule[{lR1, xAct`PSALTer`WeylNaturalGaugeTheory`lnR1}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{lR2, xAct`PSALTer`WeylNaturalGaugeTheory`lnR2}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{lR3, xAct`PSALTer`WeylNaturalGaugeTheory`lnR3}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{lR4, xAct`PSALTer`WeylNaturalGaugeTheory`lnR4}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{lR5, xAct`PSALTer`WeylNaturalGaugeTheory`lnR5}, MetricOn -> All, ContractMetrics -> True],	
	MakeRule[{lC1, xAct`PSALTer`WeylNaturalGaugeTheory`lnC1}, MetricOn -> All, ContractMetrics -> True],	
	MakeRule[{lT1, xAct`PSALTer`WeylNaturalGaugeTheory`lnT1}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{lT2, xAct`PSALTer`WeylNaturalGaugeTheory`lnT2}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{lT3, xAct`PSALTer`WeylNaturalGaugeTheory`lnT3}, MetricOn -> All, ContractMetrics -> True],	
	MakeRule[{lXi, xAct`PSALTer`WeylNaturalGaugeTheory`lnXi}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{lNu, xAct`PSALTer`WeylNaturalGaugeTheory`lnNu}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{lPhi0, xAct`PSALTer`WeylNaturalGaugeTheory`lnPhi0}, MetricOn -> All, ContractMetrics -> True]
];

WGTEToSIVariables=Join[
	MakeRule[{WeylRotationalGaugeField[-a,-b,-c], xAct`PSALTer`WeylSIVGaugeTheory`WeylSIVRotationalGaugeField[-a,-b,-c]}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{WeylTranslationalGaugeFieldPerturbation[-a,-b], xAct`PSALTer`WeylSIVGaugeTheory`WeylSIVTranslationalGaugeFieldPerturbation[-a,-b]}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{lLambda, xAct`PSALTer`WeylSIVGaugeTheory`lsLambda}, MetricOn -> All, ContractMetrics -> True],	
	MakeRule[{lR1, xAct`PSALTer`WeylSIVGaugeTheory`lsR1}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{lR2, xAct`PSALTer`WeylSIVGaugeTheory`lsR2}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{lR3, xAct`PSALTer`WeylSIVGaugeTheory`lsR3}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{lR4, xAct`PSALTer`WeylSIVGaugeTheory`lsR4}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{lR5, xAct`PSALTer`WeylSIVGaugeTheory`lsR5}, MetricOn -> All, ContractMetrics -> True],	
	MakeRule[{lC1, xAct`PSALTer`WeylSIVGaugeTheory`lsC1}, MetricOn -> All, ContractMetrics -> True],	
	MakeRule[{lT1, xAct`PSALTer`WeylSIVGaugeTheory`lsT1}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{lT2, xAct`PSALTer`WeylSIVGaugeTheory`lsT2}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{lT3, xAct`PSALTer`WeylSIVGaugeTheory`lsT3}, MetricOn -> All, ContractMetrics -> True],	
	MakeRule[{lXi, xAct`PSALTer`WeylSIVGaugeTheory`lsXi}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{lNu, xAct`PSALTer`WeylSIVGaugeTheory`lsNu}, MetricOn -> All, ContractMetrics -> True],
	MakeRule[{lPhi0, xAct`PSALTer`WeylSIVGaugeTheory`lsPhi0}, MetricOn -> All, ContractMetrics -> True]
];

(*==============================*)
(*  Explaining the gauges used  *)
(*==============================*)
Subsection@"Defining natural and scale-invariant variables";

Comment@"The Weyl symmetry in eWGT can be gauge-fixed via the Einstein gauge, c.f. Lasenby and Hobson 2016, mapping";
DisplayExpression[Compensator[]];
Comment@"to";
DisplayExpression[lPhi0];

Comment@"We also consider the mapping that we term as 'perturbation around the Einstein gauge'. This is a reparameterisation of the compensator which does not gauge-fix the Weyl symmetry:";
DisplayExpression[Compensator[]];
DisplayExpression[Compensator[]/.ToOrderCompensatorEinsteinGauge];

Comment@"For clarity, we refer to the original field variables, in which eWGT is initially formulated in, as:";
DisplayExpression[{WeylRotationalGaugeField[-a,-b,-c],WeylTranslationalGaugeFieldPerturbation[-a,-b],WeylVector[-i],Compensator[]}];
Comment@"Lasenby and Hobson 2016 defines the set of natural field variables that eWGT can be reformulated in. This is equivalent to fixing the TSG symmetry by setting B = 0, c.f. Hobson and Lasenby 2021, Phys. Rev. D 103, 104042."
DisplayExpression[{xAct`PSALTer`WeylNaturalGaugeTheory`WeylNaturalRotationalGaugeField[-a,-b,-c],xAct`PSALTer`WeylNaturalGaugeTheory`WeylNaturalTranslationalGaugeFieldPerturbation[-a,-b],xAct`PSALTer`WeylNaturalGaugeTheory`WeylNaturalCompensator[]}];
Comment@"Section III.M of Lasenby and Hobson 2016 also defines the scale-invariant variables, which allows the eWGT Lagrangian to be reformulated to remove the compensator as a field variable:"
DisplayExpression[{xAct`PSALTer`WeylSIVGaugeTheory`WeylSIVRotationalGaugeField[-a,-b,-c],xAct`PSALTer`WeylSIVGaugeTheory`WeylSIVTranslationalGaugeFieldPerturbation[-a,-b]}];
