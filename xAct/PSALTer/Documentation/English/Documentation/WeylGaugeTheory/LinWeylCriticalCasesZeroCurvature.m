(* ::Package:: *)

(*=====================================*)
(*  LinWeylCriticalCasesZeroCurvature  *)
(*=====================================*)
(*=============================================*)
(*  WGT critical cases from Lin et. al. 2021  *)
(*=============================================*)
Section@"Evaluating the critical cases of WGT with zero curvature";

(*Here we load the required files for the critical cases analysis*)
Get@FileNameJoin@{NotebookDirectory[],"Documentation","WeylGaugeTheory","WeylCriticalCasesData","CriticalCasesLinWeylZeroCurvature.m"};
Get@FileNameJoin@{NotebookDirectory[],"Documentation","WeylGaugeTheory","WeylCriticalCasesData","UnitarityInfoLinWeylZeroCurvature.m"};
Get@FileNameJoin@{NotebookDirectory[],"Documentation","WeylGaugeTheory","WeylCriticalCasesData","CalibrateCaseLinWeylZeroCurvature.m"};

Off[Solve::svars];
CriticalCasesSolutionsLinWeylZeroCurvature=First/@(Solve[#,{lLambda,lR1,lR2,lR3,lR4,lR5,lC1,lXi,lNu,lT1,lT2,lT3,lPhi0}]&/@CriticalCasesLinWeylZeroCurvature);
On[Solve::svars];

Print@CriticalCasesSolutionsLinWeylZeroCurvature[[1;;19]];

Comment@"We are now ready to check that PSALTer is getting the physics right by running it on the WGT cases in Lin et. al. 2021. We are looking at zero-curvature cases (53-71) here.";

DocumentationTimingDataLinWeylZeroCurvature=MapThread[
		AbsoluteTiming@CalibrateCaseLinWeylZeroCurvature[#1,#2]&,
		{
			Table[i,{i,1,19}],
			CriticalCasesSolutionsLinWeylZeroCurvature[[1;;19]](*formerly 1--42*)
		}];

Section@"How long did this take?";
Comment@"Computation complete; all the cases have been evaluated. You can see from the timing below (in seconds):";
DisplayExpression@DocumentationTimingDataLinWeylZeroCurvature;

(*DumpSave[FileNameJoin@{NotebookDirectory[],"DocumentationTimingDataLinWeylZeroCurvature.mx"},{DocumentationTimingDataLinWeylZeroCurvature}];*)
