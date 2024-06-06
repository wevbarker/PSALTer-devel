(* ::Package:: *)

(*========================================*)
(*  LagrangianWGTEScaleInvariantRescaling *)
(*========================================*)

(*See Section 3M, eqn 199b of Lasenby and Hobson 2016, J. Math. Phys. 57, 092505.*)
WeylWGTEScaleInvariantRescalingBH=Join[	
	MakeRule[{WeylTetrad[-a,c],(Compensator[]/lPhi0)*WeylTetrad[-a,c]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylInvTetrad[a,-c],(lPhi0/Compensator[])*WeylInvTetrad[a,-c]},MetricOn->All,ContractMetrics->True]
];

Comment@"The scale-invariant formulation is obtained from the natural-variable formulation. The tetrad";
DisplayExpression[WeylTetrad[-a,c]];
Comment@"is mapped to:";
DisplayExpression@CollectTensors@ToCanonical[WeylTetrad[-a,c]/.WeylWGTEScaleInvariantRescalingBH//xAct`PSALTer`Private`ToNewCanonical];
Comment@"The inverse tetrad";
DisplayExpression[WeylInvTetrad[a,-c]];
Comment@"is mapped to:";
DisplayExpression@CollectTensors@ToCanonical[WeylInvTetrad[a,-c]/.WeylWGTEScaleInvariantRescalingBH//xAct`PSALTer`Private`ToNewCanonical];
Comment@"The natural-variable A-field";
DisplayExpression[xAct`PSALTer`WeylNaturalGaugeTheory`WeylNaturalRotationalGaugeField[-a,-b,-c]];
Comment@"is equivalent to the scale-invariant A-field";
DisplayExpression[xAct`PSALTer`WeylSIVGaugeTheory`WeylSIVRotationalGaugeField[-a,-b,-c]];

(*==============================================*)
(*  Constructing and linearising the Lagrangian *)
(*==============================================*)

LineariseLagrangianWGTESIV[NonlinearLagrangianLinWeyl_]:=Module[{LinearLagrangianLinWeyl=NonlinearLagrangianLinWeyl},
	LinearLagrangianLinWeyl*=((1-WeylTranslationalGaugeFieldPerturbation[z,-z])*((lPhi0/Compensator[])^4));(*Scaling of the h^-1 determinant*)	
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.WeyDaggerTHCovDtoBaseTWeylVectorHBAndDaggerRtoDaggerA;
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.WeylDaggerABaseTtoAHBWeylVector;
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.{WeylVector->Zero};
	
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.WeylWGTEScaleInvariantRescalingBH;
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.RescaleEinsteinGaugeCoupling;
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.xAct`PSALTer`WeylGaugeTheoryExtended`Private`WeylHBFieldToGF;
		
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.ToOrderWeyl;
	LinearLagrangianLinWeyl//=Series[#,{PerturbativeParameterWeyl,0,2}]&;
	LinearLagrangianLinWeyl//=Normal;
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.PerturbativeParameterWeyl->1;	
	LinearLagrangianLinWeyl//=xAct`PSALTer`Private`ToNewCanonical;
	LinearLagrangianLinWeyl//=CollectTensors;	
LinearLagrangianLinWeyl];

(*================================================*)
(*  Comparing SIV Lagrangian to nat.variables, EG *)
(*================================================*)
Comment@"We notice that formulating the free Lagrangian in scale-invariant variables is the same as formulating in natural variables and setting the Einstein gauge. This is the linearised free scale-invariant-variable Lagrangian:";
LinearisedLagrangianWGTESIV=LineariseLagrangianWGTESIV[NonlinearLagrangianWGTEOriginal];
DisplayExpression[LinearisedLagrangianWGTESIV/.WGTEToSIVariables,EqnLabel->"WGTESIVExpanded"];

Comment@"This is the linearised Lagrangian in natural variables and using the Einstein gauge:";
LinearisedLagrangianWGTENat=LinearisedLagrangianWGTEOriginal/.{WeylVector->Zero}/.{Compensator->Zero};(*Nat2,EG4*)
DisplayExpression[LinearisedLagrangianWGTENat/.WGTEToNaturalVariables,EqnLabel->"WGTENatExpanded"];

DiffLagrangianWGTENatSIV=LinearisedLagrangianWGTESIV-LinearisedLagrangianWGTENat;
DiffLagrangianWGTENatSIV//=xAct`PSALTer`Private`ToNewCanonical;
DiffLagrangianWGTENatSIV//=CollectTensors;
Comment@"This is the difference between the two Lagrangians. We can clearly see that they are the same.";
DisplayExpression[DiffLagrangianWGTENatSIV];
