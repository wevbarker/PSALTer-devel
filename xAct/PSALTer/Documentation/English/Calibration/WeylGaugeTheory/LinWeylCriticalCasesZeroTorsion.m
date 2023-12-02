(* ::Package:: *)

(*====================================*)
(*  LinWeylCriticalCasesZeroTorsion  *)
(*====================================*)

(*======================================================*)
(*  Preamble: setting out the Torsion-free Lagrangian  *)
(*======================================================*)
Section@"Preamble: setting out auxillary fields to get the torsion-free Lagrangian, T* = 0";
Comment@"Here, by setting WGT T* to 0, we set contortion K (arxiv:2005.02228 eqn. 20) to 0. Then via eqns. 21-24, rotational gauge field A is no longer independent, can be expressed in terms of fields B, h, b."

(*Equation 24, we use CD[] here as discussed.*)
DefTensor[WeylTestC[c, -a, -b], M4, Antisymmetric[{-a, -b}],PrintAs->"\[ScriptC]"]; 
WeylTestCExpand=MakeRule[{WeylTestC[c,-a,-b],Evaluate[WeylTetrad[-a,i]WeylTetrad[-b,j](CD[-i][WeylInvTetrad[c,-j]]-CD[-j][WeylInvTetrad[c,-i]])]},MetricOn->All,ContractMetrics->True];

(*Equation 22 and 23, defining Delta*. *)
xAct`PSALTer`LinWeylCriticalCases14To36`Private`WeylTestDeltaSymb="\!\(\*SuperscriptBox[\(\[CapitalDelta]\), \(*\)]\)";
DefTensor[WeylTestDelta[-a,-b,-i],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`LinWeylCriticalCases14To36`Private`WeylTestDeltaSymb],Dagger->Complex];
WeylTestDeltaExpand=MakeRule[{WeylTestDelta[-a,-b,-i],Evaluate[WeylInvTetrad[c,-i]((1/2)*(WeylTestC[-a,-b,-c]-WeylTestC[-c,-a,-b]+WeylTestC[-b,-c,-a])+WeylVector[-j](-WeylTetrad[-a,j]G[-b,-c]+WeylTetrad[-b,j]G[-a,-c]))]},MetricOn->All,ContractMetrics->True];

(*Equation 21, to totally expand A gauge field in the restricted case of zero WGT torsion T*. *)
WeylTestRotationalGaugeFieldExpand=MakeRule[{WeylRotationalGaugeField[-a,-b,-i],Evaluate[WeylTestDelta[-a,-b,-i]]},MetricOn->All,ContractMetrics->True];  

WeylTestExpandRotationalGaugeToVectorAndTetradBHFunction[RotationalGaugeFieldExpression_]:=Module[{ExpandedRotationalGaugeFieldExpression=RotationalGaugeFieldExpression},
	Print@"Diagnostic: WeylTestExpandRotationalGaugeToVectorAndTetradBHFunction[...] is activated.";
	ExpandedRotationalGaugeFieldExpression=ExpandedRotationalGaugeFieldExpression/.WeylTestRotationalGaugeFieldExpand;(*Expand Eqn 21*)
	ExpandedRotationalGaugeFieldExpression//=xAct`PSALTer`Private`ToNewCanonical;	
	Print@"Diagnostic: Expand Eqn 21 completed.";
	ExpandedRotationalGaugeFieldExpression=ExpandedRotationalGaugeFieldExpression/.WeylTestDeltaExpand;(*Expand Eqn 22 and 23*)
	ExpandedRotationalGaugeFieldExpression//=xAct`PSALTer`Private`ToNewCanonical;
	Print@"Diagnostic: Expand Eqn 22 and 23 completed.";
	ExpandedRotationalGaugeFieldExpression=ExpandedRotationalGaugeFieldExpression/.WeylTestCExpand;(*Expand Eqn 24*)
	ExpandedRotationalGaugeFieldExpression//=xAct`PSALTer`Private`ToNewCanonical;
	Print@"Diagnostic: Expand Eqn 24 completed.";
	(*We want to linearise the expression for A in terms of vector B and perturbative tetradic f.*)
	ExpandedRotationalGaugeFieldExpression=ExpandedRotationalGaugeFieldExpression/.xAct`PSALTer`WeylGaugeTheory`Private`WeylHBFieldToGF;
	ExpandedRotationalGaugeFieldExpression//=xAct`PSALTer`Private`ToNewCanonical;
	Print@"Diagnostic: Expand to vector and tetrad perturbation completed. Proceeding to linearise.";
	ExpandedRotationalGaugeFieldExpression=ExpandedRotationalGaugeFieldExpression/.ToOrderWeyl;
	ExpandedRotationalGaugeFieldExpression//=Series[#,{PerturbativeParameterWeyl,0,1}]&;(*To linear order*)
	ExpandedRotationalGaugeFieldExpression//=Normal;
	ExpandedRotationalGaugeFieldExpression=ExpandedRotationalGaugeFieldExpression/.PerturbativeParameterWeyl->1;
	ExpandedRotationalGaugeFieldExpression//=xAct`PSALTer`Private`ToNewCanonical;
	Print@"Diagnostic: WeylTestExpandRotationalGaugeToVectorAndTetradBHFunction[...] is completed.";
ExpandedRotationalGaugeFieldExpression];

