(* ::Package:: *)

(*==================*)
(*  WGTEGeneralCase *)
(*==================*)
(*=======================================*)
(*  Function to loop all gauge choices  *)
(*=======================================*)

GaugeSelectorWGTELooper[CaseNumber_,LCList_]:=Module[{i,j,
	LinearisedLagrangianWGTELooper,
	Couplings={lLambda,lR1,lR2,lR3,lR4,lR5,lC1,lXi,lNu,lT1,lT2,lT3,lPhi0}},
	
	Subsection@("Case "<>ToString@CaseNumber<>" under various gauges:");
	Comment@"Here is the choice of coefficients, displayed w.r.t. the original eWGT Lagrangian:";
	DisplayExpression@CollectTensors@ToCanonical[NonlinearLagrangianWGTEOriginal/.LCList];
				
	For[i=1,i<3,i++,For[j=4,j<6,j++,
	Comment@{"Case "<>ToString@CaseNumber<>"."<>ToString@i<>ToString@j<>":"};	
	LinearisedLagrangianWGTELooper=GaugeSelectorWGTEFunction[i,j,(LinearisedLagrangianWGTEOriginal/.LCList)];
	
	(*Diagnostic*)
	Print@"This is the string that will be fed into ParticleSpectrum[ClassName -> ...]";
	Print@TheorySelectorWGTEFunction[i,j];
	Print@"This marks where Zhiyuan's code end and Will's code begins. Hard mode used";
	
	ParticleSpectrum[
		LinearisedLagrangianWGTELooper,
		ClassName->ToString@TheorySelectorWGTEFunction[i,j],
		TheoryName->"Case"<>ToString@CaseNumber<>"Gauge"<>ToString@i<>ToString@j<>"WGTE",	
		Method->"Hard",
		MaxLaurentDepth->3]
	]];

	Comment@"Okay, that concludes the analysis of this theory under the various gauges.";	
];

(*==============================*)
(*  Running the general cases  *)
(*==============================*)

Section@"Evaluating the general eWGT and the 'Punnett square' of c1 and \[Xi] constants";
Comment@"Here are the cases considered:";

(*Physical Review D*)

GeneralWGTECases={
	(*
	lR1==lR2==lR3==lR4==lR5==(lT1+lLambda)==(lT2-lLambda)==(lT3-lLambda)==0,(*Test; EH with Phi,B terms, w lC1.*)
	lR1==lR2==lR3==lR4==lR5==(lT1+lLambda)==(lT2-lLambda)==(lT3-lLambda)==lC1==0,(*Test; EH with Phi,B terms, w/o lC1.*)
	*)
	lLambda-lLambda==0,(*Most general eWGT*)
	lC1==0,
	lXi==0,
	lC1==lXi==0
};

Off[Solve::svars];
GeneralWGTECasesSolutions=First/@(Solve[#,{lLambda,lR1,lR2,lR3,lR4,lR5,lC1,lXi,lNu,lT1,lT2,lT3,lPhi0}]&/@GeneralWGTECases);
On[Solve::svars];
Print@GeneralWGTECasesSolutions[[2;;4]];

CalibrationTimingDataWGTECases=MapThread[
		AbsoluteTiming@GaugeSelectorWGTELooper[#1,#2]&,
		{
			Table[i,{i,2,4}],
			GeneralWGTECasesSolutions[[2;;4]]
		}];

Section@"How long did this take?";
Comment@"Computation complete; all the cases have been evaluated. You can see from the timing below (in seconds):";
DisplayExpression@CalibrationTimingDataWGTECases;
(*DumpSave[FileNameJoin@{NotebookDirectory[],"CalibrationTimingDataWGTECases.mx"},{CalibrationTimingDataWGTECases}];*)
