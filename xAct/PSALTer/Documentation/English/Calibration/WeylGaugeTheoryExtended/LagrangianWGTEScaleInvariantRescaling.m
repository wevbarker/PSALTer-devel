(* ::Package:: *)

(*========================================*)
(*  LagrangianWGTEScaleInvariantRescaling *)
(*========================================*)
Section@"Setting out the eWGT Lagrangian (nonlinear) in scale-invariant variables, A+_hat, h_hat:";
(*========================*)
(*  Setting the rescaling *)
(*========================*)

(*See Section 3M of Lasenby and Hobson 2016, J. Math. Phys. 57, 092505.*)
WeylWGTEScaleInvariantRescalingWeylVectorA=Join[	
	MakeRule[{WeylDaggerA[a,b,-j],WeylRotationalGaugeField[a,b,-j]},MetricOn->All,ContractMetrics->True],(*199c*)
	MakeRule[{WeylVector[-i],WeylVector[-i]+((1/3)*WeylInvTetrad[a,-i]WeylBaseT[e,-a,-e])+CD[-i][Log[Compensator[]/lPhi0]]},MetricOn->All,ContractMetrics->True](*199d*)
];

(*199d: B_hat relation to T(contracted)_natural*)
WeylWGTEScaleInvariantRescalingWeylVectortoTContracted=MakeRule[{WeylVector[-i],Evaluate[(-1/3)*WeylInvTetrad[a,-i]WeylBaseT[e,-a,-e]]},MetricOn->All,ContractMetrics->True];

(*199b*)
WeylWGTEScaleInvariantRescalingBH=Join[	
	MakeRule[{WeylTetrad[-a,c],(Compensator[]/lPhi0)*WeylTetrad[-a,c]},MetricOn->All,ContractMetrics->True],(*199c*)
	MakeRule[{WeylInvTetrad[a,-c],(lPhi0/Compensator[])*WeylInvTetrad[a,-c]},MetricOn->All,ContractMetrics->True](*199d*)
];

(*Rule to deal with the CovD issue as below*)
WeylWGTEScaleInvariantRescalingCovD=MakeRule[{WeylCovDerivDaggerOnScalar[-a],Evaluate[(-1)*WeylTetrad[-a,i]WeylVector[-i]*Compensator[]]},MetricOn->All,ContractMetrics->True];

(*Rescaling of Lagrangian by det, h^-1. Temporarily set CovD term to 0.*)
NonlinearLagrangianWGTEScaleInvariantRescaling=NonlinearLagrangianWGTEOriginal*((lPhi0/Compensator[])^4);
NonlinearLagrangianWGTEScaleInvariantRescaling=NonlinearLagrangianWGTEScaleInvariantRescaling/.{lNu->0};
NonlinearLagrangianWGTEScaleInvariantRescaling//=xAct`PSALTer`Private`ToNewCanonical;

