(* ::Package:: *)

(*=====================================*)
(*  CriticalCasesLinWeylZeroCurvature  *)
(*=====================================*)

(*How do we include the Additional Conditions?*)
(*Cases 37-42 from table IV of PHYS. REV. D 104, 024034 (2021), need to set A to 0! Not sure how to fully do this?*)
CriticalCasesLinWeylZeroCurvature={
	lR1==lR3/2-lR4==lT1==lLambda==lXi==0,(*1-1*)
	lR1==lR3/2-lR4==lT1==lLambda==lT1+lT3==0,(*1-2*)
	lR1==lR3/2-lR4==lT1==lLambda==lT1+lT3==lXi==0,(*1-3*)
	lR1==lR2==lR3/2-lR4==lT1==lT2==lLambda==lXi==0,(*3-1*)
	lR1==lR2==lR3/2-lR4==lT1==lT2==lLambda==lT1+lT3==0,(*3-2*)
	lR1==lR2==lR3/2-lR4==lT1==lT2==lLambda==lT1+lT3==lXi==0(*3-3*)
};
