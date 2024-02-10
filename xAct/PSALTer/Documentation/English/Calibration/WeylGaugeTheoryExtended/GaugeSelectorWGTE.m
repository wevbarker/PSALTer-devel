(* ::Package:: *)

(*=====================*)
(*  GaugeSelectorWGTE  *)
(*=====================*)

(*====================================*)
(*  Comments for the gauge selector  *)
(*====================================*)

GaugeSelectorWGTELegend={
	"Original variables - A,f,B,\[Phi]",(*Orig,1*)
	"Natural variables - \!\(\*SuperscriptBox[\(\[ScriptCapitalA]\), \(\[Dagger]\)]\),f,\[Phi]",(*Nat,2*)
	"Scale-invariant variables - \!\(\*SuperscriptBox[\(\!\(\*OverscriptBox[\(\[ScriptCapitalA]\), \(^\)]\)\), \(\[Dagger]\)]\),\!\(\*OverscriptBox[\(f\), \(^\)]\)",(*SIV,3*)
	"Einstein Gauge - \[Phi] \[RightArrow] \!\(\*SubscriptBox[\(\[Phi]\), \(0\)]\)",(*EG,4*)
	"Perturbation around the Einstein Gauge - \[Phi] \[RightArrow] \!\(\*SubscriptBox[\(\[Phi]\), \(0\)]\)(1+\[Phi])"(*EP,5*),
	"NA"(*SIV,6*)
};

GaugeSelectorWGTEPrint[TSGNumber_Integer,WeylNumber_Integer]:=Module[{i=TSGNumber,j=WeylNumber},
	Comment@("The gauge choices are");
	Comment@("| TSG: "<>ToString@GaugeSelectorWGTELegend[[i]]<>" |");
	Comment@("| Weyl: "<>ToString@GaugeSelectorWGTELegend[[j]]<>" |");
];

(*====================================*)
(*  Function for the gauge selector  *)
(*====================================*)

GaugeSelectorWGTEFunction[TSGNumber_Integer:1,WeylNumber_Integer:5,LagrangianCoefficientList_List:{lLambda-lLambda==0}]:=Module[{i=TSGNumber,j=WeylNumber,LCList=LagrangianCoefficientList,LCRule,OutputLagrangian},
	(*Making the coefficient rule*)
	Off[Solve::svars];
	LCRule=First/@(Solve[#,{lLambda,lR1,lR2,lR3,lR4,lR5,lC1,lXi,lNu,lT1,lT2,lT3,lPhi0}]&/@LCList);
	On[Solve::svars];
	Comment@("In terms of original eWGT Lagrangian (Natural variables), the coefficient choice is");
	DisplayExpression@CollectTensors@ToCanonical[First@(NonlinearLagrangianWGTEOriginal/.LCRule)];
	(*Printing the gauge selection*)
	GaugeSelectorWGTEPrint[i,j];
	
	Which[
	i==1&&j==5,  OutputLagrangian=LineariseLagrangianWGTE[First@(NonlinearLagrangianWGTE/.LCRule)], (*Orig1,EP5*)
	i==1&&j==4,  OutputLagrangian=LineariseLagrangianWGTE[(First@(NonlinearLagrangianWGTE/.LCRule))/.{Compensator[]->Scalar[0]}],(*Orig1,EG4*)
	i==2&&j==5,  OutputLagrangian=LineariseLagrangianWGTE[First@(NonlinearLagrangianWGTENaturalVariables/.LCRule)],(*Nat2,EP5*)
	i==2&&j==4,  OutputLagrangian=LineariseLagrangianWGTE[(First@(NonlinearLagrangianWGTENaturalVariables/.LCRule))/.{Compensator[]->Scalar[0]}],(*Nat2,EG4*)
	i==3,  OutputLagrangian=LineariseLagrangianWGTEScaleInvariantRescaling[First@(NonlinearLagrangianWGTEScaleInvariantRescalingPGT/.LCRule)](*SIV3*)];
	
	(*Diagnostic line*)
	Print@"Hi there, I'm sitting between Zhiyuan's code and Will's code!";
OutputLagrangian];

(*=======================================*)
(*  Function to loop all gauge choices  *)
(*=======================================*)
GaugeSelectorWGTELooper[CaseNumber_,LagrangianCoefficientList_List:{lLambda-lLambda==0}]:=Module[{
	LCList=LagrangianCoefficientList,
	Couplings={lLambda,lR1,lR2,lR3,lR4,lR5,lC1,lXi,lNu,lT1,lT2,lT3,lPhi0}},

	Subsection@("Case "<>ToString@CaseNumber<>" under various gauges:");
				
	For[i=1,i<3,i++,For[j=4,j<6,j++,
	ParticleSpectrum[
		GaugeSelectorWGTEFunction[i,j,LCList],
		ClassName->"WeylGaugeTheory",
		TheoryName->"Case"<>ToString@CaseNumber<>"Gauge"<>ToString@i<>ToString@j<>"WGTE",	
		Method->"Easy",
		MaxLaurentDepth->3]]];

	ParticleSpectrum[
		GaugeSelectorWGTEFunction[3,6,LCList],
		ClassName->"WeylGaugeTheory",
		TheoryName->"Case"<>ToString@CaseNumber<>"Gauge36WGTE",	
		Method->"Easy",
		MaxLaurentDepth->3];
	
	Comment@"Okay, that concludes the analysis of this theory under the various gauges.";	
];
