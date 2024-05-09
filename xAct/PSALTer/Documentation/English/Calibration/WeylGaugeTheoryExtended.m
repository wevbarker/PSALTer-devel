(* ::Package:: *)

(*===========================*)
(*  WeylGaugeTheoryExtended  *)
(*===========================*)

(*====================================*)
(*  Preamble: setting out the fields  *)
(*====================================*)
Section@"Setting up extended Weyl gauge theory (eWGT)";
Subsection@"Field strength tensors and the general Lagrangian in the original formulation";

(*We will first load the tetrad and inverse tetrad.*)
DefTensor[WeylTetrad[-a,c],M4,PrintAs->"\[ScriptH]"];
DefTensor[WeylInvTetrad[a,-c],M4,PrintAs->"\[ScriptB]"];

xAct`PSALTer`WeylGaugeTheoryExtended`Private`WeylHBFieldToGF=Join[
	MakeRule[{WeylTetrad[-i,-j],G[-i,-j]+WeylTranslationalGaugeFieldPerturbation[-i,-j]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylInvTetrad[-i,-j],G[-i,-j]-WeylTranslationalGaugeFieldPerturbation[-j,-i]+WeylTranslationalGaugeFieldPerturbation[-i,-m]WeylTranslationalGaugeFieldPerturbation[m,-j]},MetricOn->All,ContractMetrics->True]
];
AutomaticRules[WeylTetrad,MakeRule[{WeylTetrad[-a,i]WeylInvTetrad[a,-j],G[i,-j]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylTetrad,MakeRule[{WeylTetrad[-a,i]WeylInvTetrad[c,-i],G[-a,c]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylTetrad,MakeRule[{CD[-a][WeylTetrad[-j,n]],Evaluate[-WeylTetrad[-i,n]WeylTetrad[-j,m]CD[-a][WeylInvTetrad[i,-m]]]},MetricOn->All,ContractMetrics->True]];

Comment@"The tetrad h is related to the perturbation tetrad f by:";
DisplayExpression[WeylTetrad[-a,c]];
DisplayExpression[WeylTetrad[-a,c]/.xAct`PSALTer`WeylGaugeTheoryExtended`Private`WeylHBFieldToGF//xAct`PSALTer`Private`ToNewCanonical//CollectTensors];

Comment@"We expand the inverse tetrad b w.r.t. the perturbation tetrad, up to second order:";
DisplayExpression[WeylInvTetrad[a,-c]];
DisplayExpression[WeylInvTetrad[a,-c]/.xAct`PSALTer`WeylGaugeTheoryExtended`Private`WeylHBFieldToGF//xAct`PSALTer`Private`ToNewCanonical//CollectTensors];

(*We define A+,T+,R+,H+,D+Phi.*)
(*A+*)
xAct`PSALTer`WeylGaugeTheoryExtended`Private`WeylDaggerASymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalA]\), \(\[Dagger]\)]\)";
DefTensor[WeylDaggerA[a,b,-j],M4,Antisymmetric[{a,b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheoryExtended`Private`WeylDaggerASymb],Dagger->Complex];
(*R+,T+*)
DefTensor[WeylDaggerR[a,b,-d,-e], M4, {Antisymmetric[{a,b}], Antisymmetric[{-d,-e}]},PrintAs->"\!\(\*SuperscriptBox[\(\[ScriptCapitalR]\), \(\[Dagger]\)]\)"]; 
DefTensor[WeylDaggerT[a,-b,-c], M4, Antisymmetric[{-b,-c}],PrintAs->"\!\(\*SuperscriptBox[\(\[ScriptCapitalT]\), \(\[Dagger]\)]\)"]; 
(*D+Phi*)
xAct`PSALTer`WeylGaugeTheoryExtended`Private`WeylCovDerivDaggerOnScalarSymb="\!\((\*SuperscriptBox[\(\[ScriptCapitalD]\), \(\[Dagger]\)]\[Phi])\)";
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

(*We expand A+ (hence R+) and T to the base PGT quantities.*)
WeylDaggerABaseTtoAHBWeylVector=Join[	
	MakeRule[{WeylDaggerA[a,b,-j],Evaluate[WeylRotationalGaugeField[a,b,-j]+WeylVector[b]G[a,-j]-WeylVector[a]G[b,-j]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylBaseT[a,-b,-c],Evaluate[WeylTetrad[-b,i]WeylTetrad[-c,j](CD[-i][WeylInvTetrad[a,-j]]-CD[-j][WeylInvTetrad[a,-i]]+WeylRotationalGaugeField[a,-k,-i]WeylInvTetrad[k,-j]-WeylRotationalGaugeField[a,-k,-j]WeylInvTetrad[k,-i])]},MetricOn->All,ContractMetrics->True]
];

Comment@"The original formulation of eWGT is presented in section III of Lasenby and Hobson 2016, J. Math. Phys. 57, 092505. The torsion is given as:";
DisplayExpression@ToCanonical[WeylDaggerT[a,-b,-c]];
DisplayExpression@CollectTensors@ToCanonical[WeylDaggerT[a,-b,-c]/.WeyDaggerTHCovDtoBaseTWeylVectorHBAndDaggerRtoDaggerA//xAct`PSALTer`Private`ToNewCanonical];

Comment@"The H-field is given below. Note that our notation differs from that of Lasenby and Hobson to facilitate comparison with Lin et al. 2021, Phys. Rev. D 104, 024034: -H \[ShortRightArrow] H, -V \[ShortRightArrow] B.";
DisplayExpression@ToCanonical[WeylDaggerH[-a,-b]];
DisplayExpression@CollectTensors@ToCanonical[WeylDaggerH[-a,-b]/.WeyDaggerTHCovDtoBaseTWeylVectorHBAndDaggerRtoDaggerA//xAct`PSALTer`Private`ToNewCanonical];

Comment@"The covariant derivative acting on the compensator field is given by:";
DisplayExpression@ToCanonical[WeylCovDerivDaggerOnScalar[-a]];
DisplayExpression@CollectTensors@ToCanonical[WeylCovDerivDaggerOnScalar[-a]/.WeyDaggerTHCovDtoBaseTWeylVectorHBAndDaggerRtoDaggerA//xAct`PSALTer`Private`ToNewCanonical];

Comment@"The curvature is given by:";
DisplayExpression@ToCanonical[WeylDaggerR[a,b,-d,-e]];
DisplayExpression@CollectTensors@ToCanonical[WeylDaggerR[a,b,-d,-e]/.WeyDaggerTHCovDtoBaseTWeylVectorHBAndDaggerRtoDaggerA//xAct`PSALTer`Private`ToNewCanonical];

Comment@"The modified A-field of eWGT is expressed in terms of the PGT A-field. We truncate to linear order:";
DisplayExpression@ToCanonical[WeylDaggerA[a,b,-j]];
DisplayExpression@CollectTensors@ToCanonical[WeylDaggerA[a,b,-j]/.WeylDaggerABaseTtoAHBWeylVector//xAct`PSALTer`Private`ToNewCanonical];

Comment@"For completeness, we express the PGT torsion w.r.t. the PGT A-field (eqn. 10a). Similarly, we truncate to linear order:";
DisplayExpression@ToCanonical[WeylBaseT[a,-b,-c]];
DisplayExpression@CollectTensors@ToCanonical[WeylBaseT[a,-b,-c]/.WeylDaggerABaseTtoAHBWeylVector//xAct`PSALTer`Private`ToNewCanonical];

(*=================================*)
(*  Evaluating the various cases  *)
(*=================================*)

(*Here we load the files required to generate the Lagrangian*)
Get@FileNameJoin@{$ThisDirectory,"Calibration","WeylGaugeTheoryExtended","LagrangianWGTECouplings.m"};
Get@FileNameJoin@{$ThisDirectory,"Calibration","WeylGaugeTheoryExtended","LineariseWGTE.m"};
Get@FileNameJoin@{$ThisDirectory,"Calibration","WeylGaugeTheoryExtended","GaugeMapperWGTE.m"};
Get@FileNameJoin@{$ThisDirectory,"Calibration","WeylGaugeTheoryExtended","LagrangianWGTEScaleInvariantRescaling.m"};
Get@FileNameJoin@{$ThisDirectory,"Calibration","WeylGaugeTheoryExtended","GaugeSelectorWGTE.m"};
Get@FileNameJoin@{$ThisDirectory,"Calibration","WeylGaugeTheoryExtended","WGTEGeneralCase.m"};
