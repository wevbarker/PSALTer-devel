(*========================*)
(*  BimetricTensorTheory  *)
(*========================*)

BeginPackage["xAct`PSALTer`BimetricTensorTheory`",{"xAct`xTensor`","xAct`xPerm`","xAct`xCore`","xAct`xTras`","xAct`xCoba`","xAct`PSALTer`"}];

(*=================================================================*)
(*  Basic definitions of gauge fields and their conjugate sources  *)
(*=================================================================*)

xAct`PSALTer`BimetricTensorTheory`Private`BimetricFSymb="\[Psi]";
DefTensor[BimetricF[-i,-j],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`BimetricFSymb],Dagger->Complex];

xAct`PSALTer`BimetricTensorTheory`Private`BimetricTauSymb="\[ScriptCapitalT]";
DefTensor[BimetricTau[-i,-j],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`BimetricTauSymb],Dagger->Complex];

xAct`PSALTer`BimetricTensorTheory`Private`BimetricLinearMetricSymb="\[Psi]";
DefTensor[BimetricLinearMetric[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`BimetricLinearMetricSymb],Dagger->Complex];

xAct`PSALTer`BimetricTensorTheory`Private`BimetricStressEnergySymb="\[ScriptCapitalT]";
DefTensor[BimetricStressEnergy[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`BimetricStressEnergySymb],Dagger->Complex];

(*==============*)
(*  Projectors  *)
(*==============*)

(*====================================*)
(*  Basic perpendicular and parallel  *)
(*====================================*)

xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[UpTee]\)]\)";
DefTensor[ProjPerp[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpSymb]];
xAct`PSALTer`BimetricTensorTheory`Private`ProjParaSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[DoubleVerticalBar]\)]\)";
DefTensor[ProjPara[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`ProjParaSymb]];

xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG=Join[
	MakeRule[{ProjPerp[-a,b],Evaluate[V[-a]V[b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjPara[-a,b],Evaluate[G[-a,b]-V[-a]V[b]]},MetricOn->All,ContractMetrics->True]];

(*====================================*)
(*  Field perpendicular and parallel  *)
(*====================================*)

DefTensor[ProjBimetricFPerp[-a,d,e],M4];
DefTensor[ProjBimetricFPara[-a,-b,d,e],M4];

xAct`PSALTer`BimetricTensorTheory`Private`ProjBimetricFAPerpParaToVG=Join[
	MakeRule[{ProjBimetricFPerp[-a,d,e],Evaluate[
		V[d]G[-a,e]/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjBimetricFPara[-a,-b,d,e],Evaluate[
		ProjPara[-a,d]G[-b,e]/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*==============================*)
(*  Spin-parity or SO(3) parts  *)
(*==============================*)

xAct`PSALTer`BimetricTensorTheory`Private`ProjBimetricFSymb="\!\(\*SubscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(\[Hacek]\)],\(\[ScriptB]\)]\)";
DefTensor[ProjBimetricF0p[c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`ProjBimetricFSymb,xAct`PSALTer`Private`Spin0p]];
DefTensor[ProjBimetricF1p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`ProjBimetricFSymb,xAct`PSALTer`Private`Spin1p]];
DefTensor[ProjBimetricF2p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`ProjBimetricFSymb,xAct`PSALTer`Private`Spin2p]];
DefTensor[ProjBimetricF1m[-a,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`ProjBimetricFSymb,xAct`PSALTer`Private`Spin1m]];

xAct`PSALTer`BimetricTensorTheory`Private`ProjBimetricFASpinParityToVG=Join[
	MakeRule[{ProjBimetricF0p[c,d],Evaluate[
		ProjPara[c,-k]ProjPara[d,-l]G[k,l]/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjBimetricF1p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l]Antisymmetrize[G[-i,k]G[-j,l],{-i,-j}]/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjBimetricF1m[-a,d],Evaluate[
		ProjPara[d,-j]ProjPara[-a,i]G[-i,j]/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjBimetricF2p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l](Symmetrize[G[-i,k]G[-j,l],{-i,-j}]-(1/3)G[-i,-j]G[k,l])/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

(*====================================*)
(*  Field perpendicular and parallel  *)
(*====================================*)

xAct`PSALTer`BimetricTensorTheory`Private`BimetricFParaSymb="\!\(\*SuperscriptBox[\(\[Psi]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[BimetricFPara[-a,-b],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`BimetricFParaSymb],OrthogonalTo->{V[b]},Dagger->Complex];
xAct`PSALTer`BimetricTensorTheory`Private`BimetricFPerpSymb="\!\(\*SuperscriptBox[\(\[Psi]\),\(\[UpTee]\)]\)";
DefTensor[BimetricFPerp[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`BimetricFPerpSymb],Dagger->Complex];

xAct`PSALTer`BimetricTensorTheory`Private`BimetricFAToBimetricFAPerpPara=Join[
	MakeRule[{BimetricF[-a,-b],Evaluate[BimetricFPara[-a,-b]+V[-b]BimetricFPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricF[-a,-b],Evaluate[Dagger@(BimetricFPara[-a,-b]+V[-b]BimetricFPerp[-a])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BimetricTensorTheory`Private`BimetricFAPerpParaToBimetricFA=Join[
	MakeRule[{BimetricFPara[-a,-b],Evaluate[
		ProjPara[-b,c]BimetricF[-a,-c]/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{BimetricFPerp[-a],Evaluate[
		V[c]BimetricF[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricFPara[-a,-b],Evaluate[Dagger@(
		ProjPara[-b,c]BimetricF[-a,-c]/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricFPerp[-a],Evaluate[Dagger@(
		V[c]BimetricF[-a,-c])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BimetricTensorTheory`Private`BimetricTauParaSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalT]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[BimetricTauPara[-a,-b],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`BimetricTauParaSymb],OrthogonalTo->{V[b]},Dagger->Complex];