(*We check if A under restricted T is properly expanded*)
Comment@"We see how the rotational gauge field is fully expanded into B and tetrad fields under torsion restriction."
DisplayExpression@CollectTensors@ToCanonical[WeylTestExpandRotationalGaugeToVectorAndTetradBHFunction[WeylRotationalGaugeField[a,b,-i]]]\:ff1b

(*Now we make rule to expand A to fields in linear order. We will write it from scratch to save computational time*)
WeylTestAExpandToLinear=MakeRule[{WeylRotationalGaugeField[a,b,-i],
	Evaluate[(G[a,-i]WeylVector[b]-G[b,-i]WeylVector[a])-(1/2)*CD[-i][WeylTranslationalGaugeFieldPerturbation[a,b]-WeylTranslationalGaugeFieldPerturbation[b,a]]
		+(1/2)*CD[a][WeylTranslationalGaugeFieldPerturbation[b,-i]+WeylTranslationalGaugeFieldPerturbation[-i,b]]
		-(1/2)*CD[b][WeylTranslationalGaugeFieldPerturbation[a,-i]+WeylTranslationalGaugeFieldPerturbation[-i,a]]]},
	MetricOn->All,ContractMetrics->True];

Comment@"We make rule to expand A to fields in linear order. We will write it from scratch to save computational time."
DisplayExpression@CollectTensors@ToCanonical[WeylRotationalGaugeField[a,b,-i]/.WeylTestAExpandToLinear];
Print@"Check that the above two expressions are the same via subtraction:";
DisplayExpression@CollectTensors@ToCanonical[Evaluate[WeylRotationalGaugeField[a,b,-i]/.WeylTestAExpandToLinear]-WeylTestExpandRotationalGaugeToVectorAndTetradBHFunction[WeylRotationalGaugeField[a,b,-i]]];

(*Note: here we will first prepare the restricted non-linear WGT Lagrangian so that each call does not need recomputation.*)
Comment@"For cases 14-52, we will first prepare the zero-torsion non-linear WGT Lagrangian so that each call does not need recomputation."

