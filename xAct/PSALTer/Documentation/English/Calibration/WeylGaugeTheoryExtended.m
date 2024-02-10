(* ::Package:: *)

(*===========================*)
(*  WeylGaugeTheoryExtended  *)
(*===========================*)
Title@"Weyl gauge theory extended (eWGT)";
Supercomment@"We will test the WeylGaugeTheoryExtended module. This is an extension to test eWGT [Lasenby and Hobson 2016].";
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

xAct`PSALTer`WeylGaugeTheoryExtended`Private`WeylHBFieldToGF=Join[
	MakeRule[{WeylTetrad[-i,-j],G[-i,-j]+WeylTranslationalGaugeFieldPerturbation[-i,-j]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylInvTetrad[-i,-j],G[-i,-j]-WeylTranslationalGaugeFieldPerturbation[-j,-i]+WeylTranslationalGaugeFieldPerturbation[-i,-m]WeylTranslationalGaugeFieldPerturbation[m,-j]},MetricOn->All,ContractMetrics->True]
];
AutomaticRules[WeylTetrad,MakeRule[{WeylTetrad[-a,i]WeylInvTetrad[a,-j],G[i,-j]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylTetrad,MakeRule[{WeylTetrad[-a,i]WeylInvTetrad[c,-i],G[-a,c]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylTetrad,MakeRule[{CD[-a][WeylTetrad[-j,n]],Evaluate[-WeylTetrad[-i,n]WeylTetrad[-j,m]CD[-a][WeylInvTetrad[i,-m]]]},MetricOn->All,ContractMetrics->True]];

Comment@"We present the tetrad in terms of perturbation tetrad f,";
DisplayExpression[WeylTetrad[-a,c]/.xAct`PSALTer`WeylGaugeTheoryExtended`Private`WeylHBFieldToGF//xAct`PSALTer`Private`ToNewCanonical//CollectTensors];
Comment@"and the inverse tetrad in terms of perturbation tetrad f.";
DisplayExpression[WeylInvTetrad[a,-c]/.xAct`PSALTer`WeylGaugeTheoryExtended`Private`WeylHBFieldToGF//xAct`PSALTer`Private`ToNewCanonical//CollectTensors];

(*We define A+,T+,R+,H+,D+Phi.*)
(*A+*)
xAct`PSALTer`WeylGaugeTheoryExtended`Private`WeylDaggerASymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalA]\), \(\[Dagger]\)]\)";
DefTensor[WeylDaggerA[a,b,-j],M4,Antisymmetric[{a,b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheoryExtended`Private`WeylDaggerASymb],Dagger->Complex];
(*R+,T+*)
DefTensor[WeylDaggerR[a,b,-d,-e], M4, {Antisymmetric[{a,b}], Antisymmetric[{-d,-e}]},PrintAs->"\!\(\*SuperscriptBox[\(\[ScriptCapitalR]\), \(\[Dagger]\)]\)"]; 
DefTensor[WeylDaggerT[a,-b,-c], M4, Antisymmetric[{-b,-c}],PrintAs->"\!\(\*SuperscriptBox[\(\[ScriptCapitalT]\), \(\[Dagger]\)]\)"]; 
(*D+Phi*)
xAct`PSALTer`WeylGaugeTheoryExtended`Private`WeylCovDerivDaggerOnScalarSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalD]\), \(\[Dagger]\)]\[Phi]\)";
DefTensor[WeylCovDerivDaggerOnScalar[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheoryExtended`Private`WeylCovDerivDaggerOnScalarSymb],Dagger->Complex];
(*H+*)
xAct`PSALTer`WeylGaugeTheoryExtended`Private`WeylHDaggerSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalH]\), \(\[Dagger]\)]\)";
DefTensor[WeylDaggerH[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheoryExtended`Private`WeylHDaggerSymb],Dagger->Complex];
(*We also need PGT T*)
DefTensor[WeylBaseT[a,-b,-c], M4, Antisymmetric[{-b,-c}],PrintAs->"\[ScriptCapitalT]"]; 

