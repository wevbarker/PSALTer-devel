(* ::Package:: *)

(*==================*)
(*  WGTEGeneralCase *)
(*==================*)

GeneralWGTEPunnettSquare={
	lR1==lR2==lR3==lR4==lR5==(lT1+lLambda)==(lT2-lLambda)==(lT3-lLambda)==0,(*Test; EH with Phi,B terms.*)
	lLambda-lLambda==0,(*Most general eWGT*)
	lC1==0,
	lXi==0,
	lC1==lXi==0
};

Section@"Evaluating the general eWGT and the 'Punnett square' of c1 and \[Xi] constants";
Comment@"Here are the cases considered:";
Print@GeneralWGTEPunnettSquare[[1;5]];

CalibrationTimingDataWGTEPunnettSquare=MapThread[
		AbsoluteTiming@GaugeSelectorWGTELooper[#1,#2]&,
		{
			Table[i,{i,1,5}],
			GeneralWGTEPunnettSquare[[1;;5]]
		}];

Section@"How long did this take?";
Comment@"Computation complete; all the cases have been evaluated. You can see from the timing below (in seconds):";
DisplayExpression@CalibrationTimingDataWGTEPunnettSquare;
(*DumpSave[FileNameJoin@{NotebookDirectory[],"CalibrationTimingDataWGTEPunnettSquare.mx"},{CalibrationTimingDataWGTEPunnettSquare}];*)
