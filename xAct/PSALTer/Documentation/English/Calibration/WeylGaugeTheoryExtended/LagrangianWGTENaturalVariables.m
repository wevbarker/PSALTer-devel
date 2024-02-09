(* ::Package:: *)

(*=================================*)
(*  LagrangianWGTENaturalVariables *)
(*=================================*)
Section@"Setting out the eWGT Lagrangian (nonlinear) in natural variables, A+, h, Phi:";

(*Expansion of dagger field quantities*)
NonlinearLagrangianWGTENaturalVariables=NonlinearLagrangianWGTEOriginal/.WeyDaggerTHCovDtoBaseTWeylVectorHBAndDaggerRtoDaggerA;
NonlinearLagrangianWGTENaturalVariables//=xAct`PSALTer`Private`ToNewCanonical;
(*Replacement of A+ and B, to A and T_natural*)
NonlinearLagrangianWGTENaturalVariables=NonlinearLagrangianWGTENaturalVariables/.WeylWGTEScaleInvariantRescalingWeylVectorA;
NonlinearLagrangianWGTENaturalVariables//=xAct`PSALTer`Private`ToNewCanonical;
(*Replacement of T_natural to A(+) quantities*)
NonlinearLagrangianWGTENaturalVariables=NonlinearLagrangianWGTENaturalVariables/.WeylWGTEScaleInvariantRescalingWeylVectortoTLinear;
NonlinearLagrangianWGTENaturalVariables//=xAct`PSALTer`Private`ToNewCanonical;
NonlinearLagrangianWGTENaturalVariables//=CollectTensors;
Comment@"Diagnostic: We have generated and stored the general Lagrangian after the use of natural variables (A+ and h). Note that what will be displayed as A is actually A+, and that B dissapears."
(*DisplayExpression@CollectTensors@ToCanonical[NonlinearLagrangianWGTENaturalVariables];*)
