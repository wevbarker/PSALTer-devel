(* ::Package:: *)

(*==================*)
(*  WGTEGeneralCase *)
(*==================*)
(*=======================================*)
(*  Function to loop all gauge choices  *)
(*=======================================*)

GaugeSelectorWGTELooper[CaseNumber_,LCList:{lLambda-lLambda==0}]:=Module[{i,j,
	LinearisedLagrangianWGTELooper,
	Couplings={lLambda,lR1,lR2,lR3,lR4,lR5,lC1,lXi,lNu,lT1,lT2,lT3,lPhi0}},

	Subsection@("Case "<>ToString@CaseNumber<>" under various gauges:");
				
	For[i=1,i<3,i++,For[j=4,j<6,j++,
	LinearisedLagrangianWGTELooper=GaugeSelectorWGTEFunction[i,j,LCList];
	ParticleSpectrum[
		LinearisedLagrangianWGTELooper,
		ClassName->"WeylGaugeTheory",
		TheoryName->"Case"<>ToString@CaseNumber<>"Gauge"<>ToString@i<>ToString@j<>"WGTE",	
		Method->"Easy",
		MaxLaurentDepth->3]]];
	(*	
	LinearisedLagrangianWGTELooper=GaugeSelectorWGTEFunction[3,6,LCList];
	ParticleSpectrum[
		LinearisedLagrangianWGTELooper,
		ClassName->"WeylGaugeTheory",
		TheoryName->"Case"<>ToString@CaseNumber<>"Gauge36WGTE",	
		Method->"Easy",
		MaxLaurentDepth->3];
	*)
	Comment@"Okay, that concludes the analysis of this theory under the various gauges.";	
];

(*==============================*)
(*  Running the general cases  *)
(*==============================*)

Section@"Evaluating the general eWGT and the 'Punnett square' of c1 and \[Xi] constants";
Comment@"Here are the cases considered:";

GeneralWGTECases={
	lR1==lR2==lR3==lR4==lR5==(lT1+lLambda)==(lT2-lLambda)==(lT3-lLambda)==0,(*Test; EH with Phi,B terms.*)
	lLambda-lLambda==0,(*Most general eWGT*)
	lC1==0,
	lXi==0,
	lC1==lXi==0
};

Off[Solve::svars];
GeneralWGTECasesSolutions=First/@(Solve[#,{lLambda,lR1,lR2,lR3,lR4,lR5,lC1,lXi,lNu,lT1,lT2,lT3,lPhi0}]&/@GeneralWGTECases);
On[Solve::svars];
Print@GeneralWGTECasesSolutions[[1;;5]];

CalibrationTimingDataWGTECases=MapThread[
		AbsoluteTiming@GaugeSelectorWGTELooper[#1,#2]&,
		{
			Table[i,{i,1,5}],
			GeneralWGTECasesSolutions[[1;;5]]
		}];

Section@"How long did this take?";
Comment@"Computation complete; all the cases have been evaluated. You can see from the timing below (in seconds):";
DisplayExpression@CalibrationTimingDataWGTECases;
(*DumpSave[FileNameJoin@{NotebookDirectory[],"CalibrationTimingDataWGTECases.mx"},{CalibrationTimingDataWGTECases}];*)
