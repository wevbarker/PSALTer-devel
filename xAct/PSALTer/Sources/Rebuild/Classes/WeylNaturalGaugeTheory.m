(* ::Package:: *)

(*===========================*)
(*  WeylNaturalGaugeTheory  *)
(*===========================*)

BeginPackage["xAct`PSALTer`WeylNaturalGaugeTheory`",{"xAct`xTensor`","xAct`xPerm`","xAct`xCore`","xAct`xTras`","xAct`xCoba`","xAct`PSALTer`"}];

(*=================================================================*)
(*  Basic definitions of gauge fields and their conjugate sources  *)
(*=================================================================*)

xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalCompensatorSymb="\[Phi]";
DefTensor[WeylNaturalCompensator[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalCompensatorSymb],Dagger->Complex];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalCompensatorSymb="\[Rho]";
DefTensor[ConjugateSourceWeylNaturalCompensator[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalCompensatorSymb],Dagger->Complex];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalRotationalGaugeFieldSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalA]\),\(\[ConjugateTranspose]\)]\)";
DefTensor[WeylNaturalRotationalGaugeField[a,c,-d],M4,Antisymmetric[{a,c}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalRotationalGaugeFieldSymb],Dagger->Complex];

(*Is there something wrong with the Conjugate Rotational Gauge field index symmetry?*)
xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalRotationalGaugeFieldSymb="\!\(\*SuperscriptBox[\(\[Sigma]\),\(\[ConjugateTranspose]\)]\)";
DefTensor[ConjugateSourceWeylNaturalRotationalGaugeField[-i,-j,-k],M4,Antisymmetric[{-j,-k}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalRotationalGaugeFieldSymb],Dagger->Complex];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalTranslationalGaugeFieldPerturbationSymb="\[ScriptF]";
DefTensor[WeylNaturalTranslationalGaugeFieldPerturbation[-i,-j],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalTranslationalGaugeFieldPerturbationSymb],Dagger->Complex];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationSymb="\[Tau]";
DefTensor[ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbation[-i,-j],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationSymb],Dagger->Complex];

(*==============*)
(*  Projectors  *)
(*==============*)

(*====================================*)
(*  Basic perpendicular and parallel  *)
(*====================================*)

xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[UpTee]\)]\)";
DefTensor[ProjPerp[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpSymb]];
xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjParaSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[DoubleVerticalBar]\)]\)";
DefTensor[ProjPara[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjParaSymb]];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG=Join[
	MakeRule[{ProjPerp[-a,b],Evaluate[V[-a]V[b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjPara[-a,b],Evaluate[G[-a,b]-V[-a]V[b]]},MetricOn->All,ContractMetrics->True]];

(*====================================*)
(*  Field perpendicular and parallel  *)
(*====================================*)

DefTensor[ProjWeylNaturalRotationalGaugeFieldPerp[-a,-b,d,e,f],M4];
DefTensor[ProjWeylNaturalRotationalGaugeFieldPara[-a,-b,-c,d,e,f],M4];
DefTensor[ProjWeylNaturalTranslationalGaugeFieldPerturbationPerp[-a,d,e],M4];
DefTensor[ProjWeylNaturalTranslationalGaugeFieldPerturbationPara[-a,-b,d,e],M4];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjWeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldPerpParaToVG=Join[
	MakeRule[{ProjWeylNaturalRotationalGaugeFieldPerp[-a,-b,d,e,f],Evaluate[
		V[d]ProjPara[-a,e]G[-b,f]/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylNaturalRotationalGaugeFieldPara[-a,-b,-c,d,e,f],Evaluate[
		ProjPara[-a,d]ProjPara[-b,e]G[-c,f]/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylNaturalTranslationalGaugeFieldPerturbationPerp[-a,d,e],Evaluate[
		V[d]G[-a,e]/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylNaturalTranslationalGaugeFieldPerturbationPara[-a,-b,d,e],Evaluate[
		ProjPara[-a,d]G[-b,e]/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*==============================*)
(*  Spin-parity or SO(3) parts  *)
(*==============================*)

xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjWeylNaturalRotationalGaugeFieldSymb="\!\(\*SubscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(\[Hacek]\)],SuperscriptBox[\(\[ScriptCapitalA]\),\(\[ConjugateTranspose]\)]]\)";
DefTensor[ProjWeylNaturalRotationalGaugeField0p[c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjWeylNaturalRotationalGaugeFieldSymb,xAct`PSALTer`Private`Spin0p]];
DefTensor[ProjWeylNaturalRotationalGaugeField0m[d,e,f],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjWeylNaturalRotationalGaugeFieldSymb,xAct`PSALTer`Private`Spin0m]];
DefTensor[ProjWeylNaturalRotationalGaugeField1p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjWeylNaturalRotationalGaugeFieldSymb,xAct`PSALTer`Private`Spin1p]];
DefTensor[ProjWeylNaturalRotationalGaugeField1m[-a,d,e,f],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjWeylNaturalRotationalGaugeFieldSymb,xAct`PSALTer`Private`Spin1m]];
DefTensor[ProjWeylNaturalRotationalGaugeField2p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjWeylNaturalRotationalGaugeFieldSymb,xAct`PSALTer`Private`Spin2p]];
DefTensor[ProjWeylNaturalRotationalGaugeField2m[-a,-b,-c,d,e,f],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjWeylNaturalRotationalGaugeFieldSymb,xAct`PSALTer`Private`Spin2m]];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjWeylNaturalTranslationalGaugeFieldPerturbationSymb="\!\(\*SubscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(\[Hacek]\)],\(\[ScriptB]\)]\)";
DefTensor[ProjWeylNaturalTranslationalGaugeFieldPerturbation0p[c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjWeylNaturalTranslationalGaugeFieldPerturbationSymb,xAct`PSALTer`Private`Spin0p]];
DefTensor[ProjWeylNaturalTranslationalGaugeFieldPerturbation1p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjWeylNaturalTranslationalGaugeFieldPerturbationSymb,xAct`PSALTer`Private`Spin1p]];
DefTensor[ProjWeylNaturalTranslationalGaugeFieldPerturbation2p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjWeylNaturalTranslationalGaugeFieldPerturbationSymb,xAct`PSALTer`Private`Spin2p]];
DefTensor[ProjWeylNaturalTranslationalGaugeFieldPerturbation1m[-a,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjWeylNaturalTranslationalGaugeFieldPerturbationSymb,xAct`PSALTer`Private`Spin1m]];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjWeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldSpinParityToVG=Join[
	MakeRule[{ProjWeylNaturalRotationalGaugeField0p[c,d],Evaluate[
		ProjPara[c,-k]ProjPara[d,-l]G[k,l]/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylNaturalRotationalGaugeField1p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l]Antisymmetrize[G[-i,k]G[-j,l],{-i,-j}]/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylNaturalRotationalGaugeField2p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l](Symmetrize[G[-i,k]G[-j,l],{-i,-j}]-(1/3)G[-i,-j]G[k,l])/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylNaturalRotationalGaugeField0m[d,e,f],Evaluate[
		ProjPara[-i,d]ProjPara[-j,e]ProjPara[-k,f]epsilonG[i,j,k,g]V[-g]/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylNaturalRotationalGaugeField1m[-a,d,e,f],Evaluate[
		ProjPara[-i,d]ProjPara[-j,f]ProjPara[k,-a]ProjPara[-l,e]G[i,j]G[-k,l]/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylNaturalRotationalGaugeField2m[-a,-b,-c,d,e,f],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[-c,k]ProjPara[d,-l]ProjPara[e,-n]ProjPara[f,-m](3/4)((1/3)(2G[-i,l]G[-j,n]G[-k,m]-G[-j,l]G[-k,n]G[-i,m]-G[-k,l]G[-i,n]G[-j,m])-Antisymmetrize[G[-i,-k]G[-j,n]G[l,m],{-i,-j}])/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylNaturalTranslationalGaugeFieldPerturbation0p[c,d],Evaluate[
		ProjPara[c,-k]ProjPara[d,-l]G[k,l]/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylNaturalTranslationalGaugeFieldPerturbation1p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l]Antisymmetrize[G[-i,k]G[-j,l],{-i,-j}]/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylNaturalTranslationalGaugeFieldPerturbation1m[-a,d],Evaluate[
		ProjPara[d,-j]ProjPara[-a,i]G[-i,j]/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjWeylNaturalTranslationalGaugeFieldPerturbation2p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l](Symmetrize[G[-i,k]G[-j,l],{-i,-j}]-(1/3)G[-i,-j]G[k,l])/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

(*====================================*)
(*  Field perpendicular and parallel  *)
(*====================================*)

xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalTranslationalGaugeFieldPerturbationParaSymb="\!\(\*SuperscriptBox[\(\[ScriptF]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[WeylNaturalTranslationalGaugeFieldPerturbationPara[-a,-b],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalTranslationalGaugeFieldPerturbationParaSymb],OrthogonalTo->{V[b]},Dagger->Complex];
xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalRotationalGaugeFieldParaSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalA]\),\(\[ConjugateTranspose]\[DoubleVerticalBar]\)]\)";
DefTensor[WeylNaturalRotationalGaugeFieldPara[-a,-b,-c],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalRotationalGaugeFieldParaSymb],OrthogonalTo->{V[c]},Dagger->Complex];
xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalTranslationalGaugeFieldPerturbationPerpSymb="\!\(\*SuperscriptBox[\(\[ScriptF]\),\(\[UpTee]\)]\)";
DefTensor[WeylNaturalTranslationalGaugeFieldPerturbationPerp[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalTranslationalGaugeFieldPerturbationPerpSymb],Dagger->Complex];
xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalRotationalGaugeFieldPerpSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalA]\),\(\[ConjugateTranspose]\[UpTee]\)]\)";
DefTensor[WeylNaturalRotationalGaugeFieldPerp[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalRotationalGaugeFieldPerpSymb],Dagger->Complex];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldToWeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldPerpPara=Join[
	MakeRule[{WeylNaturalTranslationalGaugeFieldPerturbation[-a,-b],Evaluate[WeylNaturalTranslationalGaugeFieldPerturbationPara[-a,-b]+V[-b]WeylNaturalTranslationalGaugeFieldPerturbationPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylNaturalRotationalGaugeField[-a,-b,-c],Evaluate[WeylNaturalRotationalGaugeFieldPara[-a,-b,-c]+V[-c]WeylNaturalRotationalGaugeFieldPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylNaturalTranslationalGaugeFieldPerturbation[-a,-b],Evaluate[Dagger@(WeylNaturalTranslationalGaugeFieldPerturbationPara[-a,-b]+V[-b]WeylNaturalTranslationalGaugeFieldPerturbationPerp[-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylNaturalRotationalGaugeField[-a,-b,-c],Evaluate[Dagger@(WeylNaturalRotationalGaugeFieldPara[-a,-b,-c]+V[-c]WeylNaturalRotationalGaugeFieldPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldPerpParaToWeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeField=Join[
	MakeRule[{WeylNaturalTranslationalGaugeFieldPerturbationPara[-a,-b],Evaluate[
		ProjPara[-b,c]WeylNaturalTranslationalGaugeFieldPerturbation[-a,-c]/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylNaturalTranslationalGaugeFieldPerturbationPerp[-a],Evaluate[
		V[c]WeylNaturalTranslationalGaugeFieldPerturbation[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylNaturalRotationalGaugeFieldPara[-a,-e,-b],Evaluate[
		ProjPara[-b,c]WeylNaturalRotationalGaugeField[-a,-e,-c]/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylNaturalRotationalGaugeFieldPerp[-a,-e],Evaluate[
		V[c]WeylNaturalRotationalGaugeField[-a,-e,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylNaturalTranslationalGaugeFieldPerturbationPara[-a,-b],Evaluate[Dagger@(
		ProjPara[-b,c]WeylNaturalTranslationalGaugeFieldPerturbation[-a,-c]/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylNaturalTranslationalGaugeFieldPerturbationPerp[-a],Evaluate[Dagger@(
		V[c]WeylNaturalTranslationalGaugeFieldPerturbation[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylNaturalRotationalGaugeFieldPara[-a,-e,-b],Evaluate[Dagger@(
		ProjPara[-b,c]WeylNaturalRotationalGaugeField[-a,-e,-c]/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylNaturalRotationalGaugeFieldPerp[-a,-e],Evaluate[Dagger@(
		V[c]WeylNaturalRotationalGaugeField[-a,-e,-c])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationParaSymb="\!\(\*SuperscriptBox[\(\[Tau]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara[-a,-b],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationParaSymb],OrthogonalTo->{V[b]},Dagger->Complex];
xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalRotationalGaugeFieldParaSymb="\!\(\*SuperscriptBox[\(\[Sigma]\),\(\[ConjugateTranspose]\[DoubleVerticalBar]\)]\)";
DefTensor[ConjugateSourceWeylNaturalRotationalGaugeFieldPara[-c,-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalRotationalGaugeFieldParaSymb],OrthogonalTo->{V[c]},Dagger->Complex];
xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPerpSymb="\!\(\*SuperscriptBox[\(\[Tau]\),\(\[UpTee]\)]\)";
DefTensor[ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPerp[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPerpSymb],Dagger->Complex];
xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalRotationalGaugeFieldPerpSymb="\!\(\*SuperscriptBox[\(\[Sigma]\),\(\[ConjugateTranspose]\[UpTee]\)]\)";
DefTensor[ConjugateSourceWeylNaturalRotationalGaugeFieldPerp[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalRotationalGaugeFieldPerpSymb],Dagger->Complex];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationConjugateSourceWeylNaturalRotationalGaugeFieldToConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationConjugateSourceWeylNaturalRotationalGaugeFieldPerpPara=Join[
	MakeRule[{ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbation[-a,-b],Evaluate[
		ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara[-a,-b]+V[-b]ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylNaturalRotationalGaugeField[-c,-a,-b],Evaluate[	
		ConjugateSourceWeylNaturalRotationalGaugeFieldPara[-c,-a,-b]+V[-c]ConjugateSourceWeylNaturalRotationalGaugeFieldPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbation[-a,-b],Evaluate[Dagger@(	
		ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara[-a,-b]+V[-b]ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPerp[-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalRotationalGaugeField[-c,-a,-b],Evaluate[Dagger@(	
		ConjugateSourceWeylNaturalRotationalGaugeFieldPara[-c,-a,-b]+V[-c]ConjugateSourceWeylNaturalRotationalGaugeFieldPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationConjugateSourceWeylNaturalRotationalGaugeFieldPerpParaToConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationConjugateSourceWeylNaturalRotationalGaugeField=Join[
	MakeRule[{ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara[-a,-b],Evaluate[	
		ProjPara[-b,c]ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbation[-a,-c]/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPerp[-a],Evaluate[
		V[c]ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbation[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylNaturalRotationalGaugeFieldPara[-b,-a,-e],Evaluate[
		ProjPara[-b,c]ConjugateSourceWeylNaturalRotationalGaugeField[-c,-a,-e]/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylNaturalRotationalGaugeFieldPerp[-a,-e],Evaluate[
		V[c]ConjugateSourceWeylNaturalRotationalGaugeField[-c,-a,-e]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara[-a,-b],Evaluate[Dagger@(
		ProjPara[-b,c]ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbation[-a,-c]/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPerp[-a],Evaluate[Dagger@(
		V[c]ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbation[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalRotationalGaugeFieldPara[-b,-a,-e],Evaluate[Dagger@(
		ProjPara[-b,c]ConjugateSourceWeylNaturalRotationalGaugeField[-c,-a,-e]/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalRotationalGaugeFieldPerp[-a,-e],Evaluate[Dagger@(
		V[c]ConjugateSourceWeylNaturalRotationalGaugeField[-c,-a,-e])]},MetricOn->All,ContractMetrics->True]];

(*==============================*)
(*  Spin-parity or SO(3) parts  *)
(*==============================*)

(*======================*)
(*  Tensor definitions  *)
(*======================*)

DefSpinParityMode[WeylNaturalCompensator0p[],Spin->0,Parity->Even,
	FieldSymbol->xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalCompensatorSymb,
	SourceSymbol->xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalCompensatorSymb];

DefTensor[WeylNaturalTranslationalGaugeFieldPerturbationPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[WeylNaturalTranslationalGaugeFieldPerturbationPara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[WeylNaturalTranslationalGaugeFieldPerturbationPara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[WeylNaturalTranslationalGaugeFieldPerturbationPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];

DefTensor[WeylNaturalRotationalGaugeFieldPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[WeylNaturalRotationalGaugeFieldPara0m[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin0m],Dagger->Complex];
DefTensor[WeylNaturalRotationalGaugeFieldPara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[WeylNaturalRotationalGaugeFieldPara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[WeylNaturalRotationalGaugeFieldPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[WeylNaturalRotationalGaugeFieldPara2m[-a,-b,-c],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin2m],OrthogonalTo->{V[a],V[b],V[c]},Dagger->Complex];

AutomaticRules[WeylNaturalRotationalGaugeFieldPara2m,MakeRule[{Evaluate@Dagger@WeylNaturalRotationalGaugeFieldPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylNaturalRotationalGaugeFieldPara2m,MakeRule[{Evaluate@Dagger[epsilonG[a,b,c,d]WeylNaturalRotationalGaugeFieldPara2m[-a,-b,-c]],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylNaturalTranslationalGaugeFieldPerturbationPara2p,MakeRule[{Evaluate@Dagger@WeylNaturalTranslationalGaugeFieldPerturbationPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylNaturalRotationalGaugeFieldPara2p,MakeRule[{Evaluate@Dagger@WeylNaturalRotationalGaugeFieldPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`ManualAll=Join[
	MakeRule[{Evaluate@Dagger@WeylNaturalRotationalGaugeFieldPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger[epsilonG[a,b,c,d]WeylNaturalRotationalGaugeFieldPara2m[-a,-b,-c]],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylNaturalTranslationalGaugeFieldPerturbationPara2p[a,-a],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylNaturalRotationalGaugeFieldPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

AutomaticRules[WeylNaturalRotationalGaugeFieldPara2m,MakeRule[{WeylNaturalRotationalGaugeFieldPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylNaturalRotationalGaugeFieldPara2m,MakeRule[{epsilonG[a,b,c,d]WeylNaturalRotationalGaugeFieldPara2m[-a,-b,-c],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylNaturalTranslationalGaugeFieldPerturbationPara2p,MakeRule[{WeylNaturalTranslationalGaugeFieldPerturbationPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[WeylNaturalRotationalGaugeFieldPara2p,MakeRule[{WeylNaturalRotationalGaugeFieldPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

DefTensor[ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];

DefTensor[ConjugateSourceWeylNaturalRotationalGaugeFieldPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ConjugateSourceWeylNaturalRotationalGaugeFieldPara0m[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin0m],Dagger->Complex];
DefTensor[ConjugateSourceWeylNaturalRotationalGaugeFieldPara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[ConjugateSourceWeylNaturalRotationalGaugeFieldPara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[ConjugateSourceWeylNaturalRotationalGaugeFieldPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[ConjugateSourceWeylNaturalRotationalGaugeFieldPara2m[-a,-b,-c],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalRotationalGaugeFieldParaSymb,xAct`PSALTer`Private`Spin2m],OrthogonalTo->{V[a],V[b],V[c]},Dagger->Complex];

AutomaticRules[ConjugateSourceWeylNaturalRotationalGaugeFieldPara2m,MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalRotationalGaugeFieldPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ConjugateSourceWeylNaturalRotationalGaugeFieldPara2m,MakeRule[{Evaluate@Dagger[epsilonG[a,b,c,d]ConjugateSourceWeylNaturalRotationalGaugeFieldPara2m[-a,-b,-c]],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara2p,MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ConjugateSourceWeylNaturalRotationalGaugeFieldPara2p,MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalRotationalGaugeFieldPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`ManualAll=Join[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ManualAll,
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalRotationalGaugeFieldPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger[epsilonG[a,b,c,d]ConjugateSourceWeylNaturalRotationalGaugeFieldPara2m[-a,-b,-c]],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara2p[a,-a],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalRotationalGaugeFieldPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

AutomaticRules[ConjugateSourceWeylNaturalRotationalGaugeFieldPara2m,MakeRule[{ConjugateSourceWeylNaturalRotationalGaugeFieldPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ConjugateSourceWeylNaturalRotationalGaugeFieldPara2m,MakeRule[{epsilonG[a,b,c,d]ConjugateSourceWeylNaturalRotationalGaugeFieldPara2m[-a,-b,-c],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara2p,MakeRule[{ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ConjugateSourceWeylNaturalRotationalGaugeFieldPara2p,MakeRule[{ConjugateSourceWeylNaturalRotationalGaugeFieldPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

(*==============*)
(*  Expansions  *)
(*==============*)

xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalCompensatorSpinParityToWeylNaturalCompensator=Join[
	MakeRule[{WeylNaturalCompensator0p[],WeylNaturalCompensator[]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylNaturalCompensator0p[],Evaluate@Dagger[WeylNaturalCompensator[]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalCompensatorSpinParityToConjugateSourceWeylNaturalCompensator=Join[
	MakeRule[{ConjugateSourceWeylNaturalCompensator0p[],ConjugateSourceWeylNaturalCompensator[]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalCompensator0p[],Evaluate@Dagger[ConjugateSourceWeylNaturalCompensator[]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldParaSpinParityToWeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeField=Join[
	MakeRule[{WeylNaturalTranslationalGaugeFieldPerturbationPara0p[],Scalar[Evaluate[
		ProjWeylNaturalTranslationalGaugeFieldPerturbation0p[e,f]ProjWeylNaturalTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]WeylNaturalTranslationalGaugeFieldPerturbationPara[-a,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylNaturalTranslationalGaugeFieldPerturbationPara1p[-n,-m],Evaluate[
		ProjWeylNaturalTranslationalGaugeFieldPerturbation1p[-n,-m,e,f]ProjWeylNaturalTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]WeylNaturalTranslationalGaugeFieldPerturbationPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylNaturalTranslationalGaugeFieldPerturbationPara1m[-n],Evaluate[
		ProjWeylNaturalTranslationalGaugeFieldPerturbation1m[-n,f]ProjWeylNaturalTranslationalGaugeFieldPerturbationPerp[-f,a,c]WeylNaturalTranslationalGaugeFieldPerturbationPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylNaturalTranslationalGaugeFieldPerturbationPara2p[-n,-m],Evaluate[
		ProjWeylNaturalTranslationalGaugeFieldPerturbation2p[-n,-m,e,f]ProjWeylNaturalTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]WeylNaturalTranslationalGaugeFieldPerturbationPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylNaturalRotationalGaugeFieldPara0p[],Scalar[Evaluate[
		ProjWeylNaturalRotationalGaugeField0p[e,f]ProjWeylNaturalRotationalGaugeFieldPerp[-e,-f,a,b,c]WeylNaturalRotationalGaugeFieldPara[-a,-b,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylNaturalRotationalGaugeFieldPara0m[],Scalar[Evaluate[
		ProjWeylNaturalRotationalGaugeField0m[d,e,f]ProjWeylNaturalRotationalGaugeFieldPara[-d,-e,-f,a,b,c]WeylNaturalRotationalGaugeFieldPara[-a,-b,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylNaturalRotationalGaugeFieldPara1p[-n,-m],Evaluate[
		ProjWeylNaturalRotationalGaugeField1p[-n,-m,e,f]ProjWeylNaturalRotationalGaugeFieldPerp[-e,-f,a,b,c]WeylNaturalRotationalGaugeFieldPara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylNaturalRotationalGaugeFieldPara1m[-n],Evaluate[
		ProjWeylNaturalRotationalGaugeField1m[-n,d,e,f]ProjWeylNaturalRotationalGaugeFieldPara[-d,-e,-f,a,b,c]WeylNaturalRotationalGaugeFieldPara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylNaturalRotationalGaugeFieldPara2p[-n,-m],Evaluate[
		ProjWeylNaturalRotationalGaugeField2p[-n,-m,e,f]ProjWeylNaturalRotationalGaugeFieldPerp[-e,-f,a,b,c]WeylNaturalRotationalGaugeFieldPara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylNaturalRotationalGaugeFieldPara2m[-n,-m,-o],Evaluate[
		ProjWeylNaturalRotationalGaugeField2m[-n,-m,-o,d,e,f]ProjWeylNaturalRotationalGaugeFieldPara[-d,-e,-f,a,b,c]WeylNaturalRotationalGaugeFieldPara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylNaturalTranslationalGaugeFieldPerturbationPara0p[],Scalar[Evaluate[Dagger@(
		ProjWeylNaturalTranslationalGaugeFieldPerturbation0p[e,f]ProjWeylNaturalTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]WeylNaturalTranslationalGaugeFieldPerturbationPara[-a,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylNaturalTranslationalGaugeFieldPerturbationPara1p[-n,-m],Evaluate[Dagger@(
		ProjWeylNaturalTranslationalGaugeFieldPerturbation1p[-n,-m,e,f]ProjWeylNaturalTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]WeylNaturalTranslationalGaugeFieldPerturbationPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylNaturalTranslationalGaugeFieldPerturbationPara1m[-n],Evaluate[Dagger@(
		ProjWeylNaturalTranslationalGaugeFieldPerturbation1m[-n,f]ProjWeylNaturalTranslationalGaugeFieldPerturbationPerp[-f,a,c]WeylNaturalTranslationalGaugeFieldPerturbationPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylNaturalTranslationalGaugeFieldPerturbationPara2p[-n,-m],Evaluate[Dagger@(
		ProjWeylNaturalTranslationalGaugeFieldPerturbation2p[-n,-m,e,f]ProjWeylNaturalTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]WeylNaturalTranslationalGaugeFieldPerturbationPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylNaturalRotationalGaugeFieldPara0p[],Scalar[Evaluate[Dagger@(
		ProjWeylNaturalRotationalGaugeField0p[e,f]ProjWeylNaturalRotationalGaugeFieldPerp[-e,-f,a,b,c]WeylNaturalRotationalGaugeFieldPara[-a,-b,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylNaturalRotationalGaugeFieldPara0m[],Scalar[Evaluate[Dagger@(
		ProjWeylNaturalRotationalGaugeField0m[d,e,f]ProjWeylNaturalRotationalGaugeFieldPara[-d,-e,-f,a,b,c]WeylNaturalRotationalGaugeFieldPara[-a,-b,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylNaturalRotationalGaugeFieldPara1p[-n,-m],Evaluate[Dagger@(
		ProjWeylNaturalRotationalGaugeField1p[-n,-m,e,f]ProjWeylNaturalRotationalGaugeFieldPerp[-e,-f,a,b,c]WeylNaturalRotationalGaugeFieldPara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylNaturalRotationalGaugeFieldPara1m[-n],Evaluate[Dagger@(
		ProjWeylNaturalRotationalGaugeField1m[-n,d,e,f]ProjWeylNaturalRotationalGaugeFieldPara[-d,-e,-f,a,b,c]WeylNaturalRotationalGaugeFieldPara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylNaturalRotationalGaugeFieldPara2p[-n,-m],Evaluate[Dagger@(
		ProjWeylNaturalRotationalGaugeField2p[-n,-m,e,f]ProjWeylNaturalRotationalGaugeFieldPerp[-e,-f,a,b,c]WeylNaturalRotationalGaugeFieldPara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylNaturalRotationalGaugeFieldPara2m[-n,-m,-o],Evaluate[Dagger@(
		ProjWeylNaturalRotationalGaugeField2m[-n,-m,-o,d,e,f]ProjWeylNaturalRotationalGaugeFieldPara[-d,-e,-f,a,b,c]WeylNaturalRotationalGaugeFieldPara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True]];

DefTensor[WeylNaturalTranslationalGaugeFieldPerturbationPerp0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalTranslationalGaugeFieldPerturbationPerpSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[WeylNaturalTranslationalGaugeFieldPerturbationPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalTranslationalGaugeFieldPerturbationPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[WeylNaturalRotationalGaugeFieldPerp1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalRotationalGaugeFieldPerpSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[WeylNaturalRotationalGaugeFieldPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalRotationalGaugeFieldPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldPerpSpinParityToWeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeField=Join[
	MakeRule[{WeylNaturalTranslationalGaugeFieldPerturbationPerp0p[],Scalar[Evaluate[
		V[a]WeylNaturalTranslationalGaugeFieldPerturbationPerp[-a]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylNaturalTranslationalGaugeFieldPerturbationPerp1m[-n],Evaluate[
		ProjPara[-n,a]WeylNaturalTranslationalGaugeFieldPerturbationPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylNaturalRotationalGaugeFieldPerp1p[-n,-m],Evaluate[
		ProjPara[-n,a]ProjPara[-m,b]WeylNaturalRotationalGaugeFieldPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylNaturalRotationalGaugeFieldPerp1m[-n],Evaluate[
		ProjPara[-n,a]V[b]WeylNaturalRotationalGaugeFieldPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylNaturalTranslationalGaugeFieldPerturbationPerp0p[],Scalar[Evaluate[Dagger@(
		V[a]WeylNaturalTranslationalGaugeFieldPerturbationPerp[-a])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylNaturalTranslationalGaugeFieldPerturbationPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]WeylNaturalTranslationalGaugeFieldPerturbationPerp[-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylNaturalRotationalGaugeFieldPerp1p[-n,-m],Evaluate[Dagger@(
		ProjPara[-n,a]ProjPara[-m,b]WeylNaturalRotationalGaugeFieldPerp[-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylNaturalRotationalGaugeFieldPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]V[b]WeylNaturalRotationalGaugeFieldPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationConjugateSourceWeylNaturalRotationalGaugeFieldParaSpinParityToConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationConjugateSourceWeylNaturalRotationalGaugeField=Join[
	MakeRule[{ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara0p[],Scalar[Evaluate[
		ProjWeylNaturalTranslationalGaugeFieldPerturbation0p[e,f]ProjWeylNaturalTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara[-a,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara1p[-n,-m],Evaluate[
		ProjWeylNaturalTranslationalGaugeFieldPerturbation1p[-n,-m,e,f]ProjWeylNaturalTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara1m[-n],Evaluate[
		ProjWeylNaturalTranslationalGaugeFieldPerturbation1m[-n,f]ProjWeylNaturalTranslationalGaugeFieldPerturbationPerp[-f,a,c]ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara2p[-n,-m],Evaluate[
		ProjWeylNaturalTranslationalGaugeFieldPerturbation2p[-n,-m,e,f]ProjWeylNaturalTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylNaturalRotationalGaugeFieldPara0p[],Scalar[Evaluate[
		ProjWeylNaturalRotationalGaugeField0p[e,f]ProjWeylNaturalRotationalGaugeFieldPerp[-e,-f,a,b,c]ConjugateSourceWeylNaturalRotationalGaugeFieldPara[-c,-a,-b]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylNaturalRotationalGaugeFieldPara0m[],Scalar[Evaluate[
		ProjWeylNaturalRotationalGaugeField0m[d,e,f]ProjWeylNaturalRotationalGaugeFieldPara[-d,-e,-f,a,b,c]ConjugateSourceWeylNaturalRotationalGaugeFieldPara[-c,-a,-b]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylNaturalRotationalGaugeFieldPara1p[-n,-m],Evaluate[
		ProjWeylNaturalRotationalGaugeField1p[-n,-m,e,f]ProjWeylNaturalRotationalGaugeFieldPerp[-e,-f,a,b,c]ConjugateSourceWeylNaturalRotationalGaugeFieldPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylNaturalRotationalGaugeFieldPara1m[-n],Evaluate[
		ProjWeylNaturalRotationalGaugeField1m[-n,d,e,f]ProjWeylNaturalRotationalGaugeFieldPara[-d,-e,-f,a,b,c]ConjugateSourceWeylNaturalRotationalGaugeFieldPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylNaturalRotationalGaugeFieldPara2p[-n,-m],Evaluate[
		ProjWeylNaturalRotationalGaugeField2p[-n,-m,e,f]ProjWeylNaturalRotationalGaugeFieldPerp[-e,-f,a,b,c]ConjugateSourceWeylNaturalRotationalGaugeFieldPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylNaturalRotationalGaugeFieldPara2m[-n,-m,-o],Evaluate[
		ProjWeylNaturalRotationalGaugeField2m[-n,-m,-o,d,e,f]ProjWeylNaturalRotationalGaugeFieldPara[-d,-e,-f,a,b,c]ConjugateSourceWeylNaturalRotationalGaugeFieldPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara0p[],Scalar[Evaluate[Dagger@(
		ProjWeylNaturalTranslationalGaugeFieldPerturbation0p[e,f]ProjWeylNaturalTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara[-a,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara1p[-n,-m],Evaluate[Dagger@(
		ProjWeylNaturalTranslationalGaugeFieldPerturbation1p[-n,-m,e,f]ProjWeylNaturalTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara1m[-n],Evaluate[Dagger@(
		ProjWeylNaturalTranslationalGaugeFieldPerturbation1m[-n,f]ProjWeylNaturalTranslationalGaugeFieldPerturbationPerp[-f,a,c]ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara2p[-n,-m],Evaluate[Dagger@(
		ProjWeylNaturalTranslationalGaugeFieldPerturbation2p[-n,-m,e,f]ProjWeylNaturalTranslationalGaugeFieldPerturbationPara[-e,-f,a,c]ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalRotationalGaugeFieldPara0p[],Scalar[Evaluate[Dagger@(
		ProjWeylNaturalRotationalGaugeField0p[e,f]ProjWeylNaturalRotationalGaugeFieldPerp[-e,-f,a,b,c]ConjugateSourceWeylNaturalRotationalGaugeFieldPara[-c,-a,-b])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalRotationalGaugeFieldPara0m[],Scalar[Evaluate[Dagger@(
		ProjWeylNaturalRotationalGaugeField0m[d,e,f]ProjWeylNaturalRotationalGaugeFieldPara[-d,-e,-f,a,b,c]ConjugateSourceWeylNaturalRotationalGaugeFieldPara[-c,-a,-b])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalRotationalGaugeFieldPara1p[-n,-m],Evaluate[Dagger@(
		ProjWeylNaturalRotationalGaugeField1p[-n,-m,e,f]ProjWeylNaturalRotationalGaugeFieldPerp[-e,-f,a,b,c]ConjugateSourceWeylNaturalRotationalGaugeFieldPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalRotationalGaugeFieldPara1m[-n],Evaluate[Dagger@(
		ProjWeylNaturalRotationalGaugeField1m[-n,d,e,f]ProjWeylNaturalRotationalGaugeFieldPara[-d,-e,-f,a,b,c]ConjugateSourceWeylNaturalRotationalGaugeFieldPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalRotationalGaugeFieldPara2p[-n,-m],Evaluate[Dagger@(
		ProjWeylNaturalRotationalGaugeField2p[-n,-m,e,f]ProjWeylNaturalRotationalGaugeFieldPerp[-e,-f,a,b,c]ConjugateSourceWeylNaturalRotationalGaugeFieldPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalRotationalGaugeFieldPara2m[-n,-m,-o],Evaluate[Dagger@(
		ProjWeylNaturalRotationalGaugeField2m[-n,-m,-o,d,e,f]ProjWeylNaturalRotationalGaugeFieldPara[-d,-e,-f,a,b,c]ConjugateSourceWeylNaturalRotationalGaugeFieldPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True]];

DefTensor[ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPerp0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPerpSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[ConjugateSourceWeylNaturalRotationalGaugeFieldPerp1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalRotationalGaugeFieldPerpSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[ConjugateSourceWeylNaturalRotationalGaugeFieldPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalRotationalGaugeFieldPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationConjugateSourceWeylNaturalRotationalGaugeFieldPerpSpinParityToConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationConjugateSourceWeylNaturalRotationalGaugeField=Join[
	MakeRule[{ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPerp0p[],Scalar[Evaluate[
		V[a]ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPerp[-a]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPerp1m[-n],Evaluate[
		ProjPara[-n,a]ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylNaturalRotationalGaugeFieldPerp1p[-n,-m],Evaluate[
		ProjPara[-n,a]ProjPara[-m,b]ConjugateSourceWeylNaturalRotationalGaugeFieldPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylNaturalRotationalGaugeFieldPerp1m[-n],Evaluate[
		ProjPara[-n,a]V[b]ConjugateSourceWeylNaturalRotationalGaugeFieldPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPerp0p[],Scalar[Evaluate[Dagger@(
		V[a]ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPerp[-a])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPerp[-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalRotationalGaugeFieldPerp1p[-n,-m],Evaluate[Dagger@(
		ProjPara[-n,a]ProjPara[-m,b]ConjugateSourceWeylNaturalRotationalGaugeFieldPerp[-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalRotationalGaugeFieldPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]V[b]ConjugateSourceWeylNaturalRotationalGaugeFieldPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalCompensatorToWeylNaturalCompensatorSpinParity=Join[
	MakeRule[{WeylNaturalCompensator[],WeylNaturalCompensator0p[]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylNaturalCompensator[],Evaluate@Dagger[WeylNaturalCompensator0p[]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalCompensatorToConjugateSourceWeylNaturalCompensatorSpinParity=Join[
	MakeRule[{ConjugateSourceWeylNaturalCompensator[],ConjugateSourceWeylNaturalCompensator0p[]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalCompensator[],Evaluate@Dagger[ConjugateSourceWeylNaturalCompensator0p[]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldParaToWeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldParaSpinParity=Join[
	MakeRule[{WeylNaturalTranslationalGaugeFieldPerturbationPara[-n,-m],Evaluate[
		((1/3)ProjPara[-n,-m]WeylNaturalTranslationalGaugeFieldPerturbationPara0p[]+
		WeylNaturalTranslationalGaugeFieldPerturbationPara1p[-n,-m]+
		WeylNaturalTranslationalGaugeFieldPerturbationPara2p[-n,-m]+
		V[-n]WeylNaturalTranslationalGaugeFieldPerturbationPara1m[-m])/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjWeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylNaturalRotationalGaugeFieldPara[-n,-m,-o],Evaluate[
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]WeylNaturalRotationalGaugeFieldPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]WeylNaturalRotationalGaugeFieldPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]WeylNaturalRotationalGaugeFieldPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjWeylNaturalRotationalGaugeField0m[-n,-m,-o]WeylNaturalRotationalGaugeFieldPara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]WeylNaturalRotationalGaugeFieldPara1m[-n],{-m,-n}]+
		(4/3)WeylNaturalRotationalGaugeFieldPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjWeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylNaturalTranslationalGaugeFieldPerturbationPara[-n,-m],Evaluate[Dagger@(
		((1/3)ProjPara[-n,-m]WeylNaturalTranslationalGaugeFieldPerturbationPara0p[]+
		WeylNaturalTranslationalGaugeFieldPerturbationPara1p[-n,-m]+
		WeylNaturalTranslationalGaugeFieldPerturbationPara2p[-n,-m]+
		V[-n]WeylNaturalTranslationalGaugeFieldPerturbationPara1m[-m])/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjWeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylNaturalRotationalGaugeFieldPara[-n,-m,-o],Evaluate[Dagger@(
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]WeylNaturalRotationalGaugeFieldPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]WeylNaturalRotationalGaugeFieldPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]WeylNaturalRotationalGaugeFieldPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjWeylNaturalRotationalGaugeField0m[-n,-m,-o]WeylNaturalRotationalGaugeFieldPara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]WeylNaturalRotationalGaugeFieldPara1m[-n],{-m,-n}]+
		(4/3)WeylNaturalRotationalGaugeFieldPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjWeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldPerpToWeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldPerpSpinParity=Join[
	MakeRule[{WeylNaturalTranslationalGaugeFieldPerturbationPerp[-n],Evaluate[WeylNaturalTranslationalGaugeFieldPerturbationPerp0p[]V[-n]+WeylNaturalTranslationalGaugeFieldPerturbationPerp1m[-n]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylNaturalRotationalGaugeFieldPerp[-n,-m],Evaluate[WeylNaturalRotationalGaugeFieldPerp1p[-n,-m]+2Antisymmetrize[V[-m]WeylNaturalRotationalGaugeFieldPerp1m[-n],{-n,-m}]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylNaturalTranslationalGaugeFieldPerturbationPerp[-n],Evaluate[Dagger@(WeylNaturalTranslationalGaugeFieldPerturbationPerp0p[]V[-n]+WeylNaturalTranslationalGaugeFieldPerturbationPerp1m[-n])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylNaturalRotationalGaugeFieldPerp[-n,-m],Evaluate[Dagger@(WeylNaturalRotationalGaugeFieldPerp1p[-n,-m]+2Antisymmetrize[V[-m]WeylNaturalRotationalGaugeFieldPerp1m[-n],{-n,-m}])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationConjugateSourceWeylNaturalRotationalGaugeFieldParaToConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationConjugateSourceWeylNaturalRotationalGaugeFieldParaSpinParity=Join[
	MakeRule[{ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara[-n,-m],Evaluate[
		((1/3)ProjPara[-n,-m]ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara0p[]+
		ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara1p[-n,-m]+
		ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara2p[-n,-m]+
		V[-n]ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara1m[-m])/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjWeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylNaturalRotationalGaugeFieldPara[-o,-n,-m],Evaluate[
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]ConjugateSourceWeylNaturalRotationalGaugeFieldPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]ConjugateSourceWeylNaturalRotationalGaugeFieldPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]ConjugateSourceWeylNaturalRotationalGaugeFieldPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjWeylNaturalRotationalGaugeField0m[-n,-m,-o]ConjugateSourceWeylNaturalRotationalGaugeFieldPara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]ConjugateSourceWeylNaturalRotationalGaugeFieldPara1m[-n],{-m,-n}]+
		(4/3)ConjugateSourceWeylNaturalRotationalGaugeFieldPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjWeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara[-n,-m],Evaluate[Dagger@(
		((1/3)ProjPara[-n,-m]ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara0p[]+
		ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara1p[-n,-m]+
		ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara2p[-n,-m]+
		V[-n]ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara1m[-m])/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjWeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalRotationalGaugeFieldPara[-o,-n,-m],Evaluate[Dagger@(
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]ConjugateSourceWeylNaturalRotationalGaugeFieldPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]ConjugateSourceWeylNaturalRotationalGaugeFieldPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]ConjugateSourceWeylNaturalRotationalGaugeFieldPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjWeylNaturalRotationalGaugeField0m[-n,-m,-o]ConjugateSourceWeylNaturalRotationalGaugeFieldPara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]ConjugateSourceWeylNaturalRotationalGaugeFieldPara1m[-n],{-m,-n}]+
		(4/3)ConjugateSourceWeylNaturalRotationalGaugeFieldPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjWeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldSpinParityToVG/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationConjugateSourceWeylNaturalRotationalGaugeFieldPerpToConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationConjugateSourceWeylNaturalRotationalGaugeFieldPerpSpinParity=Join[
	MakeRule[{ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPerp[-n],Evaluate[ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPerp0p[]V[-n]+ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPerp1m[-n]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylNaturalRotationalGaugeFieldPerp[-n,-m],Evaluate[ConjugateSourceWeylNaturalRotationalGaugeFieldPerp1p[-n,-m]+2Antisymmetrize[V[-m]ConjugateSourceWeylNaturalRotationalGaugeFieldPerp1m[-n],{-n,-m}]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPerp[-n],Evaluate[Dagger@(ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPerp0p[]V[-n]+ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPerp1m[-n])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceWeylNaturalRotationalGaugeFieldPerp[-n,-m],Evaluate[Dagger@(ConjugateSourceWeylNaturalRotationalGaugeFieldPerp1p[-n,-m]+2Antisymmetrize[V[-m]ConjugateSourceWeylNaturalRotationalGaugeFieldPerp1m[-n],{-n,-m}])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`Patch2m=Join[
	MakeRule[{WeylNaturalRotationalGaugeFieldPara2m[-a,-c,-b]WeylNaturalRotationalGaugeFieldPara2m[a,b,c],(1/2)WeylNaturalRotationalGaugeFieldPara2m[-a,-b,-c]WeylNaturalRotationalGaugeFieldPara2m[a,b,c]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate[Dagger@WeylNaturalRotationalGaugeFieldPara2m[-a,-c,-b]WeylNaturalRotationalGaugeFieldPara2m[a,b,c]],Evaluate[(1/2)Dagger@WeylNaturalRotationalGaugeFieldPara2m[-a,-b,-c]WeylNaturalRotationalGaugeFieldPara2m[a,b,c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate[WeylNaturalRotationalGaugeFieldPara2m[-a,-c,-b]Dagger@WeylNaturalRotationalGaugeFieldPara2m[a,b,c]],Evaluate[(1/2)WeylNaturalRotationalGaugeFieldPara2m[-a,-b,-c]Dagger@WeylNaturalRotationalGaugeFieldPara2m[a,b,c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceWeylNaturalRotationalGaugeFieldPara2m[-a,-c,-b]ConjugateSourceWeylNaturalRotationalGaugeFieldPara2m[a,b,c],(1/2)ConjugateSourceWeylNaturalRotationalGaugeFieldPara2m[-a,-b,-c]ConjugateSourceWeylNaturalRotationalGaugeFieldPara2m[a,b,c]},MetricOn->All,ContractMetrics->True]];

AutomaticRules[WeylNaturalRotationalGaugeFieldPara2m,MakeRule[{Evaluate[WeylNaturalRotationalGaugeFieldPara2m[-a,-c,-b]Dagger@WeylNaturalRotationalGaugeFieldPara2m[a,b,c]],Evaluate[(1/2)WeylNaturalRotationalGaugeFieldPara2m[-a,-b,-c]Dagger@WeylNaturalRotationalGaugeFieldPara2m[a,b,c]]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[Evaluate[Dagger@WeylNaturalRotationalGaugeFieldPara2m],MakeRule[{Evaluate[Dagger@WeylNaturalRotationalGaugeFieldPara2m[-a,-c,-b]WeylNaturalRotationalGaugeFieldPara2m[a,b,c]],Evaluate[(1/2)Dagger@WeylNaturalRotationalGaugeFieldPara2m[-a,-b,-c]WeylNaturalRotationalGaugeFieldPara2m[a,b,c]]},MetricOn->All,ContractMetrics->True]];

(*==========================================================*)
(*  Basic definitions of the Lagrangian coupling constants  *)
(*==========================================================*)

xAct`PSALTer`WeylNaturalGaugeTheory`Private`lnLambdaSymb="\[Lambda]";
DefLagrangianCoupling[lnLambda,CouplingSymbol->xAct`PSALTer`WeylNaturalGaugeTheory`Private`lnLambdaSymb];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`lnRSymb="\[ScriptR]";
DefLagrangianCoupling[lnR1,
	CouplingSymbol->xAct`PSALTer`WeylNaturalGaugeTheory`Private`lnRSymb,CouplingIndex->1];
DefLagrangianCoupling[lnR2,
	CouplingSymbol->xAct`PSALTer`WeylNaturalGaugeTheory`Private`lnRSymb,CouplingIndex->2];
DefLagrangianCoupling[lnR3,
	CouplingSymbol->xAct`PSALTer`WeylNaturalGaugeTheory`Private`lnRSymb,CouplingIndex->3];
DefLagrangianCoupling[lnR4,
	CouplingSymbol->xAct`PSALTer`WeylNaturalGaugeTheory`Private`lnRSymb,CouplingIndex->4];
DefLagrangianCoupling[lnR5,
	CouplingSymbol->xAct`PSALTer`WeylNaturalGaugeTheory`Private`lnRSymb,CouplingIndex->5];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`lnCSymb="\[ScriptC]";
DefLagrangianCoupling[lnC1,
	CouplingSymbol->xAct`PSALTer`WeylNaturalGaugeTheory`Private`lnCSymb,CouplingIndex->1];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`lnTSymb="\[ScriptT]";
DefLagrangianCoupling[lnT1,
	CouplingSymbol->xAct`PSALTer`WeylNaturalGaugeTheory`Private`lnTSymb,CouplingIndex->1];
DefLagrangianCoupling[lnT2,
	CouplingSymbol->xAct`PSALTer`WeylNaturalGaugeTheory`Private`lnTSymb,CouplingIndex->2];
DefLagrangianCoupling[lnT3,
	CouplingSymbol->xAct`PSALTer`WeylNaturalGaugeTheory`Private`lnTSymb,CouplingIndex->3];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`lnXiSymb="\[Xi]";
DefLagrangianCoupling[lnXi,CouplingSymbol->xAct`PSALTer`WeylNaturalGaugeTheory`Private`lnXiSymb];

xAct`PSALTer`WeylNaturalGaugeTheory`Private`lnNuSymb="\[Nu]";
DefLagrangianCoupling[lnNu,CouplingSymbol->xAct`PSALTer`WeylNaturalGaugeTheory`Private`lnNuSymb];

(*Here is the Einstein Gauge for the compensator field*)
DefLagrangianCoupling[lnPhi0,
	CouplingSymbol->xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalCompensatorSymb,CouplingIndex->0];

(*===================*)
(*  Private context  *)
(*===================*)

Begin["xAct`PSALTer`WeylNaturalGaugeTheory`Private`"];

LagrangianCouplings={lnLambda,lnR1,lnR2,lnR3,lnR4,lnR5,lnC1,lnT1,lnT2,lnT3,lnXi,lnNu,lnPhi0};

FieldSpinParityTensorHeads=<|
		WeylNaturalCompensator-><|
			0-><|Even->{WeylNaturalCompensator0p},Odd->{}|>,
			1-><|Even->{},Odd->{}|>,
			2-><|Even->{},Odd->{}|>
		|>,
		WeylNaturalRotationalGaugeField-><|
			0-><|Even->{WeylNaturalRotationalGaugeFieldPara0p},Odd->{WeylNaturalRotationalGaugeFieldPara0m}|>,
			1-><|Even->{WeylNaturalRotationalGaugeFieldPara1p,WeylNaturalRotationalGaugeFieldPerp1p},Odd->{WeylNaturalRotationalGaugeFieldPara1m,WeylNaturalRotationalGaugeFieldPerp1m}|>,
			2-><|Even->{WeylNaturalRotationalGaugeFieldPara2p},Odd->{WeylNaturalRotationalGaugeFieldPara2m}|>
		|>,
		WeylNaturalTranslationalGaugeFieldPerturbation-><|
			0-><|Even->{WeylNaturalTranslationalGaugeFieldPerturbationPara0p,WeylNaturalTranslationalGaugeFieldPerturbationPerp0p},Odd->{}|>,
			1-><|Even->{WeylNaturalTranslationalGaugeFieldPerturbationPara1p},Odd->{WeylNaturalTranslationalGaugeFieldPerturbationPara1m,WeylNaturalTranslationalGaugeFieldPerturbationPerp1m}|>,
			2-><|Even->{WeylNaturalTranslationalGaugeFieldPerturbationPara2p},Odd->{}|>
		|>
|>;

SourceSpinParityTensorHeads=<|
		ConjugateSourceWeylNaturalCompensator-><|
			0-><|Even->{ConjugateSourceWeylNaturalCompensator0p},Odd->{}|>,
			1-><|Even->{},Odd->{}|>,
			2-><|Even->{},Odd->{}|>
		|>,
		ConjugateSourceWeylNaturalRotationalGaugeField-><|
			0-><|Even->{ConjugateSourceWeylNaturalRotationalGaugeFieldPara0p},Odd->{ConjugateSourceWeylNaturalRotationalGaugeFieldPara0m}|>,
			1-><|Even->{ConjugateSourceWeylNaturalRotationalGaugeFieldPara1p,ConjugateSourceWeylNaturalRotationalGaugeFieldPerp1p},Odd->{ConjugateSourceWeylNaturalRotationalGaugeFieldPara1m,ConjugateSourceWeylNaturalRotationalGaugeFieldPerp1m}|>,
			2-><|Even->{ConjugateSourceWeylNaturalRotationalGaugeFieldPara2p},Odd->{ConjugateSourceWeylNaturalRotationalGaugeFieldPara2m}|>
		|>,
		ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbation-><|
			0-><|Even->{ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara0p,ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPerp0p},Odd->{}|>,
			1-><|Even->{ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara1p},Odd->{ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara1m,ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPerp1m}|>,
			2-><|Even->{ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationPara2p},Odd->{}|>
		|>
|>;

SourceEngineeringDimensions=<|
		(*This is 1 as we choose Einstein Gauge rescaling phi -> phi0(1+phi)*)
		ConjugateSourceWeylNaturalCompensator->1,
		ConjugateSourceWeylNaturalRotationalGaugeField->0,
		ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbation->1
|>;

ExpandFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalCompensatorSpinParityToWeylNaturalCompensator;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldParaSpinParityToWeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeField;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldPerpSpinParityToWeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeField;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjWeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjWeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldSpinParityToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldPerpParaToWeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeField;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

ExpandSources[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalCompensatorSpinParityToConjugateSourceWeylNaturalCompensator;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationConjugateSourceWeylNaturalRotationalGaugeFieldParaSpinParityToConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationConjugateSourceWeylNaturalRotationalGaugeField;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationConjugateSourceWeylNaturalRotationalGaugeFieldPerpSpinParityToConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationConjugateSourceWeylNaturalRotationalGaugeField;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjWeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjWeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldSpinParityToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ProjPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationConjugateSourceWeylNaturalRotationalGaugeFieldPerpParaToConjugateSourceWeylNaturalTranslationalGaugeFieldPerturbationConjugateSourceWeylNaturalRotationalGaugeField;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
Expr];

DecomposeFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalCompensatorToWeylNaturalCompensatorSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldToWeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldPerpPara;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldParaToWeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldParaSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`WeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldPerpToWeylNaturalTranslationalGaugeFieldPerturbationWeylNaturalRotationalGaugeFieldPerpSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
	Expr=Expr/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`Patch2m;
	Expr=Expr/.xAct`PSALTer`WeylNaturalGaugeTheory`Private`ManualAll;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

End[];

EndPackage[];

DefClass[
	"WeylNaturalGaugeTheory",
	xAct`PSALTer`WeylNaturalGaugeTheory`Private`LagrangianCouplings,
	xAct`PSALTer`WeylNaturalGaugeTheory`Private`FieldSpinParityTensorHeads,
	xAct`PSALTer`WeylNaturalGaugeTheory`Private`SourceSpinParityTensorHeads,
	xAct`PSALTer`WeylNaturalGaugeTheory`Private`SourceEngineeringDimensions,
	xAct`PSALTer`WeylNaturalGaugeTheory`Private`ExpandFields,
	xAct`PSALTer`WeylNaturalGaugeTheory`Private`DecomposeFields,
	xAct`PSALTer`WeylNaturalGaugeTheory`Private`ExpandSources,
ExportClass->False];