(*To set T*T* terms to 0.*)
TestCaseZeroTorsionOverall={(lT1/3+lT2/12+lLambda/4)==(lT1/3-lT2/6+lLambda/2)==(lT1/3-2lT3/3+lLambda)==0};
(*
(*Diagnostic E-H test.*)
Print@"Diagnostic E-H test, just to check that the code flows correctly. Must be commented out before an actual run.";
TestCaseZeroTorsionOverall={lR1==lR2==lR3==lR4==lR5==lC1==lXi==lNu==(lT1+lLambda)==(lT2-lLambda)==(lT3-lLambda)==0};
*)
Off[Solve::svars];
TestCaseZeroTorsionOverallRules=First/@(Solve[#,{lLambda,lR1,lR2,lR3,lR4,lR5,lC1,lXi,lNu,lT1,lT2,lT3,lPhi0}]&/@TestCaseZeroTorsionOverall);
On[Solve::svars];

NonlinearLagrangianLinWeylZeroTorsion=First@((NonlinearLagrangianLinWeyl)/.TestCaseZeroTorsionOverallRules);
NonlinearLagrangianLinWeylZeroTorsion//=xAct`PSALTer`Private`ToNewCanonical;
Print@"Diagnostic (Lagrangian): T*T* terms removed from non-linear Lagrangian successfully:";
DisplayExpression@CollectTensors@ToCanonical[NonlinearLagrangianLinWeylZeroTorsion]\:ff1b

NonlinearLagrangianLinWeylZeroTorsion=NonlinearLagrangianLinWeylZeroTorsion/.WeylRTToHBFieldACDBFieldCDA;
NonlinearLagrangianLinWeylZeroTorsion//=xAct`PSALTer`Private`ToNewCanonical;
Print@"Diagnostic (Lagrangian): Non-linear Lagrangian expanded to level of A field successfully:";
DisplayExpression@CollectTensors@ToCanonical[NonlinearLagrangianLinWeylZeroTorsion]\:ff1b

(*Here we perform restriction on A*)
NonlinearLagrangianLinWeylZeroTorsion=NonlinearLagrangianLinWeylZeroTorsion/.WeylTestAExpandToLinear;
NonlinearLagrangianLinWeylZeroTorsion//=xAct`PSALTer`Private`ToNewCanonical;
Print@"Diagnostic (Lagrangian): A field expanded successfully:";
DisplayExpression@CollectTensors@ToCanonical[NonlinearLagrangianLinWeylZeroTorsion]\:ff1b

Comment@"We have finished loading the preamble for the restricted torsion setup."

(*=============================================*)
(*  WGT critical cases from Lin et. al. 2021  *)
(*=============================================*)
Section@"Evaluating the critical cases of WGT with zero torsion";

(*Here we load the required files for the critical cases analysis*)
Get@FileNameJoin@{NotebookDirectory[],"Calibration","WeylGaugeTheory","WeylCriticalCasesData","CriticalCasesLinWeylZeroTorsion.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","WeylGaugeTheory","WeylCriticalCasesData","CalibrateCaseLinWeylZeroTorsion.m"};

Off[Solve::svars];
CriticalCasesSolutionsLinWeylZeroTorsion=First/@(Solve[#,{lLambda,lR1,lR2,lR3,lR4,lR5,lC1,lXi,lNu,lT1,lT2,lT3,lPhi0}]&/@CriticalCasesLinWeylZeroTorsion);
On[Solve::svars];

Print@CriticalCasesSolutionsLinWeylZeroTorsion[[1;;39]];

Comment@"We are now ready to check that PSALTer is getting the physics right by running it on the WGT cases in Lin et. al. 2021. We are looking at the zero-torsion cases here (14-52).";

CalibrationTimingDataLinWeylZeroTorsion=MapThread[
		AbsoluteTiming@CalibrateCaseLinWeylZeroTorsion[#1,#2]&,
		{
			Table[i,{i,1,39}],
			CriticalCasesSolutionsLinWeylZeroTorsion[[1;;39]](*formerly 1--42*)
		}];

Section@"How long did this take?";
Comment@"Computation complete; all the cases have been evaluated. You can see from the timing below (in seconds):";
DisplayExpression@CalibrationTimingDataLinWeylZeroTorsion;

(*DumpSave[FileNameJoin@{NotebookDirectory[],"CalibrationTimingDataLinWeylZeroTorsion.mx"},{CalibrationTimingDataLinWeylZeroTorsion}];*)
