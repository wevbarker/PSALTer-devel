(* ::Package:: *)

(*=================================*)
(*  UnitarityLinWeylZeroCurvature  *)
(*=================================*)

(*Cases 37-42 from table IV of PHYS. REV. D 104, 024034 (2021), need to set A to 0! Not sure how to fully do this?*)
UnitarityLinWeylZeroCurvature={
	{lT2>0,lR2<0,lR3*(2*lR3+lR5)*(lR3+2*lR5)<0},(*1-1*)
	{lT2>0,lR2<0,lR3*(2*lR3+lR5)*(lR3+2*lR5)<0},(*1-2*)	
	{lT2>0,lR2<0,lR3*(2*lR3+lR5)*(lR3+2*lR5)<0},(*1-3*)
	{lR3*(2*lR3+lR5)*(lR3+2*lR5)<0},(*3-1*)
	{lR3*(2*lR3+lR5)*(lR3+2*lR5)<0},(*3-2*)	
	{lR3*(2*lR3+lR5)*(lR3+2*lR5)<0}(*3-3*)
};
