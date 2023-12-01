(* ::Package:: *)

(*====================================*)
(*  LinWeylCriticalCasesZeroTorsion  *)
(*====================================*)

(*======================================================*)
(*  Preamble: setting out the Torsion-free Lagrangian  *)
(*======================================================*)
Section@"Preamble: setting out auxillary fields to get the torsion-free Lagrangian, T* = 0";

(*Setting WGT torsion T* to 0, 2005.02228 eqn. 7. I am not sure what is CD defined in the PGT files.*)
xAct`PSALTer`LinWeylCriticalCases14To36`Private`WeylTestTSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalT]\), \(\[ScriptCapitalB]\)]\)";
DefTensor[WeylTestT[c,-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`LinWeylCriticalCases14To36`Private`WeylTestTSymb],Dagger->Complex];
WeylTestTExpand=MakeRule[{WeylTestT[c,-a,-b],Evaluate[WeylVector[-i](-WeylTetrad[-a,i]G[c,-b]+WeylTetrad[-b,i]G[c,-a])]},MetricOn->All,ContractMetrics->True];

Comment@"Here, by setting WGT T* to 0, we have essentially fixed T to only depend on the fields B, h, b, c.f. arxiv:2005.02228 eqn. 7."
DisplayExpression@CollectTensors@ToCanonical[WeylTestT[c,-a,-b]/.WeylTestTExpand//xAct`PSALTer`Private`ToNewCanonical]\:ff1b

(*Equation 24, using PD instead of CD*)
DefTensor[WeylTestC[c, -a, -b], M4, Antisymmetric[{-a, -b}],PrintAs->"\[ScriptC]"]; 
WeylTestCExpand=MakeRule[{WeylTestC[c,-a,-b],Evaluate[WeylTetrad[-a,i]WeylTetrad[-b,j](PD[-i][WeylInvTetrad[c,-j]]-PD[-j][WeylInvTetrad[c,-i]])]},MetricOn->All,ContractMetrics->True];

(*Equation 22 and 23, defining Delta* *)
xAct`PSALTer`LinWeylCriticalCases14To36`Private`WeylTestDeltaSymb="\!\(\*SuperscriptBox[\(\[CapitalDelta]\), \(*\)]\)";
DefTensor[WeylTestDelta[-a,-b,-i],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`LinWeylCriticalCases14To36`Private`WeylTestDeltaSymb],Dagger->Complex];
WeylTestDeltaExpand=MakeRule[{WeylTestDelta[-a,-b,-i],Evaluate[WeylInvTetrad[c,-i]((1/2)*(WeylTestC[-a,-b,-c]-WeylTestC[-c,-a,-b]+WeylTestC[-b,-c,-a])+WeylVector[-j](-WeylTetrad[-a,j]G[-b,-c]+WeylTetrad[-b,j]G[-a,-c]))]},MetricOn->All,ContractMetrics->True];

(*Equation 20 for contorsion*)
DefTensor[WeylTestContorsion[-a, -b, -i], M4, Antisymmetric[{-a, -b}],PrintAs->"\[ScriptCapitalK]"]; 
WeylTestContorsionExpand=MakeRule[{WeylTestContorsion[-a, -b, -i],Evaluate[(-1/2)*WeylInvTetrad[c,-i](WeylTestT[-a,-b,-c]-WeylTestT[-c,-a,-b]+WeylTestT[-b,-c,-a])]},MetricOn->All,ContractMetrics->True];

(*Equation 21, to totally expand A gauge field in the restricted case of zero WGT torsion T*. *)
WeylTestRotationalGaugeFieldExpand=MakeRule[{WeylRotationalGaugeField[-a,-b,-i],Evaluate[WeylTestDelta[-a,-b,-i]+WeylTestContorsion[-a,-b,-i]]},MetricOn->All,ContractMetrics->True];  

WeylTestExpandRotationalGaugeToVectorAndTetradBHFunction[RotationalGaugeField_]:=Module[{ExpandedRotationalGaugeField=RotationalGaugeField},
	ExpandedRotationalGaugeField=ExpandedRotationalGaugeField/.WeylTestRotationalGaugeFieldExpand;(*Expand Eqn 21*)
	ExpandedRotationalGaugeField=ExpandedRotationalGaugeField/.WeylTestDeltaExpand/.WeylTestCExpand; (*Expand Eqns 22-24*)
	ExpandedRotationalGaugeField=ExpandedRotationalGaugeField/.WeylTestContorsionExpand/.WeylTestTExpand;(*Expand Eqn 20 and then restriction of eqn 7*)
	ExpandedRotationalGaugeField//=xAct`PSALTer`Private`ToNewCanonical;
ExpandedRotationalGaugeField];

(*We check if A under restricted T is properly expanded*)
Comment@"Now we check if the rotational gauge field is fully expanded into B and tetrad fields under torsion restriction."
DisplayExpression@CollectTensors@ToCanonical[WeylTestExpandRotationalGaugeToVectorAndTetradBHFunction[WeylRotationalGaugeField[a,b,-i]]]\:ff1b
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
