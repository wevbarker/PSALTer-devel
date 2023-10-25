(*==========================*)
(*  AsymmetricTensorTheory  *)
(*==========================*)

BeginPackage["xAct`PSALTer`AsymmetricTensorTheory`",{"xAct`xTensor`","xAct`xPerm`","xAct`xCore`","xAct`xTras`","xAct`xCoba`","xAct`PSALTer`"}];

(*=================================================================*)
(*  Basic definitions of gauge fields and their conjugate sources  *)
(*=================================================================*)

xAct`PSALTer`AsymmetricTensorTheory`Private`FSymb="\[Psi]";
DefTensor[F[-i,-j],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`FSymb],Dagger->Complex];

xAct`PSALTer`AsymmetricTensorTheory`Private`TauSymb="\[ScriptCapitalT]";
DefTensor[Tau[-i,-j],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`TauSymb],Dagger->Complex];

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

DefTensor[ProjAPerp[-a,-b,d,e,f],M4];
DefTensor[ProjAPara[-a,-b,-c,d,e,f],M4];
DefTensor[ProjFPerp[-a,d,e],M4];
DefTensor[ProjFPara[-a,-b,d,e],M4];

xAct`PSALTer`AsymmetricTensorTheory`Private`ProjFAPerpParaToVG=Join[
	MakeRule[{ProjAPerp[-a,-b,d,e,f],Evaluate[
		V[d]ProjPara[-a,e]G[-b,f]/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjAPara[-a,-b,-c,d,e,f],Evaluate[
		ProjPara[-a,d]ProjPara[-b,e]G[-c,f]/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjFPerp[-a,d,e],Evaluate[
		V[d]G[-a,e]/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjFPara[-a,-b,d,e],Evaluate[
		ProjPara[-a,d]G[-b,e]/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*==============================*)
(*  Spin-parity or SO(3) parts  *)
(*==============================*)

xAct`PSALTer`AsymmetricTensorTheory`Private`ProjFSymb="\!\(\*SubscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(\[Hacek]\)],\(\[ScriptB]\)]\)";
DefTensor[ProjF0p[c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`ProjFSymb,xAct`PSALTer`Private`Spin0p]];
DefTensor[ProjF1p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`ProjFSymb,xAct`PSALTer`Private`Spin1p]];
DefTensor[ProjF2p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`ProjFSymb,xAct`PSALTer`Private`Spin2p]];
DefTensor[ProjF1m[-a,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`ProjFSymb,xAct`PSALTer`Private`Spin1m]];

xAct`PSALTer`AsymmetricTensorTheory`Private`ProjFASpinParityToVG=Join[
	MakeRule[{ProjF0p[c,d],Evaluate[
		ProjPara[c,-k]ProjPara[d,-l]G[k,l]/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjF1p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l]Antisymmetrize[G[-i,k]G[-j,l],{-i,-j}]/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjF1m[-a,d],Evaluate[
		ProjPara[d,-j]ProjPara[-a,i]G[-i,j]/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjF2p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l](Symmetrize[G[-i,k]G[-j,l],{-i,-j}]-(1/3)G[-i,-j]G[k,l])/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

(*====================================*)
(*  Field perpendicular and parallel  *)
(*====================================*)

xAct`PSALTer`AsymmetricTensorTheory`Private`FParaSymb="\!\(\*SuperscriptBox[\(\[Psi]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[FPara[-a,-b],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`FParaSymb],OrthogonalTo->{V[b]},Dagger->Complex];
xAct`PSALTer`AsymmetricTensorTheory`Private`FPerpSymb="\!\(\*SuperscriptBox[\(\[Psi]\),\(\[UpTee]\)]\)";
DefTensor[FPerp[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`FPerpSymb],Dagger->Complex];

xAct`PSALTer`AsymmetricTensorTheory`Private`FAToFAPerpPara=Join[
	MakeRule[{F[-a,-b],Evaluate[FPara[-a,-b]+V[-b]FPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@F[-a,-b],Evaluate[Dagger@(FPara[-a,-b]+V[-b]FPerp[-a])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`AsymmetricTensorTheory`Private`FAPerpParaToFA=Join[
	MakeRule[{FPara[-a,-b],Evaluate[
		ProjPara[-b,c]F[-a,-c]/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{FPerp[-a],Evaluate[
		V[c]F[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPara[-a,-b],Evaluate[Dagger@(
		ProjPara[-b,c]F[-a,-c]/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPerp[-a],Evaluate[Dagger@(
		V[c]F[-a,-c])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`AsymmetricTensorTheory`Private`TauParaSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalT]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[TauPara[-a,-b],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`TauParaSymb],OrthogonalTo->{V[b]},Dagger->Complex];
xAct`PSALTer`AsymmetricTensorTheory`Private`TauPerpSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalT]\),\(\[UpTee]\)]\)";
DefTensor[TauPerp[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`TauPerpSymb],Dagger->Complex];

xAct`PSALTer`AsymmetricTensorTheory`Private`TauSigmaToTauSigmaPerpPara=Join[
	MakeRule[{Tau[-a,-b],Evaluate[
		TauPara[-a,-b]+V[-b]TauPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Tau[-a,-b],Evaluate[Dagger@(	
		TauPara[-a,-b]+V[-b]TauPerp[-a])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`AsymmetricTensorTheory`Private`TauSigmaPerpParaToTauSigma=Join[
	MakeRule[{TauPara[-a,-b],Evaluate[	
		ProjPara[-b,c]Tau[-a,-c]/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{TauPerp[-a],Evaluate[
		V[c]Tau[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPara[-a,-b],Evaluate[Dagger@(
		ProjPara[-b,c]Tau[-a,-c]/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPerp[-a],Evaluate[Dagger@(
		V[c]Tau[-a,-c])]},MetricOn->All,ContractMetrics->True]];

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

DefTensor[TauPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`TauParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[TauPara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`TauParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[TauPara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`TauParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[TauPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`TauParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];

AutomaticRules[TauPara2p,MakeRule[{Evaluate@Dagger@TauPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`AsymmetricTensorTheory`Private`ManualAll=Join[xAct`PSALTer`AsymmetricTensorTheory`Private`ManualAll,
	MakeRule[{Evaluate@Dagger@TauPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

AutomaticRules[TauPara2p,MakeRule[{TauPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

(*==============*)
(*  Expansions  *)
(*==============*)

xAct`PSALTer`AsymmetricTensorTheory`Private`FAParaSpinParityToFA=Join[
	MakeRule[{FPara0p[],Scalar[Evaluate[
		ProjF0p[e,f]ProjFPara[-e,-f,a,c]FPara[-a,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{FPara1p[-n,-m],Evaluate[
		ProjF1p[-n,-m,e,f]ProjFPara[-e,-f,a,c]FPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{FPara1m[-n],Evaluate[
		ProjF1m[-n,f]ProjFPerp[-f,a,c]FPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{FPara2p[-n,-m],Evaluate[
		ProjF2p[-n,-m,e,f]ProjFPara[-e,-f,a,c]FPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPara0p[],Scalar[Evaluate[Dagger@(
		ProjF0p[e,f]ProjFPara[-e,-f,a,c]FPara[-a,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPara1p[-n,-m],Evaluate[Dagger@(
		ProjF1p[-n,-m,e,f]ProjFPara[-e,-f,a,c]FPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPara1m[-n],Evaluate[Dagger@(
		ProjF1m[-n,f]ProjFPerp[-f,a,c]FPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPara2p[-n,-m],Evaluate[Dagger@(
		ProjF2p[-n,-m,e,f]ProjFPara[-e,-f,a,c]FPara[-a,-c])]},MetricOn->All,ContractMetrics->True]];

DefTensor[FPerp0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`FPerpSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[FPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`FPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

xAct`PSALTer`AsymmetricTensorTheory`Private`FAPerpSpinParityToFA=Join[
	MakeRule[{FPerp0p[],Scalar[Evaluate[
		V[a]FPerp[-a]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{FPerp1m[-n],Evaluate[
		ProjPara[-n,a]FPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPerp0p[],Scalar[Evaluate[Dagger@(
		V[a]FPerp[-a])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]FPerp[-a])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`AsymmetricTensorTheory`Private`TauSigmaParaSpinParityToTauSigma=Join[
	MakeRule[{TauPara0p[],Scalar[Evaluate[
		ProjF0p[e,f]ProjFPara[-e,-f,a,c]TauPara[-a,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{TauPara1p[-n,-m],Evaluate[
		ProjF1p[-n,-m,e,f]ProjFPara[-e,-f,a,c]TauPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{TauPara1m[-n],Evaluate[
		ProjF1m[-n,f]ProjFPerp[-f,a,c]TauPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{TauPara2p[-n,-m],Evaluate[
		ProjF2p[-n,-m,e,f]ProjFPara[-e,-f,a,c]TauPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPara0p[],Scalar[Evaluate[Dagger@(
		ProjF0p[e,f]ProjFPara[-e,-f,a,c]TauPara[-a,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPara1p[-n,-m],Evaluate[Dagger@(
		ProjF1p[-n,-m,e,f]ProjFPara[-e,-f,a,c]TauPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPara1m[-n],Evaluate[Dagger@(
		ProjF1m[-n,f]ProjFPerp[-f,a,c]TauPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPara2p[-n,-m],Evaluate[Dagger@(
		ProjF2p[-n,-m,e,f]ProjFPara[-e,-f,a,c]TauPara[-a,-c])]},MetricOn->All,ContractMetrics->True]];

DefTensor[TauPerp0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`TauPerpSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[TauPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`AsymmetricTensorTheory`Private`TauPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

xAct`PSALTer`AsymmetricTensorTheory`Private`TauSigmaPerpSpinParityToTauSigma=Join[
	MakeRule[{TauPerp0p[],Scalar[Evaluate[
		V[a]TauPerp[-a]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{TauPerp1m[-n],Evaluate[
		ProjPara[-n,a]TauPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPerp0p[],Scalar[Evaluate[Dagger@(
		V[a]TauPerp[-a])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]TauPerp[-a])]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

xAct`PSALTer`AsymmetricTensorTheory`Private`FAParaToFAParaSpinParity=Join[
	MakeRule[{FPara[-n,-m],Evaluate[
		((1/3)ProjPara[-n,-m]FPara0p[]+
		FPara1p[-n,-m]+
		FPara2p[-n,-m]+
		V[-n]FPara1m[-m])/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjFASpinParityToVG/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPara[-n,-m],Evaluate[Dagger@(
		((1/3)ProjPara[-n,-m]FPara0p[]+
		FPara1p[-n,-m]+
		FPara2p[-n,-m]+
		V[-n]FPara1m[-m])/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjFASpinParityToVG/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`AsymmetricTensorTheory`Private`FAPerpToFAPerpSpinParity=Join[
	MakeRule[{FPerp[-n],Evaluate[FPerp0p[]V[-n]+FPerp1m[-n]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPerp[-n],Evaluate[Dagger@(FPerp0p[]V[-n]+FPerp1m[-n])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`AsymmetricTensorTheory`Private`TauSigmaParaToTauSigmaParaSpinParity=Join[
	MakeRule[{TauPara[-n,-m],Evaluate[
		((1/3)ProjPara[-n,-m]TauPara0p[]+
		TauPara1p[-n,-m]+
		TauPara2p[-n,-m]+
		V[-n]TauPara1m[-m])/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjFASpinParityToVG/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPara[-n,-m],Evaluate[Dagger@(
		((1/3)ProjPara[-n,-m]TauPara0p[]+
		TauPara1p[-n,-m]+
		TauPara2p[-n,-m]+
		V[-n]TauPara1m[-m])/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjFASpinParityToVG/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`AsymmetricTensorTheory`Private`TauSigmaPerpToTauSigmaPerpSpinParity=Join[
	MakeRule[{TauPerp[-n],Evaluate[TauPerp0p[]V[-n]+TauPerp1m[-n]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPerp[-n],Evaluate[Dagger@(TauPerp0p[]V[-n]+TauPerp1m[-n])]},MetricOn->All,ContractMetrics->True]];

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

DefLagrangianCoupling[EinsteinConstant,
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
		Tau-><|
			0-><|Even->{TauPara0p,TauPerp0p},Odd->{}|>,
			1-><|Even->{TauPara1p},Odd->{TauPara1m,TauPerp1m}|>,
			2-><|Even->{TauPara2p},Odd->{}|>
		|>
|>;

SourceEngineeringDimensions=<|
		Tau->1
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
	Expr=Expr/.xAct`PSALTer`AsymmetricTensorTheory`Private`TauSigmaParaSpinParityToTauSigma;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`AsymmetricTensorTheory`Private`TauSigmaPerpSpinParityToTauSigma;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjFAPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjFASpinParityToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`AsymmetricTensorTheory`Private`ProjPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`AsymmetricTensorTheory`Private`TauSigmaPerpParaToTauSigma;
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