Comment@"We present the 'scale-invariant' variable redefinitions as in Section 3M of Lasenby and Hobson 2016, J. Math. Phys. 57, 092505.";
Print@"Eqn. 199b, tetrad h in terms of h_hat:";
DisplayExpression@CollectTensors@ToCanonical[WeylTetrad[-a,c]/.WeylWGTEScaleInvariantRescalingBH//xAct`PSALTer`Private`ToNewCanonical];
Print@"Inverse tetrad b in terms of b_hat:";
DisplayExpression@CollectTensors@ToCanonical[WeylInvTetrad[a,-c]/.WeylWGTEScaleInvariantRescalingBH//xAct`PSALTer`Private`ToNewCanonical];
Print@"Eqn. 199d, vector B in terms of B_hat. N.B. B = -V in paper.";
DisplayExpression@CollectTensors@ToCanonical[WeylVector[-i]/.WeylWGTEScaleInvariantRescalingWeylVectorA//xAct`PSALTer`Private`ToNewCanonical];
Print@"Note that in the variables A+,f,(Phi), B is no longer a variable, and is equivalent to T_natural contracted:";
DisplayExpression@CollectTensors@ToCanonical[WeylVector[-i]/.WeylWGTEScaleInvariantRescalingWeylVectortoTContracted//xAct`PSALTer`Private`ToNewCanonical];

(*Make linearised rule*)
WeylWGTEScaleInvariantRescalingWeylVectortoTLinear=MakeRule[{WeylVector[-i],Evaluate[(-1/3)*(WeylRotationalGaugeField[-i,k,-k]+CD[-k][WeylTranslationalGaugeFieldPerturbation[-i,k]]-CD[-i][WeylTranslationalGaugeFieldPerturbation[k,-k]])]},MetricOn->All,ContractMetrics->True];
Comment@"Linearised rule for B is:"
DisplayExpression@CollectTensors@ToCanonical[WeylVector[-i]/.WeylWGTEScaleInvariantRescalingWeylVectortoTLinear//xAct`PSALTer`Private`ToNewCanonical];
(*
Comment@{"Diagnostic: Show Lagrangian after dealing with det h^-1, setting nu*D^2 term to 0 temporarily"};
DisplayExpression@CollectTensors@ToCanonical[NonlinearLagrangianWGTEScaleInvariantRescaling];
*)
(*=================================*)
(*  Checking the field quantities *)
(*=================================*)
(*
(*Check CovD+ expansion*)
Comment@{"We check CovD+ under the redefinition of variables B to B_hat:"};
WeylRescaleTestCovD=WeylCovDerivDaggerOnScalar[-a]/.WeyDaggerTHCovDtoBaseTWeylVectorHBAndDaggerRtoDaggerA;
WeylRescaleTestCovD=WeylRescaleTestCovD/.WeylWGTEScaleInvariantRescalingWeylVectorA;
WeylRescaleTestCovD//=xAct`PSALTer`Private`ToNewCanonical;
DisplayExpression@CollectTensors@ToCanonical[WeylRescaleTestCovD];

Comment@{"We know that the last two terms cancel. While normally we can expand h,b to perturbation f and remove this issue, here we need to rescale h,b before the perturbation expansion. Hence, we make a rule to make this cancellation first."};
DisplayExpression@CollectTensors@ToCanonical[WeylCovDerivDaggerOnScalar[-a]/.WeylWGTEScaleInvariantRescalingCovD//xAct`PSALTer`Private`ToNewCanonical];

(*Check H+ expansion*)
Comment@{"We check H+ under the redefinition of variables B to B_hat:"};
WeylRescaleTestH=WeylDaggerH[-a,-b]/.WeyDaggerTHCovDtoBaseTWeylVectorHBAndDaggerRtoDaggerA;
WeylRescaleTestH=WeylRescaleTestH/.WeylWGTEScaleInvariantRescalingWeylVectorA;
WeylRescaleTestH=WeylRescaleTestH/.WeylWGTEScaleInvariantRescalingBH;
WeylRescaleTestH//=xAct`PSALTer`Private`ToNewCanonical;
DisplayExpression@CollectTensors@ToCanonical[WeylRescaleTestH];

(*Check R+ expansion*)
Comment@{"We check R+ under the redefinition of variables A to A_hat, h to h_hat:"};
WeylRescaleTestR=WeylDaggerR[a,b,-d,-e]/.WeyDaggerTHCovDtoBaseTWeylVectorHBAndDaggerRtoDaggerA;
WeylRescaleTestR=WeylRescaleTestR/.WeylWGTEScaleInvariantRescalingWeylVectorA;
WeylRescaleTestR=WeylRescaleTestR/.WeylWGTEScaleInvariantRescalingBH;
WeylRescaleTestR//=xAct`PSALTer`Private`ToNewCanonical;
DisplayExpression@CollectTensors@ToCanonical[WeylRescaleTestR];

(*Check T+ expansion*)
Comment@{"We check T+ under the redefinition of variables A to A_hat, h to h_hat:"};
WeylRescaleTestT=WeylDaggerT[a,-b,-c]/.WeyDaggerTHCovDtoBaseTWeylVectorHBAndDaggerRtoDaggerA;
WeylRescaleTestT=WeylRescaleTestT/.WeylDaggerABaseTtoAHBWeylVector;
WeylRescaleTestT=WeylRescaleTestT/.WeylWGTEScaleInvariantRescalingBH;
WeylRescaleTestT//=xAct`PSALTer`Private`ToNewCanonical;
DisplayExpression@CollectTensors@ToCanonical[WeylRescaleTestT];

Comment@"Now we want to remove vector B in order to get a PGT Lagrangian. We want a linear-order expression for B_mu. First expand:"
ExpandWeylVectorDemo=WeylVector[-i];
ExpandWeylVectorDemo=ExpandWeylVectorDemo/.WeylWGTEScaleInvariantRescalingWeylVectortoTContracted;
ExpandWeylVectorDemo=ExpandWeylVectorDemo/.WeylDaggerABaseTtoAHBWeylVector;
ExpandWeylVectorDemo//=xAct`PSALTer`Private`ToNewCanonical;
DisplayExpression@CollectTensors@ToCanonical[ExpandWeylVectorDemo];

Comment@"Linearisation:"
ExpandWeylVectorDemo=ExpandWeylVectorDemo/.xAct`PSALTer`WeylGaugeTheoryExtended`Private`WeylHBFieldToGF;
ExpandWeylVectorDemo//=xAct`PSALTer`Private`ToNewCanonical;
ExpandWeylVectorDemo=ExpandWeylVectorDemo/.ToOrderWeyl;
ExpandWeylVectorDemo//=Series[#,{PerturbativeParameterWeyl,0,1}]&;(*To linear order*)
ExpandWeylVectorDemo//=Normal;
ExpandWeylVectorDemo=ExpandWeylVectorDemo/.PerturbativeParameterWeyl->1;
ExpandWeylVectorDemo//=xAct`PSALTer`Private`ToNewCanonical;
DisplayExpression@CollectTensors@ToCanonical[ExpandWeylVectorDemo];

Print@"Check two expressions are the same:"
DisplayExpression@CollectTensors@ToCanonical[ExpandWeylVectorDemo-Evaluate[WeylVector[-i]/.WeylWGTEScaleInvariantRescalingWeylVectortoTLinear]];
*)
(*==============================================================================*)
(*  WGT Lagrangian in terms of redefined scale-invariant variables, with no B  *)
(*==============================================================================*)

(*Expansion of dagger field quantities*)
NonlinearLagrangianWGTEScaleInvariantRescaling=NonlinearLagrangianWGTEScaleInvariantRescaling/.WeyDaggerTHCovDtoBaseTWeylVectorHBAndDaggerRtoDaggerA;
NonlinearLagrangianWGTEScaleInvariantRescaling//=xAct`PSALTer`Private`ToNewCanonical;
(*Replacement of A+ and V*)
NonlinearLagrangianWGTEScaleInvariantRescaling=NonlinearLagrangianWGTEScaleInvariantRescaling/.WeylWGTEScaleInvariantRescalingWeylVectorA;
(*Expansion of remaining T to A*)
NonlinearLagrangianWGTEScaleInvariantRescaling=NonlinearLagrangianWGTEScaleInvariantRescaling/.WeylDaggerABaseTtoAHBWeylVector;
NonlinearLagrangianWGTEScaleInvariantRescaling//=xAct`PSALTer`Private`ToNewCanonical;
(*Re-addition of CovD term and susbstitution to v-hat*)
NonlinearLagrangianWGTEScaleInvariantRescaling+=lNu/2*WeylCovDerivDaggerOnScalar[-a]*WeylCovDerivDaggerOnScalar[a]*((lPhi0/Compensator[])^4);
NonlinearLagrangianWGTEScaleInvariantRescaling=NonlinearLagrangianWGTEScaleInvariantRescaling/.WeylWGTEScaleInvariantRescalingCovD;
(*Replacement of h,b*)
NonlinearLagrangianWGTEScaleInvariantRescaling=NonlinearLagrangianWGTEScaleInvariantRescaling/.WeylWGTEScaleInvariantRescalingBH;
NonlinearLagrangianWGTEScaleInvariantRescaling//=xAct`PSALTer`Private`ToNewCanonical;
(*Rescaling the couplings*)
Print@"Here, we perform rescalings: \[Phi]_0^2*\[Lambda] -> \[Lambda], \[Phi]_0^2*\[Nu] -> \[Nu], \[Phi]_0^2*t_i -> t_i.";
NonlinearLagrangianWGTEScaleInvariantRescaling=NonlinearLagrangianWGTEScaleInvariantRescaling/.RescaleEinsteinGaugeCoupling;
NonlinearLagrangianWGTEScaleInvariantRescaling//=xAct`PSALTer`Private`ToNewCanonical;
(*Construct the PGT Lagrangian*)
NonlinearLagrangianWGTEScaleInvariantRescalingPGT=NonlinearLagrangianWGTEScaleInvariantRescaling/.WeylWGTEScaleInvariantRescalingWeylVectortoTLinear;
NonlinearLagrangianWGTEScaleInvariantRescalingPGT//=xAct`PSALTer`Private`ToNewCanonical;
Comment@"Diagnostic: We have generated and stored the general Lagrangian after the scale-invariant variable redefinitions (A_hat, h_hat, no B). Note that indeed all phi has disappeared."
(*DisplayExpression@CollectTensors@ToCanonical[NonlinearLagrangianWGTEScaleInvariantRescalingPGT];*)
