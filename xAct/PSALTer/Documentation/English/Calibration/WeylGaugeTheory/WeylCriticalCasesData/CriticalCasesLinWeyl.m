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
(*Section IV.A: For general Lagrangian, Lin sets lNu==lXi==lC1==0*)
CriticalCasesLinWeyl={
	lNu==lXi==lC1==lR1==lR3/2-lR4==lT1==lLambda==0,(*1*)
	lNu==lXi==lC1==lR2==lR1-lR3==lR4==lT1==lT2==lLambda==0,(*2*)
	lNu==lXi==lC1==lR1==lR2==lR3/2-lR4==lT1==lT2==lLambda==0,(*3*)
	lNu==lXi==lC1==lR1==lR3/2-lR4==lT1==lT2==lLambda==0,(*4*)
	lNu==lXi==lC1==lR1==lR2==lR3/2-lR4==lT1==lLambda==0,(*5*)
	lNu==lXi==lC1==lR1==lR3==lR4==lR5==lLambda==0,(*6*)
	lNu==lXi==lC1==lR1==lR3==lR4==lR5==lT1+lT2==lLambda==0,(*7*)
	lNu==lXi==lC1==lR2==lR1-lR3==lR4==lR1+lR5==lT1+lT2==lLambda==0,(*8*)
	lNu==lXi==lC1==lR1==lR3==lR4==lR5==lT1==lLambda==0,(*9*)
	lNu==lXi==lC1==lR1==lR3==lR4==lT1==lLambda==0,(*10*)
	lNu==lXi==lC1==lR1-lR3==lR4==2lR1+lR5==lT1==lLambda==0,(*11*)
	lNu==lXi==lC1==lR1==lR3/2-lR4==2lR3+lR5==lT1==lLambda==0,(*12*)
	lNu==lXi==lC1==lR1==lR3/2-lR4==lR3/2+lR5==lT1==lLambda==0(*13*)
};
