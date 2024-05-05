(* ::Package:: *)

(*======================*)
(*  WeylSIVGaugeTheory  *)
(*======================*)

BeginPackage["xAct`PSALTer`WeylSIVGaugeTheory`",{"xAct`xTensor`","xAct`xPerm`","xAct`xCore`","xAct`xTras`","xAct`xCoba`","xAct`PSALTer`"}];

(*=================================================================*)
(*  Basic definitions of gauge fields and their conjugate sources  *)
(*=================================================================*)

xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVRotationalGaugeFieldSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalA]\),\(^\)],\(\[ConjugateTranspose]\)]\)";
DefTensor[WeylSIVRotationalGaugeField[a,c,-d],M4,Antisymmetric[{a,c}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVRotationalGaugeFieldSymb],Dagger->Complex];

(*Is there something wrong with the Conjugate Rotational Gauge field index symmetry?*)
xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVRotationalGaugeFieldSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[Sigma]\),\(^\)],\(\[ConjugateTranspose]\)]\)";
DefTensor[ConjugateSourceWeylSIVRotationalGaugeField[-i,-j,-k],M4,Antisymmetric[{-j,-k}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVRotationalGaugeFieldSymb],Dagger->Complex];

xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVTranslationalGaugeFieldPerturbationSymb="\!\(\*OverscriptBox[\(\[ScriptF]\),\(^\)]\)";
DefTensor[WeylSIVTranslationalGaugeFieldPerturbation[-i,-j],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVTranslationalGaugeFieldPerturbationSymb],Dagger->Complex];

xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationSymb="\!\(\*OverscriptBox[\(\[Tau]\),\(^\)]\)";
DefTensor[ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbation[-i,-j],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationSymb],Dagger->Complex];

(*==============*)
(*  Projectors  *)
(*==============*)

(*====================================*)
(*  Basic perpendicular and parallel  *)
(*====================================*)

xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[UpTee]\)]\)";
DefTensor[ProjPerp[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpSymb]];
xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjParaSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[DoubleVerticalBar]\)]\)";
DefTensor[ProjPara[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjParaSymb]];

xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG=Join[
	MakeRule[{ProjPerp[-a,b],Evaluate[V[-a]V[b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjPara[-a,b],Evaluate[G[-a,b]-V[-a]V[b]]},MetricOn->All,ContractMetrics->True]];

(*====================================*)
(*  Field perpendicular and parallel  *)
(*====================================*)

DefTensor[ProjWeylSIVRotationalGaugeFieldPerp[-a,-b,d,e,f],M4];
DefTensor[ProjWeylSIVRotationalGaugeFieldPara[-a,-b,-c,d,e,f],M4];
DefTensor[ProjWeylSIVTranslationalGaugeFieldPerturbationPerp[-a,d,e],M4];
DefTensor[ProjWeylSIVTranslationalGaugeFieldPerturbationPara[-a,-b,d,e],M4];

xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjWeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldPerpParaToVG=Join[
	MakeRule[{ProjWeylSIVRotationalGaugeFieldPerp[-a,-b,d,e,f],Evaluate[
		V[d]ProjPara[-a,e]G[-b,f]/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylSIVRotationalGaugeFieldPara[-a,-b,-c,d,e,f],Evaluate[
		ProjPara[-a,d]ProjPara[-b,e]G[-c,f]/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylSIVTranslationalGaugeFieldPerturbationPerp[-a,d,e],Evaluate[
		V[d]G[-a,e]/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylSIVTranslationalGaugeFieldPerturbationPara[-a,-b,d,e],Evaluate[
		ProjPara[-a,d]G[-b,e]/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*==============================*)
(*  Spin-parity or SO(3) parts  *)
(*==============================*)

xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjWeylSIVRotationalGaugeFieldSymb="\!\(\*SubscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(\[Hacek]\)],SuperscriptBox[OverscriptBox[\(\[ScriptCapitalA]\),\(^\)],\(\[ConjugateTranspose]\)]]\)";
DefTensor[ProjWeylSIVRotationalGaugeField0p[c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjWeylSIVRotationalGaugeFieldSymb,xAct`PSALTer`Private`Spin0p]];
DefTensor[ProjWeylSIVRotationalGaugeField0m[d,e,f],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjWeylSIVRotationalGaugeFieldSymb,xAct`PSALTer`Private`Spin0m]];
DefTensor[ProjWeylSIVRotationalGaugeField1p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjWeylSIVRotationalGaugeFieldSymb,xAct`PSALTer`Private`Spin1p]];
DefTensor[ProjWeylSIVRotationalGaugeField1m[-a,d,e,f],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjWeylSIVRotationalGaugeFieldSymb,xAct`PSALTer`Private`Spin1m]];
DefTensor[ProjWeylSIVRotationalGaugeField2p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjWeylSIVRotationalGaugeFieldSymb,xAct`PSALTer`Private`Spin2p]];
DefTensor[ProjWeylSIVRotationalGaugeField2m[-a,-b,-c,d,e,f],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjWeylSIVRotationalGaugeFieldSymb,xAct`PSALTer`Private`Spin2m]];

xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjWeylSIVTranslationalGaugeFieldPerturbationSymb="\!\(\*SubscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(\[Hacek]\)],\(\[ScriptB]\)]\)";
DefTensor[ProjWeylSIVTranslationalGaugeFieldPerturbation0p[c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjWeylSIVTranslationalGaugeFieldPerturbationSymb,xAct`PSALTer`Private`Spin0p]];
DefTensor[ProjWeylSIVTranslationalGaugeFieldPerturbation1p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjWeylSIVTranslationalGaugeFieldPerturbationSymb,xAct`PSALTer`Private`Spin1p]];
DefTensor[ProjWeylSIVTranslationalGaugeFieldPerturbation2p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjWeylSIVTranslationalGaugeFieldPerturbationSymb,xAct`PSALTer`Private`Spin2p]];
DefTensor[ProjWeylSIVTranslationalGaugeFieldPerturbation1m[-a,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjWeylSIVTranslationalGaugeFieldPerturbationSymb,xAct`PSALTer`Private`Spin1m]];

xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjWeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldSpinParityToVG=Join[
	MakeRule[{ProjWeylSIVRotationalGaugeField0p[c,d],Evaluate[
		ProjPara[c,-k]ProjPara[d,-l]G[k,l]/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylSIVRotationalGaugeField1p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l]Antisymmetrize[G[-i,k]G[-j,l],{-i,-j}]/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylSIVRotationalGaugeField2p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l](Symmetrize[G[-i,k]G[-j,l],{-i,-j}]-(1/3)G[-i,-j]G[k,l])/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylSIVRotationalGaugeField0m[d,e,f],Evaluate[
		ProjPara[-i,d]ProjPara[-j,e]ProjPara[-k,f]epsilonG[i,j,k,g]V[-g]/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylSIVRotationalGaugeField1m[-a,d,e,f],Evaluate[
		ProjPara[-i,d]ProjPara[-j,f]ProjPara[k,-a]ProjPara[-l,e]G[i,j]G[-k,l]/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylSIVRotationalGaugeField2m[-a,-b,-c,d,e,f],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[-c,k]ProjPara[d,-l]ProjPara[e,-n]ProjPara[f,-m](3/4)((1/3)(2G[-i,l]G[-j,n]G[-k,m]-G[-j,l]G[-k,n]G[-i,m]-G[-k,l]G[-i,n]G[-j,m])-Antisymmetrize[G[-i,-k]G[-j,n]G[l,m],{-i,-j}])/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylSIVTranslationalGaugeFieldPerturbation0p[c,d],Evaluate[
		ProjPara[c,-k]ProjPara[d,-l]G[k,l]/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylSIVTranslationalGaugeFieldPerturbation1p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l]Antisymmetrize[G[-i,k]G[-j,l],{-i,-j}]/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylSIVTranslationalGaugeFieldPerturbation1m[-a,d],Evaluate[
		ProjPara[d,-j]ProjPara[-a,i]G[-i,j]/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylSIVTranslationalGaugeFieldPerturbation2p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l](Symmetrize[G[-i,k]G[-j,l],{-i,-j}]-(1/3)G[-i,-j]G[k,l])/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

(*====================================*)
(*  Field perpendicular and parallel  *)
(*====================================*)

xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVTranslationalGaugeFieldPerturbationParaSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptF]\),\(^\)],\(\[DoubleVerticalBar]\)]\)";
DefTensor[WeylSIVTranslationalGaugeFieldPerturbationPara[-a,-b],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVTranslationalGaugeFieldPerturbationParaSymb],OrthogonalTo->{V[b]},Dagger->Complex];
xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVRotationalGaugeFieldParaSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalA]\),\(^\)],\(\[ConjugateTranspose]\[DoubleVerticalBar]\)]\)";
DefTensor[WeylSIVRotationalGaugeFieldPara[-a,-b,-c],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVRotationalGaugeFieldParaSymb],OrthogonalTo->{V[c]},Dagger->Complex];
xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVTranslationalGaugeFieldPerturbationPerpSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptF]\),\(^\)],\(\[UpTee]\)]\)";
DefTensor[WeylSIVTranslationalGaugeFieldPerturbationPerp[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVTranslationalGaugeFieldPerturbationPerpSymb],Dagger->Complex];
xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVRotationalGaugeFieldPerpSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalA]\),\(^\)],\(\[ConjugateTranspose]\[UpTee]\)]\)";
DefTensor[WeylSIVRotationalGaugeFieldPerp[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVRotationalGaugeFieldPerpSymb],Dagger->Complex];

xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldToWeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldPerpPara=Join[
	MakeRule[{WeylSIVTranslationalGaugeFieldPerturbation[-a,-b],Evaluate[WeylSIVTranslationalGaugeFieldPerturbationPara[-a,-b]+V[-b]WeylSIVTranslationalGaugeFieldPerturbationPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylSIVRotationalGaugeField[-a,-b,-c],Evaluate[WeylSIVRotationalGaugeFieldPara[-a,-b,-c]+V[-c]WeylSIVRotationalGaugeFieldPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylSIVTranslationalGaugeFieldPerturbation[-a,-b],Evaluate[Dagger@(WeylSIVTranslationalGaugeFieldPerturbationPara[-a,-b]+V[-b]WeylSIVTranslationalGaugeFieldPerturbationPerp[-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylSIVRotationalGaugeField[-a,-b,-c],Evaluate[Dagger@(WeylSIVRotationalGaugeFieldPara[-a,-b,-c]+V[-c]WeylSIVRotationalGaugeFieldPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldPerpParaToWeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeField=Join[
	MakeRule[{WeylSIVTranslationalGaugeFieldPerturbationPara[-a,-b],Evaluate[
		ProjPara[-b,c]WeylSIVTranslationalGaugeFieldPerturbation[-a,-c]/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylSIVTranslationalGaugeFieldPerturbationPerp[-a],Evaluate[
		V[c]WeylSIVTranslationalGaugeFieldPerturbation[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylSIVRotationalGaugeFieldPara[-a,-e,-b],Evaluate[
		ProjPara[-b,c]WeylSIVRotationalGaugeField[-a,-e,-c]/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylSIVRotationalGaugeFieldPerp[-a,-e],Evaluate[
		V[c]WeylSIVRotationalGaugeField[-a,-e,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylSIVTranslationalGaugeFieldPerturbationPara[-a,-b],Evaluate[Dagger@(
		ProjPara[-b,c]WeylSIVTranslationalGaugeFieldPerturbation[-a,-c]/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylSIVTranslationalGaugeFieldPerturbationPerp[-a],Evaluate[Dagger@(
		V[c]WeylSIVTranslationalGaugeFieldPerturbation[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylSIVRotationalGaugeFieldPara[-a,-e,-b],Evaluate[Dagger@(
		ProjPara[-b,c]WeylSIVRotationalGaugeField[-a,-e,-c]/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylSIVRotationalGaugeFieldPerp[-a,-e],Evaluate[Dagger@(
		V[c]WeylSIVRotationalGaugeField[-a,-e,-c])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationParaSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[Tau]\),\(^\)],\(\[DoubleVerticalBar]\)]\)";
DefTensor[ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara[-a,-b],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationParaSymb],OrthogonalTo->{V[b]},Dagger->Complex];
xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVRotationalGaugeFieldParaSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[Sigma]\),\(^\)],\(\[ConjugateTranspose]\[DoubleVerticalBar]\)]\)";
DefTensor[ConjugateSourceWeylSIVRotationalGaugeFieldPara[-c,-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVRotationalGaugeFieldParaSymb],OrthogonalTo->{V[c]},Dagger->Complex];
xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPerpSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[Tau]\),\(^\)],\(\[UpTee]\)]\)";
DefTensor[ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPerp[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPerpSymb],Dagger->Complex];
xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVRotationalGaugeFieldPerpSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[Sigma]\),\(^\)],\(\[ConjugateTranspose]\[UpTee]\)]\)";
DefTensor[ConjugateSourceWeylSIVRotationalGaugeFieldPerp[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVRotationalGaugeFieldPerpSymb],Dagger->Complex];

xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationConjugateSourceWeylSIVRotationalGaugeFieldToConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationConjugateSourceWeylSIVRotationalGaugeFieldPerpPara=Join[
	MakeRule[{ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbation[-a,-b],Evaluate[
		ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara[-a,-b]+V[-b]ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylSIVRotationalGaugeField[-c,-a,-b],Evaluate[	
		ConjugateSourceWeylSIVRotationalGaugeFieldPara[-c,-a,-b]+V[-c]ConjugateSourceWeylSIVRotationalGaugeFieldPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbation[-a,-b],Evaluate[Dagger@(	
		ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara[-a,-b]+V[-b]ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPerp[-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVRotationalGaugeField[-c,-a,-b],Evaluate[Dagger@(	
		ConjugateSourceWeylSIVRotationalGaugeFieldPara[-c,-a,-b]+V[-c]ConjugateSourceWeylSIVRotationalGaugeFieldPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationConjugateSourceWeylSIVRotationalGaugeFieldPerpParaToConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationConjugateSourceWeylSIVRotationalGaugeField=Join[
	MakeRule[{ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara[-a,-b],Evaluate[	
		ProjPara[-b,c]ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbation[-a,-c]/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPerp[-a],Evaluate[
		V[c]ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbation[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylSIVRotationalGaugeFieldPara[-b,-a,-e],Evaluate[
		ProjPara[-b,c]ConjugateSourceWeylSIVRotationalGaugeField[-c,-a,-e]/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylSIVRotationalGaugeFieldPerp[-a,-e],Evaluate[
		V[c]ConjugateSourceWeylSIVRotationalGaugeField[-c,-a,-e]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara[-a,-b],Evaluate[Dagger@(
		ProjPara[-b,c]ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbation[-a,-c]/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPerp[-a],Evaluate[Dagger@(
		V[c]ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbation[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVRotationalGaugeFieldPara[-b,-a,-e],Evaluate[Dagger@(
		ProjPara[-b,c]ConjugateSourceWeylSIVRotationalGaugeField[-c,-a,-e]/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVRotationalGaugeFieldPerp[-a,-e],Evaluate[Dagger@(
		V[c]ConjugateSourceWeylSIVRotationalGaugeField[-c,-a,-e])]},MetricOn->All,ContractMetrics->True]];

(*==============================*)
(*  Spin-parity or SO(3) parts  *)
(*==============================*)

(*======================*)
(*  Tensor definitions  *)
(*======================*)

DefTensor[WeylSIVTranslationalGaugeFieldPerturbationPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[WeylSIVTranslationalGaugeFieldPerturbationPara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[WeylSIVTranslationalGaugeFieldPerturbationPara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[WeylSIVTranslationalGaugeFieldPerturbationPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];

DefTensor[WeylSIVRotationalGaugeFieldPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[WeylSIVRotationalGaugeFieldPara0m[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin0m],Dagger->Complex];
DefTensor[WeylSIVRotationalGaugeFieldPara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[WeylSIVRotationalGaugeFieldPara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[WeylSIVRotationalGaugeFieldPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[WeylSIVRotationalGaugeFieldPara2m[-a,-b,-c],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin2m],OrthogonalTo->{V[a],V[b],V[c]},Dagger->Complex];

AutomaticRules[WeylSIVRotationalGaugeFieldPara2m,MakeRule[{Evaluate@Dagger@WeylSIVRotationalGaugeFieldPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylSIVRotationalGaugeFieldPara2m,MakeRule[{Evaluate@Dagger[epsilonG[a,b,c,d]WeylSIVRotationalGaugeFieldPara2m[-a,-b,-c]],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylSIVTranslationalGaugeFieldPerturbationPara2p,MakeRule[{Evaluate@Dagger@WeylSIVTranslationalGaugeFieldPerturbationPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylSIVRotationalGaugeFieldPara2p,MakeRule[{Evaluate@Dagger@WeylSIVRotationalGaugeFieldPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylSIVGaugeTheory`Private`ManualAll=Join[
	MakeRule[{Evaluate@Dagger@WeylSIVRotationalGaugeFieldPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger[epsilonG[a,b,c,d]WeylSIVRotationalGaugeFieldPara2m[-a,-b,-c]],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylSIVTranslationalGaugeFieldPerturbationPara2p[a,-a],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylSIVRotationalGaugeFieldPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

AutomaticRules[WeylSIVRotationalGaugeFieldPara2m,MakeRule[{WeylSIVRotationalGaugeFieldPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylSIVRotationalGaugeFieldPara2m,MakeRule[{epsilonG[a,b,c,d]WeylSIVRotationalGaugeFieldPara2m[-a,-b,-c],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylSIVTranslationalGaugeFieldPerturbationPara2p,MakeRule[{WeylSIVTranslationalGaugeFieldPerturbationPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylSIVRotationalGaugeFieldPara2p,MakeRule[{WeylSIVRotationalGaugeFieldPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

DefTensor[ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];

DefTensor[ConjugateSourceWeylSIVRotationalGaugeFieldPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ConjugateSourceWeylSIVRotationalGaugeFieldPara0m[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin0m],Dagger->Complex];
DefTensor[ConjugateSourceWeylSIVRotationalGaugeFieldPara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[ConjugateSourceWeylSIVRotationalGaugeFieldPara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[ConjugateSourceWeylSIVRotationalGaugeFieldPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[ConjugateSourceWeylSIVRotationalGaugeFieldPara2m[-a,-b,-c],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin2m],OrthogonalTo->{V[a],V[b],V[c]},Dagger->Complex];

AutomaticRules[ConjugateSourceWeylSIVRotationalGaugeFieldPara2m,MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVRotationalGaugeFieldPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ConjugateSourceWeylSIVRotationalGaugeFieldPara2m,MakeRule[{Evaluate@Dagger[epsilonG[a,b,c,d]ConjugateSourceWeylSIVRotationalGaugeFieldPara2m[-a,-b,-c]],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara2p,MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ConjugateSourceWeylSIVRotationalGaugeFieldPara2p,MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVRotationalGaugeFieldPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylSIVGaugeTheory`Private`ManualAll=Join[xAct`PSALTer`WeylSIVGaugeTheory`Private`ManualAll,
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVRotationalGaugeFieldPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger[epsilonG[a,b,c,d]ConjugateSourceWeylSIVRotationalGaugeFieldPara2m[-a,-b,-c]],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara2p[a,-a],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVRotationalGaugeFieldPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

AutomaticRules[ConjugateSourceWeylSIVRotationalGaugeFieldPara2m,MakeRule[{ConjugateSourceWeylSIVRotationalGaugeFieldPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ConjugateSourceWeylSIVRotationalGaugeFieldPara2m,MakeRule[{epsilonG[a,b,c,d]ConjugateSourceWeylSIVRotationalGaugeFieldPara2m[-a,-b,-c],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara2p,MakeRule[{ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ConjugateSourceWeylSIVRotationalGaugeFieldPara2p,MakeRule[{ConjugateSourceWeylSIVRotationalGaugeFieldPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

(*==============*)
(*  Expansions  *)
(*==============*)

xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldParaSpinParityToWeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeField=Join[
	MakeRule[{WeylSIVTranslationalGaugeFieldPerturbationPara0p[],Scalar[Evaluate[
		ProjWeylSIVTranslationalGaugeFieldPerturbation0p[e,f]ProjWeylSIVTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]WeylSIVTranslationalGaugeFieldPerturbationPara[-a,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylSIVTranslationalGaugeFieldPerturbationPara1p[-n,-m],Evaluate[
		ProjWeylSIVTranslationalGaugeFieldPerturbation1p[-n,-m,e,f]ProjWeylSIVTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]WeylSIVTranslationalGaugeFieldPerturbationPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylSIVTranslationalGaugeFieldPerturbationPara1m[-n],Evaluate[
		ProjWeylSIVTranslationalGaugeFieldPerturbation1m[-n,f]ProjWeylSIVTranslationalGaugeFieldPerturbationPerp[-f,a,c]WeylSIVTranslationalGaugeFieldPerturbationPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylSIVTranslationalGaugeFieldPerturbationPara2p[-n,-m],Evaluate[
		ProjWeylSIVTranslationalGaugeFieldPerturbation2p[-n,-m,e,f]ProjWeylSIVTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]WeylSIVTranslationalGaugeFieldPerturbationPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylSIVRotationalGaugeFieldPara0p[],Scalar[Evaluate[
		ProjWeylSIVRotationalGaugeField0p[e,f]ProjWeylSIVRotationalGaugeFieldPerp[-e,-f,a,b,c]WeylSIVRotationalGaugeFieldPara[-a,-b,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylSIVRotationalGaugeFieldPara0m[],Scalar[Evaluate[
		ProjWeylSIVRotationalGaugeField0m[d,e,f]ProjWeylSIVRotationalGaugeFieldPara[-d,-e,-f,a,b,c]WeylSIVRotationalGaugeFieldPara[-a,-b,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylSIVRotationalGaugeFieldPara1p[-n,-m],Evaluate[
		ProjWeylSIVRotationalGaugeField1p[-n,-m,e,f]ProjWeylSIVRotationalGaugeFieldPerp[-e,-f,a,b,c]WeylSIVRotationalGaugeFieldPara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylSIVRotationalGaugeFieldPara1m[-n],Evaluate[
		ProjWeylSIVRotationalGaugeField1m[-n,d,e,f]ProjWeylSIVRotationalGaugeFieldPara[-d,-e,-f,a,b,c]WeylSIVRotationalGaugeFieldPara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylSIVRotationalGaugeFieldPara2p[-n,-m],Evaluate[
		ProjWeylSIVRotationalGaugeField2p[-n,-m,e,f]ProjWeylSIVRotationalGaugeFieldPerp[-e,-f,a,b,c]WeylSIVRotationalGaugeFieldPara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylSIVRotationalGaugeFieldPara2m[-n,-m,-o],Evaluate[
		ProjWeylSIVRotationalGaugeField2m[-n,-m,-o,d,e,f]ProjWeylSIVRotationalGaugeFieldPara[-d,-e,-f,a,b,c]WeylSIVRotationalGaugeFieldPara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylSIVTranslationalGaugeFieldPerturbationPara0p[],Scalar[Evaluate[Dagger@(
		ProjWeylSIVTranslationalGaugeFieldPerturbation0p[e,f]ProjWeylSIVTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]WeylSIVTranslationalGaugeFieldPerturbationPara[-a,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylSIVTranslationalGaugeFieldPerturbationPara1p[-n,-m],Evaluate[Dagger@(
		ProjWeylSIVTranslationalGaugeFieldPerturbation1p[-n,-m,e,f]ProjWeylSIVTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]WeylSIVTranslationalGaugeFieldPerturbationPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylSIVTranslationalGaugeFieldPerturbationPara1m[-n],Evaluate[Dagger@(
		ProjWeylSIVTranslationalGaugeFieldPerturbation1m[-n,f]ProjWeylSIVTranslationalGaugeFieldPerturbationPerp[-f,a,c]WeylSIVTranslationalGaugeFieldPerturbationPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylSIVTranslationalGaugeFieldPerturbationPara2p[-n,-m],Evaluate[Dagger@(
		ProjWeylSIVTranslationalGaugeFieldPerturbation2p[-n,-m,e,f]ProjWeylSIVTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]WeylSIVTranslationalGaugeFieldPerturbationPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylSIVRotationalGaugeFieldPara0p[],Scalar[Evaluate[Dagger@(
		ProjWeylSIVRotationalGaugeField0p[e,f]ProjWeylSIVRotationalGaugeFieldPerp[-e,-f,a,b,c]WeylSIVRotationalGaugeFieldPara[-a,-b,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylSIVRotationalGaugeFieldPara0m[],Scalar[Evaluate[Dagger@(
		ProjWeylSIVRotationalGaugeField0m[d,e,f]ProjWeylSIVRotationalGaugeFieldPara[-d,-e,-f,a,b,c]WeylSIVRotationalGaugeFieldPara[-a,-b,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylSIVRotationalGaugeFieldPara1p[-n,-m],Evaluate[Dagger@(
		ProjWeylSIVRotationalGaugeField1p[-n,-m,e,f]ProjWeylSIVRotationalGaugeFieldPerp[-e,-f,a,b,c]WeylSIVRotationalGaugeFieldPara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylSIVRotationalGaugeFieldPara1m[-n],Evaluate[Dagger@(
		ProjWeylSIVRotationalGaugeField1m[-n,d,e,f]ProjWeylSIVRotationalGaugeFieldPara[-d,-e,-f,a,b,c]WeylSIVRotationalGaugeFieldPara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylSIVRotationalGaugeFieldPara2p[-n,-m],Evaluate[Dagger@(
		ProjWeylSIVRotationalGaugeField2p[-n,-m,e,f]ProjWeylSIVRotationalGaugeFieldPerp[-e,-f,a,b,c]WeylSIVRotationalGaugeFieldPara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylSIVRotationalGaugeFieldPara2m[-n,-m,-o],Evaluate[Dagger@(
		ProjWeylSIVRotationalGaugeField2m[-n,-m,-o,d,e,f]ProjWeylSIVRotationalGaugeFieldPara[-d,-e,-f,a,b,c]WeylSIVRotationalGaugeFieldPara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True]];

DefTensor[WeylSIVTranslationalGaugeFieldPerturbationPerp0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVTranslationalGaugeFieldPerturbationPerpSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[WeylSIVTranslationalGaugeFieldPerturbationPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVTranslationalGaugeFieldPerturbationPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[WeylSIVRotationalGaugeFieldPerp1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVRotationalGaugeFieldPerpSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[WeylSIVRotationalGaugeFieldPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVRotationalGaugeFieldPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldPerpSpinParityToWeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeField=Join[
	MakeRule[{WeylSIVTranslationalGaugeFieldPerturbationPerp0p[],Scalar[Evaluate[
		V[a]WeylSIVTranslationalGaugeFieldPerturbationPerp[-a]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylSIVTranslationalGaugeFieldPerturbationPerp1m[-n],Evaluate[
		ProjPara[-n,a]WeylSIVTranslationalGaugeFieldPerturbationPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylSIVRotationalGaugeFieldPerp1p[-n,-m],Evaluate[
		ProjPara[-n,a]ProjPara[-m,b]WeylSIVRotationalGaugeFieldPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylSIVRotationalGaugeFieldPerp1m[-n],Evaluate[
		ProjPara[-n,a]V[b]WeylSIVRotationalGaugeFieldPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylSIVTranslationalGaugeFieldPerturbationPerp0p[],Scalar[Evaluate[Dagger@(
		V[a]WeylSIVTranslationalGaugeFieldPerturbationPerp[-a])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylSIVTranslationalGaugeFieldPerturbationPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]WeylSIVTranslationalGaugeFieldPerturbationPerp[-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylSIVRotationalGaugeFieldPerp1p[-n,-m],Evaluate[Dagger@(
		ProjPara[-n,a]ProjPara[-m,b]WeylSIVRotationalGaugeFieldPerp[-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylSIVRotationalGaugeFieldPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]V[b]WeylSIVRotationalGaugeFieldPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationConjugateSourceWeylSIVRotationalGaugeFieldParaSpinParityToConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationConjugateSourceWeylSIVRotationalGaugeField=Join[
	MakeRule[{ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara0p[],Scalar[Evaluate[
		ProjWeylSIVTranslationalGaugeFieldPerturbation0p[e,f]ProjWeylSIVTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara[-a,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara1p[-n,-m],Evaluate[
		ProjWeylSIVTranslationalGaugeFieldPerturbation1p[-n,-m,e,f]ProjWeylSIVTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara1m[-n],Evaluate[
		ProjWeylSIVTranslationalGaugeFieldPerturbation1m[-n,f]ProjWeylSIVTranslationalGaugeFieldPerturbationPerp[-f,a,c]ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara2p[-n,-m],Evaluate[
		ProjWeylSIVTranslationalGaugeFieldPerturbation2p[-n,-m,e,f]ProjWeylSIVTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylSIVRotationalGaugeFieldPara0p[],Scalar[Evaluate[
		ProjWeylSIVRotationalGaugeField0p[e,f]ProjWeylSIVRotationalGaugeFieldPerp[-e,-f,a,b,c]ConjugateSourceWeylSIVRotationalGaugeFieldPara[-c,-a,-b]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylSIVRotationalGaugeFieldPara0m[],Scalar[Evaluate[
		ProjWeylSIVRotationalGaugeField0m[d,e,f]ProjWeylSIVRotationalGaugeFieldPara[-d,-e,-f,a,b,c]ConjugateSourceWeylSIVRotationalGaugeFieldPara[-c,-a,-b]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylSIVRotationalGaugeFieldPara1p[-n,-m],Evaluate[
		ProjWeylSIVRotationalGaugeField1p[-n,-m,e,f]ProjWeylSIVRotationalGaugeFieldPerp[-e,-f,a,b,c]ConjugateSourceWeylSIVRotationalGaugeFieldPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylSIVRotationalGaugeFieldPara1m[-n],Evaluate[
		ProjWeylSIVRotationalGaugeField1m[-n,d,e,f]ProjWeylSIVRotationalGaugeFieldPara[-d,-e,-f,a,b,c]ConjugateSourceWeylSIVRotationalGaugeFieldPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylSIVRotationalGaugeFieldPara2p[-n,-m],Evaluate[
		ProjWeylSIVRotationalGaugeField2p[-n,-m,e,f]ProjWeylSIVRotationalGaugeFieldPerp[-e,-f,a,b,c]ConjugateSourceWeylSIVRotationalGaugeFieldPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylSIVRotationalGaugeFieldPara2m[-n,-m,-o],Evaluate[
		ProjWeylSIVRotationalGaugeField2m[-n,-m,-o,d,e,f]ProjWeylSIVRotationalGaugeFieldPara[-d,-e,-f,a,b,c]ConjugateSourceWeylSIVRotationalGaugeFieldPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara0p[],Scalar[Evaluate[Dagger@(
		ProjWeylSIVTranslationalGaugeFieldPerturbation0p[e,f]ProjWeylSIVTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara[-a,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara1p[-n,-m],Evaluate[Dagger@(
		ProjWeylSIVTranslationalGaugeFieldPerturbation1p[-n,-m,e,f]ProjWeylSIVTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara1m[-n],Evaluate[Dagger@(
		ProjWeylSIVTranslationalGaugeFieldPerturbation1m[-n,f]ProjWeylSIVTranslationalGaugeFieldPerturbationPerp[-f,a,c]ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara2p[-n,-m],Evaluate[Dagger@(
		ProjWeylSIVTranslationalGaugeFieldPerturbation2p[-n,-m,e,f]ProjWeylSIVTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVRotationalGaugeFieldPara0p[],Scalar[Evaluate[Dagger@(
		ProjWeylSIVRotationalGaugeField0p[e,f]ProjWeylSIVRotationalGaugeFieldPerp[-e,-f,a,b,c]ConjugateSourceWeylSIVRotationalGaugeFieldPara[-c,-a,-b])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVRotationalGaugeFieldPara0m[],Scalar[Evaluate[Dagger@(
		ProjWeylSIVRotationalGaugeField0m[d,e,f]ProjWeylSIVRotationalGaugeFieldPara[-d,-e,-f,a,b,c]ConjugateSourceWeylSIVRotationalGaugeFieldPara[-c,-a,-b])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVRotationalGaugeFieldPara1p[-n,-m],Evaluate[Dagger@(
		ProjWeylSIVRotationalGaugeField1p[-n,-m,e,f]ProjWeylSIVRotationalGaugeFieldPerp[-e,-f,a,b,c]ConjugateSourceWeylSIVRotationalGaugeFieldPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVRotationalGaugeFieldPara1m[-n],Evaluate[Dagger@(
		ProjWeylSIVRotationalGaugeField1m[-n,d,e,f]ProjWeylSIVRotationalGaugeFieldPara[-d,-e,-f,a,b,c]ConjugateSourceWeylSIVRotationalGaugeFieldPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVRotationalGaugeFieldPara2p[-n,-m],Evaluate[Dagger@(
		ProjWeylSIVRotationalGaugeField2p[-n,-m,e,f]ProjWeylSIVRotationalGaugeFieldPerp[-e,-f,a,b,c]ConjugateSourceWeylSIVRotationalGaugeFieldPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVRotationalGaugeFieldPara2m[-n,-m,-o],Evaluate[Dagger@(
		ProjWeylSIVRotationalGaugeField2m[-n,-m,-o,d,e,f]ProjWeylSIVRotationalGaugeFieldPara[-d,-e,-f,a,b,c]ConjugateSourceWeylSIVRotationalGaugeFieldPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True]];

DefTensor[ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPerp0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPerpSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[ConjugateSourceWeylSIVRotationalGaugeFieldPerp1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVRotationalGaugeFieldPerpSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[ConjugateSourceWeylSIVRotationalGaugeFieldPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVRotationalGaugeFieldPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationConjugateSourceWeylSIVRotationalGaugeFieldPerpSpinParityToConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationConjugateSourceWeylSIVRotationalGaugeField=Join[
	MakeRule[{ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPerp0p[],Scalar[Evaluate[
		V[a]ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPerp[-a]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPerp1m[-n],Evaluate[
		ProjPara[-n,a]ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylSIVRotationalGaugeFieldPerp1p[-n,-m],Evaluate[
		ProjPara[-n,a]ProjPara[-m,b]ConjugateSourceWeylSIVRotationalGaugeFieldPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylSIVRotationalGaugeFieldPerp1m[-n],Evaluate[
		ProjPara[-n,a]V[b]ConjugateSourceWeylSIVRotationalGaugeFieldPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPerp0p[],Scalar[Evaluate[Dagger@(
		V[a]ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPerp[-a])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPerp[-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVRotationalGaugeFieldPerp1p[-n,-m],Evaluate[Dagger@(
		ProjPara[-n,a]ProjPara[-m,b]ConjugateSourceWeylSIVRotationalGaugeFieldPerp[-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVRotationalGaugeFieldPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]V[b]ConjugateSourceWeylSIVRotationalGaugeFieldPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldParaToWeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldParaSpinParity=Join[
	MakeRule[{WeylSIVTranslationalGaugeFieldPerturbationPara[-n,-m],Evaluate[
		((1/3)ProjPara[-n,-m]WeylSIVTranslationalGaugeFieldPerturbationPara0p[]+
		WeylSIVTranslationalGaugeFieldPerturbationPara1p[-n,-m]+
		WeylSIVTranslationalGaugeFieldPerturbationPara2p[-n,-m]+
		V[-n]WeylSIVTranslationalGaugeFieldPerturbationPara1m[-m])/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjWeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylSIVRotationalGaugeFieldPara[-n,-m,-o],Evaluate[
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]WeylSIVRotationalGaugeFieldPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]WeylSIVRotationalGaugeFieldPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]WeylSIVRotationalGaugeFieldPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjWeylSIVRotationalGaugeField0m[-n,-m,-o]WeylSIVRotationalGaugeFieldPara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]WeylSIVRotationalGaugeFieldPara1m[-n],{-m,-n}]+
		(4/3)WeylSIVRotationalGaugeFieldPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjWeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylSIVTranslationalGaugeFieldPerturbationPara[-n,-m],Evaluate[Dagger@(
		((1/3)ProjPara[-n,-m]WeylSIVTranslationalGaugeFieldPerturbationPara0p[]+
		WeylSIVTranslationalGaugeFieldPerturbationPara1p[-n,-m]+
		WeylSIVTranslationalGaugeFieldPerturbationPara2p[-n,-m]+
		V[-n]WeylSIVTranslationalGaugeFieldPerturbationPara1m[-m])/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjWeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylSIVRotationalGaugeFieldPara[-n,-m,-o],Evaluate[Dagger@(
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]WeylSIVRotationalGaugeFieldPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]WeylSIVRotationalGaugeFieldPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]WeylSIVRotationalGaugeFieldPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjWeylSIVRotationalGaugeField0m[-n,-m,-o]WeylSIVRotationalGaugeFieldPara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]WeylSIVRotationalGaugeFieldPara1m[-n],{-m,-n}]+
		(4/3)WeylSIVRotationalGaugeFieldPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjWeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldPerpToWeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldPerpSpinParity=Join[
	MakeRule[{WeylSIVTranslationalGaugeFieldPerturbationPerp[-n],Evaluate[WeylSIVTranslationalGaugeFieldPerturbationPerp0p[]V[-n]+WeylSIVTranslationalGaugeFieldPerturbationPerp1m[-n]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylSIVRotationalGaugeFieldPerp[-n,-m],Evaluate[WeylSIVRotationalGaugeFieldPerp1p[-n,-m]+2Antisymmetrize[V[-m]WeylSIVRotationalGaugeFieldPerp1m[-n],{-n,-m}]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylSIVTranslationalGaugeFieldPerturbationPerp[-n],Evaluate[Dagger@(WeylSIVTranslationalGaugeFieldPerturbationPerp0p[]V[-n]+WeylSIVTranslationalGaugeFieldPerturbationPerp1m[-n])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylSIVRotationalGaugeFieldPerp[-n,-m],Evaluate[Dagger@(WeylSIVRotationalGaugeFieldPerp1p[-n,-m]+2Antisymmetrize[V[-m]WeylSIVRotationalGaugeFieldPerp1m[-n],{-n,-m}])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationConjugateSourceWeylSIVRotationalGaugeFieldParaToConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationConjugateSourceWeylSIVRotationalGaugeFieldParaSpinParity=Join[
	MakeRule[{ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara[-n,-m],Evaluate[
		((1/3)ProjPara[-n,-m]ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara0p[]+
		ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara1p[-n,-m]+
		ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara2p[-n,-m]+
		V[-n]ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara1m[-m])/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjWeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylSIVRotationalGaugeFieldPara[-o,-n,-m],Evaluate[
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]ConjugateSourceWeylSIVRotationalGaugeFieldPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]ConjugateSourceWeylSIVRotationalGaugeFieldPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]ConjugateSourceWeylSIVRotationalGaugeFieldPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjWeylSIVRotationalGaugeField0m[-n,-m,-o]ConjugateSourceWeylSIVRotationalGaugeFieldPara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]ConjugateSourceWeylSIVRotationalGaugeFieldPara1m[-n],{-m,-n}]+
		(4/3)ConjugateSourceWeylSIVRotationalGaugeFieldPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjWeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara[-n,-m],Evaluate[Dagger@(
		((1/3)ProjPara[-n,-m]ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara0p[]+
		ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara1p[-n,-m]+
		ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara2p[-n,-m]+
		V[-n]ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara1m[-m])/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjWeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVRotationalGaugeFieldPara[-o,-n,-m],Evaluate[Dagger@(
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]ConjugateSourceWeylSIVRotationalGaugeFieldPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]ConjugateSourceWeylSIVRotationalGaugeFieldPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]ConjugateSourceWeylSIVRotationalGaugeFieldPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjWeylSIVRotationalGaugeField0m[-n,-m,-o]ConjugateSourceWeylSIVRotationalGaugeFieldPara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]ConjugateSourceWeylSIVRotationalGaugeFieldPara1m[-n],{-m,-n}]+
		(4/3)ConjugateSourceWeylSIVRotationalGaugeFieldPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjWeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationConjugateSourceWeylSIVRotationalGaugeFieldPerpToConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationConjugateSourceWeylSIVRotationalGaugeFieldPerpSpinParity=Join[
	MakeRule[{ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPerp[-n],Evaluate[ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPerp0p[]V[-n]+ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPerp1m[-n]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylSIVRotationalGaugeFieldPerp[-n,-m],Evaluate[ConjugateSourceWeylSIVRotationalGaugeFieldPerp1p[-n,-m]+2Antisymmetrize[V[-m]ConjugateSourceWeylSIVRotationalGaugeFieldPerp1m[-n],{-n,-m}]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPerp[-n],Evaluate[Dagger@(ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPerp0p[]V[-n]+ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPerp1m[-n])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylSIVRotationalGaugeFieldPerp[-n,-m],Evaluate[Dagger@(ConjugateSourceWeylSIVRotationalGaugeFieldPerp1p[-n,-m]+2Antisymmetrize[V[-m]ConjugateSourceWeylSIVRotationalGaugeFieldPerp1m[-n],{-n,-m}])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylSIVGaugeTheory`Private`Patch2m=Join[
	MakeRule[{WeylSIVRotationalGaugeFieldPara2m[-a,-c,-b]WeylSIVRotationalGaugeFieldPara2m[a,b,c],(1/2)WeylSIVRotationalGaugeFieldPara2m[-a,-b,-c]WeylSIVRotationalGaugeFieldPara2m[a,b,c]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate[Dagger@WeylSIVRotationalGaugeFieldPara2m[-a,-c,-b]WeylSIVRotationalGaugeFieldPara2m[a,b,c]],Evaluate[(1/2)Dagger@WeylSIVRotationalGaugeFieldPara2m[-a,-b,-c]WeylSIVRotationalGaugeFieldPara2m[a,b,c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate[WeylSIVRotationalGaugeFieldPara2m[-a,-c,-b]Dagger@WeylSIVRotationalGaugeFieldPara2m[a,b,c]],Evaluate[(1/2)WeylSIVRotationalGaugeFieldPara2m[-a,-b,-c]Dagger@WeylSIVRotationalGaugeFieldPara2m[a,b,c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylSIVRotationalGaugeFieldPara2m[-a,-c,-b]ConjugateSourceWeylSIVRotationalGaugeFieldPara2m[a,b,c],(1/2)ConjugateSourceWeylSIVRotationalGaugeFieldPara2m[-a,-b,-c]ConjugateSourceWeylSIVRotationalGaugeFieldPara2m[a,b,c]},MetricOn->All,ContractMetrics->True]];

AutomaticRules[WeylSIVRotationalGaugeFieldPara2m,MakeRule[{Evaluate[WeylSIVRotationalGaugeFieldPara2m[-a,-c,-b]Dagger@WeylSIVRotationalGaugeFieldPara2m[a,b,c]],Evaluate[(1/2)WeylSIVRotationalGaugeFieldPara2m[-a,-b,-c]Dagger@WeylSIVRotationalGaugeFieldPara2m[a,b,c]]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[Evaluate[Dagger@WeylSIVRotationalGaugeFieldPara2m],MakeRule[{Evaluate[Dagger@WeylSIVRotationalGaugeFieldPara2m[-a,-c,-b]WeylSIVRotationalGaugeFieldPara2m[a,b,c]],Evaluate[(1/2)Dagger@WeylSIVRotationalGaugeFieldPara2m[-a,-b,-c]WeylSIVRotationalGaugeFieldPara2m[a,b,c]]},MetricOn->All,ContractMetrics->True]];

(*==========================================================*)
(*  Basic definitions of the Lagrangian coupling constants  *)
(*==========================================================*)

xAct`PSALTer`WeylSIVGaugeTheory`Private`lsLambdaSymb="\[Lambda]";
DefLagrangianCoupling[lsLambda,CouplingSymbol->xAct`PSALTer`WeylSIVGaugeTheory`Private`lsLambdaSymb];

xAct`PSALTer`WeylSIVGaugeTheory`Private`lsRSymb="\[ScriptR]";
DefLagrangianCoupling[lsR1,
	CouplingSymbol->xAct`PSALTer`WeylSIVGaugeTheory`Private`lsRSymb,CouplingIndex->1];
DefLagrangianCoupling[lsR2,
	CouplingSymbol->xAct`PSALTer`WeylSIVGaugeTheory`Private`lsRSymb,CouplingIndex->2];
DefLagrangianCoupling[lsR3,
	CouplingSymbol->xAct`PSALTer`WeylSIVGaugeTheory`Private`lsRSymb,CouplingIndex->3];
DefLagrangianCoupling[lsR4,
	CouplingSymbol->xAct`PSALTer`WeylSIVGaugeTheory`Private`lsRSymb,CouplingIndex->4];
DefLagrangianCoupling[lsR5,
	CouplingSymbol->xAct`PSALTer`WeylSIVGaugeTheory`Private`lsRSymb,CouplingIndex->5];

xAct`PSALTer`WeylSIVGaugeTheory`Private`lsCSymb="\[ScriptC]";
DefLagrangianCoupling[lsC1,
	CouplingSymbol->xAct`PSALTer`WeylSIVGaugeTheory`Private`lsCSymb,CouplingIndex->1];

xAct`PSALTer`WeylSIVGaugeTheory`Private`lsTSymb="\[ScriptT]";
DefLagrangianCoupling[lsT1,
	CouplingSymbol->xAct`PSALTer`WeylSIVGaugeTheory`Private`lsTSymb,CouplingIndex->1];
DefLagrangianCoupling[lsT2,
	CouplingSymbol->xAct`PSALTer`WeylSIVGaugeTheory`Private`lsTSymb,CouplingIndex->2];
DefLagrangianCoupling[lsT3,
	CouplingSymbol->xAct`PSALTer`WeylSIVGaugeTheory`Private`lsTSymb,CouplingIndex->3];

xAct`PSALTer`WeylSIVGaugeTheory`Private`lsXiSymb="\[Xi]";
DefLagrangianCoupling[lsXi,CouplingSymbol->xAct`PSALTer`WeylSIVGaugeTheory`Private`lsXiSymb];

xAct`PSALTer`WeylSIVGaugeTheory`Private`lsNuSymb="\[Nu]";
DefLagrangianCoupling[lsNu,CouplingSymbol->xAct`PSALTer`WeylSIVGaugeTheory`Private`lsNuSymb];

(*Here is the Einstein Gauge for the compensator field*)
xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVCompensatorSymb="\[Phi]";
DefLagrangianCoupling[lsPhi0,
	CouplingSymbol->xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVCompensatorSymb,CouplingIndex->0];

(*===================*)
(*  Private context  *)
(*===================*)

Begin["xAct`PSALTer`WeylSIVGaugeTheory`Private`"];

LagrangianCouplings={lsLambda,lsR1,lsR2,lsR3,lsR4,lsR5,lsC1,lsT1,lsT2,lsT3,lsXi,lsNu,lsPhi0};

FieldSpinParityTensorHeads=<|
		WeylSIVRotationalGaugeField-><|
			0-><|Even->{WeylSIVRotationalGaugeFieldPara0p},Odd->{WeylSIVRotationalGaugeFieldPara0m}|>,
			1-><|Even->{WeylSIVRotationalGaugeFieldPara1p,WeylSIVRotationalGaugeFieldPerp1p},Odd->{WeylSIVRotationalGaugeFieldPara1m,WeylSIVRotationalGaugeFieldPerp1m}|>,
			2-><|Even->{WeylSIVRotationalGaugeFieldPara2p},Odd->{WeylSIVRotationalGaugeFieldPara2m}|>
		|>,
		WeylSIVTranslationalGaugeFieldPerturbation-><|
			0-><|Even->{WeylSIVTranslationalGaugeFieldPerturbationPara0p,WeylSIVTranslationalGaugeFieldPerturbationPerp0p},Odd->{}|>,
			1-><|Even->{WeylSIVTranslationalGaugeFieldPerturbationPara1p},Odd->{WeylSIVTranslationalGaugeFieldPerturbationPara1m,WeylSIVTranslationalGaugeFieldPerturbationPerp1m}|>,
			2-><|Even->{WeylSIVTranslationalGaugeFieldPerturbationPara2p},Odd->{}|>
		|>
|>;

SourceSpinParityTensorHeads=<|
		ConjugateSourceWeylSIVRotationalGaugeField-><|
			0-><|Even->{ConjugateSourceWeylSIVRotationalGaugeFieldPara0p},Odd->{ConjugateSourceWeylSIVRotationalGaugeFieldPara0m}|>,
			1-><|Even->{ConjugateSourceWeylSIVRotationalGaugeFieldPara1p,ConjugateSourceWeylSIVRotationalGaugeFieldPerp1p},Odd->{ConjugateSourceWeylSIVRotationalGaugeFieldPara1m,ConjugateSourceWeylSIVRotationalGaugeFieldPerp1m}|>,
			2-><|Even->{ConjugateSourceWeylSIVRotationalGaugeFieldPara2p},Odd->{ConjugateSourceWeylSIVRotationalGaugeFieldPara2m}|>
		|>,
		ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbation-><|
			0-><|Even->{ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara0p,ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPerp0p},Odd->{}|>,
			1-><|Even->{ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara1p},Odd->{ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara1m,ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPerp1m}|>,
			2-><|Even->{ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationPara2p},Odd->{}|>
		|>
|>;

SourceEngineeringDimensions=<|
		(*This is 1 as we choose Einstein Gauge rescaling phi -> phi0(1+phi)*)
		ConjugateSourceWeylSIVRotationalGaugeField->0,
		ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbation->1
|>;

ExpandFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldParaSpinParityToWeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeField;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldPerpSpinParityToWeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeField;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjWeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjWeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldSpinParityToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldPerpParaToWeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeField;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

ExpandSources[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationConjugateSourceWeylSIVRotationalGaugeFieldParaSpinParityToConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationConjugateSourceWeylSIVRotationalGaugeField;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationConjugateSourceWeylSIVRotationalGaugeFieldPerpSpinParityToConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationConjugateSourceWeylSIVRotationalGaugeField;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjWeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjWeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldSpinParityToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ProjPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationConjugateSourceWeylSIVRotationalGaugeFieldPerpParaToConjugateSourceWeylSIVTranslationalGaugeFieldPerturbationConjugateSourceWeylSIVRotationalGaugeField;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
Expr];

DecomposeFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldToWeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldPerpPara;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldParaToWeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldParaSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylSIVGaugeTheory`Private`WeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldPerpToWeylSIVTranslationalGaugeFieldPerturbationWeylSIVRotationalGaugeFieldPerpSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
	Expr=Expr/.xAct`PSALTer`WeylSIVGaugeTheory`Private`Patch2m;
	Expr=Expr/.xAct`PSALTer`WeylSIVGaugeTheory`Private`ManualAll;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

End[];

EndPackage[];

DefClass[
	"WeylSIVGaugeTheory",
	xAct`PSALTer`WeylSIVGaugeTheory`Private`LagrangianCouplings,
	xAct`PSALTer`WeylSIVGaugeTheory`Private`FieldSpinParityTensorHeads,
	xAct`PSALTer`WeylSIVGaugeTheory`Private`SourceSpinParityTensorHeads,
	xAct`PSALTer`WeylSIVGaugeTheory`Private`SourceEngineeringDimensions,
	xAct`PSALTer`WeylSIVGaugeTheory`Private`ExpandFields,
	xAct`PSALTer`WeylSIVGaugeTheory`Private`DecomposeFields,
	xAct`PSALTer`WeylSIVGaugeTheory`Private`ExpandSources,
ExportClass->False];