(*Expansion rule, expanding out T+ and H+. Also we expand R+ to A+*)
WeyDaggerTHCovDtoBaseTWeylVectorHBAndDaggerRtoDaggerA=Join[
	MakeRule[{WeylDaggerT[a,-b,-c],Evaluate[WeylBaseT[a,-b,-c]+(1/3)*(G[a,-b]WeylBaseT[d,-c,-d]-G[a,-c]WeylBaseT[e,-b,-e])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylDaggerH[-a,-b],Evaluate[WeylTetrad[-a,i]WeylTetrad[-b,j](CD[-i][WeylVector[-j]-((1/3)*WeylInvTetrad[c,-j]WeylBaseT[e,-c,-e])]-CD[-j][WeylVector[-i]-((1/3)*WeylInvTetrad[d,-i]WeylBaseT[h,-d,-h])])]},MetricOn->All,ContractMetrics->True],		
	MakeRule[{WeylCovDerivDaggerOnScalar[-a],Evaluate[CD[-a][Compensator[]]-(WeylTetrad[-a,i]WeylVector[-i]-(1/3)*WeylBaseT[e,-a,-e])*Compensator[]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylDaggerR[a,b,-d,-e],Evaluate[WeylTetrad[-d,i]WeylTetrad[-e,j](CD[-i][WeylDaggerA[a,b,-j]]-CD[-j][WeylDaggerA[a,b,-i]]+WeylDaggerA[a,-k,-i]WeylDaggerA[k,b,-j]-WeylDaggerA[a,-k,-j]WeylDaggerA[k,b,-i])]},MetricOn->All,ContractMetrics->True]
];

Comment@"We present and expand the eWGT (dagger) field strengths:";
Print@"T+:"
DisplayExpression@CollectTensors@ToCanonical[WeylDaggerT[a,-b,-c]/.WeyDaggerTHCovDtoBaseTWeylVectorHBAndDaggerRtoDaggerA//xAct`PSALTer`Private`ToNewCanonical];
Print@"H+:"
DisplayExpression@CollectTensors@ToCanonical[WeylDaggerH[-a,-b]/.WeyDaggerTHCovDtoBaseTWeylVectorHBAndDaggerRtoDaggerA//xAct`PSALTer`Private`ToNewCanonical];
Print@"CovD+(Phi):"
DisplayExpression@CollectTensors@ToCanonical[WeylCovDerivDaggerOnScalar[-a]/.WeyDaggerTHCovDtoBaseTWeylVectorHBAndDaggerRtoDaggerA//xAct`PSALTer`Private`ToNewCanonical];
Print@"R+:"
DisplayExpression@CollectTensors@ToCanonical[WeylDaggerR[a,b,-d,-e]/.WeyDaggerTHCovDtoBaseTWeylVectorHBAndDaggerRtoDaggerA//xAct`PSALTer`Private`ToNewCanonical];

Get@FileNameJoin@{$ThisDirectory,"Calibration","WeylGaugeTheoryExtended","ToOrderWeylAndRescalingWGTE.m"};
(*
(*We want a linear expression for A+ w.r.t. A. Should work out properly, but not sure if there is any exact and easy way to show other than exhaustively listing.*)
xAct`PSALTer`WeylGaugeTheoryExtended`Private`ADaggerExpandNonlinear=MakeRule[{WeylDaggerA[a,b,-j],Evaluate[WeylRotationalGaugeField[a,b,-j]+WeylVector[i](WeylInvTetrad[a,-j]WeylInvTetrad[b,-i]-WeylInvTetrad[b,-j]WeylInvTetrad[a,-i])]},MetricOn->All,ContractMetrics->True];
xAct`PSALTer`WeylGaugeTheoryExtended`Private`ADaggerExpandNonlinearToLinearEval[ADaggerExpression_]:=Module[{ADaggerEvaluated=ADaggerExpression},
	Comment@"Here is the non-linear expansion of A+ to level of perturbation field f:";
	ADaggerEvaluated=ADaggerEvaluated/.xAct`PSALTer`WeylGaugeTheoryExtended`Private`ADaggerExpandNonlinear;
	ADaggerEvaluated=ADaggerEvaluated/.xAct`PSALTer`WeylGaugeTheoryExtended`Private`WeylHBFieldToGF;
	ADaggerEvaluated//=xAct`PSALTer`Private`ToNewCanonical;
	DisplayExpression@CollectTensors@ToCanonical[ADaggerEvaluated];
	Comment@"Here is the linearised expansion:";
	ADaggerEvaluated=ADaggerEvaluated/.ToOrderWeyl;
	ADaggerEvaluated//=Series[#,{PerturbativeParameterWeyl,0,1}]&;(*To linear order*)
	ADaggerEvaluated//=Normal;
	ADaggerEvaluated=ADaggerEvaluated/.PerturbativeParameterWeyl->1;
	ADaggerEvaluated//=xAct`PSALTer`Private`ToNewCanonical;
	DisplayExpression@CollectTensors@ToCanonical[ADaggerEvaluated];
ADaggerEvaluated];
xAct`PSALTer`WeylGaugeTheoryExtended`Private`ADaggerExpandNonlinearToLinearEval[WeylDaggerA[a,b,-j]];
*)
(*Now we expand A+ (hence R+) and T to the base PGT quantities.*)
WeylDaggerABaseTtoAHBWeylVector=Join[	
	MakeRule[{WeylDaggerA[a,b,-j],Evaluate[WeylRotationalGaugeField[a,b,-j]+WeylVector[b]G[a,-j]-WeylVector[a]G[b,-j]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylBaseT[a,-b,-c],Evaluate[WeylTetrad[-b,i]WeylTetrad[-c,j](CD[-i][WeylInvTetrad[a,-j]]-CD[-j][WeylInvTetrad[a,-i]]+WeylRotationalGaugeField[a,-k,-i]WeylInvTetrad[k,-j]-WeylRotationalGaugeField[a,-k,-j]WeylInvTetrad[k,-i])]},MetricOn->All,ContractMetrics->True]
];

Comment@"We present and expand A+ and T into PGT field strengths:";
Print@"A+:"
DisplayExpression@CollectTensors@ToCanonical[WeylDaggerA[a,b,-j]/.WeylDaggerABaseTtoAHBWeylVector//xAct`PSALTer`Private`ToNewCanonical];
Print@"T:"
DisplayExpression@CollectTensors@ToCanonical[WeylBaseT[a,-b,-c]/.WeylDaggerABaseTtoAHBWeylVector//xAct`PSALTer`Private`ToNewCanonical];
(*
Print@"Check two expressions for A+ are the same:"
DisplayExpression@CollectTensors@ToCanonical[xAct`PSALTer`WeylGaugeTheoryExtended`Private`ADaggerExpandNonlinearToLinearEval[WeylDaggerA[a,b,-j]]-Evaluate[WeylDaggerA[a,b,-j]/.WeylDaggerABaseTtoAHBWeylVector]];
*)
Supercomment@"Now we have defined all the fields we need.";

(*=================================*)
(*  Evaluating the various cases  *)
(*=================================*)

(*Here we load the files required to generate the Lagrangian*)
Get@FileNameJoin@{$ThisDirectory,"Calibration","WeylGaugeTheoryExtended","LagrangianWGTECouplings.m"};
Get@FileNameJoin@{$ThisDirectory,"Calibration","WeylGaugeTheoryExtended","LineariseWGTE.m"};
Get@FileNameJoin@{$ThisDirectory,"Calibration","WeylGaugeTheoryExtended","LagrangianWGTEScaleInvariantRescaling.m"};
Get@FileNameJoin@{$ThisDirectory,"Calibration","WeylGaugeTheoryExtended","LineariseWGTEScaleInvariantRescaling.m"};
Get@FileNameJoin@{$ThisDirectory,"Calibration","WeylGaugeTheoryExtended","LagrangianWGTENaturalVariables.m"};
Get@FileNameJoin@{$ThisDirectory,"Calibration","WeylGaugeTheoryExtended","GaugeSelectorWGTE.m"};
Get@FileNameJoin@{$ThisDirectory,"Calibration","WeylGaugeTheoryExtended","WGTEGeneralCase.m"};
