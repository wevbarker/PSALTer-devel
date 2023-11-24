(* ::Package:: *)

(*========================*)
(*  CriticalCasesLinWeyl  *)
(*========================*)

(*BasicCriticalCases={
	kR1==kR2==kR3==kR4==kR5==kLambda/4+kT1/3+kT2/12==-kLambda/2-kT1/3+kT2/6==-kLambda-kT1/3+2*kT3/3==0,
	kR1==kR2==kR3==kR4==kR5==kT1==kT2==kT3==0
};*)

(*How do we include the Additional Conditions?*)
	
(*Cases 1-13 from table I of PHYS. REV. D 104, 024034 (2021)*)
CriticalCasesLinWeyl={
	lR1==lR3/2-lR4==lT1==lLambda==0,(*1*)
	lR2==lR1-lR3==lR4==lT1==lT2==lLambda==0,(*2*)
	lR1==lR2==lR3/2-lR4==lT1==lT2==lLambda==0,(*3*)
	lR1==lR3/2-lR4==lT1==lT2==lLambda==0,(*4*)
	lR1==lR2==lR3/2-lR4==lT1==lLambda==0,(*5*)
	lR1==lR3==lR4==lR5==lLambda==0,(*6*)
	lR1==lR3==lR4==lR5==lT1+lT2==lLambda==0,(*7*)
	lR2==lR1-lR3==lR4==lR1+lR5==lT1+lT2==lLambda==0,(*8*)
	lR1==lR3==lR4==lR5==lT1==lLambda==0,(*9*)
	lR1==lR3==lR4==lT1==lLambda==0,(*10*)
	lR1-lR3==lR4==2lR1+lR5==lT1==lLambda==0,(*11*)
	lR1==lR3/2-lR4==2lR3+lR5==lT1==lLambda==0,(*12*)
	lR1==lR3/2-lR4==lR3/2+lR5==lT1==lLambda==0(*13*)
};
