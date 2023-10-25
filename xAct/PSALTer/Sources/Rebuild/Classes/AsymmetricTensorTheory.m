(*==========================*)
(*  AsymmetricTensorTheory  *)
(*==========================*)

BeginPackage["xAct`PSALTer`AsymmetricTensorTheory`",{"xAct`xTensor`","xAct`xPerm`","xAct`xCore`","xAct`xTras`","xAct`xCoba`","xAct`PSALTer`"}];

(*=================================================================*)
(*  Basic definitions of gauge fields and their conjugate sources  *)
(*=================================================================*)

xAct`PSALTer`AsymmetricTensorTheory`Private`AsymmetricFSymb="\[Psi]";
DefTensor[AsymmetricF[-i,-j],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`AsymmetricFSymb],Dagger->Complex];

xAct`PSALTer`AsymmetricTensorTheory`Private`AsymmetricTauSymb="\[ScriptCapitalT]";
DefTensor[AsymmetricTau[-i,-j],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`AsymmetricTauSymb],Dagger->Complex];

(*==============*)
(*  Projectors  *)
(*==============*)

(*====================================*)
(*  Basic perpendicular and parallel  *)
(*====================================*)

xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[UpTee]\)]\)";
DefTensor[ProjPerp[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpSymb]];
xAct`PSALTer`AsymmetricTensorTheory`Private`ProjParaSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[DoubleVerticalBar]\)]\)";
DefTensor[ProjPara[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`ProjParaSymb]];

xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG=Join[
	MakeRule[{ProjPerp[-a,b],Evaluate[V[-a]V[b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjPara[-a,b],Evaluate[G[-a,b]-V[-a]V[b]]},MetricOn->All,ContractMetrics->True]];

(*====================================*)
(*  Field perpendicular and parallel  *)
(*====================================*)

DefTensor[ProjAsymmetricFPerp[-a,d,e],M4];
DefTensor[ProjAsymmetricFPara[-a,-b,d,e],M4];

xAct`PSALTer`AsymmetricTensorTheory`Private`ProjFAPerpParaToVG=Join[
	MakeRule[{ProjAsymmetricFPerp[-a,d,e],Evaluate[
		V[d]G[-a,e]/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjAsymmetricFPara[-a,-b,d,e],Evaluate[
		ProjPara[-a,d]G[-b,e]/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*==============================*)
(*  Spin-parity or SO(3) parts  *)
(*==============================*)

xAct`PSALTer`AsymmetricTensorTheory`Private`ProjAsymmetricFSymb="\!\(\*SubscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(\[Hacek]\)],\(\[ScriptB]\)]\)";
DefTensor[ProjAsymmetricF0p[c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`ProjAsymmetricFSymb,xAct`PSALTer`Private`Spin0p]];
DefTensor[ProjAsymmetricF1p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`ProjAsymmetricFSymb,xAct`PSALTer`Private`Spin1p]];
DefTensor[ProjAsymmetricF2p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`ProjAsymmetricFSymb,xAct`PSALTer`Private`Spin2p]];
DefTensor[ProjAsymmetricF1m[-a,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`ProjAsymmetricFSymb,xAct`PSALTer`Private`Spin1m]];

xAct`PSALTer`AsymmetricTensorTheory`Private`ProjFASpinParityToVG=Join[
	MakeRule[{ProjAsymmetricF0p[c,d],Evaluate[
		ProjPara[c,-k]ProjPara[d,-l]G[k,l]/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjAsymmetricF1p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l]Antisymmetrize[G[-i,k]G[-j,l],{-i,-j}]/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjAsymmetricF1m[-a,d],Evaluate[
		ProjPara[d,-j]ProjPara[-a,i]G[-i,j]/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjAsymmetricF2p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l](Symmetrize[G[-i,k]G[-j,l],{-i,-j}]-(1/3)G[-i,-j]G[k,l])/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

(*====================================*)
(*  Field perpendicular and parallel  *)
(*====================================*)

xAct`PSALTer`AsymmetricTensorTheory`Private`FParaSymb="\!\(\*SuperscriptBox[\(\[Psi]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[AsymmetricFPara[-a,-b],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`FParaSymb],OrthogonalTo->{V[b]},Dagger->Complex];
xAct`PSALTer`AsymmetricTensorTheory`Private`FPerpSymb="\!\(\*SuperscriptBox[\(\[Psi]\),\(\[UpTee]\)]\)";
DefTensor[AsymmetricFPerp[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`FPerpSymb],Dagger->Complex];

xAct`PSALTer`AsymmetricTensorTheory`Private`FAToFAPerpPara=Join[
	MakeRule[{AsymmetricF[-a,-b],Evaluate[AsymmetricFPara[-a,-b]+V[-b]AsymmetricFPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@AsymmetricF[-a,-b],Evaluate[Dagger@(AsymmetricFPara[-a,-b]+V[-b]AsymmetricFPerp[-a])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`AsymmetricTensorTheory`Private`FAPerpParaToFA=Join[
	MakeRule[{AsymmetricFPara[-a,-b],Evaluate[
		ProjPara[-b,c]AsymmetricF[-a,-c]/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{AsymmetricFPerp[-a],Evaluate[
		V[c]AsymmetricF[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@AsymmetricFPara[-a,-b],Evaluate[Dagger@(
		ProjPara[-b,c]AsymmetricF[-a,-c]/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@AsymmetricFPerp[-a],Evaluate[Dagger@(
		V[c]AsymmetricF[-a,-c])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`AsymmetricTensorTheory`Private`AsymmetricTauParaSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalT]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[AsymmetricTauPara[-a,-b],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`AsymmetricTauParaSymb],OrthogonalTo->{V[b]},Dagger->Complex];
xAct`PSALTer`AsymmetricTensorTheory`Private`AsymmetricTauPerpSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalT]\),\(\[UpTee]\)]\)";
DefTensor[AsymmetricTauPerp[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`AsymmetricTauPerpSymb],Dagger->Complex];

xAct`PSALTer`AsymmetricTensorTheory`Private`AsymmetricTauSigmaToAsymmetricTauSigmaPerpPara=Join[
	MakeRule[{AsymmetricTau[-a,-b],Evaluate[
		AsymmetricTauPara[-a,-b]+V[-b]AsymmetricTauPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@AsymmetricTau[-a,-b],Evaluate[Dagger@(	
		AsymmetricTauPara[-a,-b]+V[-b]AsymmetricTauPerp[-a])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`AsymmetricTensorTheory`Private`AsymmetricTauSigmaPerpParaToAsymmetricTauSigma=Join[
	MakeRule[{AsymmetricTauPara[-a,-b],Evaluate[	
		ProjPara[-b,c]AsymmetricTau[-a,-c]/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{AsymmetricTauPerp[-a],Evaluate[
		V[c]AsymmetricTau[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@AsymmetricTauPara[-a,-b],Evaluate[Dagger@(
		ProjPara[-b,c]AsymmetricTau[-a,-c]/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@AsymmetricTauPerp[-a],Evaluate[Dagger@(
		V[c]AsymmetricTau[-a,-c])]},MetricOn->All,ContractMetrics->True]];

(*==============================*)
(*  Spin-parity or SO(3) parts  *)
(*==============================*)

(*======================*)
(*  Tensor definitions  *)
(*======================*)

DefTensor[FPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`FParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[FPara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`FParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[FPara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`FParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[FPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`FParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];

xAct`PSALTer`AsymmetricTensorTheory`Private`ManualAll=MakeRule[{Evaluate@Dagger@FPara2p[a,-a],0},MetricOn->All,ContractMetrics->True];

AutomaticRules[FPara2p,MakeRule[{FPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

DefTensor[AsymmetricTauPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`AsymmetricTauParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[AsymmetricTauPara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`AsymmetricTauParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[AsymmetricTauPara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`AsymmetricTauParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[AsymmetricTauPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`AsymmetricTauParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];

AutomaticRules[AsymmetricTauPara2p,MakeRule[{Evaluate@Dagger@AsymmetricTauPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`AsymmetricTensorTheory`Private`ManualAll=Join[xAct`PSALTer`AsymmetricTensorTheory`Private`ManualAll,
	MakeRule[{Evaluate@Dagger@AsymmetricTauPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

AutomaticRules[AsymmetricTauPara2p,MakeRule[{AsymmetricTauPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

(*==============*)
(*  Expansions  *)
(*==============*)

xAct`PSALTer`AsymmetricTensorTheory`Private`FAParaSpinParityToFA=Join[
	MakeRule[{FPara0p[],Scalar[Evaluate[
		ProjAsymmetricF0p[e,f]ProjAsymmetricFPara[-e,-f,a,c]AsymmetricFPara[-a,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{FPara1p[-n,-m],Evaluate[
		ProjAsymmetricF1p[-n,-m,e,f]ProjAsymmetricFPara[-e,-f,a,c]AsymmetricFPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{FPara1m[-n],Evaluate[
		ProjAsymmetricF1m[-n,f]ProjAsymmetricFPerp[-f,a,c]AsymmetricFPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{FPara2p[-n,-m],Evaluate[
		ProjAsymmetricF2p[-n,-m,e,f]ProjAsymmetricFPara[-e,-f,a,c]AsymmetricFPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPara0p[],Scalar[Evaluate[Dagger@(
		ProjAsymmetricF0p[e,f]ProjAsymmetricFPara[-e,-f,a,c]AsymmetricFPara[-a,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPara1p[-n,-m],Evaluate[Dagger@(
		ProjAsymmetricF1p[-n,-m,e,f]ProjAsymmetricFPara[-e,-f,a,c]AsymmetricFPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPara1m[-n],Evaluate[Dagger@(
		ProjAsymmetricF1m[-n,f]ProjAsymmetricFPerp[-f,a,c]AsymmetricFPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPara2p[-n,-m],Evaluate[Dagger@(
		ProjAsymmetricF2p[-n,-m,e,f]ProjAsymmetricFPara[-e,-f,a,c]AsymmetricFPara[-a,-c])]},MetricOn->All,ContractMetrics->True]];

DefTensor[FPerp0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`FPerpSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[FPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`FPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

xAct`PSALTer`AsymmetricTensorTheory`Private`FAPerpSpinParityToFA=Join[
	MakeRule[{FPerp0p[],Scalar[Evaluate[
		V[a]AsymmetricFPerp[-a]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{FPerp1m[-n],Evaluate[
		ProjPara[-n,a]AsymmetricFPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPerp0p[],Scalar[Evaluate[Dagger@(
		V[a]AsymmetricFPerp[-a])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]AsymmetricFPerp[-a])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`AsymmetricTensorTheory`Private`AsymmetricTauSigmaParaSpinParityToAsymmetricTauSigma=Join[
	MakeRule[{AsymmetricTauPara0p[],Scalar[Evaluate[
		ProjAsymmetricF0p[e,f]ProjAsymmetricFPara[-e,-f,a,c]AsymmetricTauPara[-a,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{AsymmetricTauPara1p[-n,-m],Evaluate[
		ProjAsymmetricF1p[-n,-m,e,f]ProjAsymmetricFPara[-e,-f,a,c]AsymmetricTauPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{AsymmetricTauPara1m[-n],Evaluate[
		ProjAsymmetricF1m[-n,f]ProjAsymmetricFPerp[-f,a,c]AsymmetricTauPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{AsymmetricTauPara2p[-n,-m],Evaluate[
		ProjAsymmetricF2p[-n,-m,e,f]ProjAsymmetricFPara[-e,-f,a,c]AsymmetricTauPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@AsymmetricTauPara0p[],Scalar[Evaluate[Dagger@(
		ProjAsymmetricF0p[e,f]ProjAsymmetricFPara[-e,-f,a,c]AsymmetricTauPara[-a,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@AsymmetricTauPara1p[-n,-m],Evaluate[Dagger@(
		ProjAsymmetricF1p[-n,-m,e,f]ProjAsymmetricFPara[-e,-f,a,c]AsymmetricTauPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@AsymmetricTauPara1m[-n],Evaluate[Dagger@(
		ProjAsymmetricF1m[-n,f]ProjAsymmetricFPerp[-f,a,c]AsymmetricTauPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@AsymmetricTauPara2p[-n,-m],Evaluate[Dagger@(
		ProjAsymmetricF2p[-n,-m,e,f]ProjAsymmetricFPara[-e,-f,a,c]AsymmetricTauPara[-a,-c])]},MetricOn->All,ContractMetrics->True]];

DefTensor[AsymmetricTauPerp0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`AsymmetricTauPerpSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[AsymmetricTauPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`AsymmetricTauPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

xAct`PSALTer`AsymmetricTensorTheory`Private`AsymmetricTauSigmaPerpSpinParityToAsymmetricTauSigma=Join[
	MakeRule[{AsymmetricTauPerp0p[],Scalar[Evaluate[
		V[a]AsymmetricTauPerp[-a]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{AsymmetricTauPerp1m[-n],Evaluate[
		ProjPara[-n,a]AsymmetricTauPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@AsymmetricTauPerp0p[],Scalar[Evaluate[Dagger@(
		V[a]AsymmetricTauPerp[-a])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@AsymmetricTauPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]AsymmetricTauPerp[-a])]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

xAct`PSALTer`AsymmetricTensorTheory`Private`FAParaToFAParaSpinParity=Join[
	MakeRule[{AsymmetricFPara[-n,-m],Evaluate[
		((1/3)ProjPara[-n,-m]FPara0p[]+
		FPara1p[-n,-m]+
		FPara2p[-n,-m]+
		V[-n]FPara1m[-m])/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjFASpinParityToVG/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@AsymmetricFPara[-n,-m],Evaluate[Dagger@(
		((1/3)ProjPara[-n,-m]FPara0p[]+
		FPara1p[-n,-m]+
		FPara2p[-n,-m]+
		V[-n]FPara1m[-m])/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjFASpinParityToVG/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`AsymmetricTensorTheory`Private`FAPerpToFAPerpSpinParity=Join[
	MakeRule[{AsymmetricFPerp[-n],Evaluate[FPerp0p[]V[-n]+FPerp1m[-n]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@AsymmetricFPerp[-n],Evaluate[Dagger@(FPerp0p[]V[-n]+FPerp1m[-n])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`AsymmetricTensorTheory`Private`AsymmetricTauSigmaParaToAsymmetricTauSigmaParaSpinParity=Join[
	MakeRule[{AsymmetricTauPara[-n,-m],Evaluate[
		((1/3)ProjPara[-n,-m]AsymmetricTauPara0p[]+
		AsymmetricTauPara1p[-n,-m]+
		AsymmetricTauPara2p[-n,-m]+
		V[-n]AsymmetricTauPara1m[-m])/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjFASpinParityToVG/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@AsymmetricTauPara[-n,-m],Evaluate[Dagger@(
		((1/3)ProjPara[-n,-m]AsymmetricTauPara0p[]+
		AsymmetricTauPara1p[-n,-m]+
		AsymmetricTauPara2p[-n,-m]+
		V[-n]AsymmetricTauPara1m[-m])/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjFASpinParityToVG/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`AsymmetricTensorTheory`Private`AsymmetricTauSigmaPerpToAsymmetricTauSigmaPerpSpinParity=Join[
	MakeRule[{AsymmetricTauPerp[-n],Evaluate[AsymmetricTauPerp0p[]V[-n]+AsymmetricTauPerp1m[-n]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@AsymmetricTauPerp[-n],Evaluate[Dagger@(AsymmetricTauPerp0p[]V[-n]+AsymmetricTauPerp1m[-n])]},MetricOn->All,ContractMetrics->True]];

(*==========================================================*)
(*  Basic definitions of the Lagrangian coupling constants  *)
(*==========================================================*)

(*=======================*)
(*  Karananas couplings  *)
(*=======================*)

xAct`PSALTer`AsymmetricTensorTheory`Private`kLambdaSymb="\[Lambda]";
DefLagrangianCoupling[kLambda,CouplingSymbol->xAct`PSALTer`AsymmetricTensorTheory`Private`kLambdaSymb];

xAct`PSALTer`AsymmetricTensorTheory`Private`kRSymb="\[ScriptR]";
DefLagrangianCoupling[kR1,
	CouplingSymbol->xAct`PSALTer`AsymmetricTensorTheory`Private`kRSymb,CouplingIndex->1];
DefLagrangianCoupling[kR2,
	CouplingSymbol->xAct`PSALTer`AsymmetricTensorTheory`Private`kRSymb,CouplingIndex->2];
DefLagrangianCoupling[kR3,
	CouplingSymbol->xAct`PSALTer`AsymmetricTensorTheory`Private`kRSymb,CouplingIndex->3];
DefLagrangianCoupling[kR4,
	CouplingSymbol->xAct`PSALTer`AsymmetricTensorTheory`Private`kRSymb,CouplingIndex->4];
DefLagrangianCoupling[kR5,
	CouplingSymbol->xAct`PSALTer`AsymmetricTensorTheory`Private`kRSymb,CouplingIndex->5];
DefLagrangianCoupling[kR6,
	CouplingSymbol->xAct`PSALTer`AsymmetricTensorTheory`Private`kRSymb,CouplingIndex->6];

xAct`PSALTer`AsymmetricTensorTheory`Private`kTSymb="\[ScriptT]";
DefLagrangianCoupling[kT1,
	CouplingSymbol->xAct`PSALTer`AsymmetricTensorTheory`Private`kTSymb,CouplingIndex->1];
DefLagrangianCoupling[kT2,
	CouplingSymbol->xAct`PSALTer`AsymmetricTensorTheory`Private`kTSymb,CouplingIndex->2];
DefLagrangianCoupling[kT3,
	CouplingSymbol->xAct`PSALTer`AsymmetricTensorTheory`Private`kTSymb,CouplingIndex->3];

DefLagrangianCoupling[xAct`PSALTer`AsymmetricTensorTheory`EinsteinConstant,
	CouplingSymbol->"\[Kappa]"];

(*================================*)
(*  Hayasahi-Shirafuji couplings  *)
(*================================*)

xAct`PSALTer`AsymmetricTensorTheory`Private`AlpSymb="\[Alpha]";
DefLagrangianCoupling[Alp0,
	CouplingSymbol->xAct`PSALTer`AsymmetricTensorTheory`Private`AlpSymb,CouplingIndex->0];
DefLagrangianCoupling[Alp1,
	CouplingSymbol->xAct`PSALTer`AsymmetricTensorTheory`Private`AlpSymb,CouplingIndex->1];
DefLagrangianCoupling[Alp2,
	CouplingSymbol->xAct`PSALTer`AsymmetricTensorTheory`Private`AlpSymb,CouplingIndex->2];
DefLagrangianCoupling[Alp3,
	CouplingSymbol->xAct`PSALTer`AsymmetricTensorTheory`Private`AlpSymb,CouplingIndex->3];
DefLagrangianCoupling[Alp4,
	CouplingSymbol->xAct`PSALTer`AsymmetricTensorTheory`Private`AlpSymb,CouplingIndex->4];
DefLagrangianCoupling[Alp5,
	CouplingSymbol->xAct`PSALTer`AsymmetricTensorTheory`Private`AlpSymb,CouplingIndex->5];
DefLagrangianCoupling[Alp6,
	CouplingSymbol->xAct`PSALTer`AsymmetricTensorTheory`Private`AlpSymb,CouplingIndex->6];

xAct`PSALTer`AsymmetricTensorTheory`Private`BetSymb="\[Beta]";
DefLagrangianCoupling[Bet1,
	CouplingSymbol->xAct`PSALTer`AsymmetricTensorTheory`Private`BetSymb,CouplingIndex->1];
DefLagrangianCoupling[Bet2,
	CouplingSymbol->xAct`PSALTer`AsymmetricTensorTheory`Private`BetSymb,CouplingIndex->2];
DefLagrangianCoupling[Bet3,
	CouplingSymbol->xAct`PSALTer`AsymmetricTensorTheory`Private`BetSymb,CouplingIndex->3];

(*===================*)
(*  Private context  *)
(*===================*)

Begin["xAct`PSALTer`AsymmetricTensorTheory`Private`"];

LagrangianCouplings={Alp0,Alp1,Alp2,Alp3,Alp4,Alp5,Alp6,Bet1,Bet2,Bet3,kLambda,kR1,kR2,kR3,kR4,kR5,kR6,kT1,kT2,kT3};

FieldSpinParityTensorHeads=<|
		F-><|
			0-><|Even->{FPara0p,FPerp0p},Odd->{}|>,
			1-><|Even->{FPara1p},Odd->{FPara1m,FPerp1m}|>,
			2-><|Even->{FPara2p},Odd->{}|>
		|>
|>;

SourceSpinParityTensorHeads=<|
		AsymmetricTau-><|
			0-><|Even->{AsymmetricTauPara0p,AsymmetricTauPerp0p},Odd->{}|>,
			1-><|Even->{AsymmetricTauPara1p},Odd->{AsymmetricTauPara1m,AsymmetricTauPerp1m}|>,
			2-><|Even->{AsymmetricTauPara2p},Odd->{}|>
		|>
|>;

SourceEngineeringDimensions=<|
		AsymmetricTau->1
|>;

ExpandFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`AsymmetricTensorTheory`Private`FAParaSpinParityToFA;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`AsymmetricTensorTheory`Private`FAPerpSpinParityToFA;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjFAPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjFASpinParityToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`AsymmetricTensorTheory`Private`FAPerpParaToFA;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

ExpandSources[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`AsymmetricTensorTheory`Private`AsymmetricTauSigmaParaSpinParityToAsymmetricTauSigma;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`AsymmetricTensorTheory`Private`AsymmetricTauSigmaPerpSpinParityToAsymmetricTauSigma;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjFAPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjFASpinParityToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`AsymmetricTensorTheory`Private`AsymmetricTauSigmaPerpParaToAsymmetricTauSigma;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
Expr];

DecomposeFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`AsymmetricTensorTheory`Private`FAToFAPerpPara;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`AsymmetricTensorTheory`Private`FAParaToFAParaSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`AsymmetricTensorTheory`Private`FAPerpToFAPerpSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
	Expr=Expr/.xAct`PSALTer`AsymmetricTensorTheory`Private`Patch2m;
	Expr=Expr/.xAct`PSALTer`AsymmetricTensorTheory`Private`ManualAll;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

End[];

EndPackage[];

DefClass[
	"AsymmetricTensorTheory",
	xAct`PSALTer`AsymmetricTensorTheory`Private`LagrangianCouplings,
	xAct`PSALTer`AsymmetricTensorTheory`Private`FieldSpinParityTensorHeads,
	xAct`PSALTer`AsymmetricTensorTheory`Private`SourceSpinParityTensorHeads,
	xAct`PSALTer`AsymmetricTensorTheory`Private`SourceEngineeringDimensions,
	xAct`PSALTer`AsymmetricTensorTheory`Private`ExpandFields,
	xAct`PSALTer`AsymmetricTensorTheory`Private`DecomposeFields,
	xAct`PSALTer`AsymmetricTensorTheory`Private`ExpandSources,
ExportClass->False];
