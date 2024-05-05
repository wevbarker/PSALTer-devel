(* ::Package:: *)

(*===========================*)
(*  WeylEinsteinGaugeTheory  *)
(*===========================*)

BeginPackage["xAct`PSALTer`WeylEinsteinGaugeTheory`",{"xAct`xTensor`","xAct`xPerm`","xAct`xCore`","xAct`xTras`","xAct`xCoba`","xAct`PSALTer`"}];

(*=================================================================*)
(*  Basic definitions of gauge fields and their conjugate sources  *)
(*=================================================================*)

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinVectorSymb="\[ScriptCapitalB]";
DefTensor[WeylEinsteinVector[-d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinVectorSymb],Dagger->Complex];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinVectorSymb="\[ScriptCapitalJ]";
DefTensor[ConjugateSourceWeylEinsteinVector[-d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinVectorSymb],Dagger->Complex];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinRotationalGaugeFieldSymb="\[ScriptCapitalA]";
DefTensor[WeylEinsteinRotationalGaugeField[a,c,-d],M4,Antisymmetric[{a,c}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinRotationalGaugeFieldSymb],Dagger->Complex];

(*Is there something wrong with the Conjugate Rotational Gauge field index symmetry?*)
xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinRotationalGaugeFieldSymb="\[Sigma]";
DefTensor[ConjugateSourceWeylEinsteinRotationalGaugeField[-i,-j,-k],M4,Antisymmetric[{-j,-k}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinRotationalGaugeFieldSymb],Dagger->Complex];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinTranslationalGaugeFieldPerturbationSymb="\[ScriptF]";
DefTensor[WeylEinsteinTranslationalGaugeFieldPerturbation[-i,-j],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinTranslationalGaugeFieldPerturbationSymb],Dagger->Complex];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationSymb="\[Tau]";
DefTensor[ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbation[-i,-j],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationSymb],Dagger->Complex];

(*==============*)
(*  Projectors  *)
(*==============*)