xAct`PSALTer`BimetricTensorTheory`Private`BimetricTauPerpSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalT]\),\(\[UpTee]\)]\)";
DefTensor[BimetricTauPerp[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`BimetricTauPerpSymb],Dagger->Complex];

xAct`PSALTer`BimetricTensorTheory`Private`BimetricTauSigmaToBimetricTauSigmaPerpPara=Join[
	MakeRule[{BimetricTau[-a,-b],Evaluate[
		BimetricTauPara[-a,-b]+V[-b]BimetricTauPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricTau[-a,-b],Evaluate[Dagger@(	
		BimetricTauPara[-a,-b]+V[-b]BimetricTauPerp[-a])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BimetricTensorTheory`Private`BimetricTauSigmaPerpParaToBimetricTauSigma=Join[
	MakeRule[{BimetricTauPara[-a,-b],Evaluate[	
		ProjPara[-b,c]BimetricTau[-a,-c]/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{BimetricTauPerp[-a],Evaluate[
		V[c]BimetricTau[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricTauPara[-a,-b],Evaluate[Dagger@(
		ProjPara[-b,c]BimetricTau[-a,-c]/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricTauPerp[-a],Evaluate[Dagger@(
		V[c]BimetricTau[-a,-c])]},MetricOn->All,ContractMetrics->True]];

(*==============================*)
(*  Spin-parity or SO(3) parts  *)
(*==============================*)

(*======================*)
(*  Tensor definitions  *)
(*======================*)

DefTensor[BimetricFPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`BimetricFParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[BimetricFPara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`BimetricFParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[BimetricFPara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`BimetricFParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[BimetricFPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`BimetricFParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];

xAct`PSALTer`BimetricTensorTheory`Private`ManualAll=MakeRule[{Evaluate@Dagger@BimetricFPara2p[a,-a],0},MetricOn->All,ContractMetrics->True];

AutomaticRules[BimetricFPara2p,MakeRule[{BimetricFPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

DefTensor[BimetricTauPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`BimetricTauParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[BimetricTauPara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`BimetricTauParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[BimetricTauPara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`BimetricTauParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[BimetricTauPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`BimetricTauParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];

AutomaticRules[BimetricTauPara2p,MakeRule[{Evaluate@Dagger@BimetricTauPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BimetricTensorTheory`Private`ManualAll=Join[xAct`PSALTer`BimetricTensorTheory`Private`ManualAll,
	MakeRule[{Evaluate@Dagger@BimetricTauPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

AutomaticRules[BimetricTauPara2p,MakeRule[{BimetricTauPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BimetricTensorTheory`Private`BimetricLinearMetricPerpSymb="\!\(\*SuperscriptBox[\(\[Psi]\),\(\[UpTee]\)]\)";
DefTensor[BimetricLinearMetricPerp0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`BimetricLinearMetricPerpSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];

DefTensor[BimetricLinearMetricPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`BimetricLinearMetricPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

xAct`PSALTer`BimetricTensorTheory`Private`BimetricLinearMetricParaSymb="\!\(\*SuperscriptBox[\(\[Psi]\),\(\[DoubleVerticalBar]\)]\)";

DefTensor[BimetricLinearMetricPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`BimetricLinearMetricParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];

DefTensor[BimetricLinearMetricPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`BimetricLinearMetricParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];


AutomaticRules[BimetricLinearMetricPara2p,MakeRule[{Evaluate@Dagger@BimetricLinearMetricPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[BimetricLinearMetricPara2p,MakeRule[{BimetricLinearMetricPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BimetricTensorTheory`Private`BimetricStressEnergyPerpSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalT]\),\(\[UpTee]\)]\)";
DefTensor[BimetricStressEnergyPerp0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`BimetricStressEnergyPerpSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[BimetricStressEnergyPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`BimetricStressEnergyPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
xAct`PSALTer`BimetricTensorTheory`Private`BimetricStressEnergyParaSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalT]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[BimetricStressEnergyPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`BimetricStressEnergyParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[BimetricStressEnergyPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`BimetricStressEnergyParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];

AutomaticRules[BimetricStressEnergyPara2p,MakeRule[{Evaluate@Dagger@BimetricStressEnergyPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[BimetricStressEnergyPara2p,MakeRule[{BimetricStressEnergyPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

(*==============*)
(*  Expansions  *)
(*==============*)

xAct`PSALTer`BimetricTensorTheory`Private`BimetricFAParaSpinParityToBimetricFA=Join[
	MakeRule[{BimetricFPara0p[],Scalar[Evaluate[
		ProjBimetricF0p[e,f]ProjBimetricFPara[-e,-f,a,c]BimetricFPara[-a,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{BimetricFPara1p[-n,-m],Evaluate[
		ProjBimetricF1p[-n,-m,e,f]ProjBimetricFPara[-e,-f,a,c]BimetricFPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{BimetricFPara1m[-n],Evaluate[
		ProjBimetricF1m[-n,f]ProjBimetricFPerp[-f,a,c]BimetricFPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{BimetricFPara2p[-n,-m],Evaluate[
		ProjBimetricF2p[-n,-m,e,f]ProjBimetricFPara[-e,-f,a,c]BimetricFPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricFPara0p[],Scalar[Evaluate[Dagger@(
		ProjBimetricF0p[e,f]ProjBimetricFPara[-e,-f,a,c]BimetricFPara[-a,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricFPara1p[-n,-m],Evaluate[Dagger@(
		ProjBimetricF1p[-n,-m,e,f]ProjBimetricFPara[-e,-f,a,c]BimetricFPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricFPara1m[-n],Evaluate[Dagger@(
		ProjBimetricF1m[-n,f]ProjBimetricFPerp[-f,a,c]BimetricFPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricFPara2p[-n,-m],Evaluate[Dagger@(
		ProjBimetricF2p[-n,-m,e,f]ProjBimetricFPara[-e,-f,a,c]BimetricFPara[-a,-c])]},MetricOn->All,ContractMetrics->True]];

DefTensor[BimetricFPerp0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`BimetricFPerpSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[BimetricFPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`BimetricFPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

xAct`PSALTer`BimetricTensorTheory`Private`BimetricFAPerpSpinParityToBimetricFA=Join[
	MakeRule[{BimetricFPerp0p[],Scalar[Evaluate[
		V[a]BimetricFPerp[-a]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{BimetricFPerp1m[-n],Evaluate[
		ProjPara[-n,a]BimetricFPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricFPerp0p[],Scalar[Evaluate[Dagger@(
		V[a]BimetricFPerp[-a])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricFPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]BimetricFPerp[-a])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BimetricTensorTheory`Private`BimetricTauSigmaParaSpinParityToBimetricTauSigma=Join[
	MakeRule[{BimetricTauPara0p[],Scalar[Evaluate[
		ProjBimetricF0p[e,f]ProjBimetricFPara[-e,-f,a,c]BimetricTauPara[-a,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{BimetricTauPara1p[-n,-m],Evaluate[
		ProjBimetricF1p[-n,-m,e,f]ProjBimetricFPara[-e,-f,a,c]BimetricTauPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{BimetricTauPara1m[-n],Evaluate[
		ProjBimetricF1m[-n,f]ProjBimetricFPerp[-f,a,c]BimetricTauPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{BimetricTauPara2p[-n,-m],Evaluate[
		ProjBimetricF2p[-n,-m,e,f]ProjBimetricFPara[-e,-f,a,c]BimetricTauPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricTauPara0p[],Scalar[Evaluate[Dagger@(
		ProjBimetricF0p[e,f]ProjBimetricFPara[-e,-f,a,c]BimetricTauPara[-a,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricTauPara1p[-n,-m],Evaluate[Dagger@(
		ProjBimetricF1p[-n,-m,e,f]ProjBimetricFPara[-e,-f,a,c]BimetricTauPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricTauPara1m[-n],Evaluate[Dagger@(
		ProjBimetricF1m[-n,f]ProjBimetricFPerp[-f,a,c]BimetricTauPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricTauPara2p[-n,-m],Evaluate[Dagger@(
		ProjBimetricF2p[-n,-m,e,f]ProjBimetricFPara[-e,-f,a,c]BimetricTauPara[-a,-c])]},MetricOn->All,ContractMetrics->True]];

DefTensor[BimetricTauPerp0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`BimetricTauPerpSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[BimetricTauPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BimetricTensorTheory`Private`BimetricTauPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

xAct`PSALTer`BimetricTensorTheory`Private`BimetricTauSigmaPerpSpinParityToBimetricTauSigma=Join[
	MakeRule[{BimetricTauPerp0p[],Scalar[Evaluate[
		V[a]BimetricTauPerp[-a]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{BimetricTauPerp1m[-n],Evaluate[
		ProjPara[-n,a]BimetricTauPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricTauPerp0p[],Scalar[Evaluate[Dagger@(
		V[a]BimetricTauPerp[-a])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricTauPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]BimetricTauPerp[-a])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BimetricTensorTheory`Private`BimetricLinearMetricSpinParityToBimetricLinearMetric=Join[
	MakeRule[{BimetricLinearMetricPerp0p[],Evaluate[
		ProjPerp[a,b]BimetricLinearMetric[-a,-b]/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{BimetricLinearMetricPerp1m[-a],Evaluate[
		V[b]ProjPara[-a,c]BimetricLinearMetric[-c,-b]/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{BimetricLinearMetricPara0p[],Evaluate[
		ProjPara[a,b]BimetricLinearMetric[-a,-b]/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{BimetricLinearMetricPara2p[-a,-b],Evaluate[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*BimetricLinearMetric[-c,-d]/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricLinearMetricPerp0p[],Evaluate@Dagger[
		ProjPerp[a,b]BimetricLinearMetric[-a,-b]/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricLinearMetricPerp1m[-a],Evaluate@Dagger[
		V[b]ProjPara[-a,c]BimetricLinearMetric[-c,-b]/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricLinearMetricPara0p[],Evaluate@Dagger[
		ProjPara[a,b]BimetricLinearMetric[-a,-b]/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricLinearMetricPara2p[-a,-b],Evaluate@Dagger[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*BimetricLinearMetric[-c,-d]/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BimetricTensorTheory`Private`BimetricStressEnergySpinParityToBimetricStressEnergy=Join[
	MakeRule[{BimetricStressEnergyPerp0p[],Evaluate[
		ProjPerp[a,b]BimetricStressEnergy[-a,-b]/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{BimetricStressEnergyPerp1m[-a],Evaluate[
		V[b]ProjPara[-a,c]BimetricStressEnergy[-c,-b]/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{BimetricStressEnergyPara0p[],Evaluate[
		ProjPara[a,b]BimetricStressEnergy[-a,-b]/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{BimetricStressEnergyPara2p[-a,-b],Evaluate[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*BimetricStressEnergy[-c,-d]/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricStressEnergyPerp0p[],Evaluate@Dagger[
		ProjPerp[a,b]BimetricStressEnergy[-a,-b]/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricStressEnergyPerp1m[-a],Evaluate@Dagger[
		V[b]ProjPara[-a,c]BimetricStressEnergy[-c,-b]/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricStressEnergyPara0p[],Evaluate@Dagger[
		ProjPara[a,b]BimetricStressEnergy[-a,-b]/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricStressEnergyPara2p[-a,-b],Evaluate@Dagger[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*BimetricStressEnergy[-c,-d]/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

xAct`PSALTer`BimetricTensorTheory`Private`BimetricFAParaToBimetricFAParaSpinParity=Join[
	MakeRule[{BimetricFPara[-n,-m],Evaluate[
		((1/3)ProjPara[-n,-m]BimetricFPara0p[]+
		BimetricFPara1p[-n,-m]+
		BimetricFPara2p[-n,-m]+
		V[-n]BimetricFPara1m[-m])/.xAct`PSALTer`BimetricTensorTheory`Private`ProjBimetricFASpinParityToVG/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricFPara[-n,-m],Evaluate[Dagger@(
		((1/3)ProjPara[-n,-m]BimetricFPara0p[]+
		BimetricFPara1p[-n,-m]+
		BimetricFPara2p[-n,-m]+
		V[-n]BimetricFPara1m[-m])/.xAct`PSALTer`BimetricTensorTheory`Private`ProjBimetricFASpinParityToVG/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BimetricTensorTheory`Private`BimetricFAPerpToBimetricFAPerpSpinParity=Join[
	MakeRule[{BimetricFPerp[-n],Evaluate[BimetricFPerp0p[]V[-n]+BimetricFPerp1m[-n]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricFPerp[-n],Evaluate[Dagger@(BimetricFPerp0p[]V[-n]+BimetricFPerp1m[-n])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BimetricTensorTheory`Private`BimetricTauSigmaParaToBimetricTauSigmaParaSpinParity=Join[
	MakeRule[{BimetricTauPara[-n,-m],Evaluate[
		((1/3)ProjPara[-n,-m]BimetricTauPara0p[]+
		BimetricTauPara1p[-n,-m]+
		BimetricTauPara2p[-n,-m]+
		V[-n]BimetricTauPara1m[-m])/.xAct`PSALTer`BimetricTensorTheory`Private`ProjBimetricFASpinParityToVG/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricTauPara[-n,-m],Evaluate[Dagger@(
		((1/3)ProjPara[-n,-m]BimetricTauPara0p[]+
		BimetricTauPara1p[-n,-m]+
		BimetricTauPara2p[-n,-m]+
		V[-n]BimetricTauPara1m[-m])/.xAct`PSALTer`BimetricTensorTheory`Private`ProjBimetricFASpinParityToVG/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BimetricTensorTheory`Private`BimetricTauSigmaPerpToBimetricTauSigmaPerpSpinParity=Join[
	MakeRule[{BimetricTauPerp[-n],Evaluate[BimetricTauPerp0p[]V[-n]+BimetricTauPerp1m[-n]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricTauPerp[-n],Evaluate[Dagger@(BimetricTauPerp0p[]V[-n]+BimetricTauPerp1m[-n])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BimetricTensorTheory`Private`BimetricLinearMetricToBimetricLinearMetricSpinParity=Join[
	MakeRule[{BimetricLinearMetric[-a,-b],Evaluate[
		(
			BimetricLinearMetricPerp0p[]V[-a]V[-b]
			+BimetricLinearMetricPerp1m[-a]V[-b]
			+BimetricLinearMetricPerp1m[-b]V[-a]
			+(1/3)*BimetricLinearMetricPara0p[]ProjPara[-a,-b]
			+BimetricLinearMetricPara2p[-a,-b]
		)/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical
	]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricLinearMetric[-a,-b],Evaluate@Dagger[
		(
			BimetricLinearMetricPerp0p[]V[-a]V[-b]
			+BimetricLinearMetricPerp1m[-a]V[-b]
			+BimetricLinearMetricPerp1m[-b]V[-a]
			+(1/3)*BimetricLinearMetricPara0p[]ProjPara[-a,-b]
			+BimetricLinearMetricPara2p[-a,-b]
		)/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical
	]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BimetricTensorTheory`Private`BimetricStressEnergyToBimetricStressEnergySpinParity=Join[
	MakeRule[{BimetricStressEnergy[-a,-b],Evaluate[
		(
			BimetricStressEnergyPerp0p[]V[-a]V[-b]
			+BimetricStressEnergyPerp1m[-a]V[-b]
			+BimetricStressEnergyPerp1m[-b]V[-a]
			+(1/3)*BimetricStressEnergyPara0p[]ProjPara[-a,-b]
			+BimetricStressEnergyPara2p[-a,-b]
		)/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical
	]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@BimetricStressEnergy[-a,-b],Evaluate@Dagger[
		(
			BimetricStressEnergyPerp0p[]V[-a]V[-b]
			+BimetricStressEnergyPerp1m[-a]V[-b]
			+BimetricStressEnergyPerp1m[-b]V[-a]
			+(1/3)*BimetricStressEnergyPara0p[]ProjPara[-a,-b]
			+BimetricStressEnergyPara2p[-a,-b]
		)/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical
	]},MetricOn->All,ContractMetrics->True]];

(*==========================================================*)
(*  Basic definitions of the Lagrangian coupling constants  *)
(*==========================================================*)

(*=======================*)
(*  Karananas couplings  *)
(*=======================*)

xAct`PSALTer`BimetricTensorTheory`Private`kLambdaSymb="\[Lambda]";
DefLagrangianCoupling[kLambda,CouplingSymbol->xAct`PSALTer`BimetricTensorTheory`Private`kLambdaSymb];

xAct`PSALTer`BimetricTensorTheory`Private`kRSymb="\[ScriptR]";
DefLagrangianCoupling[kR1,
	CouplingSymbol->xAct`PSALTer`BimetricTensorTheory`Private`kRSymb,CouplingIndex->1];
DefLagrangianCoupling[kR2,
	CouplingSymbol->xAct`PSALTer`BimetricTensorTheory`Private`kRSymb,CouplingIndex->2];
DefLagrangianCoupling[kR3,
	CouplingSymbol->xAct`PSALTer`BimetricTensorTheory`Private`kRSymb,CouplingIndex->3];
DefLagrangianCoupling[kR4,
	CouplingSymbol->xAct`PSALTer`BimetricTensorTheory`Private`kRSymb,CouplingIndex->4];
DefLagrangianCoupling[kR5,
	CouplingSymbol->xAct`PSALTer`BimetricTensorTheory`Private`kRSymb,CouplingIndex->5];
DefLagrangianCoupling[kR6,
	CouplingSymbol->xAct`PSALTer`BimetricTensorTheory`Private`kRSymb,CouplingIndex->6];

xAct`PSALTer`BimetricTensorTheory`Private`kTSymb="\[ScriptT]";
DefLagrangianCoupling[kT1,
	CouplingSymbol->xAct`PSALTer`BimetricTensorTheory`Private`kTSymb,CouplingIndex->1];
DefLagrangianCoupling[kT2,
	CouplingSymbol->xAct`PSALTer`BimetricTensorTheory`Private`kTSymb,CouplingIndex->2];
DefLagrangianCoupling[kT3,
	CouplingSymbol->xAct`PSALTer`BimetricTensorTheory`Private`kTSymb,CouplingIndex->3];

DefLagrangianCoupling[EinsteinConstant,
	CouplingSymbol->"\[Kappa]"];

(*================================*)
(*  Hayasahi-Shirafuji couplings  *)
(*================================*)

xAct`PSALTer`BimetricTensorTheory`Private`AlpSymb="\[Alpha]";
DefLagrangianCoupling[Alp0,
	CouplingSymbol->xAct`PSALTer`BimetricTensorTheory`Private`AlpSymb,CouplingIndex->0];
DefLagrangianCoupling[Alp1,
	CouplingSymbol->xAct`PSALTer`BimetricTensorTheory`Private`AlpSymb,CouplingIndex->1];
DefLagrangianCoupling[Alp2,
	CouplingSymbol->xAct`PSALTer`BimetricTensorTheory`Private`AlpSymb,CouplingIndex->2];
DefLagrangianCoupling[Alp3,
	CouplingSymbol->xAct`PSALTer`BimetricTensorTheory`Private`AlpSymb,CouplingIndex->3];
DefLagrangianCoupling[Alp4,
	CouplingSymbol->xAct`PSALTer`BimetricTensorTheory`Private`AlpSymb,CouplingIndex->4];
DefLagrangianCoupling[Alp5,
	CouplingSymbol->xAct`PSALTer`BimetricTensorTheory`Private`AlpSymb,CouplingIndex->5];
DefLagrangianCoupling[Alp6,
	CouplingSymbol->xAct`PSALTer`BimetricTensorTheory`Private`AlpSymb,CouplingIndex->6];

xAct`PSALTer`BimetricTensorTheory`Private`BetSymb="\[Beta]";
DefLagrangianCoupling[Bet1,
	CouplingSymbol->xAct`PSALTer`BimetricTensorTheory`Private`BetSymb,CouplingIndex->1];
DefLagrangianCoupling[Bet2,
	CouplingSymbol->xAct`PSALTer`BimetricTensorTheory`Private`BetSymb,CouplingIndex->2];
DefLagrangianCoupling[Bet3,
	CouplingSymbol->xAct`PSALTer`BimetricTensorTheory`Private`BetSymb,CouplingIndex->3];

(*===================*)
(*  Private context  *)
(*===================*)

Begin["xAct`PSALTer`BimetricTensorTheory`Private`"];

LagrangianCouplings={Alp0,Alp1,Alp2,Alp3,Alp4,Alp5,Alp6,Bet1,Bet2,Bet3,kLambda,kR1,kR2,kR3,kR4,kR5,kR6,kT1,kT2,kT3};

FieldSpinParityTensorHeads=<|
		BimetricF-><|
			0-><|Even->{BimetricFPara0p,BimetricFPerp0p},Odd->{}|>,
			1-><|Even->{BimetricFPara1p},Odd->{BimetricFPara1m,BimetricFPerp1m}|>,
			2-><|Even->{BimetricFPara2p},Odd->{}|>
		|>,
		BimetricLinearMetric-><|
			0-><|Even->{BimetricLinearMetricPerp0p,BimetricLinearMetricPara0p},Odd->{}|>,
			1-><|Even->{},Odd->{BimetricLinearMetricPerp1m}|>,
			2-><|Even->{BimetricLinearMetricPara2p},Odd->{}|>
		|>
|>;

SourceSpinParityTensorHeads=<|
		BimetricTau-><|
			0-><|Even->{BimetricTauPara0p,BimetricTauPerp0p},Odd->{}|>,
			1-><|Even->{BimetricTauPara1p},Odd->{BimetricTauPara1m,BimetricTauPerp1m}|>,
			2-><|Even->{BimetricTauPara2p},Odd->{}|>
		|>,
		BimetricStressEnergy-><|
			0-><|Even->{BimetricStressEnergyPerp0p,BimetricStressEnergyPara0p},Odd->{}|>,
			1-><|Even->{},Odd->{BimetricStressEnergyPerp1m}|>,
			2-><|Even->{BimetricStressEnergyPara2p},Odd->{}|>
		|>
|>;

SourceEngineeringDimensions=<|
		BimetricTau->1,
		BimetricStressEnergy->1
|>;

ExpandFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`BimetricTensorTheory`Private`BimetricLinearMetricSpinParityToBimetricLinearMetric;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`BimetricTensorTheory`Private`BimetricFAParaSpinParityToBimetricFA;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`BimetricTensorTheory`Private`BimetricFAPerpSpinParityToBimetricFA;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`BimetricTensorTheory`Private`ProjBimetricFAPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`BimetricTensorTheory`Private`ProjBimetricFASpinParityToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`BimetricTensorTheory`Private`BimetricFAPerpParaToBimetricFA;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

ExpandSources[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`BimetricTensorTheory`Private`BimetricStressEnergySpinParityToBimetricStressEnergy;
	Expr=Expr/.xAct`PSALTer`BimetricTensorTheory`Private`BimetricTauSigmaParaSpinParityToBimetricTauSigma;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`BimetricTensorTheory`Private`BimetricTauSigmaPerpSpinParityToBimetricTauSigma;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`BimetricTensorTheory`Private`ProjBimetricFAPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`BimetricTensorTheory`Private`ProjBimetricFASpinParityToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`BimetricTensorTheory`Private`ProjPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`BimetricTensorTheory`Private`BimetricTauSigmaPerpParaToBimetricTauSigma;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
Expr];

DecomposeFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`BimetricTensorTheory`Private`BimetricLinearMetricToBimetricLinearMetricSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`BimetricTensorTheory`Private`BimetricFAToBimetricFAPerpPara;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`BimetricTensorTheory`Private`BimetricFAParaToBimetricFAParaSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`BimetricTensorTheory`Private`BimetricFAPerpToBimetricFAPerpSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
	Expr=Expr/.xAct`PSALTer`BimetricTensorTheory`Private`ManualAll;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

End[];

EndPackage[];

DefClass[
	"BimetricTensorTheory",
	xAct`PSALTer`BimetricTensorTheory`Private`LagrangianCouplings,
	xAct`PSALTer`BimetricTensorTheory`Private`FieldSpinParityTensorHeads,
	xAct`PSALTer`BimetricTensorTheory`Private`SourceSpinParityTensorHeads,
	xAct`PSALTer`BimetricTensorTheory`Private`SourceEngineeringDimensions,
	xAct`PSALTer`BimetricTensorTheory`Private`ExpandFields,
	xAct`PSALTer`BimetricTensorTheory`Private`DecomposeFields,
	xAct`PSALTer`BimetricTensorTheory`Private`ExpandSources,
ExportClass->False];
