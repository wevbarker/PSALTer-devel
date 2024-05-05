(* ::Package:: *)

(*===============================*)
(*  LinWeylCriticalCasesGeneral  *)
(*===============================*)

(*=============================================*)
(*  WGT critical cases from Lin et. al. 2021  *)
(*=============================================*)
Section@"Evaluating the critical cases of WGT";

(*Here we load the required files for the critical cases analysis*)
Get@FileNameJoin@{NotebookDirectory[],"Documentation","WeylGaugeTheory","WeylCriticalCasesData","CriticalCasesLinWeyl.m"};
Get@FileNameJoin@{NotebookDirectory[],"Documentation","WeylGaugeTheory","WeylCriticalCasesData","UnitarityLinWeyl.m"};
Get@FileNameJoin@{NotebookDirectory[],"Documentation","WeylGaugeTheory","WeylCriticalCasesData","CalibrateCaseLinWeyl.m"};

Off[Solve::svars];
CriticalCasesSolutionsLinWeyl=First/@(Solve[#,{lLambda,lR1,lR2,lR3,lR4,lR5,lC1,lXi,lNu,lT1,lT2,lT3,lPhi0}]&/@CriticalCasesLinWeyl);
On[Solve::svars];

Print@CriticalCasesSolutionsLinWeyl[[1;;13]];
Print@UnitarityLinWeyl[[1;;13]];

Comment@"We are now ready to check that PSALTer is getting the physics right by running it on the WGT cases in Lin et. al. 2021. We are looking at cases 1-13 of Table III.";

DocumentationTimingDataLinWeyl=MapThread[
		AbsoluteTiming@CalibrateCaseLinWeyl[#1,#2,#3]&,
		{
			Table[i,{i,1,13}],
			CriticalCasesSolutionsLinWeyl[[1;;13]],(*formerly 1--42*)
			UnitarityLinWeyl[[1;;13]]
		}];

Section@"How long did this take?";
Comment@"Computation complete; all the cases have been evaluated. You can see from the timing below (in seconds):";
DisplayExpression@DocumentationTimingDataLinWeyl;

(*DumpSave[FileNameJoin@{NotebookDirectory[],"DocumentationTimingDataLinWeyl.mx"},{DocumentationTimingDataLinWeyl}];*)
