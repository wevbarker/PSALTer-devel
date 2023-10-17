(* ::Package:: *)

(*===================*)
(*  WeylGaugeTheory  *)
(*===================*)
Title@"Weyl gauge theory (WGT)";
Supercomment@"We will test the WeylGaugeTheory module.";
Supercomment@"This section is still under development by Zhiyuan.";

(*====================================*)
(*  Preamble: setting out the fields  *)
(*====================================*)
Section@"Preamble: setting out the fields";

(*We will first load the tetrad and inverse tetrad.*)
Comment@"We present the tetrad,";
DefTensor[WeylTetrad[-a,c],M4,PrintAs->"\[ScriptH]"];
DisplayExpression[WeylTetrad[-a,c]];

Comment@"and the inverse tetrad.";
DefTensor[WeylInvTetrad[a,-c],M4,PrintAs->"\[ScriptB]"];
DisplayExpression[WeylInvTetrad[a,-c]];

xAct`PSALTer`WeylGaugeTheory`Private`WeylHBFieldToGF=Join[
	MakeRule[{WeylTetrad[-i,-j],G[-i,-j]+WeylTranslationalGaugeFieldPerturbation[-i,-j]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylInvTetrad[-i,-j],G[-i,-j]-WeylTranslationalGaugeFieldPerturbation[-j,-i]+WeylTranslationalGaugeFieldPerturbation[-i,-m]WeylTranslationalGaugeFieldPerturbation[m,-j]},MetricOn->All,ContractMetrics->True]
];
AutomaticRules[WeylTetrad,MakeRule[{WeylTetrad[-a,i]WeylInvTetrad[a,-j],G[i,-j]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylTetrad,MakeRule[{WeylTetrad[-a,i]WeylInvTetrad[c,-i],G[-a,c]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylTetrad,MakeRule[{CD[-a][WeylTetrad[-j,n]],Evaluate[-WeylTetrad[-i,n]WeylTetrad[-j,m]CD[-a][WeylInvTetrad[i,-m]]]},MetricOn->All,ContractMetrics->True]];

Comment@"We present the tetrad in terms of perturbation tetrad f,";
DisplayExpression[WeylTetrad[-a,c]/.xAct`PSALTer`WeylGaugeTheory`Private`WeylHBFieldToGF//xAct`PSALTer`Private`ToNewCanonical//CollectTensors];
Comment@"and the inverse tetrad in terms of perturbation tetrad f.";
DisplayExpression[WeylInvTetrad[a,-c]/.xAct`PSALTer`WeylGaugeTheory`Private`WeylHBFieldToGF//xAct`PSALTer`Private`ToNewCanonical//CollectTensors];

(*Now we define the field strengths T and R (the base, unstarred PGT values)*)
DefTensor[WeylBaseR[a, b, -d, -e], M4, {Antisymmetric[{a, b}], Antisymmetric[{-d, -e}]},PrintAs->"\[ScriptCapitalR]"]; 
DefTensor[WeylBaseT[a, -b, -c], M4, Antisymmetric[{-b, -c}],PrintAs->"\[ScriptCapitalT]"]; 

WeylRTToHBFieldACDBFieldCDA=Join[	
	MakeRule[{WeylBaseR[a,b,-d,-e],WeylTetrad[-d,i]WeylTetrad[-e,j](CD[-i][WeylRotationalGaugeField[a,b,-j]]-CD[-j][WeylRotationalGaugeField[a,b,-i]]+WeylRotationalGaugeField[a,-k,-i]WeylRotationalGaugeField[k,b,-j]-WeylRotationalGaugeField[a,-k,-j]WeylRotationalGaugeField[k,b,-i])},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylBaseT[a,-b,-c],(WeylTetrad[-b,i]WeylTetrad[-c,j])(CD[-i][WeylInvTetrad[a,-j]]-CD[-j][WeylInvTetrad[a,-i]]+WeylRotationalGaugeField[a,-k,-i]WeylInvTetrad[k,-j]-WeylRotationalGaugeField[a,-k,-j]WeylInvTetrad[k,-i])},MetricOn->All,ContractMetrics->True]
];

(*Here we load the files required to generate the Lagrangian*)
Get@FileNameJoin@{NotebookDirectory[],"Calibration","WeylGaugeTheory","LagrangianLinWeylCouplings.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","WeylGaugeTheory","LineariseLinWeyl.m"};

Comment@"We expand the field strength R into the unstarred PGT quantities.";
DisplayExpression[WeylBaseR[a, b, -d, -e]/.WeylRTToHBFieldACDBFieldCDA//xAct`PSALTer`Private`ToNewCanonical//CollectTensors];
Comment@"We expand the field strength T into the unstarred PGT quantities.";
DisplayExpression[WeylT[c,-a,-b]/.xAct`PSALTer`LagrangianLinWeylCouplings`Private`WeylQuantitiesExpand//xAct`PSALTer`Private`ToNewCanonical//CollectTensors];
DisplayExpression[WeylT[c,-a,-b]/.xAct`PSALTer`LagrangianLinWeylCouplings`Private`WeylQuantitiesExpand/.WeylRTToHBFieldACDBFieldCDA//xAct`PSALTer`Private`ToNewCanonical//CollectTensors];
Comment@"We expand the field strength H into the unstarred PGT quantities.";
DisplayExpression[WeylH[-a,-b]/.xAct`PSALTer`LagrangianLinWeylCouplings`Private`WeylQuantitiesExpand//xAct`PSALTer`Private`ToNewCanonical//CollectTensors];
Comment@"We expand the field strength CovD of Phi into the unstarred PGT quantities.";
DisplayExpression[WeylCovariantDerivativeOnScalar[-i]/.xAct`PSALTer`LagrangianLinWeylCouplings`Private`WeylQuantitiesExpand//xAct`PSALTer`Private`ToNewCanonical//CollectTensors];

Supercomment@"Now we have defined all the fields we need.";

(*============================*)
(*  Test case 1: E--H action  *)
(*============================*)
Section@"Test case 1: E--H action.";
(*
(*Test case to check if issue was in Solve settings. *)
TestEHLagrangian = (-lLambda*(Compensator[]^2)*WeylBaseR[a,b,-a,-b]);
DisplayExpression@CollectTensors@ToCanonical[TestEHLagrangian];

LinearisedTestEHLagrangian=LineariseLagrangianLinWeyl[TestEHLagrangian];
Comment@{"Here is the linearised Lagrangian before feeding into ParticleSpectrum[]."};
DisplayExpression@CollectTensors@ToCanonical[LinearisedTestEHLagrangian];

(*Diagnostic line*)
Print@"Hi there, I'm sitting between Zhiyuan's code and Will's code! I use method -> hard mode.";

ParticleSpectrum[
	LinearisedTestEHLagrangian,
	ClassName->"WeylGaugeTheory",
	TheoryName->"TestWGTwithEHTestSolve",	
	Method->"Hard",
	MaxLaurentDepth->3
];

Supercomment@"This marks the completion of the particle spectrum analysis for the modified E--H action. Here we directly use the E--H action instead of depending on Lin couplings.";
*)

Comment@"We test the case of the modified Einstein-Hilbert action, and the code will give only 2 propagating graviton modes.";
TestCase={lR1==lR2==lR3==lR4==lR5==lC1==lXi==lNu==(lT1+lLambda)==(lT2-lLambda)==(lT3-lLambda)==0};
Off[Solve::svars];
TestCaseRules=First/@(Solve[#,{lLambda,lR1,lR2,lR3,lR4,lR5,lC1,lXi,lNu,lT1,lT2,lT3,lPhi0}]&/@TestCase);
On[Solve::svars];

DisplayExpression@CollectTensors@ToCanonical[First@((NonlinearLagrangianLinWeyl)/.TestCaseRules)];
LinearisedLagrangianLinWeyl=LineariseLagrangianLinWeyl[First@((NonlinearLagrangianLinWeyl)/.TestCaseRules)];

Comment@{"Here is the linearised Lagrangian before feeding into ParticleSpectrum[]."};
DisplayExpression@CollectTensors@ToCanonical[LinearisedLagrangianLinWeyl];

(*Diagnostic line*)
Print@"Hi there, I'm sitting between Zhiyuan's code and Will's code! I use method -> hard mode.";

ParticleSpectrum[
	LinearisedLagrangianLinWeyl,
	ClassName->"WeylGaugeTheory",
	TheoryName->"TestWGTwithEH",	
	Method->"Hard",
	MaxLaurentDepth->3
];

Supercomment@"This marks the completion of the particle spectrum analysis for the modified E--H action.";

(*=========================================================*)
(*  Test case 2: E--H action with propagating compensator  *)
(*=========================================================*)
Section@"Test case 2: E--H action with propagating compensator.";
Comment@"We test the case of the modified Einstein-Hilbert action, with propagating compensator.";

TestCase2={lR1==lR2==lR3==lR4==lR5==lC1==lXi==(lT1+lLambda)==(lT2-lLambda)==(lT3-lLambda)==0};
Off[Solve::svars];
TestCase2Rules=First/@(Solve[#,{lLambda,lR1,lR2,lR3,lR4,lR5,lC1,lXi,lNu,lT1,lT2,lT3,lPhi0}]&/@TestCase2);
On[Solve::svars];

DisplayExpression@CollectTensors@ToCanonical[First@((NonlinearLagrangianLinWeyl)/.TestCase2Rules)];
LinearisedLagrangianLinWeyl=LineariseLagrangianLinWeyl[First@((NonlinearLagrangianLinWeyl)/.TestCase2Rules)];
Comment@{"Here is the linearised Lagrangian before feeding into ParticleSpectrum[]."};
DisplayExpression@CollectTensors@ToCanonical[LinearisedLagrangianLinWeyl];

(*Diagnostic line*)
Print@"Hi there, I'm sitting between Zhiyuan's code and Will's code! I use method -> hard mode.";

ParticleSpectrum[
	LinearisedLagrangianLinWeyl,
	ClassName->"WeylGaugeTheory",
	TheoryName->"TestWGTwithEHwithPropagator",	
	Method->"Hard",
	MaxLaurentDepth->3
];

Supercomment@"This marks the completion of the particle spectrum analysis for the modified E--H action with propagating compensator.";

(*=====================================================================*)
(*  Test case 3: E--H action with propagating compensator and vector.  *)
(*=====================================================================*)
Section@"Test case 3: E--H action with propagating compensator and vector.";
Comment@"We test the case of the modified Einstein-Hilbert action, with propagating compensator and vector B.";

TestCase3={lR1==lR2==lR3==lR4==lR5==(lT1+lLambda)==(lT2-lLambda)==(lT3-lLambda)==0};
Off[Solve::svars];
TestCase3Rules=First/@(Solve[#,{lLambda,lR1,lR2,lR3,lR4,lR5,lC1,lXi,lNu,lT1,lT2,lT3,lPhi0}]&/@TestCase3);
On[Solve::svars];

DisplayExpression@CollectTensors@ToCanonical[First@((NonlinearLagrangianLinWeyl)/.TestCase3Rules)];
LinearisedLagrangianLinWeyl=LineariseLagrangianLinWeyl[First@((NonlinearLagrangianLinWeyl)/.TestCase3Rules)];
Comment@{"Here is the linearised Lagrangian before feeding into ParticleSpectrum[]."};
DisplayExpression@CollectTensors@ToCanonical[LinearisedLagrangianLinWeyl];

(*Diagnostic line*)
Print@"Hi there, I'm sitting between Zhiyuan's code and Will's code! I use method -> hard mode.";

ParticleSpectrum[
	LinearisedLagrangianLinWeyl,
	ClassName->"WeylGaugeTheory",
	TheoryName->"TestWGTwithEHwithPropagatorVector",	
	Method->"Hard",
	MaxLaurentDepth->3
];

Supercomment@"This marks the completion of the particle spectrum analysis for the modified E--H action with propagating compensator and vector.";

(*=====================*)
(*  Most general WGT  *)
(*=====================*)
Section@"Most general WGT";
Comment@{"We will study the most general WGT as defined in eqn 10 of Lin et. al. 2021, PHYS. REV. D 104, 024034."};

DisplayExpression@CollectTensors@ToCanonical[NonlinearLagrangianLinWeyl];
LinearisedLagrangianLinWeyl=LineariseLagrangianLinWeyl[NonlinearLagrangianLinWeyl];

Comment@{"Here is the linearised Lagrangian before feeding into ParticleSpectrum[]."};
DisplayExpression@CollectTensors@ToCanonical[LinearisedLagrangianLinWeyl];

(*Diagnostic line*)
Print@"Hi there, I'm sitting between Zhiyuan's code and Will's code! Method -> Hard mode.";

ParticleSpectrum[
	LinearisedLagrangianLinWeyl,
	ClassName->"WeylGaugeTheory",
	TheoryName->"GeneralWGT",	
	Method->"Hard",
	MaxLaurentDepth->3
];

Supercomment@"This marks the completion of the particle spectrum analysis for the general WGT."

(*=============================================*)
(*  WGT critical cases from Lin et. al. 2021  *)
(*=============================================*)

(*
Section@"Evaluating the critical cases of WGT";

(*Here we load the required files for the critical cases analysis*)
Get@FileNameJoin@{NotebookDirectory[],"Calibration","WeylGaugeTheory","CriticalCasesLinWeyl.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","WeylGaugeTheory","UnitarityLinWeyl.m"};

Off[Solve::svars];
CriticalCasesSolutionsLinWeyl=First/@(Solve[#,{lLambda,lR1,lR2,lR3,lR4,lR5,lC1,lXi,lNu,lT1,lT2,lT3,lPhi0}]&/@CriticalCasesLinWeyl);
On[Solve::svars];

Comment@"We are now ready to check that PSALTer is getting the physics right by running it on the WGT cases in Lin et. al. 2021. We are looking at cases 1-13 here.";
Get@FileNameJoin@{NotebookDirectory[],"Calibration","WeylGaugeTheory","CalibrateCaseLinWeyl.m"};
CalibrationTimingDataLinWeyl=MapThread[
		AbsoluteTiming@CalibrateCaseLinWeyl[#1,#2,#3]&,
		{
			Table[i,{i,1,13}],
			CriticalCasesSolutionsLinWeyl[[1;;13]],(*formerly 1--42*)
			UnitarityLinWeyl[[1;;13]]
		}];
*)
		
(*
Section@"How long did this take?";
Comment@"Computation complete; all the cases have been evaluated. You can see from the timing below (in seconds):";
DisplayExpression@CalibrationTimingDataLinWeyl;
*)

(*DumpSave[FileNameJoin@{NotebookDirectory[],"CalibrationTimingDataLinWeyl.mx"},{CalibrationTimingDataLinWeyl}];*)
