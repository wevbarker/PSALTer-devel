(* ::Package:: *)

(*==============================*)
(*  LinWeylCriticalCases37To42  *)
(*==============================*)

(*We need to set field A to zero.*)
(*WeylTestSetAToZero=MakeRule[{WeylRotationalGaugeField[-a,-b,-c],Zero[-a,-b,-c]},MetricOn->All,ContractMetrics->True];*)

(*=============================================*)
(*  WGT critical cases from Lin et. al. 2021  *)
(*=============================================*)
Section@"Evaluating the critical cases of WGT with zero curvature";

(*Here we load the required files for the critical cases analysis*)
Get@FileNameJoin@{NotebookDirectory[],"Calibration","WeylGaugeTheory","WeylCriticalCasesData","CriticalCasesLinWeylZeroCurvature.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","WeylGaugeTheory","WeylCriticalCasesData","UnitarityLinWeylZeroCurvature.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","WeylGaugeTheory","WeylCriticalCasesData","CalibrateCaseLinWeylZeroCurvature.m"};

Off[Solve::svars];
CriticalCasesSolutionsLinWeylZeroCurvature=First/@(Solve[#,{lLambda,lR1,lR2,lR3,lR4,lR5,lC1,lXi,lNu,lT1,lT2,lT3,lPhi0}]&/@CriticalCasesLinWeylZeroCurvature);
On[Solve::svars];

Print@CriticalCasesSolutionsLinWeylZeroCurvature[[1;;6]];
Print@UnitarityLinWeylZeroCurvature[[1;;6]];

Comment@"We are now ready to check that PSALTer is getting the physics right by running it on the WGT cases in Lin et. al. 2021. We are looking at cases 37-42 here.";

CalibrationTimingDataLinWeylZeroCurvature=MapThread[
		AbsoluteTiming@CalibrateCaseLinWeylZeroCurvature[#1,#2,#3]&,
		{
			Table[i,{i,1,6}],
			CriticalCasesSolutionsLinWeylZeroCurvature[[1;;6]],(*formerly 1--42*)
			UnitarityLinWeylZeroCurvature[[1;;6]]
		}];

Section@"How long did this take?";
Comment@"Computation complete; all the cases have been evaluated. You can see from the timing below (in seconds):";
DisplayExpression@CalibrationTimingDataLinWeylZeroCurvature;

(*DumpSave[FileNameJoin@{NotebookDirectory[],"CalibrationTimingDataLinWeylZeroCurvature.mx"},{CalibrationTimingDataLinWeylZeroCurvature}];*)
