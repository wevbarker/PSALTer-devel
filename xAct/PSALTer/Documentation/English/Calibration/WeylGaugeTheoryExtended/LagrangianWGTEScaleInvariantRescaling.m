(* ::Package:: *)

(*========================================*)
(*  LagrangianWGTEScaleInvariantRescaling *)
(*========================================*)
Subsection@"Defining natural and scale-invariant variables";

Comment@"The Weyl symmetry in eWGT can be gauge-fixed via the Einstein gauge, c.f. Lasenby and Hobson 2016, mapping";
DisplayExpression[Compensator[]];
Comment@"to";
DisplayExpression[lPhi0];

Comment@"We also consider the mapping that we term as 'perturbation around the Einstein gauge'. This is a reparameterisation of the compensator which does not gauge-fix the Weyl symmetry:";
DisplayExpression[Compensator[]];
DisplayExpression[Compensator[]/.ToOrderCompensatorEinsteinGauge];

Comment@"Hobson and Lasenby 2021, Phys. Rev. D 103, 104042 notes that eWGT possesses a TSG symmetry in addition to Weyl symmetry. Gauge-fixing the TSG symmetry with B = 0 is equivalent to reformulating the eWGT Lagrangian in a set of natural variables as defined in Hobson and Lasenby 2021, Phys. Rev. D 103, 104042. Accordingly, original field variables are those that occur in the (initial) Lagrangian where the TSG symmetry is left unfixed.";
Comment@"Section III.M of Lasenby and Hobson 2016 also defines the scale-invariant variables, which allows the eWGT Lagrangian to be reformulated to remove the compensator as a field variable. The scale-invariant formulation is obtained from the natural-variable formulation. The tetrad";

(*See Section 3M, eqn 199b of Lasenby and Hobson 2016, J. Math. Phys. 57, 092505.*)
WeylWGTEScaleInvariantRescalingBH=Join[	
	MakeRule[{WeylTetrad[-a,c],(Compensator[]/lPhi0)*WeylTetrad[-a,c]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylInvTetrad[a,-c],(lPhi0/Compensator[])*WeylInvTetrad[a,-c]},MetricOn->All,ContractMetrics->True]];

DisplayExpression[WeylTetrad[-a,c]];
Comment@"is mapped to:";
DisplayExpression@CollectTensors@ToCanonical[WeylTetrad[-a,c]/.WeylWGTEScaleInvariantRescalingBH//xAct`PSALTer`Private`ToNewCanonical];
Comment@"The inverse tetrad";
DisplayExpression[WeylInvTetrad[a,-c]];
Comment@"is mapped to:";
DisplayExpression@CollectTensors@ToCanonical[WeylInvTetrad[a,-c]/.WeylWGTEScaleInvariantRescalingBH//xAct`PSALTer`Private`ToNewCanonical];
Comment@"The natural-variable A-field is equivalent to the scale-invariant A-field.";

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
DisplayExpression[LinearisedLagrangianWGTESIV,EqnLabel->"WGTESIVExpanded"];

Comment@"This is the linearised Lagrangian in natural variables and using the Einstein gauge:";
LinearisedLagrangianWGTENat=LinearisedLagrangianWGTEOriginal/.{WeylVector->Zero}/.{Compensator->Zero};(*Nat2,EG4*)
DisplayExpression[LinearisedLagrangianWGTENat,EqnLabel->"WGTENatExpanded"];

DiffLagrangianWGTENatSIV=LinearisedLagrangianWGTESIV-LinearisedLagrangianWGTENat;
DiffLagrangianWGTENatSIV//=xAct`PSALTer`Private`ToNewCanonical;
DiffLagrangianWGTENatSIV//=CollectTensors;
Comment@"This is the difference between the two Lagrangians. We can clearly see that they are the same.";
DisplayExpression[DiffLagrangianWGTENatSIV];
