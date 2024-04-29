(* ::Package:: *)

(*=====================*)
(*  GaugeSelectorWGTE  *)
(*=====================*)
Supercomment@"We now have four gauge choices/field reformulations that must give equivalent physics and particle spectra: choosing original vs. natural variables (w.r.t. TSG symmetry), and choosing Einstein gauge or perturbation (w.r.t. Weyl symmetry). We also see that using both natural variables and the Einstein gauge is the same as using the scale-invariant formulation. We now proceed to run through test cases of the eWGT Lagrangian to check that the four formulations indeed give the same results up to differences in residue. Differences in residue may arise as the various gauge choices remove different rows and columns from the (singular) propagator matrix.";
(*====================================*)
(*  Comments for the gauge selector  *)
(*====================================*)

GaugeSelectorWGTELegend={
	"Original variables",(*Orig,1*)
	"Natural variables",(*Nat,2*)
	"Scale-invariant variables",(*SIV,3*)
	"Einstein gauge",(*EG,4*)
	"Perturbation around the Einstein gauge"(*EP,5*),
	"NA"(*SIV,6*)
};

GaugeSelectorWGTEPrint[TSGNumber_Integer,WeylNumber_Integer]:=Module[{i=TSGNumber,j=WeylNumber},
	Comment@("The gauge choices are");
	Print@("TSG: "<>ToString@GaugeSelectorWGTELegend[[i]]<>" ");
	Print@("Weyl: "<>ToString@GaugeSelectorWGTELegend[[j]]<>" ");
];

(*====================================*)
(*  Function for the gauge selector  *)
(*====================================*)

GaugeSelectorWGTEFunction[TSGNumber_Integer:1,WeylNumber_Integer:5,InputLagrangian_:LinearisedLagrangianWGTEOriginal]:=Module[{
	OutputLagrangian},
	
	(*Printing the gauge selection*)
	GaugeSelectorWGTEPrint[TSGNumber,WeylNumber];
	
	Which[
	TSGNumber==1&&WeylNumber==5,  OutputLagrangian=InputLagrangian(*Orig1,EP5*),
	TSGNumber==1&&WeylNumber==4,  OutputLagrangian=InputLagrangian/.{Compensator->Zero}/.WGTEToEinsteinGaugeOriginalVariables(*Orig1,EG4*),
	TSGNumber==2&&WeylNumber==5,  OutputLagrangian=InputLagrangian/.{WeylVector->Zero}/.WGTEToNaturalVariables(*Nat2,EP5*),
	TSGNumber==2&&WeylNumber==4,  OutputLagrangian=InputLagrangian/.{WeylVector->Zero}/.{Compensator->Zero}/.WGTEToSIVariables(*Nat2,EG4*),
	TSGNumber==3,  OutputLagrangian=InputLagrangian/.WGTEToSIVariables(*LinearisedLagrangianWGTESIV, SIV3*)];
OutputLagrangian];

(*=======================================*)
(*  Function for theory class selector  *)
(*=======================================*)

TheorySelectorWGTEFunction[TSGNumber_Integer:1,WeylNumber_Integer:5]:=Module[{OutputTheoryClass},
	Which[
	TSGNumber==1&&WeylNumber==5,  OutputTheoryClass="WeylGaugeTheory"(*Orig1,EP5*),
	TSGNumber==1&&WeylNumber==4,  OutputTheoryClass="WeylEinsteinGaugeTheory"(*Orig1,EG4*),
	TSGNumber==2&&WeylNumber==5,  OutputTheoryClass="WeylNaturalGaugeTheory"(*Nat2,EP5*),
	TSGNumber==2&&WeylNumber==4,  OutputTheoryClass="WeylSIVGaugeTheory"(*Nat2,EG4*),
	TSGNumber==3,  OutputTheoryClass="WeylSIVGaugeTheory"(*SIV3*)];
OutputTheoryClass];
