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
Get@FileNameJoin@{$ThisDirectory,"Calibration","WeylGaugeTheory","LagrangianLinWeylCouplings.m"};
Get@FileNameJoin@{$ThisDirectory,"Calibration","WeylGaugeTheory","LineariseLinWeyl.m"};

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

(*=================================*)
(*  Evaluating the various cases  *)
(*=================================*)

(*Get@FileNameJoin@{NotebookDirectory[],"Calibration","WeylGaugeTheory","WeylSimpleTestCases.m"};*)
(*Get@FileNameJoin@{NotebookDirectory[],"Calibration","WeylGaugeTheory","WeylGeneralCase.m"};*)
(*Get@FileNameJoin@{NotebookDirectory[],"Calibration","WeylGaugeTheory","LinWeylCriticalCases01To13.m"};*)
(*Get@FileNameJoin@{NotebookDirectory[],"Calibration","WeylGaugeTheory","LinWeylCriticalCases14To36.m"};*)
Get@FileNameJoin@{NotebookDirectory[],"Calibration","WeylGaugeTheory","LinWeylCriticalCases37To42.m"};