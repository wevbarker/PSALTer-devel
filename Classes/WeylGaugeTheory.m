(* ::Package:: *)

(*===================*)
(*  WeylGaugeTheory  *)
(*===================*)

BeginPackage["xAct`PSALTer`WeylGaugeTheory`",{"xAct`xTensor`","xAct`xPerm`","xAct`xCore`","xAct`xTras`","xAct`xCoba`","xAct`PSALTer`"}];

(*=================================================================*)
(*  Basic definitions of gauge fields and their conjugate sources  *)
(*=================================================================*)

xAct`PSALTer`WeylGaugeTheory`Private`WeylVectorSymb="\[ScriptCapitalB]";
DefTensor[WeylVector[-d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`WeylVectorSymb],Dagger->Complex];

xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylVectorSymb="\[ScriptCapitalJ]";
DefTensor[ConjugateSourceWeylVector[-d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylVectorSymb],Dagger->Complex];

xAct`PSALTer`WeylGaugeTheory`Private`CompensatorSymb="\[Phi]";
DefTensor[Compensator[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`CompensatorSymb],Dagger->Complex];

xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceCompensatorSymb="\[Rho]";
DefTensor[ConjugateSourceCompensator[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceCompensatorSymb],Dagger->Complex];

xAct`PSALTer`WeylGaugeTheory`Private`WeylRotationalGaugeFieldSymb="\[ScriptCapitalA]";
DefTensor[WeylRotationalGaugeField[a,c,-d],M4,Antisymmetric[{a,c}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`WeylRotationalGaugeFieldSymb],Dagger->Complex];

(*Is there something wrong with the Conjugate Rotational Gauge field index symmetry?*)
xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylRotationalGaugeFieldSymb="\[Sigma]";
DefTensor[ConjugateSourceWeylRotationalGaugeField[-i,-j,-k],M4,Antisymmetric[{-j,-k}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylRotationalGaugeFieldSymb],Dagger->Complex];

xAct`PSALTer`WeylGaugeTheory`Private`WeylTranslationalGaugeFieldPerturbationSymb="\[ScriptF]";
DefTensor[WeylTranslationalGaugeFieldPerturbation[-i,-j],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`WeylTranslationalGaugeFieldPerturbationSymb],Dagger->Complex];

xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylTranslationalGaugeFieldPerturbationSymb="\[Tau]";
DefTensor[ConjugateSourceWeylTranslationalGaugeFieldPerturbation[-i,-j],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylTranslationalGaugeFieldPerturbationSymb],Dagger->Complex];

(*==============*)
(*  Projectors  *)
(*==============*)

(*====================================*)
(*  Basic perpendicular and parallel  *)
(*====================================*)

xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[UpTee]\)]\)";
DefTensor[ProjPerp[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpSymb]];
xAct`PSALTer`WeylGaugeTheory`Private`ProjParaSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[DoubleVerticalBar]\)]\)";
DefTensor[ProjPara[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ProjParaSymb]];

xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG=Join[
	MakeRule[{ProjPerp[-a,b],Evaluate[V[-a]V[b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjPara[-a,b],Evaluate[G[-a,b]-V[-a]V[b]]},MetricOn->All,ContractMetrics->True]];

(*====================================*)
(*  Field perpendicular and parallel  *)
(*====================================*)

DefTensor[ProjWeylRotationalGaugeFieldPerp[-a,-b,d,e,f],M4];
DefTensor[ProjWeylRotationalGaugeFieldPara[-a,-b,-c,d,e,f],M4];
DefTensor[ProjWeylTranslationalGaugeFieldPerturbationPerp[-a,d,e],M4];
DefTensor[ProjWeylTranslationalGaugeFieldPerturbationPara[-a,-b,d,e],M4];

xAct`PSALTer`WeylGaugeTheory`Private`ProjWeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldPerpParaToVG=Join[
	MakeRule[{ProjWeylRotationalGaugeFieldPerp[-a,-b,d,e,f],Evaluate[
		V[d]ProjPara[-a,e]G[-b,f]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylRotationalGaugeFieldPara[-a,-b,-c,d,e,f],Evaluate[
		ProjPara[-a,d]ProjPara[-b,e]G[-c,f]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylTranslationalGaugeFieldPerturbationPerp[-a,d,e],Evaluate[
		V[d]G[-a,e]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylTranslationalGaugeFieldPerturbationPara[-a,-b,d,e],Evaluate[
		ProjPara[-a,d]G[-b,e]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*==============================*)
(*  Spin-parity or SO(3) parts  *)
(*==============================*)

xAct`PSALTer`WeylGaugeTheory`Private`ProjWeylRotationalGaugeFieldSymb="\!\(\*SubscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(\[Hacek]\)],\(\[ScriptCapitalA]\)]\)";
DefTensor[ProjWeylRotationalGaugeField0p[c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ProjWeylRotationalGaugeFieldSymb,xAct`PSALTer`Private`Spin0p]];
DefTensor[ProjWeylRotationalGaugeField0m[d,e,f],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ProjWeylRotationalGaugeFieldSymb,xAct`PSALTer`Private`Spin0m]];
DefTensor[ProjWeylRotationalGaugeField1p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ProjWeylRotationalGaugeFieldSymb,xAct`PSALTer`Private`Spin1p]];
DefTensor[ProjWeylRotationalGaugeField1m[-a,d,e,f],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ProjWeylRotationalGaugeFieldSymb,xAct`PSALTer`Private`Spin1m]];
DefTensor[ProjWeylRotationalGaugeField2p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ProjWeylRotationalGaugeFieldSymb,xAct`PSALTer`Private`Spin2p]];
DefTensor[ProjWeylRotationalGaugeField2m[-a,-b,-c,d,e,f],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ProjWeylRotationalGaugeFieldSymb,xAct`PSALTer`Private`Spin2m]];

xAct`PSALTer`WeylGaugeTheory`Private`ProjWeylTranslationalGaugeFieldPerturbationSymb="\!\(\*SubscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(\[Hacek]\)],\(\[ScriptB]\)]\)";
DefTensor[ProjWeylTranslationalGaugeFieldPerturbation0p[c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ProjWeylTranslationalGaugeFieldPerturbationSymb,xAct`PSALTer`Private`Spin0p]];
DefTensor[ProjWeylTranslationalGaugeFieldPerturbation1p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ProjWeylTranslationalGaugeFieldPerturbationSymb,xAct`PSALTer`Private`Spin1p]];
DefTensor[ProjWeylTranslationalGaugeFieldPerturbation2p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ProjWeylTranslationalGaugeFieldPerturbationSymb,xAct`PSALTer`Private`Spin2p]];
DefTensor[ProjWeylTranslationalGaugeFieldPerturbation1m[-a,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ProjWeylTranslationalGaugeFieldPerturbationSymb,xAct`PSALTer`Private`Spin1m]];

xAct`PSALTer`WeylGaugeTheory`Private`ProjWeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldSpinParityToVG=Join[
	MakeRule[{ProjWeylRotationalGaugeField0p[c,d],Evaluate[
		ProjPara[c,-k]ProjPara[d,-l]G[k,l]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylRotationalGaugeField1p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l]Antisymmetrize[G[-i,k]G[-j,l],{-i,-j}]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylRotationalGaugeField2p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l](Symmetrize[G[-i,k]G[-j,l],{-i,-j}]-(1/3)G[-i,-j]G[k,l])/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylRotationalGaugeField0m[d,e,f],Evaluate[
		ProjPara[-i,d]ProjPara[-j,e]ProjPara[-k,f]epsilonG[i,j,k,g]V[-g]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylRotationalGaugeField1m[-a,d,e,f],Evaluate[
		ProjPara[-i,d]ProjPara[-j,f]ProjPara[k,-a]ProjPara[-l,e]G[i,j]G[-k,l]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylRotationalGaugeField2m[-a,-b,-c,d,e,f],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[-c,k]ProjPara[d,-l]ProjPara[e,-n]ProjPara[f,-m](3/4)((1/3)(2G[-i,l]G[-j,n]G[-k,m]-G[-j,l]G[-k,n]G[-i,m]-G[-k,l]G[-i,n]G[-j,m])-Antisymmetrize[G[-i,-k]G[-j,n]G[l,m],{-i,-j}])/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylTranslationalGaugeFieldPerturbation0p[c,d],Evaluate[
		ProjPara[c,-k]ProjPara[d,-l]G[k,l]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylTranslationalGaugeFieldPerturbation1p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l]Antisymmetrize[G[-i,k]G[-j,l],{-i,-j}]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylTranslationalGaugeFieldPerturbation1m[-a,d],Evaluate[
		ProjPara[d,-j]ProjPara[-a,i]G[-i,j]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylTranslationalGaugeFieldPerturbation2p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l](Symmetrize[G[-i,k]G[-j,l],{-i,-j}]-(1/3)G[-i,-j]G[k,l])/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

(*====================================*)
(*  Field perpendicular and parallel  *)
(*====================================*)

xAct`PSALTer`WeylGaugeTheory`Private`WeylTranslationalGaugeFieldPerturbationParaSymb="\!\(\*SuperscriptBox[\(\[ScriptF]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[WeylTranslationalGaugeFieldPerturbationPara[-a,-b],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`WeylTranslationalGaugeFieldPerturbationParaSymb],OrthogonalTo->{V[b]},Dagger->Complex];
xAct`PSALTer`WeylGaugeTheory`Private`WeylRotationalGaugeFieldParaSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalA]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[WeylRotationalGaugeFieldPara[-a,-b,-c],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`WeylRotationalGaugeFieldParaSymb],OrthogonalTo->{V[c]},Dagger->Complex];
xAct`PSALTer`WeylGaugeTheory`Private`WeylTranslationalGaugeFieldPerturbationPerpSymb="\!\(\*SuperscriptBox[\(\[ScriptF]\),\(\[UpTee]\)]\)";
DefTensor[WeylTranslationalGaugeFieldPerturbationPerp[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`WeylTranslationalGaugeFieldPerturbationPerpSymb],Dagger->Complex];
xAct`PSALTer`WeylGaugeTheory`Private`WeylRotationalGaugeFieldPerpSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalA]\),\(\[UpTee]\)]\)";
DefTensor[WeylRotationalGaugeFieldPerp[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`WeylRotationalGaugeFieldPerpSymb],Dagger->Complex];

xAct`PSALTer`WeylGaugeTheory`Private`WeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldToWeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldPerpPara=Join[
	MakeRule[{WeylTranslationalGaugeFieldPerturbation[-a,-b],Evaluate[WeylTranslationalGaugeFieldPerturbationPara[-a,-b]+V[-b]WeylTranslationalGaugeFieldPerturbationPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylRotationalGaugeField[-a,-b,-c],Evaluate[WeylRotationalGaugeFieldPara[-a,-b,-c]+V[-c]WeylRotationalGaugeFieldPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylTranslationalGaugeFieldPerturbation[-a,-b],Evaluate[Dagger@(WeylTranslationalGaugeFieldPerturbationPara[-a,-b]+V[-b]WeylTranslationalGaugeFieldPerturbationPerp[-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylRotationalGaugeField[-a,-b,-c],Evaluate[Dagger@(WeylRotationalGaugeFieldPara[-a,-b,-c]+V[-c]WeylRotationalGaugeFieldPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`WeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldPerpParaToWeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeField=Join[
	MakeRule[{WeylTranslationalGaugeFieldPerturbationPara[-a,-b],Evaluate[
		ProjPara[-b,c]WeylTranslationalGaugeFieldPerturbation[-a,-c]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylTranslationalGaugeFieldPerturbationPerp[-a],Evaluate[
		V[c]WeylTranslationalGaugeFieldPerturbation[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylRotationalGaugeFieldPara[-a,-e,-b],Evaluate[
		ProjPara[-b,c]WeylRotationalGaugeField[-a,-e,-c]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylRotationalGaugeFieldPerp[-a,-e],Evaluate[
		V[c]WeylRotationalGaugeField[-a,-e,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylTranslationalGaugeFieldPerturbationPara[-a,-b],Evaluate[Dagger@(
		ProjPara[-b,c]WeylTranslationalGaugeFieldPerturbation[-a,-c]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylTranslationalGaugeFieldPerturbationPerp[-a],Evaluate[Dagger@(
		V[c]WeylTranslationalGaugeFieldPerturbation[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylRotationalGaugeFieldPara[-a,-e,-b],Evaluate[Dagger@(
		ProjPara[-b,c]WeylRotationalGaugeField[-a,-e,-c]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylRotationalGaugeFieldPerp[-a,-e],Evaluate[Dagger@(
		V[c]WeylRotationalGaugeField[-a,-e,-c])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylTranslationalGaugeFieldPerturbationParaSymb="\!\(\*SuperscriptBox[\(\[Tau]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara[-a,-b],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylTranslationalGaugeFieldPerturbationParaSymb],OrthogonalTo->{V[b]},Dagger->Complex];
xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylRotationalGaugeFieldParaSymb="\!\(\*SuperscriptBox[\(\[Sigma]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[ConjugateSourceWeylRotationalGaugeFieldPara[-c,-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylRotationalGaugeFieldParaSymb],OrthogonalTo->{V[c]},Dagger->Complex];
xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylTranslationalGaugeFieldPerturbationPerpSymb="\!\(\*SuperscriptBox[\(\[Tau]\),\(\[UpTee]\)]\)";
DefTensor[ConjugateSourceWeylTranslationalGaugeFieldPerturbationPerp[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylTranslationalGaugeFieldPerturbationPerpSymb],Dagger->Complex];
xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylRotationalGaugeFieldPerpSymb="\!\(\*SuperscriptBox[\(\[Sigma]\),\(\[UpTee]\)]\)";
DefTensor[ConjugateSourceWeylRotationalGaugeFieldPerp[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylRotationalGaugeFieldPerpSymb],Dagger->Complex];

xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylTranslationalGaugeFieldPerturbationConjugateSourceWeylRotationalGaugeFieldToConjugateSourceWeylTranslationalGaugeFieldPerturbationConjugateSourceWeylRotationalGaugeFieldPerpPara=Join[
	MakeRule[{ConjugateSourceWeylTranslationalGaugeFieldPerturbation[-a,-b],Evaluate[
		ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara[-a,-b]+V[-b]ConjugateSourceWeylTranslationalGaugeFieldPerturbationPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylRotationalGaugeField[-c,-a,-b],Evaluate[	
		ConjugateSourceWeylRotationalGaugeFieldPara[-c,-a,-b]+V[-c]ConjugateSourceWeylRotationalGaugeFieldPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylTranslationalGaugeFieldPerturbation[-a,-b],Evaluate[Dagger@(	
		ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara[-a,-b]+V[-b]ConjugateSourceWeylTranslationalGaugeFieldPerturbationPerp[-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylRotationalGaugeField[-c,-a,-b],Evaluate[Dagger@(	
		ConjugateSourceWeylRotationalGaugeFieldPara[-c,-a,-b]+V[-c]ConjugateSourceWeylRotationalGaugeFieldPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylTranslationalGaugeFieldPerturbationConjugateSourceWeylRotationalGaugeFieldPerpParaToConjugateSourceWeylTranslationalGaugeFieldPerturbationConjugateSourceWeylRotationalGaugeField=Join[
	MakeRule[{ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara[-a,-b],Evaluate[	
		ProjPara[-b,c]ConjugateSourceWeylTranslationalGaugeFieldPerturbation[-a,-c]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylTranslationalGaugeFieldPerturbationPerp[-a],Evaluate[
		V[c]ConjugateSourceWeylTranslationalGaugeFieldPerturbation[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylRotationalGaugeFieldPara[-b,-a,-e],Evaluate[
		ProjPara[-b,c]ConjugateSourceWeylRotationalGaugeField[-c,-a,-e]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylRotationalGaugeFieldPerp[-a,-e],Evaluate[
		V[c]ConjugateSourceWeylRotationalGaugeField[-c,-a,-e]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara[-a,-b],Evaluate[Dagger@(
		ProjPara[-b,c]ConjugateSourceWeylTranslationalGaugeFieldPerturbation[-a,-c]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylTranslationalGaugeFieldPerturbationPerp[-a],Evaluate[Dagger@(
		V[c]ConjugateSourceWeylTranslationalGaugeFieldPerturbation[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylRotationalGaugeFieldPara[-b,-a,-e],Evaluate[Dagger@(
		ProjPara[-b,c]ConjugateSourceWeylRotationalGaugeField[-c,-a,-e]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylRotationalGaugeFieldPerp[-a,-e],Evaluate[Dagger@(
		V[c]ConjugateSourceWeylRotationalGaugeField[-c,-a,-e])]},MetricOn->All,ContractMetrics->True]];

(*==============================*)
(*  Spin-parity or SO(3) parts  *)
(*==============================*)

(*======================*)
(*  Tensor definitions  *)
(*======================*)

DefSpinParityMode[WeylVector0p[],Spin->0,Parity->Even,
	FieldSymbol->xAct`PSALTer`WeylGaugeTheory`Private`WeylVectorSymb,
	SourceSymbol->xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylVectorSymb];

DefSpinParityMode[WeylVector1m[-a],Spin->1,Parity->Odd,
	FieldSymbol->xAct`PSALTer`WeylGaugeTheory`Private`WeylVectorSymb,
	SourceSymbol->xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylVectorSymb];

DefSpinParityMode[Compensator0p[],Spin->0,Parity->Even,
	FieldSymbol->xAct`PSALTer`WeylGaugeTheory`Private`CompensatorSymb,
	SourceSymbol->xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceCompensatorSymb];

DefTensor[WeylTranslationalGaugeFieldPerturbationPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`WeylTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[WeylTranslationalGaugeFieldPerturbationPara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`WeylTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[WeylTranslationalGaugeFieldPerturbationPara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`WeylTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[WeylTranslationalGaugeFieldPerturbationPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`WeylTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];

DefTensor[WeylRotationalGaugeFieldPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`WeylRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[WeylRotationalGaugeFieldPara0m[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`WeylRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin0m],Dagger->Complex];
DefTensor[WeylRotationalGaugeFieldPara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`WeylRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[WeylRotationalGaugeFieldPara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`WeylRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[WeylRotationalGaugeFieldPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`WeylRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[WeylRotationalGaugeFieldPara2m[-a,-b,-c],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`WeylRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin2m],OrthogonalTo->{V[a],V[b],V[c]},Dagger->Complex];

AutomaticRules[WeylRotationalGaugeFieldPara2m,MakeRule[{Evaluate@Dagger@WeylRotationalGaugeFieldPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylRotationalGaugeFieldPara2m,MakeRule[{Evaluate@Dagger[epsilonG[a,b,c,d]WeylRotationalGaugeFieldPara2m[-a,-b,-c]],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylTranslationalGaugeFieldPerturbationPara2p,MakeRule[{Evaluate@Dagger@WeylTranslationalGaugeFieldPerturbationPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylRotationalGaugeFieldPara2p,MakeRule[{Evaluate@Dagger@WeylRotationalGaugeFieldPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`ManualAll=Join[
	MakeRule[{Evaluate@Dagger@WeylRotationalGaugeFieldPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger[epsilonG[a,b,c,d]WeylRotationalGaugeFieldPara2m[-a,-b,-c]],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylTranslationalGaugeFieldPerturbationPara2p[a,-a],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylRotationalGaugeFieldPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

AutomaticRules[WeylRotationalGaugeFieldPara2m,MakeRule[{WeylRotationalGaugeFieldPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylRotationalGaugeFieldPara2m,MakeRule[{epsilonG[a,b,c,d]WeylRotationalGaugeFieldPara2m[-a,-b,-c],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylTranslationalGaugeFieldPerturbationPara2p,MakeRule[{WeylTranslationalGaugeFieldPerturbationPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylRotationalGaugeFieldPara2p,MakeRule[{WeylRotationalGaugeFieldPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

DefTensor[ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];

DefTensor[ConjugateSourceWeylRotationalGaugeFieldPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ConjugateSourceWeylRotationalGaugeFieldPara0m[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin0m],Dagger->Complex];
DefTensor[ConjugateSourceWeylRotationalGaugeFieldPara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[ConjugateSourceWeylRotationalGaugeFieldPara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[ConjugateSourceWeylRotationalGaugeFieldPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[ConjugateSourceWeylRotationalGaugeFieldPara2m[-a,-b,-c],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin2m],OrthogonalTo->{V[a],V[b],V[c]},Dagger->Complex];

AutomaticRules[ConjugateSourceWeylRotationalGaugeFieldPara2m,MakeRule[{Evaluate@Dagger@ConjugateSourceWeylRotationalGaugeFieldPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ConjugateSourceWeylRotationalGaugeFieldPara2m,MakeRule[{Evaluate@Dagger[epsilonG[a,b,c,d]ConjugateSourceWeylRotationalGaugeFieldPara2m[-a,-b,-c]],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara2p,MakeRule[{Evaluate@Dagger@ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ConjugateSourceWeylRotationalGaugeFieldPara2p,MakeRule[{Evaluate@Dagger@ConjugateSourceWeylRotationalGaugeFieldPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`ManualAll=Join[xAct`PSALTer`WeylGaugeTheory`Private`ManualAll,
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylRotationalGaugeFieldPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger[epsilonG[a,b,c,d]ConjugateSourceWeylRotationalGaugeFieldPara2m[-a,-b,-c]],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara2p[a,-a],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylRotationalGaugeFieldPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

AutomaticRules[ConjugateSourceWeylRotationalGaugeFieldPara2m,MakeRule[{ConjugateSourceWeylRotationalGaugeFieldPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ConjugateSourceWeylRotationalGaugeFieldPara2m,MakeRule[{epsilonG[a,b,c,d]ConjugateSourceWeylRotationalGaugeFieldPara2m[-a,-b,-c],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara2p,MakeRule[{ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ConjugateSourceWeylRotationalGaugeFieldPara2p,MakeRule[{ConjugateSourceWeylRotationalGaugeFieldPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

(*==============*)
(*  Expansions  *)
(*==============*)

xAct`PSALTer`WeylGaugeTheory`Private`WeylVectorSpinParityToWeylVector=Join[
	MakeRule[{WeylVector0p[],Evaluate[V[a]WeylVector[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylVector1m[-a],Evaluate[
		ProjPara[-a,b]WeylVector[-b]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylVector0p[],Evaluate@Dagger[V[a]WeylVector[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylVector1m[-a],Evaluate@Dagger[
		ProjPara[-a,b]WeylVector[-b]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylVectorSpinParityToConjugateSourceWeylVector=Join[
	MakeRule[{ConjugateSourceWeylVector0p[],Evaluate[V[a]ConjugateSourceWeylVector[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylVector1m[-a],Evaluate[
		ProjPara[-a,b]ConjugateSourceWeylVector[-b]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylVector0p[],Evaluate@Dagger[V[a]ConjugateSourceWeylVector[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylVector1m[-a],Evaluate@Dagger[
		ProjPara[-a,b]ConjugateSourceWeylVector[-b]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`CompensatorSpinParityToCompensator=Join[
	MakeRule[{Compensator0p[],Compensator[]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Compensator0p[],Evaluate@Dagger[Compensator[]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceCompensatorSpinParityToConjugateSourceCompensator=Join[
	MakeRule[{ConjugateSourceCompensator0p[],ConjugateSourceCompensator[]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceCompensator0p[],Evaluate@Dagger[ConjugateSourceCompensator[]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`WeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldParaSpinParityToWeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeField=Join[
	MakeRule[{WeylTranslationalGaugeFieldPerturbationPara0p[],Scalar[Evaluate[
		ProjWeylTranslationalGaugeFieldPerturbation0p[e,f]ProjWeylTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]WeylTranslationalGaugeFieldPerturbationPara[-a,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylTranslationalGaugeFieldPerturbationPara1p[-n,-m],Evaluate[
		ProjWeylTranslationalGaugeFieldPerturbation1p[-n,-m,e,f]ProjWeylTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]WeylTranslationalGaugeFieldPerturbationPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylTranslationalGaugeFieldPerturbationPara1m[-n],Evaluate[
		ProjWeylTranslationalGaugeFieldPerturbation1m[-n,f]ProjWeylTranslationalGaugeFieldPerturbationPerp[-f,a,c]WeylTranslationalGaugeFieldPerturbationPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylTranslationalGaugeFieldPerturbationPara2p[-n,-m],Evaluate[
		ProjWeylTranslationalGaugeFieldPerturbation2p[-n,-m,e,f]ProjWeylTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]WeylTranslationalGaugeFieldPerturbationPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylRotationalGaugeFieldPara0p[],Scalar[Evaluate[
		ProjWeylRotationalGaugeField0p[e,f]ProjWeylRotationalGaugeFieldPerp[-e,-f,a,b,c]WeylRotationalGaugeFieldPara[-a,-b,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylRotationalGaugeFieldPara0m[],Scalar[Evaluate[
		ProjWeylRotationalGaugeField0m[d,e,f]ProjWeylRotationalGaugeFieldPara[-d,-e,-f,a,b,c]WeylRotationalGaugeFieldPara[-a,-b,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylRotationalGaugeFieldPara1p[-n,-m],Evaluate[
		ProjWeylRotationalGaugeField1p[-n,-m,e,f]ProjWeylRotationalGaugeFieldPerp[-e,-f,a,b,c]WeylRotationalGaugeFieldPara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylRotationalGaugeFieldPara1m[-n],Evaluate[
		ProjWeylRotationalGaugeField1m[-n,d,e,f]ProjWeylRotationalGaugeFieldPara[-d,-e,-f,a,b,c]WeylRotationalGaugeFieldPara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylRotationalGaugeFieldPara2p[-n,-m],Evaluate[
		ProjWeylRotationalGaugeField2p[-n,-m,e,f]ProjWeylRotationalGaugeFieldPerp[-e,-f,a,b,c]WeylRotationalGaugeFieldPara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylRotationalGaugeFieldPara2m[-n,-m,-o],Evaluate[
		ProjWeylRotationalGaugeField2m[-n,-m,-o,d,e,f]ProjWeylRotationalGaugeFieldPara[-d,-e,-f,a,b,c]WeylRotationalGaugeFieldPara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylTranslationalGaugeFieldPerturbationPara0p[],Scalar[Evaluate[Dagger@(
		ProjWeylTranslationalGaugeFieldPerturbation0p[e,f]ProjWeylTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]WeylTranslationalGaugeFieldPerturbationPara[-a,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylTranslationalGaugeFieldPerturbationPara1p[-n,-m],Evaluate[Dagger@(
		ProjWeylTranslationalGaugeFieldPerturbation1p[-n,-m,e,f]ProjWeylTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]WeylTranslationalGaugeFieldPerturbationPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylTranslationalGaugeFieldPerturbationPara1m[-n],Evaluate[Dagger@(
		ProjWeylTranslationalGaugeFieldPerturbation1m[-n,f]ProjWeylTranslationalGaugeFieldPerturbationPerp[-f,a,c]WeylTranslationalGaugeFieldPerturbationPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylTranslationalGaugeFieldPerturbationPara2p[-n,-m],Evaluate[Dagger@(
		ProjWeylTranslationalGaugeFieldPerturbation2p[-n,-m,e,f]ProjWeylTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]WeylTranslationalGaugeFieldPerturbationPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylRotationalGaugeFieldPara0p[],Scalar[Evaluate[Dagger@(
		ProjWeylRotationalGaugeField0p[e,f]ProjWeylRotationalGaugeFieldPerp[-e,-f,a,b,c]WeylRotationalGaugeFieldPara[-a,-b,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylRotationalGaugeFieldPara0m[],Scalar[Evaluate[Dagger@(
		ProjWeylRotationalGaugeField0m[d,e,f]ProjWeylRotationalGaugeFieldPara[-d,-e,-f,a,b,c]WeylRotationalGaugeFieldPara[-a,-b,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylRotationalGaugeFieldPara1p[-n,-m],Evaluate[Dagger@(
		ProjWeylRotationalGaugeField1p[-n,-m,e,f]ProjWeylRotationalGaugeFieldPerp[-e,-f,a,b,c]WeylRotationalGaugeFieldPara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylRotationalGaugeFieldPara1m[-n],Evaluate[Dagger@(
		ProjWeylRotationalGaugeField1m[-n,d,e,f]ProjWeylRotationalGaugeFieldPara[-d,-e,-f,a,b,c]WeylRotationalGaugeFieldPara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylRotationalGaugeFieldPara2p[-n,-m],Evaluate[Dagger@(
		ProjWeylRotationalGaugeField2p[-n,-m,e,f]ProjWeylRotationalGaugeFieldPerp[-e,-f,a,b,c]WeylRotationalGaugeFieldPara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylRotationalGaugeFieldPara2m[-n,-m,-o],Evaluate[Dagger@(
		ProjWeylRotationalGaugeField2m[-n,-m,-o,d,e,f]ProjWeylRotationalGaugeFieldPara[-d,-e,-f,a,b,c]WeylRotationalGaugeFieldPara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True]];

DefTensor[WeylTranslationalGaugeFieldPerturbationPerp0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`WeylTranslationalGaugeFieldPerturbationPerpSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[WeylTranslationalGaugeFieldPerturbationPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`WeylTranslationalGaugeFieldPerturbationPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[WeylRotationalGaugeFieldPerp1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`WeylRotationalGaugeFieldPerpSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[WeylRotationalGaugeFieldPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`WeylRotationalGaugeFieldPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

xAct`PSALTer`WeylGaugeTheory`Private`WeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldPerpSpinParityToWeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeField=Join[
	MakeRule[{WeylTranslationalGaugeFieldPerturbationPerp0p[],Scalar[Evaluate[
		V[a]WeylTranslationalGaugeFieldPerturbationPerp[-a]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylTranslationalGaugeFieldPerturbationPerp1m[-n],Evaluate[
		ProjPara[-n,a]WeylTranslationalGaugeFieldPerturbationPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylRotationalGaugeFieldPerp1p[-n,-m],Evaluate[
		ProjPara[-n,a]ProjPara[-m,b]WeylRotationalGaugeFieldPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylRotationalGaugeFieldPerp1m[-n],Evaluate[
		ProjPara[-n,a]V[b]WeylRotationalGaugeFieldPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylTranslationalGaugeFieldPerturbationPerp0p[],Scalar[Evaluate[Dagger@(
		V[a]WeylTranslationalGaugeFieldPerturbationPerp[-a])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylTranslationalGaugeFieldPerturbationPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]WeylTranslationalGaugeFieldPerturbationPerp[-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylRotationalGaugeFieldPerp1p[-n,-m],Evaluate[Dagger@(
		ProjPara[-n,a]ProjPara[-m,b]WeylRotationalGaugeFieldPerp[-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylRotationalGaugeFieldPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]V[b]WeylRotationalGaugeFieldPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylTranslationalGaugeFieldPerturbationConjugateSourceWeylRotationalGaugeFieldParaSpinParityToConjugateSourceWeylTranslationalGaugeFieldPerturbationConjugateSourceWeylRotationalGaugeField=Join[
	MakeRule[{ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara0p[],Scalar[Evaluate[
		ProjWeylTranslationalGaugeFieldPerturbation0p[e,f]ProjWeylTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara[-a,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara1p[-n,-m],Evaluate[
		ProjWeylTranslationalGaugeFieldPerturbation1p[-n,-m,e,f]ProjWeylTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara1m[-n],Evaluate[
		ProjWeylTranslationalGaugeFieldPerturbation1m[-n,f]ProjWeylTranslationalGaugeFieldPerturbationPerp[-f,a,c]ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara2p[-n,-m],Evaluate[
		ProjWeylTranslationalGaugeFieldPerturbation2p[-n,-m,e,f]ProjWeylTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylRotationalGaugeFieldPara0p[],Scalar[Evaluate[
		ProjWeylRotationalGaugeField0p[e,f]ProjWeylRotationalGaugeFieldPerp[-e,-f,a,b,c]ConjugateSourceWeylRotationalGaugeFieldPara[-c,-a,-b]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylRotationalGaugeFieldPara0m[],Scalar[Evaluate[
		ProjWeylRotationalGaugeField0m[d,e,f]ProjWeylRotationalGaugeFieldPara[-d,-e,-f,a,b,c]ConjugateSourceWeylRotationalGaugeFieldPara[-c,-a,-b]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylRotationalGaugeFieldPara1p[-n,-m],Evaluate[
		ProjWeylRotationalGaugeField1p[-n,-m,e,f]ProjWeylRotationalGaugeFieldPerp[-e,-f,a,b,c]ConjugateSourceWeylRotationalGaugeFieldPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylRotationalGaugeFieldPara1m[-n],Evaluate[
		ProjWeylRotationalGaugeField1m[-n,d,e,f]ProjWeylRotationalGaugeFieldPara[-d,-e,-f,a,b,c]ConjugateSourceWeylRotationalGaugeFieldPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylRotationalGaugeFieldPara2p[-n,-m],Evaluate[
		ProjWeylRotationalGaugeField2p[-n,-m,e,f]ProjWeylRotationalGaugeFieldPerp[-e,-f,a,b,c]ConjugateSourceWeylRotationalGaugeFieldPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylRotationalGaugeFieldPara2m[-n,-m,-o],Evaluate[
		ProjWeylRotationalGaugeField2m[-n,-m,-o,d,e,f]ProjWeylRotationalGaugeFieldPara[-d,-e,-f,a,b,c]ConjugateSourceWeylRotationalGaugeFieldPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara0p[],Scalar[Evaluate[Dagger@(
		ProjWeylTranslationalGaugeFieldPerturbation0p[e,f]ProjWeylTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara[-a,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara1p[-n,-m],Evaluate[Dagger@(
		ProjWeylTranslationalGaugeFieldPerturbation1p[-n,-m,e,f]ProjWeylTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara1m[-n],Evaluate[Dagger@(
		ProjWeylTranslationalGaugeFieldPerturbation1m[-n,f]ProjWeylTranslationalGaugeFieldPerturbationPerp[-f,a,c]ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara2p[-n,-m],Evaluate[Dagger@(
		ProjWeylTranslationalGaugeFieldPerturbation2p[-n,-m,e,f]ProjWeylTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylRotationalGaugeFieldPara0p[],Scalar[Evaluate[Dagger@(
		ProjWeylRotationalGaugeField0p[e,f]ProjWeylRotationalGaugeFieldPerp[-e,-f,a,b,c]ConjugateSourceWeylRotationalGaugeFieldPara[-c,-a,-b])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylRotationalGaugeFieldPara0m[],Scalar[Evaluate[Dagger@(
		ProjWeylRotationalGaugeField0m[d,e,f]ProjWeylRotationalGaugeFieldPara[-d,-e,-f,a,b,c]ConjugateSourceWeylRotationalGaugeFieldPara[-c,-a,-b])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylRotationalGaugeFieldPara1p[-n,-m],Evaluate[Dagger@(
		ProjWeylRotationalGaugeField1p[-n,-m,e,f]ProjWeylRotationalGaugeFieldPerp[-e,-f,a,b,c]ConjugateSourceWeylRotationalGaugeFieldPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylRotationalGaugeFieldPara1m[-n],Evaluate[Dagger@(
		ProjWeylRotationalGaugeField1m[-n,d,e,f]ProjWeylRotationalGaugeFieldPara[-d,-e,-f,a,b,c]ConjugateSourceWeylRotationalGaugeFieldPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylRotationalGaugeFieldPara2p[-n,-m],Evaluate[Dagger@(
		ProjWeylRotationalGaugeField2p[-n,-m,e,f]ProjWeylRotationalGaugeFieldPerp[-e,-f,a,b,c]ConjugateSourceWeylRotationalGaugeFieldPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylRotationalGaugeFieldPara2m[-n,-m,-o],Evaluate[Dagger@(
		ProjWeylRotationalGaugeField2m[-n,-m,-o,d,e,f]ProjWeylRotationalGaugeFieldPara[-d,-e,-f,a,b,c]ConjugateSourceWeylRotationalGaugeFieldPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True]];

DefTensor[ConjugateSourceWeylTranslationalGaugeFieldPerturbationPerp0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylTranslationalGaugeFieldPerturbationPerpSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ConjugateSourceWeylTranslationalGaugeFieldPerturbationPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylTranslationalGaugeFieldPerturbationPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[ConjugateSourceWeylRotationalGaugeFieldPerp1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylRotationalGaugeFieldPerpSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[ConjugateSourceWeylRotationalGaugeFieldPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylRotationalGaugeFieldPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylTranslationalGaugeFieldPerturbationConjugateSourceWeylRotationalGaugeFieldPerpSpinParityToConjugateSourceWeylTranslationalGaugeFieldPerturbationConjugateSourceWeylRotationalGaugeField=Join[
	MakeRule[{ConjugateSourceWeylTranslationalGaugeFieldPerturbationPerp0p[],Scalar[Evaluate[
		V[a]ConjugateSourceWeylTranslationalGaugeFieldPerturbationPerp[-a]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylTranslationalGaugeFieldPerturbationPerp1m[-n],Evaluate[
		ProjPara[-n,a]ConjugateSourceWeylTranslationalGaugeFieldPerturbationPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylRotationalGaugeFieldPerp1p[-n,-m],Evaluate[
		ProjPara[-n,a]ProjPara[-m,b]ConjugateSourceWeylRotationalGaugeFieldPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylRotationalGaugeFieldPerp1m[-n],Evaluate[
		ProjPara[-n,a]V[b]ConjugateSourceWeylRotationalGaugeFieldPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylTranslationalGaugeFieldPerturbationPerp0p[],Scalar[Evaluate[Dagger@(
		V[a]ConjugateSourceWeylTranslationalGaugeFieldPerturbationPerp[-a])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylTranslationalGaugeFieldPerturbationPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]ConjugateSourceWeylTranslationalGaugeFieldPerturbationPerp[-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylRotationalGaugeFieldPerp1p[-n,-m],Evaluate[Dagger@(
		ProjPara[-n,a]ProjPara[-m,b]ConjugateSourceWeylRotationalGaugeFieldPerp[-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylRotationalGaugeFieldPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]V[b]ConjugateSourceWeylRotationalGaugeFieldPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

xAct`PSALTer`WeylGaugeTheory`Private`WeylVectorToWeylVectorSpinParity=Join[
	MakeRule[{WeylVector[-a],Evaluate[V[-a]WeylVector0p[]+WeylVector1m[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylVector[-a],Evaluate@Dagger[V[-a]WeylVector0p[]+WeylVector1m[-a]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylVectorToConjugateSourceWeylVectorSpinParity=Join[
	MakeRule[{ConjugateSourceWeylVector[-a],Evaluate[V[-a]ConjugateSourceWeylVector0p[]+ConjugateSourceWeylVector1m[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylVector[-a],Evaluate@Dagger[V[-a]ConjugateSourceWeylVector0p[]+ConjugateSourceWeylVector1m[-a]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`CompensatorToCompensatorSpinParity=Join[
	MakeRule[{Compensator[],Compensator0p[]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Compensator[],Evaluate@Dagger[Compensator0p[]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceCompensatorToConjugateSourceCompensatorSpinParity=Join[
	MakeRule[{ConjugateSourceCompensator[],ConjugateSourceCompensator0p[]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceCompensator[],Evaluate@Dagger[ConjugateSourceCompensator0p[]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`WeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldParaToWeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldParaSpinParity=Join[
	MakeRule[{WeylTranslationalGaugeFieldPerturbationPara[-n,-m],Evaluate[
		((1/3)ProjPara[-n,-m]WeylTranslationalGaugeFieldPerturbationPara0p[]+
		WeylTranslationalGaugeFieldPerturbationPara1p[-n,-m]+
		WeylTranslationalGaugeFieldPerturbationPara2p[-n,-m]+
		V[-n]WeylTranslationalGaugeFieldPerturbationPara1m[-m])/.xAct`PSALTer`WeylGaugeTheory`Private`ProjWeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylRotationalGaugeFieldPara[-n,-m,-o],Evaluate[
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]WeylRotationalGaugeFieldPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]WeylRotationalGaugeFieldPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]WeylRotationalGaugeFieldPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjWeylRotationalGaugeField0m[-n,-m,-o]WeylRotationalGaugeFieldPara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]WeylRotationalGaugeFieldPara1m[-n],{-m,-n}]+
		(4/3)WeylRotationalGaugeFieldPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`WeylGaugeTheory`Private`ProjWeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylTranslationalGaugeFieldPerturbationPara[-n,-m],Evaluate[Dagger@(
		((1/3)ProjPara[-n,-m]WeylTranslationalGaugeFieldPerturbationPara0p[]+
		WeylTranslationalGaugeFieldPerturbationPara1p[-n,-m]+
		WeylTranslationalGaugeFieldPerturbationPara2p[-n,-m]+
		V[-n]WeylTranslationalGaugeFieldPerturbationPara1m[-m])/.xAct`PSALTer`WeylGaugeTheory`Private`ProjWeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylRotationalGaugeFieldPara[-n,-m,-o],Evaluate[Dagger@(
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]WeylRotationalGaugeFieldPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]WeylRotationalGaugeFieldPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]WeylRotationalGaugeFieldPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjWeylRotationalGaugeField0m[-n,-m,-o]WeylRotationalGaugeFieldPara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]WeylRotationalGaugeFieldPara1m[-n],{-m,-n}]+
		(4/3)WeylRotationalGaugeFieldPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`WeylGaugeTheory`Private`ProjWeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`WeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldPerpToWeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldPerpSpinParity=Join[
	MakeRule[{WeylTranslationalGaugeFieldPerturbationPerp[-n],Evaluate[WeylTranslationalGaugeFieldPerturbationPerp0p[]V[-n]+WeylTranslationalGaugeFieldPerturbationPerp1m[-n]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylRotationalGaugeFieldPerp[-n,-m],Evaluate[WeylRotationalGaugeFieldPerp1p[-n,-m]+2Antisymmetrize[V[-m]WeylRotationalGaugeFieldPerp1m[-n],{-n,-m}]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylTranslationalGaugeFieldPerturbationPerp[-n],Evaluate[Dagger@(WeylTranslationalGaugeFieldPerturbationPerp0p[]V[-n]+WeylTranslationalGaugeFieldPerturbationPerp1m[-n])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylRotationalGaugeFieldPerp[-n,-m],Evaluate[Dagger@(WeylRotationalGaugeFieldPerp1p[-n,-m]+2Antisymmetrize[V[-m]WeylRotationalGaugeFieldPerp1m[-n],{-n,-m}])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylTranslationalGaugeFieldPerturbationConjugateSourceWeylRotationalGaugeFieldParaToConjugateSourceWeylTranslationalGaugeFieldPerturbationConjugateSourceWeylRotationalGaugeFieldParaSpinParity=Join[
	MakeRule[{ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara[-n,-m],Evaluate[
		((1/3)ProjPara[-n,-m]ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara0p[]+
		ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara1p[-n,-m]+
		ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara2p[-n,-m]+
		V[-n]ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara1m[-m])/.xAct`PSALTer`WeylGaugeTheory`Private`ProjWeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylRotationalGaugeFieldPara[-o,-n,-m],Evaluate[
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]ConjugateSourceWeylRotationalGaugeFieldPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]ConjugateSourceWeylRotationalGaugeFieldPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]ConjugateSourceWeylRotationalGaugeFieldPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjWeylRotationalGaugeField0m[-n,-m,-o]ConjugateSourceWeylRotationalGaugeFieldPara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]ConjugateSourceWeylRotationalGaugeFieldPara1m[-n],{-m,-n}]+
		(4/3)ConjugateSourceWeylRotationalGaugeFieldPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`WeylGaugeTheory`Private`ProjWeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara[-n,-m],Evaluate[Dagger@(
		((1/3)ProjPara[-n,-m]ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara0p[]+
		ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara1p[-n,-m]+
		ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara2p[-n,-m]+
		V[-n]ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara1m[-m])/.xAct`PSALTer`WeylGaugeTheory`Private`ProjWeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylRotationalGaugeFieldPara[-o,-n,-m],Evaluate[Dagger@(
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]ConjugateSourceWeylRotationalGaugeFieldPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]ConjugateSourceWeylRotationalGaugeFieldPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]ConjugateSourceWeylRotationalGaugeFieldPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjWeylRotationalGaugeField0m[-n,-m,-o]ConjugateSourceWeylRotationalGaugeFieldPara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]ConjugateSourceWeylRotationalGaugeFieldPara1m[-n],{-m,-n}]+
		(4/3)ConjugateSourceWeylRotationalGaugeFieldPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`WeylGaugeTheory`Private`ProjWeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylTranslationalGaugeFieldPerturbationConjugateSourceWeylRotationalGaugeFieldPerpToConjugateSourceWeylTranslationalGaugeFieldPerturbationConjugateSourceWeylRotationalGaugeFieldPerpSpinParity=Join[
	MakeRule[{ConjugateSourceWeylTranslationalGaugeFieldPerturbationPerp[-n],Evaluate[ConjugateSourceWeylTranslationalGaugeFieldPerturbationPerp0p[]V[-n]+ConjugateSourceWeylTranslationalGaugeFieldPerturbationPerp1m[-n]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylRotationalGaugeFieldPerp[-n,-m],Evaluate[ConjugateSourceWeylRotationalGaugeFieldPerp1p[-n,-m]+2Antisymmetrize[V[-m]ConjugateSourceWeylRotationalGaugeFieldPerp1m[-n],{-n,-m}]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylTranslationalGaugeFieldPerturbationPerp[-n],Evaluate[Dagger@(ConjugateSourceWeylTranslationalGaugeFieldPerturbationPerp0p[]V[-n]+ConjugateSourceWeylTranslationalGaugeFieldPerturbationPerp1m[-n])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylRotationalGaugeFieldPerp[-n,-m],Evaluate[Dagger@(ConjugateSourceWeylRotationalGaugeFieldPerp1p[-n,-m]+2Antisymmetrize[V[-m]ConjugateSourceWeylRotationalGaugeFieldPerp1m[-n],{-n,-m}])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`Patch2m=Join[
	MakeRule[{WeylRotationalGaugeFieldPara2m[-a,-c,-b]WeylRotationalGaugeFieldPara2m[a,b,c],(1/2)WeylRotationalGaugeFieldPara2m[-a,-b,-c]WeylRotationalGaugeFieldPara2m[a,b,c]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate[Dagger@WeylRotationalGaugeFieldPara2m[-a,-c,-b]WeylRotationalGaugeFieldPara2m[a,b,c]],Evaluate[(1/2)Dagger@WeylRotationalGaugeFieldPara2m[-a,-b,-c]WeylRotationalGaugeFieldPara2m[a,b,c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate[WeylRotationalGaugeFieldPara2m[-a,-c,-b]Dagger@WeylRotationalGaugeFieldPara2m[a,b,c]],Evaluate[(1/2)WeylRotationalGaugeFieldPara2m[-a,-b,-c]Dagger@WeylRotationalGaugeFieldPara2m[a,b,c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylRotationalGaugeFieldPara2m[-a,-c,-b]ConjugateSourceWeylRotationalGaugeFieldPara2m[a,b,c],(1/2)ConjugateSourceWeylRotationalGaugeFieldPara2m[-a,-b,-c]ConjugateSourceWeylRotationalGaugeFieldPara2m[a,b,c]},MetricOn->All,ContractMetrics->True]];

AutomaticRules[WeylRotationalGaugeFieldPara2m,MakeRule[{Evaluate[WeylRotationalGaugeFieldPara2m[-a,-c,-b]Dagger@WeylRotationalGaugeFieldPara2m[a,b,c]],Evaluate[(1/2)WeylRotationalGaugeFieldPara2m[-a,-b,-c]Dagger@WeylRotationalGaugeFieldPara2m[a,b,c]]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[Evaluate[Dagger@WeylRotationalGaugeFieldPara2m],MakeRule[{Evaluate[Dagger@WeylRotationalGaugeFieldPara2m[-a,-c,-b]WeylRotationalGaugeFieldPara2m[a,b,c]],Evaluate[(1/2)Dagger@WeylRotationalGaugeFieldPara2m[-a,-b,-c]WeylRotationalGaugeFieldPara2m[a,b,c]]},MetricOn->All,ContractMetrics->True]];

(*==========================================================*)
(*  Basic definitions of the Lagrangian coupling constants  *)
(*==========================================================*)

xAct`PSALTer`WeylGaugeTheory`Private`lLambdaSymb="\[Lambda]";
DefLagrangianCoupling[lLambda,CouplingSymbol->xAct`PSALTer`WeylGaugeTheory`Private`lLambdaSymb];

xAct`PSALTer`WeylGaugeTheory`Private`lRSymb="\[ScriptR]";
DefLagrangianCoupling[lR1,
	CouplingSymbol->xAct`PSALTer`WeylGaugeTheory`Private`lRSymb,CouplingIndex->1];
DefLagrangianCoupling[lR2,
	CouplingSymbol->xAct`PSALTer`WeylGaugeTheory`Private`lRSymb,CouplingIndex->2];
DefLagrangianCoupling[lR3,
	CouplingSymbol->xAct`PSALTer`WeylGaugeTheory`Private`lRSymb,CouplingIndex->3];
DefLagrangianCoupling[lR4,
	CouplingSymbol->xAct`PSALTer`WeylGaugeTheory`Private`lRSymb,CouplingIndex->4];
DefLagrangianCoupling[lR5,
	CouplingSymbol->xAct`PSALTer`WeylGaugeTheory`Private`lRSymb,CouplingIndex->5];

xAct`PSALTer`WeylGaugeTheory`Private`lCSymb="\[ScriptC]";
DefLagrangianCoupling[lC1,
	CouplingSymbol->xAct`PSALTer`WeylGaugeTheory`Private`lCSymb,CouplingIndex->1];

xAct`PSALTer`WeylGaugeTheory`Private`lTSymb="\[ScriptT]";
DefLagrangianCoupling[lT1,
	CouplingSymbol->xAct`PSALTer`WeylGaugeTheory`Private`lTSymb,CouplingIndex->1];
DefLagrangianCoupling[lT2,
	CouplingSymbol->xAct`PSALTer`WeylGaugeTheory`Private`lTSymb,CouplingIndex->2];
DefLagrangianCoupling[lT3,
	CouplingSymbol->xAct`PSALTer`WeylGaugeTheory`Private`lTSymb,CouplingIndex->3];

xAct`PSALTer`WeylGaugeTheory`Private`lXiSymb="\[Xi]";
DefLagrangianCoupling[lXi,CouplingSymbol->xAct`PSALTer`WeylGaugeTheory`Private`lXiSymb];

xAct`PSALTer`WeylGaugeTheory`Private`lNuSymb="\[Nu]";
DefLagrangianCoupling[lNu,CouplingSymbol->xAct`PSALTer`WeylGaugeTheory`Private`lNuSymb];

(*Here is the Einstein Gauge for the compensator field*)
DefLagrangianCoupling[lPhi0,
	CouplingSymbol->xAct`PSALTer`WeylGaugeTheory`Private`CompensatorSymb,CouplingIndex->0];

(*===================*)
(*  Private context  *)
(*===================*)

Begin["xAct`PSALTer`WeylGaugeTheory`Private`"];

LagrangianCouplings={lLambda,lR1,lR2,lR3,lR4,lR5,lC1,lT1,lT2,lT3,lXi,lNu,lPhi0};

FieldSpinParityTensorHeads=<|
		WeylVector-><|
			0-><|Even->{WeylVector0p},Odd->{}|>,
			1-><|Even->{},Odd->{WeylVector1m}|>,
			2-><|Even->{},Odd->{}|>
		|>,
		Compensator-><|
			0-><|Even->{Compensator0p},Odd->{}|>,
			1-><|Even->{},Odd->{}|>,
			2-><|Even->{},Odd->{}|>
		|>,
		WeylRotationalGaugeField-><|
			0-><|Even->{WeylRotationalGaugeFieldPara0p},Odd->{WeylRotationalGaugeFieldPara0m}|>,
			1-><|Even->{WeylRotationalGaugeFieldPara1p,WeylRotationalGaugeFieldPerp1p},Odd->{WeylRotationalGaugeFieldPara1m,WeylRotationalGaugeFieldPerp1m}|>,
			2-><|Even->{WeylRotationalGaugeFieldPara2p},Odd->{WeylRotationalGaugeFieldPara2m}|>
		|>,
		WeylTranslationalGaugeFieldPerturbation-><|
			0-><|Even->{WeylTranslationalGaugeFieldPerturbationPara0p,WeylTranslationalGaugeFieldPerturbationPerp0p},Odd->{}|>,
			1-><|Even->{WeylTranslationalGaugeFieldPerturbationPara1p},Odd->{WeylTranslationalGaugeFieldPerturbationPara1m,WeylTranslationalGaugeFieldPerturbationPerp1m}|>,
			2-><|Even->{WeylTranslationalGaugeFieldPerturbationPara2p},Odd->{}|>
		|>
|>;

SourceSpinParityTensorHeads=<|
		ConjugateSourceWeylVector-><|
			0-><|Even->{ConjugateSourceWeylVector0p},Odd->{}|>,
			1-><|Even->{},Odd->{ConjugateSourceWeylVector1m}|>,
			2-><|Even->{},Odd->{}|>
		|>,
		ConjugateSourceCompensator-><|
			0-><|Even->{ConjugateSourceCompensator0p},Odd->{}|>,
			1-><|Even->{},Odd->{}|>,
			2-><|Even->{},Odd->{}|>
		|>,
		ConjugateSourceWeylRotationalGaugeField-><|
			0-><|Even->{ConjugateSourceWeylRotationalGaugeFieldPara0p},Odd->{ConjugateSourceWeylRotationalGaugeFieldPara0m}|>,
			1-><|Even->{ConjugateSourceWeylRotationalGaugeFieldPara1p,ConjugateSourceWeylRotationalGaugeFieldPerp1p},Odd->{ConjugateSourceWeylRotationalGaugeFieldPara1m,ConjugateSourceWeylRotationalGaugeFieldPerp1m}|>,
			2-><|Even->{ConjugateSourceWeylRotationalGaugeFieldPara2p},Odd->{ConjugateSourceWeylRotationalGaugeFieldPara2m}|>
		|>,
		ConjugateSourceWeylTranslationalGaugeFieldPerturbation-><|
			0-><|Even->{ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara0p,ConjugateSourceWeylTranslationalGaugeFieldPerturbationPerp0p},Odd->{}|>,
			1-><|Even->{ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara1p},Odd->{ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara1m,ConjugateSourceWeylTranslationalGaugeFieldPerturbationPerp1m}|>,
			2-><|Even->{ConjugateSourceWeylTranslationalGaugeFieldPerturbationPara2p},Odd->{}|>
		|>
|>;

SourceEngineeringDimensions=<|
		ConjugateSourceWeylVector->0,
		(*This is 1 as we choose Einstein Gauge rescaling phi -> phi0(1+phi)*)
		ConjugateSourceCompensator->1,
		ConjugateSourceWeylRotationalGaugeField->0,
		ConjugateSourceWeylTranslationalGaugeFieldPerturbation->1
|>;

ExpandFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`WeylVectorSpinParityToWeylVector;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`CompensatorSpinParityToCompensator;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`WeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldParaSpinParityToWeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeField;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`WeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldPerpSpinParityToWeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeField;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`ProjWeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`ProjWeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldSpinParityToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`WeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldPerpParaToWeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeField;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

ExpandSources[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylVectorSpinParityToConjugateSourceWeylVector;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceCompensatorSpinParityToConjugateSourceCompensator;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylTranslationalGaugeFieldPerturbationConjugateSourceWeylRotationalGaugeFieldParaSpinParityToConjugateSourceWeylTranslationalGaugeFieldPerturbationConjugateSourceWeylRotationalGaugeField;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylTranslationalGaugeFieldPerturbationConjugateSourceWeylRotationalGaugeFieldPerpSpinParityToConjugateSourceWeylTranslationalGaugeFieldPerturbationConjugateSourceWeylRotationalGaugeField;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`ProjWeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`ProjWeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldSpinParityToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylTranslationalGaugeFieldPerturbationConjugateSourceWeylRotationalGaugeFieldPerpParaToConjugateSourceWeylTranslationalGaugeFieldPerturbationConjugateSourceWeylRotationalGaugeField;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
Expr];

DecomposeFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`WeylVectorToWeylVectorSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`CompensatorToCompensatorSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`WeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldToWeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldPerpPara;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`WeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldParaToWeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldParaSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`WeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldPerpToWeylTranslationalGaugeFieldPerturbationWeylRotationalGaugeFieldPerpSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`Patch2m;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`ManualAll;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

End[];

EndPackage[];

DefClass[
	"WeylGaugeTheory",
	xAct`PSALTer`WeylGaugeTheory`Private`LagrangianCouplings,
	xAct`PSALTer`WeylGaugeTheory`Private`FieldSpinParityTensorHeads,
	xAct`PSALTer`WeylGaugeTheory`Private`SourceSpinParityTensorHeads,
	xAct`PSALTer`WeylGaugeTheory`Private`SourceEngineeringDimensions,
	xAct`PSALTer`WeylGaugeTheory`Private`ExpandFields,
	xAct`PSALTer`WeylGaugeTheory`Private`DecomposeFields,
	xAct`PSALTer`WeylGaugeTheory`Private`ExpandSources,
ExportClass->False];
