(* ::Package:: *)

(*========================================*)
(*  LagrangianWGTEScaleInvariantRescaling *)
(*========================================*)

Section@"Setting out and linearising the eWGT Lagrangian (nonlinear) in scale-invariant variables, A+_hat, h_hat";

(*See Section 3M, eqn 199b of Lasenby and Hobson 2016, J. Math. Phys. 57, 092505.*)
WeylWGTEScaleInvariantRescalingBH=Join[	
	MakeRule[{WeylTetrad[-a,c],(Compensator[]/lPhi0)*WeylTetrad[-a,c]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylInvTetrad[a,-c],(lPhi0/Compensator[])*WeylInvTetrad[a,-c]},MetricOn->All,ContractMetrics->True]
];

Comment@"We present the 'scale-invariant' variable redefinitions as in Section 3M of Lasenby and Hobson 2016, J. Math. Phys. 57, 092505.";
Comment@"N.B. the SIV reparametrisation only works in the natural variables, i.e. TSG gauge B=0.";

Print@"Eqn. 199b, tetrad h in terms of h_hat:";
DisplayExpression@CollectTensors@ToCanonical[WeylTetrad[-a,c]/.WeylWGTEScaleInvariantRescalingBH//xAct`PSALTer`Private`ToNewCanonical];
Print@"Inverse tetrad b in terms of b_hat:";
DisplayExpression@CollectTensors@ToCanonical[WeylInvTetrad[a,-c]/.WeylWGTEScaleInvariantRescalingBH//xAct`PSALTer`Private`ToNewCanonical];

(*==============================================*)
(*  Constructing and linearising the Lagrangian *)
(*==============================================*)

LineariseLagrangianWGTESIV[NonlinearLagrangianLinWeyl_]:=Module[{LinearLagrangianLinWeyl=NonlinearLagrangianLinWeyl},
	Print@"Diagnostic: linearisation routine called on to linearise eWGT Lagrangian w.r.t. SIV variables.";
	LinearLagrangianLinWeyl*=((1-WeylTranslationalGaugeFieldPerturbation[z,-z])*((lPhi0/Compensator[])^4));(*Scaling of the h^-1 determinant*)	
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.WeyDaggerTHCovDtoBaseTWeylVectorHBAndDaggerRtoDaggerA;
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.WeylDaggerABaseTtoAHBWeylVector;
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.{WeylVector->Zero};
	Print@"Diagnostic: successfully expanded to h,b fields. Natural variables A(+), B=0.";
	
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.WeylWGTEScaleInvariantRescalingBH;
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.RescaleEinsteinGaugeCoupling;
	Print@"Diagnostic: successful SIV reparam for b,h. Here, we perform coeff. rescalings: \[Phi]_0^2*\[Lambda] -> \[Lambda], \[Phi]_0^2*\[Nu] -> \[Nu], \[Phi]_0^2*t_i -> t_i.";
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.xAct`PSALTer`WeylGaugeTheoryExtended`Private`WeylHBFieldToGF;
	(*Print@"Diagnostic: successfully expanded to f field.";*)
		
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.ToOrderWeyl;
	LinearLagrangianLinWeyl//=Series[#,{PerturbativeParameterWeyl,0,2}]&;
	LinearLagrangianLinWeyl//=Normal;
	LinearLagrangianLinWeyl=LinearLagrangianLinWeyl/.PerturbativeParameterWeyl->1;	
	LinearLagrangianLinWeyl//=xAct`PSALTer`Private`ToNewCanonical;
	LinearLagrangianLinWeyl//=CollectTensors;
	Print@"Diagnostic: linearised SIV Lagrangian generated successfully!";	
LinearLagrangianLinWeyl];

(*================================================*)
(*  Comparing SIV Lagrangian to nat.variables, EG *)
(*================================================*)
Comment@"Whatever the meaning of the SIV variables, at the free Lagrangian level, it is equivalent to using natural variables (A+,f) and taking the Einstein gauge (Phi0). We demostrate:";

Comment@"This is the linearised free SIV Lagrangian:";
LinearisedLagrangianWGTESIV=LineariseLagrangianWGTESIV[NonlinearLagrangianWGTEOriginal];
DisplayExpression[LinearisedLagrangianWGTESIV/.WGTEToSIVariables,EqnLabel->"WGTESIVExpanded"];

Comment@"This is the linearised Lagrangian, natural variables, Einstein gauge:";
LinearisedLagrangianWGTENat=LinearisedLagrangianWGTEOriginal/.{WeylVector->Zero}/.{Compensator->Zero};(*Nat2,EG4*)
DisplayExpression[LinearisedLagrangianWGTENat/.WGTEToNaturalVariables,EqnLabel->"WGTENatExpanded"];

DiffLagrangianWGTENatSIV=LinearisedLagrangianWGTESIV-LinearisedLagrangianWGTENat;
DiffLagrangianWGTENatSIV//=xAct`PSALTer`Private`ToNewCanonical;
DiffLagrangianWGTENatSIV//=CollectTensors;
Comment@"This is the difference between the two Lagrangians. We can clearly see that they are equal!";
DisplayExpression[DiffLagrangianWGTENatSIV];
