(* ::Package:: *)

(*=====================*)
(*  GaugeSelectorWGTE  *)
(*=====================*)
(*====================================*)
(*  Comments for the gauge selector  *)
(*====================================*)

GaugeSelectorWGTELegend={
	"Original variables - A,f,B,\[Phi]",(*Orig,1*)
	"Natural variables - A+,f,\[Phi]",(*Nat,2*)
	"Scale-invariant variables - A+_hat,f_hat",(*SIV,3*)
	"Einstein Gauge - \[Phi] \[RightArrow] \[Phi]0",(*EG,4*)
	"Perturbation around the Einstein Gauge - \[Phi] \[RightArrow] \[Phi]0(1+\[Phi])"(*EP,5*),
	"NA"(*SIV,6*)
};

GaugeSelectorWGTEPrint[TSGNumber_Integer,WeylNumber_Integer]:=Module[{i=TSGNumber,j=WeylNumber},
	Comment@("The gauge choices are");
	Print@("| TSG: "<>ToString@GaugeSelectorWGTELegend[[i]]<>" |");
	Print@("| Weyl: "<>ToString@GaugeSelectorWGTELegend[[j]]<>" |");
];

(*====================================*)
(*  Function for the gauge selector  *)
(*====================================*)

GaugeSelectorWGTEFunction[TSGNumber_Integer:1,WeylNumber_Integer:5]:=Module[{
	OutputLagrangian},
	OutputLagrangian=LinearisedLagrangianWGTEOriginal;
	
	(*Printing the gauge selection*)
	GaugeSelectorWGTEPrint[TSGNumber,WeylNumber];
	
	Which[
	TSGNumber==1&&WeylNumber==5,  OutputLagrangian=OutputLagrangian(*Orig1,EP5*),
	TSGNumber==1&&WeylNumber==4,  OutputLagrangian=OutputLagrangian/.{Compensator->Zero}/.WGTEToEinsteinGaugeOriginalVariables(*Orig1,EG4*),
	TSGNumber==2&&WeylNumber==5,  OutputLagrangian=OutputLagrangian/.{WeylVector->Zero}/.WGTEToNaturalVariables(*Nat2,EP5*),
	TSGNumber==2&&WeylNumber==4,  OutputLagrangian=OutputLagrangian/.{WeylVector->Zero}/.{Compensator->Zero}/.WGTEToSIVariables(*Nat2,EG4*),
	TSGNumber==3,  OutputLagrangian=LinearisedLagrangianWGTESIV/.WGTEToSIVariables(*SIV3*)];
	
	(*Diagnostic line*)
	Print@"Diagnostic: the linearised Lagrangian is displayed prior to feeding into PSALTer. We can see that the substitutions have been made to send the Lagrangian to the correct theory class.";
	DisplayExpression@CollectTensors@ToCanonical[OutputLagrangian];
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