(*====================================*)
(*  Basic perpendicular and parallel  *)
(*====================================*)

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[UpTee]\)]\)";
DefTensor[ProjPerp[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpSymb]];
xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjParaSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[DoubleVerticalBar]\)]\)";
DefTensor[ProjPara[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjParaSymb]];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG=Join[
	MakeRule[{ProjPerp[-a,b],Evaluate[V[-a]V[b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjPara[-a,b],Evaluate[G[-a,b]-V[-a]V[b]]},MetricOn->All,ContractMetrics->True]];

(*====================================*)
(*  Field perpendicular and parallel  *)
(*====================================*)

DefTensor[ProjWeylEinsteinRotationalGaugeFieldPerp[-a,-b,d,e,f],M4];
DefTensor[ProjWeylEinsteinRotationalGaugeFieldPara[-a,-b,-c,d,e,f],M4];
DefTensor[ProjWeylEinsteinTranslationalGaugeFieldPerturbationPerp[-a,d,e],M4];
DefTensor[ProjWeylEinsteinTranslationalGaugeFieldPerturbationPara[-a,-b,d,e],M4];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjWeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldPerpParaToVG=Join[
	MakeRule[{ProjWeylEinsteinRotationalGaugeFieldPerp[-a,-b,d,e,f],Evaluate[
		V[d]ProjPara[-a,e]G[-b,f]/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylEinsteinRotationalGaugeFieldPara[-a,-b,-c,d,e,f],Evaluate[
		ProjPara[-a,d]ProjPara[-b,e]G[-c,f]/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylEinsteinTranslationalGaugeFieldPerturbationPerp[-a,d,e],Evaluate[
		V[d]G[-a,e]/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylEinsteinTranslationalGaugeFieldPerturbationPara[-a,-b,d,e],Evaluate[
		ProjPara[-a,d]G[-b,e]/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*==============================*)
(*  Spin-parity or SO(3) parts  *)
(*==============================*)

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjWeylEinsteinRotationalGaugeFieldSymb="\!\(\*SubscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(\[Hacek]\)],\(\[ScriptCapitalA]\)]\)";
DefTensor[ProjWeylEinsteinRotationalGaugeField0p[c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjWeylEinsteinRotationalGaugeFieldSymb,xAct`PSALTer`Private`Spin0p]];
DefTensor[ProjWeylEinsteinRotationalGaugeField0m[d,e,f],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjWeylEinsteinRotationalGaugeFieldSymb,xAct`PSALTer`Private`Spin0m]];
DefTensor[ProjWeylEinsteinRotationalGaugeField1p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjWeylEinsteinRotationalGaugeFieldSymb,xAct`PSALTer`Private`Spin1p]];
DefTensor[ProjWeylEinsteinRotationalGaugeField1m[-a,d,e,f],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjWeylEinsteinRotationalGaugeFieldSymb,xAct`PSALTer`Private`Spin1m]];
DefTensor[ProjWeylEinsteinRotationalGaugeField2p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjWeylEinsteinRotationalGaugeFieldSymb,xAct`PSALTer`Private`Spin2p]];
DefTensor[ProjWeylEinsteinRotationalGaugeField2m[-a,-b,-c,d,e,f],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjWeylEinsteinRotationalGaugeFieldSymb,xAct`PSALTer`Private`Spin2m]];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjWeylEinsteinTranslationalGaugeFieldPerturbationSymb="\!\(\*SubscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(\[Hacek]\)],\(\[ScriptB]\)]\)";
DefTensor[ProjWeylEinsteinTranslationalGaugeFieldPerturbation0p[c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjWeylEinsteinTranslationalGaugeFieldPerturbationSymb,xAct`PSALTer`Private`Spin0p]];
DefTensor[ProjWeylEinsteinTranslationalGaugeFieldPerturbation1p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjWeylEinsteinTranslationalGaugeFieldPerturbationSymb,xAct`PSALTer`Private`Spin1p]];
DefTensor[ProjWeylEinsteinTranslationalGaugeFieldPerturbation2p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjWeylEinsteinTranslationalGaugeFieldPerturbationSymb,xAct`PSALTer`Private`Spin2p]];
DefTensor[ProjWeylEinsteinTranslationalGaugeFieldPerturbation1m[-a,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjWeylEinsteinTranslationalGaugeFieldPerturbationSymb,xAct`PSALTer`Private`Spin1m]];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjWeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldSpinParityToVG=Join[
	MakeRule[{ProjWeylEinsteinRotationalGaugeField0p[c,d],Evaluate[
		ProjPara[c,-k]ProjPara[d,-l]G[k,l]/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylEinsteinRotationalGaugeField1p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l]Antisymmetrize[G[-i,k]G[-j,l],{-i,-j}]/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylEinsteinRotationalGaugeField2p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l](Symmetrize[G[-i,k]G[-j,l],{-i,-j}]-(1/3)G[-i,-j]G[k,l])/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylEinsteinRotationalGaugeField0m[d,e,f],Evaluate[
		ProjPara[-i,d]ProjPara[-j,e]ProjPara[-k,f]epsilonG[i,j,k,g]V[-g]/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylEinsteinRotationalGaugeField1m[-a,d,e,f],Evaluate[
		ProjPara[-i,d]ProjPara[-j,f]ProjPara[k,-a]ProjPara[-l,e]G[i,j]G[-k,l]/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylEinsteinRotationalGaugeField2m[-a,-b,-c,d,e,f],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[-c,k]ProjPara[d,-l]ProjPara[e,-n]ProjPara[f,-m](3/4)((1/3)(2G[-i,l]G[-j,n]G[-k,m]-G[-j,l]G[-k,n]G[-i,m]-G[-k,l]G[-i,n]G[-j,m])-Antisymmetrize[G[-i,-k]G[-j,n]G[l,m],{-i,-j}])/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylEinsteinTranslationalGaugeFieldPerturbation0p[c,d],Evaluate[
		ProjPara[c,-k]ProjPara[d,-l]G[k,l]/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylEinsteinTranslationalGaugeFieldPerturbation1p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l]Antisymmetrize[G[-i,k]G[-j,l],{-i,-j}]/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylEinsteinTranslationalGaugeFieldPerturbation1m[-a,d],Evaluate[
		ProjPara[d,-j]ProjPara[-a,i]G[-i,j]/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylEinsteinTranslationalGaugeFieldPerturbation2p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l](Symmetrize[G[-i,k]G[-j,l],{-i,-j}]-(1/3)G[-i,-j]G[k,l])/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

(*====================================*)
(*  Field perpendicular and parallel  *)
(*====================================*)

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinTranslationalGaugeFieldPerturbationParaSymb="\!\(\*SuperscriptBox[\(\[ScriptF]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[WeylEinsteinTranslationalGaugeFieldPerturbationPara[-a,-b],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinTranslationalGaugeFieldPerturbationParaSymb],OrthogonalTo->{V[b]},Dagger->Complex];
xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinRotationalGaugeFieldParaSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalA]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[WeylEinsteinRotationalGaugeFieldPara[-a,-b,-c],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinRotationalGaugeFieldParaSymb],OrthogonalTo->{V[c]},Dagger->Complex];
xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinTranslationalGaugeFieldPerturbationPerpSymb="\!\(\*SuperscriptBox[\(\[ScriptF]\),\(\[UpTee]\)]\)";
DefTensor[WeylEinsteinTranslationalGaugeFieldPerturbationPerp[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinTranslationalGaugeFieldPerturbationPerpSymb],Dagger->Complex];
xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinRotationalGaugeFieldPerpSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalA]\),\(\[UpTee]\)]\)";
DefTensor[WeylEinsteinRotationalGaugeFieldPerp[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinRotationalGaugeFieldPerpSymb],Dagger->Complex];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldToWeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldPerpPara=Join[
	MakeRule[{WeylEinsteinTranslationalGaugeFieldPerturbation[-a,-b],Evaluate[WeylEinsteinTranslationalGaugeFieldPerturbationPara[-a,-b]+V[-b]WeylEinsteinTranslationalGaugeFieldPerturbationPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylEinsteinRotationalGaugeField[-a,-b,-c],Evaluate[WeylEinsteinRotationalGaugeFieldPara[-a,-b,-c]+V[-c]WeylEinsteinRotationalGaugeFieldPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinTranslationalGaugeFieldPerturbation[-a,-b],Evaluate[Dagger@(WeylEinsteinTranslationalGaugeFieldPerturbationPara[-a,-b]+V[-b]WeylEinsteinTranslationalGaugeFieldPerturbationPerp[-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinRotationalGaugeField[-a,-b,-c],Evaluate[Dagger@(WeylEinsteinRotationalGaugeFieldPara[-a,-b,-c]+V[-c]WeylEinsteinRotationalGaugeFieldPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldPerpParaToWeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeField=Join[
	MakeRule[{WeylEinsteinTranslationalGaugeFieldPerturbationPara[-a,-b],Evaluate[
		ProjPara[-b,c]WeylEinsteinTranslationalGaugeFieldPerturbation[-a,-c]/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylEinsteinTranslationalGaugeFieldPerturbationPerp[-a],Evaluate[
		V[c]WeylEinsteinTranslationalGaugeFieldPerturbation[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylEinsteinRotationalGaugeFieldPara[-a,-e,-b],Evaluate[
		ProjPara[-b,c]WeylEinsteinRotationalGaugeField[-a,-e,-c]/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylEinsteinRotationalGaugeFieldPerp[-a,-e],Evaluate[
		V[c]WeylEinsteinRotationalGaugeField[-a,-e,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinTranslationalGaugeFieldPerturbationPara[-a,-b],Evaluate[Dagger@(
		ProjPara[-b,c]WeylEinsteinTranslationalGaugeFieldPerturbation[-a,-c]/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinTranslationalGaugeFieldPerturbationPerp[-a],Evaluate[Dagger@(
		V[c]WeylEinsteinTranslationalGaugeFieldPerturbation[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinRotationalGaugeFieldPara[-a,-e,-b],Evaluate[Dagger@(
		ProjPara[-b,c]WeylEinsteinRotationalGaugeField[-a,-e,-c]/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinRotationalGaugeFieldPerp[-a,-e],Evaluate[Dagger@(
		V[c]WeylEinsteinRotationalGaugeField[-a,-e,-c])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationParaSymb="\!\(\*SuperscriptBox[\(\[Tau]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara[-a,-b],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationParaSymb],OrthogonalTo->{V[b]},Dagger->Complex];
xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinRotationalGaugeFieldParaSymb="\!\(\*SuperscriptBox[\(\[Sigma]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[ConjugateSourceWeylEinsteinRotationalGaugeFieldPara[-c,-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinRotationalGaugeFieldParaSymb],OrthogonalTo->{V[c]},Dagger->Complex];
xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPerpSymb="\!\(\*SuperscriptBox[\(\[Tau]\),\(\[UpTee]\)]\)";
DefTensor[ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPerp[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPerpSymb],Dagger->Complex];
xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinRotationalGaugeFieldPerpSymb="\!\(\*SuperscriptBox[\(\[Sigma]\),\(\[UpTee]\)]\)";
DefTensor[ConjugateSourceWeylEinsteinRotationalGaugeFieldPerp[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinRotationalGaugeFieldPerpSymb],Dagger->Complex];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationConjugateSourceWeylEinsteinRotationalGaugeFieldToConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationConjugateSourceWeylEinsteinRotationalGaugeFieldPerpPara=Join[
	MakeRule[{ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbation[-a,-b],Evaluate[
		ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara[-a,-b]+V[-b]ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylEinsteinRotationalGaugeField[-c,-a,-b],Evaluate[	
		ConjugateSourceWeylEinsteinRotationalGaugeFieldPara[-c,-a,-b]+V[-c]ConjugateSourceWeylEinsteinRotationalGaugeFieldPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbation[-a,-b],Evaluate[Dagger@(	
		ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara[-a,-b]+V[-b]ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPerp[-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinRotationalGaugeField[-c,-a,-b],Evaluate[Dagger@(	
		ConjugateSourceWeylEinsteinRotationalGaugeFieldPara[-c,-a,-b]+V[-c]ConjugateSourceWeylEinsteinRotationalGaugeFieldPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationConjugateSourceWeylEinsteinRotationalGaugeFieldPerpParaToConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationConjugateSourceWeylEinsteinRotationalGaugeField=Join[
	MakeRule[{ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara[-a,-b],Evaluate[	
		ProjPara[-b,c]ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbation[-a,-c]/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPerp[-a],Evaluate[
		V[c]ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbation[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylEinsteinRotationalGaugeFieldPara[-b,-a,-e],Evaluate[
		ProjPara[-b,c]ConjugateSourceWeylEinsteinRotationalGaugeField[-c,-a,-e]/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylEinsteinRotationalGaugeFieldPerp[-a,-e],Evaluate[
		V[c]ConjugateSourceWeylEinsteinRotationalGaugeField[-c,-a,-e]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara[-a,-b],Evaluate[Dagger@(
		ProjPara[-b,c]ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbation[-a,-c]/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPerp[-a],Evaluate[Dagger@(
		V[c]ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbation[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinRotationalGaugeFieldPara[-b,-a,-e],Evaluate[Dagger@(
		ProjPara[-b,c]ConjugateSourceWeylEinsteinRotationalGaugeField[-c,-a,-e]/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinRotationalGaugeFieldPerp[-a,-e],Evaluate[Dagger@(
		V[c]ConjugateSourceWeylEinsteinRotationalGaugeField[-c,-a,-e])]},MetricOn->All,ContractMetrics->True]];

(*==============================*)
(*  Spin-parity or SO(3) parts  *)
(*==============================*)

(*======================*)
(*  Tensor definitions  *)
(*======================*)

DefSpinParityMode[WeylEinsteinVector0p[],Spin->0,Parity->Even,
	FieldSymbol->xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinVectorSymb,
	SourceSymbol->xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinVectorSymb];

DefSpinParityMode[WeylEinsteinVector1m[-a],Spin->1,Parity->Odd,
	FieldSymbol->xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinVectorSymb,
	SourceSymbol->xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinVectorSymb];

DefTensor[WeylEinsteinTranslationalGaugeFieldPerturbationPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[WeylEinsteinTranslationalGaugeFieldPerturbationPara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[WeylEinsteinTranslationalGaugeFieldPerturbationPara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[WeylEinsteinTranslationalGaugeFieldPerturbationPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];

DefTensor[WeylEinsteinRotationalGaugeFieldPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[WeylEinsteinRotationalGaugeFieldPara0m[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin0m],Dagger->Complex];
DefTensor[WeylEinsteinRotationalGaugeFieldPara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[WeylEinsteinRotationalGaugeFieldPara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[WeylEinsteinRotationalGaugeFieldPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[WeylEinsteinRotationalGaugeFieldPara2m[-a,-b,-c],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin2m],OrthogonalTo->{V[a],V[b],V[c]},Dagger->Complex];

AutomaticRules[WeylEinsteinRotationalGaugeFieldPara2m,MakeRule[{Evaluate@Dagger@WeylEinsteinRotationalGaugeFieldPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylEinsteinRotationalGaugeFieldPara2m,MakeRule[{Evaluate@Dagger[epsilonG[a,b,c,d]WeylEinsteinRotationalGaugeFieldPara2m[-a,-b,-c]],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylEinsteinTranslationalGaugeFieldPerturbationPara2p,MakeRule[{Evaluate@Dagger@WeylEinsteinTranslationalGaugeFieldPerturbationPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylEinsteinRotationalGaugeFieldPara2p,MakeRule[{Evaluate@Dagger@WeylEinsteinRotationalGaugeFieldPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ManualAll=Join[
	MakeRule[{Evaluate@Dagger@WeylEinsteinRotationalGaugeFieldPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger[epsilonG[a,b,c,d]WeylEinsteinRotationalGaugeFieldPara2m[-a,-b,-c]],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinTranslationalGaugeFieldPerturbationPara2p[a,-a],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinRotationalGaugeFieldPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

AutomaticRules[WeylEinsteinRotationalGaugeFieldPara2m,MakeRule[{WeylEinsteinRotationalGaugeFieldPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylEinsteinRotationalGaugeFieldPara2m,MakeRule[{epsilonG[a,b,c,d]WeylEinsteinRotationalGaugeFieldPara2m[-a,-b,-c],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylEinsteinTranslationalGaugeFieldPerturbationPara2p,MakeRule[{WeylEinsteinTranslationalGaugeFieldPerturbationPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylEinsteinRotationalGaugeFieldPara2p,MakeRule[{WeylEinsteinRotationalGaugeFieldPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

DefTensor[ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];

DefTensor[ConjugateSourceWeylEinsteinRotationalGaugeFieldPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ConjugateSourceWeylEinsteinRotationalGaugeFieldPara0m[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin0m],Dagger->Complex];
DefTensor[ConjugateSourceWeylEinsteinRotationalGaugeFieldPara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[ConjugateSourceWeylEinsteinRotationalGaugeFieldPara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2m[-a,-b,-c],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin2m],OrthogonalTo->{V[a],V[b],V[c]},Dagger->Complex];

AutomaticRules[ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2m,MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2m,MakeRule[{Evaluate@Dagger[epsilonG[a,b,c,d]ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2m[-a,-b,-c]],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara2p,MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2p,MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ManualAll=Join[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ManualAll,
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger[epsilonG[a,b,c,d]ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2m[-a,-b,-c]],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara2p[a,-a],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

AutomaticRules[ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2m,MakeRule[{ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2m,MakeRule[{epsilonG[a,b,c,d]ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2m[-a,-b,-c],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara2p,MakeRule[{ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2p,MakeRule[{ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

(*==============*)
(*  Expansions  *)
(*==============*)

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinVectorSpinParityToWeylEinsteinVector=Join[
	MakeRule[{WeylEinsteinVector0p[],Evaluate[V[a]WeylEinsteinVector[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylEinsteinVector1m[-a],Evaluate[
		ProjPara[-a,b]WeylEinsteinVector[-b]/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinVector0p[],Evaluate@Dagger[V[a]WeylEinsteinVector[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinVector1m[-a],Evaluate@Dagger[
		ProjPara[-a,b]WeylEinsteinVector[-b]/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinVectorSpinParityToConjugateSourceWeylEinsteinVector=Join[
	MakeRule[{ConjugateSourceWeylEinsteinVector0p[],Evaluate[V[a]ConjugateSourceWeylEinsteinVector[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylEinsteinVector1m[-a],Evaluate[
		ProjPara[-a,b]ConjugateSourceWeylEinsteinVector[-b]/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinVector0p[],Evaluate@Dagger[V[a]ConjugateSourceWeylEinsteinVector[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinVector1m[-a],Evaluate@Dagger[
		ProjPara[-a,b]ConjugateSourceWeylEinsteinVector[-b]/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldParaSpinParityToWeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeField=Join[
	MakeRule[{WeylEinsteinTranslationalGaugeFieldPerturbationPara0p[],Scalar[Evaluate[
		ProjWeylEinsteinTranslationalGaugeFieldPerturbation0p[e,f]ProjWeylEinsteinTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]WeylEinsteinTranslationalGaugeFieldPerturbationPara[-a,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylEinsteinTranslationalGaugeFieldPerturbationPara1p[-n,-m],Evaluate[
		ProjWeylEinsteinTranslationalGaugeFieldPerturbation1p[-n,-m,e,f]ProjWeylEinsteinTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]WeylEinsteinTranslationalGaugeFieldPerturbationPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylEinsteinTranslationalGaugeFieldPerturbationPara1m[-n],Evaluate[
		ProjWeylEinsteinTranslationalGaugeFieldPerturbation1m[-n,f]ProjWeylEinsteinTranslationalGaugeFieldPerturbationPerp[-f,a,c]WeylEinsteinTranslationalGaugeFieldPerturbationPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylEinsteinTranslationalGaugeFieldPerturbationPara2p[-n,-m],Evaluate[
		ProjWeylEinsteinTranslationalGaugeFieldPerturbation2p[-n,-m,e,f]ProjWeylEinsteinTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]WeylEinsteinTranslationalGaugeFieldPerturbationPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylEinsteinRotationalGaugeFieldPara0p[],Scalar[Evaluate[
		ProjWeylEinsteinRotationalGaugeField0p[e,f]ProjWeylEinsteinRotationalGaugeFieldPerp[-e,-f,a,b,c]WeylEinsteinRotationalGaugeFieldPara[-a,-b,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylEinsteinRotationalGaugeFieldPara0m[],Scalar[Evaluate[
		ProjWeylEinsteinRotationalGaugeField0m[d,e,f]ProjWeylEinsteinRotationalGaugeFieldPara[-d,-e,-f,a,b,c]WeylEinsteinRotationalGaugeFieldPara[-a,-b,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylEinsteinRotationalGaugeFieldPara1p[-n,-m],Evaluate[
		ProjWeylEinsteinRotationalGaugeField1p[-n,-m,e,f]ProjWeylEinsteinRotationalGaugeFieldPerp[-e,-f,a,b,c]WeylEinsteinRotationalGaugeFieldPara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylEinsteinRotationalGaugeFieldPara1m[-n],Evaluate[
		ProjWeylEinsteinRotationalGaugeField1m[-n,d,e,f]ProjWeylEinsteinRotationalGaugeFieldPara[-d,-e,-f,a,b,c]WeylEinsteinRotationalGaugeFieldPara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylEinsteinRotationalGaugeFieldPara2p[-n,-m],Evaluate[
		ProjWeylEinsteinRotationalGaugeField2p[-n,-m,e,f]ProjWeylEinsteinRotationalGaugeFieldPerp[-e,-f,a,b,c]WeylEinsteinRotationalGaugeFieldPara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylEinsteinRotationalGaugeFieldPara2m[-n,-m,-o],Evaluate[
		ProjWeylEinsteinRotationalGaugeField2m[-n,-m,-o,d,e,f]ProjWeylEinsteinRotationalGaugeFieldPara[-d,-e,-f,a,b,c]WeylEinsteinRotationalGaugeFieldPara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinTranslationalGaugeFieldPerturbationPara0p[],Scalar[Evaluate[Dagger@(
		ProjWeylEinsteinTranslationalGaugeFieldPerturbation0p[e,f]ProjWeylEinsteinTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]WeylEinsteinTranslationalGaugeFieldPerturbationPara[-a,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinTranslationalGaugeFieldPerturbationPara1p[-n,-m],Evaluate[Dagger@(
		ProjWeylEinsteinTranslationalGaugeFieldPerturbation1p[-n,-m,e,f]ProjWeylEinsteinTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]WeylEinsteinTranslationalGaugeFieldPerturbationPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinTranslationalGaugeFieldPerturbationPara1m[-n],Evaluate[Dagger@(
		ProjWeylEinsteinTranslationalGaugeFieldPerturbation1m[-n,f]ProjWeylEinsteinTranslationalGaugeFieldPerturbationPerp[-f,a,c]WeylEinsteinTranslationalGaugeFieldPerturbationPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinTranslationalGaugeFieldPerturbationPara2p[-n,-m],Evaluate[Dagger@(
		ProjWeylEinsteinTranslationalGaugeFieldPerturbation2p[-n,-m,e,f]ProjWeylEinsteinTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]WeylEinsteinTranslationalGaugeFieldPerturbationPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinRotationalGaugeFieldPara0p[],Scalar[Evaluate[Dagger@(
		ProjWeylEinsteinRotationalGaugeField0p[e,f]ProjWeylEinsteinRotationalGaugeFieldPerp[-e,-f,a,b,c]WeylEinsteinRotationalGaugeFieldPara[-a,-b,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinRotationalGaugeFieldPara0m[],Scalar[Evaluate[Dagger@(
		ProjWeylEinsteinRotationalGaugeField0m[d,e,f]ProjWeylEinsteinRotationalGaugeFieldPara[-d,-e,-f,a,b,c]WeylEinsteinRotationalGaugeFieldPara[-a,-b,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinRotationalGaugeFieldPara1p[-n,-m],Evaluate[Dagger@(
		ProjWeylEinsteinRotationalGaugeField1p[-n,-m,e,f]ProjWeylEinsteinRotationalGaugeFieldPerp[-e,-f,a,b,c]WeylEinsteinRotationalGaugeFieldPara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinRotationalGaugeFieldPara1m[-n],Evaluate[Dagger@(
		ProjWeylEinsteinRotationalGaugeField1m[-n,d,e,f]ProjWeylEinsteinRotationalGaugeFieldPara[-d,-e,-f,a,b,c]WeylEinsteinRotationalGaugeFieldPara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinRotationalGaugeFieldPara2p[-n,-m],Evaluate[Dagger@(
		ProjWeylEinsteinRotationalGaugeField2p[-n,-m,e,f]ProjWeylEinsteinRotationalGaugeFieldPerp[-e,-f,a,b,c]WeylEinsteinRotationalGaugeFieldPara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinRotationalGaugeFieldPara2m[-n,-m,-o],Evaluate[Dagger@(
		ProjWeylEinsteinRotationalGaugeField2m[-n,-m,-o,d,e,f]ProjWeylEinsteinRotationalGaugeFieldPara[-d,-e,-f,a,b,c]WeylEinsteinRotationalGaugeFieldPara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True]];

DefTensor[WeylEinsteinTranslationalGaugeFieldPerturbationPerp0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinTranslationalGaugeFieldPerturbationPerpSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[WeylEinsteinTranslationalGaugeFieldPerturbationPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinTranslationalGaugeFieldPerturbationPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[WeylEinsteinRotationalGaugeFieldPerp1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinRotationalGaugeFieldPerpSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[WeylEinsteinRotationalGaugeFieldPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinRotationalGaugeFieldPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldPerpSpinParityToWeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeField=Join[
	MakeRule[{WeylEinsteinTranslationalGaugeFieldPerturbationPerp0p[],Scalar[Evaluate[
		V[a]WeylEinsteinTranslationalGaugeFieldPerturbationPerp[-a]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylEinsteinTranslationalGaugeFieldPerturbationPerp1m[-n],Evaluate[
		ProjPara[-n,a]WeylEinsteinTranslationalGaugeFieldPerturbationPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylEinsteinRotationalGaugeFieldPerp1p[-n,-m],Evaluate[
		ProjPara[-n,a]ProjPara[-m,b]WeylEinsteinRotationalGaugeFieldPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylEinsteinRotationalGaugeFieldPerp1m[-n],Evaluate[
		ProjPara[-n,a]V[b]WeylEinsteinRotationalGaugeFieldPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinTranslationalGaugeFieldPerturbationPerp0p[],Scalar[Evaluate[Dagger@(
		V[a]WeylEinsteinTranslationalGaugeFieldPerturbationPerp[-a])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinTranslationalGaugeFieldPerturbationPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]WeylEinsteinTranslationalGaugeFieldPerturbationPerp[-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinRotationalGaugeFieldPerp1p[-n,-m],Evaluate[Dagger@(
		ProjPara[-n,a]ProjPara[-m,b]WeylEinsteinRotationalGaugeFieldPerp[-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinRotationalGaugeFieldPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]V[b]WeylEinsteinRotationalGaugeFieldPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationConjugateSourceWeylEinsteinRotationalGaugeFieldParaSpinParityToConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationConjugateSourceWeylEinsteinRotationalGaugeField=Join[
	MakeRule[{ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara0p[],Scalar[Evaluate[
		ProjWeylEinsteinTranslationalGaugeFieldPerturbation0p[e,f]ProjWeylEinsteinTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara[-a,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara1p[-n,-m],Evaluate[
		ProjWeylEinsteinTranslationalGaugeFieldPerturbation1p[-n,-m,e,f]ProjWeylEinsteinTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara1m[-n],Evaluate[
		ProjWeylEinsteinTranslationalGaugeFieldPerturbation1m[-n,f]ProjWeylEinsteinTranslationalGaugeFieldPerturbationPerp[-f,a,c]ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara2p[-n,-m],Evaluate[
		ProjWeylEinsteinTranslationalGaugeFieldPerturbation2p[-n,-m,e,f]ProjWeylEinsteinTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylEinsteinRotationalGaugeFieldPara0p[],Scalar[Evaluate[
		ProjWeylEinsteinRotationalGaugeField0p[e,f]ProjWeylEinsteinRotationalGaugeFieldPerp[-e,-f,a,b,c]ConjugateSourceWeylEinsteinRotationalGaugeFieldPara[-c,-a,-b]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylEinsteinRotationalGaugeFieldPara0m[],Scalar[Evaluate[
		ProjWeylEinsteinRotationalGaugeField0m[d,e,f]ProjWeylEinsteinRotationalGaugeFieldPara[-d,-e,-f,a,b,c]ConjugateSourceWeylEinsteinRotationalGaugeFieldPara[-c,-a,-b]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylEinsteinRotationalGaugeFieldPara1p[-n,-m],Evaluate[
		ProjWeylEinsteinRotationalGaugeField1p[-n,-m,e,f]ProjWeylEinsteinRotationalGaugeFieldPerp[-e,-f,a,b,c]ConjugateSourceWeylEinsteinRotationalGaugeFieldPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylEinsteinRotationalGaugeFieldPara1m[-n],Evaluate[
		ProjWeylEinsteinRotationalGaugeField1m[-n,d,e,f]ProjWeylEinsteinRotationalGaugeFieldPara[-d,-e,-f,a,b,c]ConjugateSourceWeylEinsteinRotationalGaugeFieldPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2p[-n,-m],Evaluate[
		ProjWeylEinsteinRotationalGaugeField2p[-n,-m,e,f]ProjWeylEinsteinRotationalGaugeFieldPerp[-e,-f,a,b,c]ConjugateSourceWeylEinsteinRotationalGaugeFieldPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2m[-n,-m,-o],Evaluate[
		ProjWeylEinsteinRotationalGaugeField2m[-n,-m,-o,d,e,f]ProjWeylEinsteinRotationalGaugeFieldPara[-d,-e,-f,a,b,c]ConjugateSourceWeylEinsteinRotationalGaugeFieldPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara0p[],Scalar[Evaluate[Dagger@(
		ProjWeylEinsteinTranslationalGaugeFieldPerturbation0p[e,f]ProjWeylEinsteinTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara[-a,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara1p[-n,-m],Evaluate[Dagger@(
		ProjWeylEinsteinTranslationalGaugeFieldPerturbation1p[-n,-m,e,f]ProjWeylEinsteinTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara1m[-n],Evaluate[Dagger@(
		ProjWeylEinsteinTranslationalGaugeFieldPerturbation1m[-n,f]ProjWeylEinsteinTranslationalGaugeFieldPerturbationPerp[-f,a,c]ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara2p[-n,-m],Evaluate[Dagger@(
		ProjWeylEinsteinTranslationalGaugeFieldPerturbation2p[-n,-m,e,f]ProjWeylEinsteinTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinRotationalGaugeFieldPara0p[],Scalar[Evaluate[Dagger@(
		ProjWeylEinsteinRotationalGaugeField0p[e,f]ProjWeylEinsteinRotationalGaugeFieldPerp[-e,-f,a,b,c]ConjugateSourceWeylEinsteinRotationalGaugeFieldPara[-c,-a,-b])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinRotationalGaugeFieldPara0m[],Scalar[Evaluate[Dagger@(
		ProjWeylEinsteinRotationalGaugeField0m[d,e,f]ProjWeylEinsteinRotationalGaugeFieldPara[-d,-e,-f,a,b,c]ConjugateSourceWeylEinsteinRotationalGaugeFieldPara[-c,-a,-b])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinRotationalGaugeFieldPara1p[-n,-m],Evaluate[Dagger@(
		ProjWeylEinsteinRotationalGaugeField1p[-n,-m,e,f]ProjWeylEinsteinRotationalGaugeFieldPerp[-e,-f,a,b,c]ConjugateSourceWeylEinsteinRotationalGaugeFieldPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinRotationalGaugeFieldPara1m[-n],Evaluate[Dagger@(
		ProjWeylEinsteinRotationalGaugeField1m[-n,d,e,f]ProjWeylEinsteinRotationalGaugeFieldPara[-d,-e,-f,a,b,c]ConjugateSourceWeylEinsteinRotationalGaugeFieldPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2p[-n,-m],Evaluate[Dagger@(
		ProjWeylEinsteinRotationalGaugeField2p[-n,-m,e,f]ProjWeylEinsteinRotationalGaugeFieldPerp[-e,-f,a,b,c]ConjugateSourceWeylEinsteinRotationalGaugeFieldPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2m[-n,-m,-o],Evaluate[Dagger@(
		ProjWeylEinsteinRotationalGaugeField2m[-n,-m,-o,d,e,f]ProjWeylEinsteinRotationalGaugeFieldPara[-d,-e,-f,a,b,c]ConjugateSourceWeylEinsteinRotationalGaugeFieldPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True]];

DefTensor[ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPerp0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPerpSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[ConjugateSourceWeylEinsteinRotationalGaugeFieldPerp1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinRotationalGaugeFieldPerpSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[ConjugateSourceWeylEinsteinRotationalGaugeFieldPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinRotationalGaugeFieldPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationConjugateSourceWeylEinsteinRotationalGaugeFieldPerpSpinParityToConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationConjugateSourceWeylEinsteinRotationalGaugeField=Join[
	MakeRule[{ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPerp0p[],Scalar[Evaluate[
		V[a]ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPerp[-a]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPerp1m[-n],Evaluate[
		ProjPara[-n,a]ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylEinsteinRotationalGaugeFieldPerp1p[-n,-m],Evaluate[
		ProjPara[-n,a]ProjPara[-m,b]ConjugateSourceWeylEinsteinRotationalGaugeFieldPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylEinsteinRotationalGaugeFieldPerp1m[-n],Evaluate[
		ProjPara[-n,a]V[b]ConjugateSourceWeylEinsteinRotationalGaugeFieldPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPerp0p[],Scalar[Evaluate[Dagger@(
		V[a]ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPerp[-a])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPerp[-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinRotationalGaugeFieldPerp1p[-n,-m],Evaluate[Dagger@(
		ProjPara[-n,a]ProjPara[-m,b]ConjugateSourceWeylEinsteinRotationalGaugeFieldPerp[-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinRotationalGaugeFieldPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]V[b]ConjugateSourceWeylEinsteinRotationalGaugeFieldPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinVectorToWeylEinsteinVectorSpinParity=Join[
	MakeRule[{WeylEinsteinVector[-a],Evaluate[V[-a]WeylEinsteinVector0p[]+WeylEinsteinVector1m[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinVector[-a],Evaluate@Dagger[V[-a]WeylEinsteinVector0p[]+WeylEinsteinVector1m[-a]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinVectorToConjugateSourceWeylEinsteinVectorSpinParity=Join[
	MakeRule[{ConjugateSourceWeylEinsteinVector[-a],Evaluate[V[-a]ConjugateSourceWeylEinsteinVector0p[]+ConjugateSourceWeylEinsteinVector1m[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinVector[-a],Evaluate@Dagger[V[-a]ConjugateSourceWeylEinsteinVector0p[]+ConjugateSourceWeylEinsteinVector1m[-a]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldParaToWeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldParaSpinParity=Join[
	MakeRule[{WeylEinsteinTranslationalGaugeFieldPerturbationPara[-n,-m],Evaluate[
		((1/3)ProjPara[-n,-m]WeylEinsteinTranslationalGaugeFieldPerturbationPara0p[]+
		WeylEinsteinTranslationalGaugeFieldPerturbationPara1p[-n,-m]+
		WeylEinsteinTranslationalGaugeFieldPerturbationPara2p[-n,-m]+
		V[-n]WeylEinsteinTranslationalGaugeFieldPerturbationPara1m[-m])/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjWeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylEinsteinRotationalGaugeFieldPara[-n,-m,-o],Evaluate[
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]WeylEinsteinRotationalGaugeFieldPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]WeylEinsteinRotationalGaugeFieldPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]WeylEinsteinRotationalGaugeFieldPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjWeylEinsteinRotationalGaugeField0m[-n,-m,-o]WeylEinsteinRotationalGaugeFieldPara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]WeylEinsteinRotationalGaugeFieldPara1m[-n],{-m,-n}]+
		(4/3)WeylEinsteinRotationalGaugeFieldPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjWeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinTranslationalGaugeFieldPerturbationPara[-n,-m],Evaluate[Dagger@(
		((1/3)ProjPara[-n,-m]WeylEinsteinTranslationalGaugeFieldPerturbationPara0p[]+
		WeylEinsteinTranslationalGaugeFieldPerturbationPara1p[-n,-m]+
		WeylEinsteinTranslationalGaugeFieldPerturbationPara2p[-n,-m]+
		V[-n]WeylEinsteinTranslationalGaugeFieldPerturbationPara1m[-m])/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjWeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinRotationalGaugeFieldPara[-n,-m,-o],Evaluate[Dagger@(
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]WeylEinsteinRotationalGaugeFieldPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]WeylEinsteinRotationalGaugeFieldPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]WeylEinsteinRotationalGaugeFieldPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjWeylEinsteinRotationalGaugeField0m[-n,-m,-o]WeylEinsteinRotationalGaugeFieldPara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]WeylEinsteinRotationalGaugeFieldPara1m[-n],{-m,-n}]+
		(4/3)WeylEinsteinRotationalGaugeFieldPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjWeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldPerpToWeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldPerpSpinParity=Join[
	MakeRule[{WeylEinsteinTranslationalGaugeFieldPerturbationPerp[-n],Evaluate[WeylEinsteinTranslationalGaugeFieldPerturbationPerp0p[]V[-n]+WeylEinsteinTranslationalGaugeFieldPerturbationPerp1m[-n]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylEinsteinRotationalGaugeFieldPerp[-n,-m],Evaluate[WeylEinsteinRotationalGaugeFieldPerp1p[-n,-m]+2Antisymmetrize[V[-m]WeylEinsteinRotationalGaugeFieldPerp1m[-n],{-n,-m}]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinTranslationalGaugeFieldPerturbationPerp[-n],Evaluate[Dagger@(WeylEinsteinTranslationalGaugeFieldPerturbationPerp0p[]V[-n]+WeylEinsteinTranslationalGaugeFieldPerturbationPerp1m[-n])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylEinsteinRotationalGaugeFieldPerp[-n,-m],Evaluate[Dagger@(WeylEinsteinRotationalGaugeFieldPerp1p[-n,-m]+2Antisymmetrize[V[-m]WeylEinsteinRotationalGaugeFieldPerp1m[-n],{-n,-m}])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationConjugateSourceWeylEinsteinRotationalGaugeFieldParaToConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationConjugateSourceWeylEinsteinRotationalGaugeFieldParaSpinParity=Join[
	MakeRule[{ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara[-n,-m],Evaluate[
		((1/3)ProjPara[-n,-m]ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara0p[]+
		ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara1p[-n,-m]+
		ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara2p[-n,-m]+
		V[-n]ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara1m[-m])/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjWeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylEinsteinRotationalGaugeFieldPara[-o,-n,-m],Evaluate[
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]ConjugateSourceWeylEinsteinRotationalGaugeFieldPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]ConjugateSourceWeylEinsteinRotationalGaugeFieldPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjWeylEinsteinRotationalGaugeField0m[-n,-m,-o]ConjugateSourceWeylEinsteinRotationalGaugeFieldPara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]ConjugateSourceWeylEinsteinRotationalGaugeFieldPara1m[-n],{-m,-n}]+
		(4/3)ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjWeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara[-n,-m],Evaluate[Dagger@(
		((1/3)ProjPara[-n,-m]ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara0p[]+
		ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara1p[-n,-m]+
		ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara2p[-n,-m]+
		V[-n]ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara1m[-m])/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjWeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinRotationalGaugeFieldPara[-o,-n,-m],Evaluate[Dagger@(
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]ConjugateSourceWeylEinsteinRotationalGaugeFieldPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]ConjugateSourceWeylEinsteinRotationalGaugeFieldPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjWeylEinsteinRotationalGaugeField0m[-n,-m,-o]ConjugateSourceWeylEinsteinRotationalGaugeFieldPara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]ConjugateSourceWeylEinsteinRotationalGaugeFieldPara1m[-n],{-m,-n}]+
		(4/3)ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjWeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationConjugateSourceWeylEinsteinRotationalGaugeFieldPerpToConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationConjugateSourceWeylEinsteinRotationalGaugeFieldPerpSpinParity=Join[
	MakeRule[{ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPerp[-n],Evaluate[ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPerp0p[]V[-n]+ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPerp1m[-n]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylEinsteinRotationalGaugeFieldPerp[-n,-m],Evaluate[ConjugateSourceWeylEinsteinRotationalGaugeFieldPerp1p[-n,-m]+2Antisymmetrize[V[-m]ConjugateSourceWeylEinsteinRotationalGaugeFieldPerp1m[-n],{-n,-m}]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPerp[-n],Evaluate[Dagger@(ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPerp0p[]V[-n]+ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPerp1m[-n])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylEinsteinRotationalGaugeFieldPerp[-n,-m],Evaluate[Dagger@(ConjugateSourceWeylEinsteinRotationalGaugeFieldPerp1p[-n,-m]+2Antisymmetrize[V[-m]ConjugateSourceWeylEinsteinRotationalGaugeFieldPerp1m[-n],{-n,-m}])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`Patch2m=Join[
	MakeRule[{WeylEinsteinRotationalGaugeFieldPara2m[-a,-c,-b]WeylEinsteinRotationalGaugeFieldPara2m[a,b,c],(1/2)WeylEinsteinRotationalGaugeFieldPara2m[-a,-b,-c]WeylEinsteinRotationalGaugeFieldPara2m[a,b,c]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate[Dagger@WeylEinsteinRotationalGaugeFieldPara2m[-a,-c,-b]WeylEinsteinRotationalGaugeFieldPara2m[a,b,c]],Evaluate[(1/2)Dagger@WeylEinsteinRotationalGaugeFieldPara2m[-a,-b,-c]WeylEinsteinRotationalGaugeFieldPara2m[a,b,c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate[WeylEinsteinRotationalGaugeFieldPara2m[-a,-c,-b]Dagger@WeylEinsteinRotationalGaugeFieldPara2m[a,b,c]],Evaluate[(1/2)WeylEinsteinRotationalGaugeFieldPara2m[-a,-b,-c]Dagger@WeylEinsteinRotationalGaugeFieldPara2m[a,b,c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2m[-a,-c,-b]ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2m[a,b,c],(1/2)ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2m[-a,-b,-c]ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2m[a,b,c]},MetricOn->All,ContractMetrics->True]];

AutomaticRules[WeylEinsteinRotationalGaugeFieldPara2m,MakeRule[{Evaluate[WeylEinsteinRotationalGaugeFieldPara2m[-a,-c,-b]Dagger@WeylEinsteinRotationalGaugeFieldPara2m[a,b,c]],Evaluate[(1/2)WeylEinsteinRotationalGaugeFieldPara2m[-a,-b,-c]Dagger@WeylEinsteinRotationalGaugeFieldPara2m[a,b,c]]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[Evaluate[Dagger@WeylEinsteinRotationalGaugeFieldPara2m],MakeRule[{Evaluate[Dagger@WeylEinsteinRotationalGaugeFieldPara2m[-a,-c,-b]WeylEinsteinRotationalGaugeFieldPara2m[a,b,c]],Evaluate[(1/2)Dagger@WeylEinsteinRotationalGaugeFieldPara2m[-a,-b,-c]WeylEinsteinRotationalGaugeFieldPara2m[a,b,c]]},MetricOn->All,ContractMetrics->True]];

(*==========================================================*)
(*  Basic definitions of the Lagrangian coupling constants  *)
(*==========================================================*)

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`leLambdaSymb="\[Lambda]";
DefLagrangianCoupling[leLambda,CouplingSymbol->xAct`PSALTer`WeylEinsteinGaugeTheory`Private`leLambdaSymb];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`leRSymb="\[ScriptR]";
DefLagrangianCoupling[leR1,
	CouplingSymbol->xAct`PSALTer`WeylEinsteinGaugeTheory`Private`leRSymb,CouplingIndex->1];
DefLagrangianCoupling[leR2,
	CouplingSymbol->xAct`PSALTer`WeylEinsteinGaugeTheory`Private`leRSymb,CouplingIndex->2];
DefLagrangianCoupling[leR3,
	CouplingSymbol->xAct`PSALTer`WeylEinsteinGaugeTheory`Private`leRSymb,CouplingIndex->3];
DefLagrangianCoupling[leR4,
	CouplingSymbol->xAct`PSALTer`WeylEinsteinGaugeTheory`Private`leRSymb,CouplingIndex->4];
DefLagrangianCoupling[leR5,
	CouplingSymbol->xAct`PSALTer`WeylEinsteinGaugeTheory`Private`leRSymb,CouplingIndex->5];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`leCSymb="\[ScriptC]";
DefLagrangianCoupling[leC1,
	CouplingSymbol->xAct`PSALTer`WeylEinsteinGaugeTheory`Private`leCSymb,CouplingIndex->1];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`leTSymb="\[ScriptT]";
DefLagrangianCoupling[leT1,
	CouplingSymbol->xAct`PSALTer`WeylEinsteinGaugeTheory`Private`leTSymb,CouplingIndex->1];
DefLagrangianCoupling[leT2,
	CouplingSymbol->xAct`PSALTer`WeylEinsteinGaugeTheory`Private`leTSymb,CouplingIndex->2];
DefLagrangianCoupling[leT3,
	CouplingSymbol->xAct`PSALTer`WeylEinsteinGaugeTheory`Private`leTSymb,CouplingIndex->3];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`leXiSymb="\[Xi]";
DefLagrangianCoupling[leXi,CouplingSymbol->xAct`PSALTer`WeylEinsteinGaugeTheory`Private`leXiSymb];

xAct`PSALTer`WeylEinsteinGaugeTheory`Private`leNuSymb="\[Nu]";
DefLagrangianCoupling[leNu,CouplingSymbol->xAct`PSALTer`WeylEinsteinGaugeTheory`Private`leNuSymb];

(*Here is the Einstein Gauge for the compensator field*)
xAct`PSALTer`WeylEinsteinGaugeTheory`Private`CompensatorSymb="\[Phi]";
DefLagrangianCoupling[lePhi0,
	CouplingSymbol->xAct`PSALTer`WeylEinsteinGaugeTheory`Private`CompensatorSymb,CouplingIndex->0];

(*===================*)
(*  Private context  *)
(*===================*)

Begin["xAct`PSALTer`WeylEinsteinGaugeTheory`Private`"];

LagrangianCouplings={leLambda,leR1,leR2,leR3,leR4,leR5,leC1,leT1,leT2,leT3,leXi,leNu,lePhi0};

FieldSpinParityTensorHeads=<|
		WeylEinsteinVector-><|
			0-><|Even->{WeylEinsteinVector0p},Odd->{}|>,
			1-><|Even->{},Odd->{WeylEinsteinVector1m}|>,
			2-><|Even->{},Odd->{}|>
		|>,
		WeylEinsteinRotationalGaugeField-><|
			0-><|Even->{WeylEinsteinRotationalGaugeFieldPara0p},Odd->{WeylEinsteinRotationalGaugeFieldPara0m}|>,
			1-><|Even->{WeylEinsteinRotationalGaugeFieldPara1p,WeylEinsteinRotationalGaugeFieldPerp1p},Odd->{WeylEinsteinRotationalGaugeFieldPara1m,WeylEinsteinRotationalGaugeFieldPerp1m}|>,
			2-><|Even->{WeylEinsteinRotationalGaugeFieldPara2p},Odd->{WeylEinsteinRotationalGaugeFieldPara2m}|>
		|>,
		WeylEinsteinTranslationalGaugeFieldPerturbation-><|
			0-><|Even->{WeylEinsteinTranslationalGaugeFieldPerturbationPara0p,WeylEinsteinTranslationalGaugeFieldPerturbationPerp0p},Odd->{}|>,
			1-><|Even->{WeylEinsteinTranslationalGaugeFieldPerturbationPara1p},Odd->{WeylEinsteinTranslationalGaugeFieldPerturbationPara1m,WeylEinsteinTranslationalGaugeFieldPerturbationPerp1m}|>,
			2-><|Even->{WeylEinsteinTranslationalGaugeFieldPerturbationPara2p},Odd->{}|>
		|>
|>;

SourceSpinParityTensorHeads=<|
		ConjugateSourceWeylEinsteinVector-><|
			0-><|Even->{ConjugateSourceWeylEinsteinVector0p},Odd->{}|>,
			1-><|Even->{},Odd->{ConjugateSourceWeylEinsteinVector1m}|>,
			2-><|Even->{},Odd->{}|>
		|>,
		ConjugateSourceWeylEinsteinRotationalGaugeField-><|
			0-><|Even->{ConjugateSourceWeylEinsteinRotationalGaugeFieldPara0p},Odd->{ConjugateSourceWeylEinsteinRotationalGaugeFieldPara0m}|>,
			1-><|Even->{ConjugateSourceWeylEinsteinRotationalGaugeFieldPara1p,ConjugateSourceWeylEinsteinRotationalGaugeFieldPerp1p},Odd->{ConjugateSourceWeylEinsteinRotationalGaugeFieldPara1m,ConjugateSourceWeylEinsteinRotationalGaugeFieldPerp1m}|>,
			2-><|Even->{ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2p},Odd->{ConjugateSourceWeylEinsteinRotationalGaugeFieldPara2m}|>
		|>,
		ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbation-><|
			0-><|Even->{ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara0p,ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPerp0p},Odd->{}|>,
			1-><|Even->{ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara1p},Odd->{ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara1m,ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPerp1m}|>,
			2-><|Even->{ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationPara2p},Odd->{}|>
		|>
|>;

SourceEngineeringDimensions=<|
		ConjugateSourceWeylEinsteinVector->0,
		ConjugateSourceWeylEinsteinRotationalGaugeField->0,
		ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbation->1
|>;

ExpandFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinVectorSpinParityToWeylEinsteinVector;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldParaSpinParityToWeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeField;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldPerpSpinParityToWeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeField;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjWeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjWeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldSpinParityToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldPerpParaToWeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeField;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

ExpandSources[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinVectorSpinParityToConjugateSourceWeylEinsteinVector;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationConjugateSourceWeylEinsteinRotationalGaugeFieldParaSpinParityToConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationConjugateSourceWeylEinsteinRotationalGaugeField;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationConjugateSourceWeylEinsteinRotationalGaugeFieldPerpSpinParityToConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationConjugateSourceWeylEinsteinRotationalGaugeField;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjWeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjWeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldSpinParityToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ProjPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationConjugateSourceWeylEinsteinRotationalGaugeFieldPerpParaToConjugateSourceWeylEinsteinTranslationalGaugeFieldPerturbationConjugateSourceWeylEinsteinRotationalGaugeField;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
Expr];

DecomposeFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinVectorToWeylEinsteinVectorSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldToWeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldPerpPara;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldParaToWeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldParaSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`WeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldPerpToWeylEinsteinTranslationalGaugeFieldPerturbationWeylEinsteinRotationalGaugeFieldPerpSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
	Expr=Expr/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`Patch2m;
	Expr=Expr/.xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ManualAll;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

End[];

EndPackage[];

DefClass[
	"WeylEinsteinGaugeTheory",
	xAct`PSALTer`WeylEinsteinGaugeTheory`Private`LagrangianCouplings,
	xAct`PSALTer`WeylEinsteinGaugeTheory`Private`FieldSpinParityTensorHeads,
	xAct`PSALTer`WeylEinsteinGaugeTheory`Private`SourceSpinParityTensorHeads,
	xAct`PSALTer`WeylEinsteinGaugeTheory`Private`SourceEngineeringDimensions,
	xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ExpandFields,
	xAct`PSALTer`WeylEinsteinGaugeTheory`Private`DecomposeFields,
	xAct`PSALTer`WeylEinsteinGaugeTheory`Private`ExpandSources,
ExportClass->False];
