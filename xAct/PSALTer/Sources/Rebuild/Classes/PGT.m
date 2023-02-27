(*=======*)
(*  PGT  *)
(*=======*)

(*=============================================*)
(*  The context for the PGT class of theories  *)
(*=============================================*)

BeginPackage["xAct`PSALTer`PGT`",{"xAct`xTensor`","xAct`xPerm`","xAct`xCore`","xAct`xTras`","xAct`xCoba`","xAct`PSALTer`"}];

(*=================================================================*)
(*  Basic definitions of gauge fields and their conjugate sources  *)
(*=================================================================*)

xAct`PSALTer`PGT`Private`ASymb="\[ScriptCapitalA]";
DefTensor[A[a,c,-d],M4,Antisymmetric[{a,c}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`ASymb],Dagger->Complex];

xAct`PSALTer`PGT`Private`SigmaSymb="\[Sigma]";
DefTensor[Sigma[-i,-j,-k],M4,Antisymmetric[{-j,-k}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`SigmaSymb],Dagger->Complex];

xAct`PSALTer`PGT`Private`FSymb="\[ScriptF]";
DefTensor[F[-i,-j],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`FSymb],Dagger->Complex];

xAct`PSALTer`PGT`Private`TauSymb="\[Tau](\[CapitalDelta]+\[ScriptCapitalK])";
DefTensor[Tau[-i,-j],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`TauSymb],Dagger->Complex];

(*==============*)
(*  Projectors  *)
(*==============*)

xAct`PSALTer`PGT`Private`PPerpSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[UpTee]\)]\)";
DefTensor[PPerp[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`PPerpSymb]];
xAct`PSALTer`PGT`Private`PParaSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[DoubleVerticalBar]\)]\)";
DefTensor[PPara[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`PParaSymb]];
xAct`PSALTer`PGT`Private`PADMActivate=Join[
	MakeRule[{PPerp[-a,b],Evaluate[V[-a]V[b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{PPara[-a,b],Evaluate[G[-a,b]-V[-a]V[b]]},MetricOn->All,ContractMetrics->True]];

DefTensor[PAPerp[-a,-b,d,e,f],M4];
DefTensor[PAPara[-a,-b,-c,d,e,f],M4];
DefTensor[PBPerp[-a,d,e],M4];
DefTensor[PBPara[-a,-b,d,e],M4];

xAct`PSALTer`PGT`Private`PADMPiActivate=Join[
	MakeRule[{PAPerp[-a,-b,d,e,f],Evaluate[
		V[d]PPara[-a,e]G[-b,f]/.xAct`PSALTer`PGT`Private`PADMActivate//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{PAPara[-a,-b,-c,d,e,f],Evaluate[
		PPara[-a,d]PPara[-b,e]G[-c,f]/.xAct`PSALTer`PGT`Private`PADMActivate//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{PBPerp[-a,d,e],Evaluate[
		V[d]G[-a,e]/.xAct`PSALTer`PGT`Private`PADMActivate//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{PBPara[-a,-b,d,e],Evaluate[
		PPara[-a,d]G[-b,e]/.xAct`PSALTer`PGT`Private`PADMActivate//ToCanonical]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`PGT`Private`PASymb="\!\(\*SubscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(\[Hacek]\)],\(\[ScriptCapitalA]\)]\)";
DefTensor[PA0p[c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`PASymb,xAct`PSALTer`Private`Spin0p]];
DefTensor[PA0m[d,e,f],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`PASymb,xAct`PSALTer`Private`Spin0m]];
DefTensor[PA1p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`PASymb,xAct`PSALTer`Private`Spin1p]];
DefTensor[PA1m[-a,d,e,f],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`PASymb,xAct`PSALTer`Private`Spin1m]];
DefTensor[PA2p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`PASymb,xAct`PSALTer`Private`Spin2p]];
DefTensor[PA2m[-a,-b,-c,d,e,f],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`PASymb,xAct`PSALTer`Private`Spin2m]];
xAct`PSALTer`PGT`Private`PBSymb="\!\(\*SubscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(\[Hacek]\)],\(\[ScriptB]\)]\)";
DefTensor[PB0p[c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`PBSymb,xAct`PSALTer`Private`Spin0p]];
DefTensor[PB1p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`PBSymb,xAct`PSALTer`Private`Spin1p]];
DefTensor[PB2p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`PBSymb,xAct`PSALTer`Private`Spin2p]];
DefTensor[PB1m[-a,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`PBSymb,xAct`PSALTer`Private`Spin1m]];

xAct`PSALTer`PGT`Private`PO3PiActivate=Join[
	MakeRule[{PA0p[c,d],Evaluate[
		PPara[c,-k]PPara[d,-l]G[k,l]/.xAct`PSALTer`PGT`Private`PADMActivate//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{PA1p[-a,-b,c,d],Evaluate[
		PPara[-a,i]PPara[-b,j]PPara[c,-k]PPara[d,-l]Antisymmetrize[G[-i,k]G[-j,l],{-i,-j}]/.xAct`PSALTer`PGT`Private`PADMActivate//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{PA2p[-a,-b,c,d],Evaluate[
		PPara[-a,i]PPara[-b,j]PPara[c,-k]PPara[d,-l](Symmetrize[G[-i,k]G[-j,l],{-i,-j}]-(1/3)G[-i,-j]G[k,l])/.xAct`PSALTer`PGT`Private`PADMActivate//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{PA0m[d,e,f],Evaluate[
		PPara[-i,d]PPara[-j,e]PPara[-k,f]epsilonG[i,j,k,g]V[-g]/.xAct`PSALTer`PGT`Private`PADMActivate//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{PA1m[-a,d,e,f],Evaluate[
		PPara[-i,d]PPara[-j,f]PPara[k,-a]PPara[-l,e]G[i,j]G[-k,l]/.xAct`PSALTer`PGT`Private`PADMActivate//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{PA2m[-a,-b,-c,d,e,f],Evaluate[
		PPara[-a,i]PPara[-b,j]PPara[-c,k]PPara[d,-l]PPara[e,-n]PPara[f,-m](3/4)((1/3)(2G[-i,l]G[-j,n]G[-k,m]-G[-j,l]G[-k,n]G[-i,m]-G[-k,l]G[-i,n]G[-j,m])-Antisymmetrize[G[-i,-k]G[-j,n]G[l,m],{-i,-j}])/.xAct`PSALTer`PGT`Private`PADMActivate//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{PB0p[c,d],Evaluate[
		PPara[c,-k]PPara[d,-l]G[k,l]/.xAct`PSALTer`PGT`Private`PADMActivate//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{PB1p[-a,-b,c,d],Evaluate[
		PPara[-a,i]PPara[-b,j]PPara[c,-k]PPara[d,-l]Antisymmetrize[G[-i,k]G[-j,l],{-i,-j}]/.xAct`PSALTer`PGT`Private`PADMActivate//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{PB1m[-a,d],Evaluate[
		PPara[d,-j]PPara[-a,i]G[-i,j]/.xAct`PSALTer`PGT`Private`PADMActivate//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{PB2p[-a,-b,c,d],Evaluate[
		PPara[-a,i]PPara[-b,j]PPara[c,-k]PPara[d,-l](Symmetrize[G[-i,k]G[-j,l],{-i,-j}]-(1/3)G[-i,-j]G[k,l])/.xAct`PSALTer`PGT`Private`PADMActivate//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*==============================*)
(*  Perpendicular and parallel  *)
(*==============================*)

xAct`PSALTer`PGT`Private`FParaSymb="\!\(\*SuperscriptBox[\(\[ScriptF]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[FPara[-a,-b],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`FParaSymb],OrthogonalTo->{V[b]},Dagger->Complex];
xAct`PSALTer`PGT`Private`AParaSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalA]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[APara[-a,-b,-c],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`AParaSymb],OrthogonalTo->{V[c]},Dagger->Complex];
xAct`PSALTer`PGT`Private`FPerpSymb="\!\(\*SuperscriptBox[\(\[ScriptF]\),\(\[UpTee]\)]\)";
DefTensor[FPerp[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`FPerpSymb],Dagger->Complex];
xAct`PSALTer`PGT`Private`APerpSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalA]\),\(\[UpTee]\)]\)";
DefTensor[APerp[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`APerpSymb],Dagger->Complex];

xAct`PSALTer`PGT`Private`GaugeDecompose=Join[
	MakeRule[{F[-a,-b],Evaluate[FPara[-a,-b]+V[-b]FPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{A[-a,-b,-c],Evaluate[APara[-a,-b,-c]+V[-c]APerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@F[-a,-b],Evaluate[Dagger@(FPara[-a,-b]+V[-b]FPerp[-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@A[-a,-b,-c],Evaluate[Dagger@(APara[-a,-b,-c]+V[-c]APerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`PGT`Private`GaugeCompose=Join[
	MakeRule[{FPara[-a,-b],Evaluate[
		PPara[-b,c]F[-a,-c]/.xAct`PSALTer`PGT`Private`PADMActivate]},MetricOn->All,ContractMetrics->True],
	MakeRule[{FPerp[-a],Evaluate[
		V[c]F[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{APara[-a,-e,-b],Evaluate[
		PPara[-b,c]A[-a,-e,-c]/.xAct`PSALTer`PGT`Private`PADMActivate]},MetricOn->All,ContractMetrics->True],
	MakeRule[{APerp[-a,-e],Evaluate[
		V[c]A[-a,-e,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPara[-a,-b],Evaluate[Dagger@(
		PPara[-b,c]F[-a,-c]/.xAct`PSALTer`PGT`Private`PADMActivate)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPerp[-a],Evaluate[Dagger@(
		V[c]F[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APara[-a,-e,-b],Evaluate[Dagger@(
		PPara[-b,c]A[-a,-e,-c]/.xAct`PSALTer`PGT`Private`PADMActivate)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APerp[-a,-e],Evaluate[Dagger@(
		V[c]A[-a,-e,-c])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`PGT`Private`TauParaSymb="\!\(\*SuperscriptBox[\(\[Tau]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[TauPara[-a,-b],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`TauParaSymb],OrthogonalTo->{V[b]},Dagger->Complex];
xAct`PSALTer`PGT`Private`SigmaParaSymb="\!\(\*SuperscriptBox[\(\[Sigma]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[SigmaPara[-c,-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`SigmaParaSymb],OrthogonalTo->{V[c]},Dagger->Complex];
xAct`PSALTer`PGT`Private`TauPerpSymb="\!\(\*SuperscriptBox[\(\[Tau]\),\(\[UpTee]\)]\)";
DefTensor[TauPerp[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`TauPerpSymb],Dagger->Complex];
xAct`PSALTer`PGT`Private`SigmaPerpSymb="\!\(\*SuperscriptBox[\(\[Sigma]\),\(\[UpTee]\)]\)";
DefTensor[SigmaPerp[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`SigmaPerpSymb],Dagger->Complex];

xAct`PSALTer`PGT`Private`SourceDecompose=Join[
	MakeRule[{Tau[-a,-b],Evaluate[
		TauPara[-a,-b]+V[-b]TauPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Sigma[-c,-a,-b],Evaluate[	
		SigmaPara[-c,-a,-b]+V[-c]SigmaPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Tau[-a,-b],Evaluate[Dagger@(	
		TauPara[-a,-b]+V[-b]TauPerp[-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Sigma[-c,-a,-b],Evaluate[Dagger@(	
		SigmaPara[-c,-a,-b]+V[-c]SigmaPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`PGT`Private`SourceCompose=Join[
	MakeRule[{TauPara[-a,-b],Evaluate[	
		PPara[-b,c]Tau[-a,-c]/.xAct`PSALTer`PGT`Private`PADMActivate]},MetricOn->All,ContractMetrics->True],
	MakeRule[{TauPerp[-a],Evaluate[
		V[c]Tau[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SigmaPara[-b,-a,-e],Evaluate[
		PPara[-b,c]Sigma[-c,-a,-e]/.xAct`PSALTer`PGT`Private`PADMActivate]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SigmaPerp[-a,-e],Evaluate[
		V[c]Sigma[-c,-a,-e]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPara[-a,-b],Evaluate[Dagger@(
		PPara[-b,c]Tau[-a,-c]/.xAct`PSALTer`PGT`Private`PADMActivate)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPerp[-a],Evaluate[Dagger@(
		V[c]Tau[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SigmaPara[-b,-a,-e],Evaluate[Dagger@(
		PPara[-b,c]Sigma[-c,-a,-e]/.xAct`PSALTer`PGT`Private`PADMActivate)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SigmaPerp[-a,-e],Evaluate[Dagger@(
		V[c]Sigma[-c,-a,-e])]},MetricOn->All,ContractMetrics->True]];

(*==============================*)
(*  Definition of SO(3) irreps  *)
(*==============================*)

DefTensor[FPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`FParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[FPara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`FParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[FPara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`FParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[FPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`FParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];

DefTensor[APara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`AParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[APara0m[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`AParaSymb,xAct`PSALTer`Private`Spin0m],Dagger->Complex];
DefTensor[APara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`AParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[APara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`AParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[APara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`AParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[APara2m[-a,-b,-c],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`AParaSymb,xAct`PSALTer`Private`Spin2m],OrthogonalTo->{V[a],V[b],V[c]},Dagger->Complex];

AutomaticRules[APara2m,MakeRule[{Evaluate@Dagger@APara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[APara2m,MakeRule[{Evaluate@Dagger[epsilonG[a,b,c,d]APara2m[-a,-b,-c]],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[FPara2p,MakeRule[{Evaluate@Dagger@FPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[APara2p,MakeRule[{Evaluate@Dagger@APara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`PGT`Private`ManualAll=Join[
	MakeRule[{Evaluate@Dagger@APara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger[epsilonG[a,b,c,d]APara2m[-a,-b,-c]],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPara2p[a,-a],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

AutomaticRules[APara2m,MakeRule[{APara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[APara2m,MakeRule[{epsilonG[a,b,c,d]APara2m[-a,-b,-c],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[FPara2p,MakeRule[{FPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[APara2p,MakeRule[{APara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

DefTensor[TauPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`TauParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[TauPara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`TauParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[TauPara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`TauParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[TauPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`TauParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];

DefTensor[SigmaPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`SigmaParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[SigmaPara0m[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`SigmaParaSymb,xAct`PSALTer`Private`Spin0m],Dagger->Complex];
DefTensor[SigmaPara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`SigmaParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[SigmaPara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`SigmaParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[SigmaPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`SigmaParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[SigmaPara2m[-a,-b,-c],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`SigmaParaSymb,xAct`PSALTer`Private`Spin2m],OrthogonalTo->{V[a],V[b],V[c]},Dagger->Complex];

AutomaticRules[SigmaPara2m,MakeRule[{Evaluate@Dagger@SigmaPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[SigmaPara2m,MakeRule[{Evaluate@Dagger[epsilonG[a,b,c,d]SigmaPara2m[-a,-b,-c]],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[TauPara2p,MakeRule[{Evaluate@Dagger@TauPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[SigmaPara2p,MakeRule[{Evaluate@Dagger@SigmaPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`PGT`Private`ManualAll=Join[xAct`PSALTer`PGT`Private`ManualAll,
	MakeRule[{Evaluate@Dagger@SigmaPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger[epsilonG[a,b,c,d]SigmaPara2m[-a,-b,-c]],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPara2p[a,-a],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SigmaPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

AutomaticRules[SigmaPara2m,MakeRule[{SigmaPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[SigmaPara2m,MakeRule[{epsilonG[a,b,c,d]SigmaPara2m[-a,-b,-c],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[TauPara2p,MakeRule[{TauPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[SigmaPara2p,MakeRule[{SigmaPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

(*==============================*)
(*  Expanding the SO(3) irreps  *)
(*==============================*)

xAct`PSALTer`PGT`Private`GaugePO3Activate=Join[
	MakeRule[{FPara0p[],Scalar[Evaluate[
		PB0p[e,f]PBPara[-e,-f,a,c]FPara[-a,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{FPara1p[-n,-m],Evaluate[
		PB1p[-n,-m,e,f]PBPara[-e,-f,a,c]FPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{FPara1m[-n],Evaluate[
		PB1m[-n,f]PBPerp[-f,a,c]FPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{FPara2p[-n,-m],Evaluate[
		PB2p[-n,-m,e,f]PBPara[-e,-f,a,c]FPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{APara0p[],Scalar[Evaluate[
		PA0p[e,f]PAPerp[-e,-f,a,b,c]APara[-a,-b,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{APara0m[],Scalar[Evaluate[
		PA0m[d,e,f]PAPara[-d,-e,-f,a,b,c]APara[-a,-b,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{APara1p[-n,-m],Evaluate[
		PA1p[-n,-m,e,f]PAPerp[-e,-f,a,b,c]APara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{APara1m[-n],Evaluate[
		PA1m[-n,d,e,f]PAPara[-d,-e,-f,a,b,c]APara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{APara2p[-n,-m],Evaluate[
		PA2p[-n,-m,e,f]PAPerp[-e,-f,a,b,c]APara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{APara2m[-n,-m,-o],Evaluate[
		PA2m[-n,-m,-o,d,e,f]PAPara[-d,-e,-f,a,b,c]APara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPara0p[],Scalar[Evaluate[Dagger@(
		PB0p[e,f]PBPara[-e,-f,a,c]FPara[-a,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPara1p[-n,-m],Evaluate[Dagger@(
		PB1p[-n,-m,e,f]PBPara[-e,-f,a,c]FPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPara1m[-n],Evaluate[Dagger@(
		PB1m[-n,f]PBPerp[-f,a,c]FPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPara2p[-n,-m],Evaluate[Dagger@(
		PB2p[-n,-m,e,f]PBPara[-e,-f,a,c]FPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APara0p[],Scalar[Evaluate[Dagger@(
		PA0p[e,f]PAPerp[-e,-f,a,b,c]APara[-a,-b,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APara0m[],Scalar[Evaluate[Dagger@(
		PA0m[d,e,f]PAPara[-d,-e,-f,a,b,c]APara[-a,-b,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APara1p[-n,-m],Evaluate[Dagger@(
		PA1p[-n,-m,e,f]PAPerp[-e,-f,a,b,c]APara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APara1m[-n],Evaluate[Dagger@(
		PA1m[-n,d,e,f]PAPara[-d,-e,-f,a,b,c]APara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APara2p[-n,-m],Evaluate[Dagger@(
		PA2p[-n,-m,e,f]PAPerp[-e,-f,a,b,c]APara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APara2m[-n,-m,-o],Evaluate[Dagger@(
		PA2m[-n,-m,-o,d,e,f]PAPara[-d,-e,-f,a,b,c]APara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True]];

DefTensor[FPerp0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`FPerpSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[FPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`FPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[APerp1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`APerpSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[APerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`APerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

xAct`PSALTer`PGT`Private`GaugePerpO3Activate=Join[
	MakeRule[{FPerp0p[],Scalar[Evaluate[
		V[a]FPerp[-a]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{FPerp1m[-n],Evaluate[
		PPara[-n,a]FPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{APerp1p[-n,-m],Evaluate[
		PPara[-n,a]PPara[-m,b]APerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{APerp1m[-n],Evaluate[
		PPara[-n,a]V[b]APerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPerp0p[],Scalar[Evaluate[Dagger@(
		V[a]FPerp[-a])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPerp1m[-n],Evaluate[Dagger@(
		PPara[-n,a]FPerp[-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APerp1p[-n,-m],Evaluate[Dagger@(
		PPara[-n,a]PPara[-m,b]APerp[-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APerp1m[-n],Evaluate[Dagger@(
		PPara[-n,a]V[b]APerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`PGT`Private`SourcePO3Activate=Join[
	MakeRule[{TauPara0p[],Scalar[Evaluate[
		PB0p[e,f]PBPara[-e,-f,a,c]TauPara[-a,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{TauPara1p[-n,-m],Evaluate[
		PB1p[-n,-m,e,f]PBPara[-e,-f,a,c]TauPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{TauPara1m[-n],Evaluate[
		PB1m[-n,f]PBPerp[-f,a,c]TauPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{TauPara2p[-n,-m],Evaluate[
		PB2p[-n,-m,e,f]PBPara[-e,-f,a,c]TauPara[-a,-c]]},MetricOn->All,ContractMetrics->True];
	MakeRule[{SigmaPara0p[],Scalar[Evaluate[
		PA0p[e,f]PAPerp[-e,-f,a,b,c]SigmaPara[-c,-a,-b]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SigmaPara0m[],Scalar[Evaluate[
		PA0m[d,e,f]PAPara[-d,-e,-f,a,b,c]SigmaPara[-c,-a,-b]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SigmaPara1p[-n,-m],Evaluate[
		PA1p[-n,-m,e,f]PAPerp[-e,-f,a,b,c]SigmaPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SigmaPara1m[-n],Evaluate[
		PA1m[-n,d,e,f]PAPara[-d,-e,-f,a,b,c]SigmaPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SigmaPara2p[-n,-m],Evaluate[
		PA2p[-n,-m,e,f]PAPerp[-e,-f,a,b,c]SigmaPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SigmaPara2m[-n,-m,-o],Evaluate[
		PA2m[-n,-m,-o,d,e,f]PAPara[-d,-e,-f,a,b,c]SigmaPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPara0p[],Scalar[Evaluate[Dagger@(
		PB0p[e,f]PBPara[-e,-f,a,c]TauPara[-a,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPara1p[-n,-m],Evaluate[Dagger@(
		PB1p[-n,-m,e,f]PBPara[-e,-f,a,c]TauPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPara1m[-n],Evaluate[Dagger@(
		PB1m[-n,f]PBPerp[-f,a,c]TauPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPara2p[-n,-m],Evaluate[Dagger@(
		PB2p[-n,-m,e,f]PBPara[-e,-f,a,c]TauPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SigmaPara0p[],Scalar[Evaluate[Dagger@(
		PA0p[e,f]PAPerp[-e,-f,a,b,c]SigmaPara[-c,-a,-b])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SigmaPara0m[],Scalar[Evaluate[Dagger@(
		PA0m[d,e,f]PAPara[-d,-e,-f,a,b,c]SigmaPara[-c,-a,-b])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SigmaPara1p[-n,-m],Evaluate[Dagger@(
		PA1p[-n,-m,e,f]PAPerp[-e,-f,a,b,c]SigmaPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SigmaPara1m[-n],Evaluate[Dagger@(
		PA1m[-n,d,e,f]PAPara[-d,-e,-f,a,b,c]SigmaPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SigmaPara2p[-n,-m],Evaluate[Dagger@(
		PA2p[-n,-m,e,f]PAPerp[-e,-f,a,b,c]SigmaPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SigmaPara2m[-n,-m,-o],Evaluate[Dagger@(
		PA2m[-n,-m,-o,d,e,f]PAPara[-d,-e,-f,a,b,c]SigmaPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True]];

DefTensor[TauPerp0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`TauPerpSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[TauPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`TauPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[SigmaPerp1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`SigmaPerpSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[SigmaPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`PGT`Private`SigmaPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

xAct`PSALTer`PGT`Private`SourcePerpO3Activate=Join[
	MakeRule[{TauPerp0p[],Scalar[Evaluate[
		V[a]TauPerp[-a]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{TauPerp1m[-n],Evaluate[
		PPara[-n,a]TauPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SigmaPerp1p[-n,-m],Evaluate[
		PPara[-n,a]PPara[-m,b]SigmaPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SigmaPerp1m[-n],Evaluate[
		PPara[-n,a]V[b]SigmaPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPerp0p[],Scalar[Evaluate[Dagger@(
		V[a]TauPerp[-a])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPerp1m[-n],Evaluate[Dagger@(
		PPara[-n,a]TauPerp[-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SigmaPerp1p[-n,-m],Evaluate[Dagger@(
		PPara[-n,a]PPara[-m,b]SigmaPerp[-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SigmaPerp1m[-n],Evaluate[Dagger@(
		PPara[-n,a]V[b]SigmaPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

(*===================*)
(*  Expand original  *)
(*===================*)

xAct`PSALTer`PGT`Private`GaugePToGaugePO3=Join[
	MakeRule[{FPara[-n,-m],Evaluate[
		((1/3)PPara[-n,-m]FPara0p[]+
		FPara1p[-n,-m]+
		FPara2p[-n,-m]+
		V[-n]FPara1m[-m])/.xAct`PSALTer`PGT`Private`PO3PiActivate/.xAct`PSALTer`PGT`Private`PADMActivate//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{APara[-n,-m,-o],Evaluate[
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)PPara[-m,-o]APara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]APara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]APara2p[-m,-o],{-n,-m}]+
		(-1/6)PA0m[-n,-m,-o]APara0m[]+
		Antisymmetrize[-PPara[-m,-o]APara1m[-n],{-m,-n}]+
		(4/3)APara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`PGT`Private`PO3PiActivate/.xAct`PSALTer`PGT`Private`PADMActivate//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPara[-n,-m],Evaluate[Dagger@(
		((1/3)PPara[-n,-m]FPara0p[]+
		FPara1p[-n,-m]+
		FPara2p[-n,-m]+
		V[-n]FPara1m[-m])/.xAct`PSALTer`PGT`Private`PO3PiActivate/.xAct`PSALTer`PGT`Private`PADMActivate//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APara[-n,-m,-o],Evaluate[Dagger@(
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)PPara[-m,-o]APara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]APara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]APara2p[-m,-o],{-n,-m}]+
		(-1/6)PA0m[-n,-m,-o]APara0m[]+
		Antisymmetrize[-PPara[-m,-o]APara1m[-n],{-m,-n}]+
		(4/3)APara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`PGT`Private`PO3PiActivate/.xAct`PSALTer`PGT`Private`PADMActivate//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`PGT`Private`GaugePerpToGaugePO3=Join[
	MakeRule[{FPerp[-n],Evaluate[FPerp0p[]V[-n]+FPerp1m[-n]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{APerp[-n,-m],Evaluate[APerp1p[-n,-m]+2Antisymmetrize[V[-m]APerp1m[-n],{-n,-m}]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPerp[-n],Evaluate[Dagger@(FPerp0p[]V[-n]+FPerp1m[-n])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APerp[-n,-m],Evaluate[Dagger@(APerp1p[-n,-m]+2Antisymmetrize[V[-m]APerp1m[-n],{-n,-m}])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`PGT`Private`SourcePToGaugePO3=Join[
	MakeRule[{TauPara[-n,-m],Evaluate[
		((1/3)PPara[-n,-m]TauPara0p[]+
		TauPara1p[-n,-m]+
		TauPara2p[-n,-m]+
		V[-n]TauPara1m[-m])/.xAct`PSALTer`PGT`Private`PO3PiActivate/.xAct`PSALTer`PGT`Private`PADMActivate//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SigmaPara[-o,-n,-m],Evaluate[
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)PPara[-m,-o]SigmaPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]SigmaPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]SigmaPara2p[-m,-o],{-n,-m}]+
		(-1/6)PA0m[-n,-m,-o]SigmaPara0m[]+
		Antisymmetrize[-PPara[-m,-o]SigmaPara1m[-n],{-m,-n}]+
		(4/3)SigmaPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`PGT`Private`PO3PiActivate/.xAct`PSALTer`PGT`Private`PADMActivate//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPara[-n,-m],Evaluate[Dagger@(
		((1/3)PPara[-n,-m]TauPara0p[]+
		TauPara1p[-n,-m]+
		TauPara2p[-n,-m]+
		V[-n]TauPara1m[-m])/.xAct`PSALTer`PGT`Private`PO3PiActivate/.xAct`PSALTer`PGT`Private`PADMActivate//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SigmaPara[-o,-n,-m],Evaluate[Dagger@(
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)PPara[-m,-o]SigmaPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]SigmaPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]SigmaPara2p[-m,-o],{-n,-m}]+
		(-1/6)PA0m[-n,-m,-o]SigmaPara0m[]+
		Antisymmetrize[-PPara[-m,-o]SigmaPara1m[-n],{-m,-n}]+
		(4/3)SigmaPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`PGT`Private`PO3PiActivate/.xAct`PSALTer`PGT`Private`PADMActivate//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`PGT`Private`SourcePerpToGaugePO3=Join[
	MakeRule[{TauPerp[-n],Evaluate[TauPerp0p[]V[-n]+TauPerp1m[-n]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SigmaPerp[-n,-m],Evaluate[SigmaPerp1p[-n,-m]+2Antisymmetrize[V[-m]SigmaPerp1m[-n],{-n,-m}]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPerp[-n],Evaluate[Dagger@(TauPerp0p[]V[-n]+TauPerp1m[-n])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SigmaPerp[-n,-m],Evaluate[Dagger@(SigmaPerp1p[-n,-m]+2Antisymmetrize[V[-m]SigmaPerp1m[-n],{-n,-m}])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`PGT`Private`Patch2m=Join[
	MakeRule[{APara2m[-a,-c,-b]APara2m[a,b,c],(1/2)APara2m[-a,-b,-c]APara2m[a,b,c]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate[Dagger@APara2m[-a,-c,-b]APara2m[a,b,c]],Evaluate[(1/2)Dagger@APara2m[-a,-b,-c]APara2m[a,b,c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate[APara2m[-a,-c,-b]Dagger@APara2m[a,b,c]],Evaluate[(1/2)APara2m[-a,-b,-c]Dagger@APara2m[a,b,c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SigmaPara2m[-a,-c,-b]SigmaPara2m[a,b,c],(1/2)SigmaPara2m[-a,-b,-c]SigmaPara2m[a,b,c]},MetricOn->All,ContractMetrics->True]];

AutomaticRules[APara2m,MakeRule[{Evaluate[APara2m[-a,-c,-b]Dagger@APara2m[a,b,c]],Evaluate[(1/2)APara2m[-a,-b,-c]Dagger@APara2m[a,b,c]]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[Evaluate[Dagger@APara2m],MakeRule[{Evaluate[Dagger@APara2m[-a,-c,-b]APara2m[a,b,c]],Evaluate[(1/2)Dagger@APara2m[-a,-b,-c]APara2m[a,b,c]]},MetricOn->All,ContractMetrics->True]];

(*===================*)
(*  Private context  *)
(*===================*)

Begin["xAct`PSALTer`PGT`Private`"];

FieldSpinParityTensorHeadsPGT=<|
		A-><|
			0-><|Even->{APara0p},Odd->{APara0m}|>,
			1-><|Even->{APara1p,APerp1p},Odd->{APara1m,APerp1m}|>,
			2-><|Even->{APara2p},Odd->{APara2m}|>
		|>,
		F-><|
			0-><|Even->{FPara0p,FPerp0p},Odd->{}|>,
			1-><|Even->{FPara1p},Odd->{FPara1m,FPerp1m}|>,
			2-><|Even->{FPara2p},Odd->{}|>
		|>
|>;

SourceSpinParityTensorHeadsPGT=<|
		Sigma-><|
			0-><|Even->{SigmaPara0p},Odd->{SigmaPara0m}|>,
			1-><|Even->{SigmaPara1p,SigmaPerp1p},Odd->{SigmaPara1m,SigmaPerp1m}|>,
			2-><|Even->{SigmaPara2p},Odd->{SigmaPara2m}|>
		|>,
		Tau-><|
			0-><|Even->{TauPara0p,TauPerp0p},Odd->{}|>,
			1-><|Even->{TauPara1p},Odd->{TauPara1m,TauPerp1m}|>,
			2-><|Even->{TauPara2p},Odd->{}|>
		|>
|>;

EngineeringDimensionsPGT=<|
		Sigma->0,
		Tau->1
|>;

DecomposeFieldsPGT[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`PGT`Private`GaugePO3Activate;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`PGT`Private`GaugePerpO3Activate;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`PGT`Private`PADMPiActivate;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`PGT`Private`PO3PiActivate;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`PGT`Private`PADMActivate;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`PGT`Private`GaugeCompose;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

FourierDecomposePGT[InputExpr_]:=Module[{Expr=InputExpr},
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`PGT`Private`GaugeDecompose;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`PGT`Private`GaugePToGaugePO3/.xAct`PSALTer`PGT`Private`GaugePerpToGaugePO3;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
	Expr=Expr/.xAct`PSALTer`PGT`Private`Patch2m;
	Expr=Expr/.xAct`PSALTer`PGT`Private`ManualAll;
	Expr=Expr/.xAct`PSALTer`PGT`Private`ManualAll;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

FirstSpeciousFunctionPGT[InputExpr_]:=Module[{Constraint=InputExpr},
	Constraint=Constraint/.xAct`PSALTer`PGT`Private`SourcePO3Activate;
	Constraint=Constraint/.xAct`PSALTer`PGT`Private`SourcePerpO3Activate;
	Constraint=Constraint/.xAct`PSALTer`PGT`Private`PADMPiActivate;
	Constraint=Constraint/.xAct`PSALTer`PGT`Private`PO3PiActivate;
	Constraint=Constraint/.xAct`PSALTer`PGT`Private`PADMActivate;
	Constraint=Constraint/.xAct`PSALTer`PGT`Private`SourceCompose;
Constraint];

SecondSpeciousFunctionPGT[InputExpr_]:=Module[{Constraint=InputExpr},
	Constraint=Constraint/.xAct`PSALTer`PGT`Private`SourceCompose;
Constraint];

ThirdSpeciousFunctionPGT[InputExpr_]:=Module[{Sector=InputExpr},
	Sector//=NoScalar;
	Sector=Sector/.xAct`PSALTer`PGT`Private`SourcePO3Activate;
	Sector//=NoScalar;
	Sector//=xAct`PSALTer`Private`ToNewCanonical;
	Sector=Sector/.xAct`PSALTer`PGT`Private`SourcePerpO3Activate;
	Sector//=NoScalar;
	Sector//=xAct`PSALTer`Private`ToNewCanonical;
	Sector=Sector/.xAct`PSALTer`PGT`Private`PADMPiActivate;
	Sector//=NoScalar;
	Sector//=xAct`PSALTer`Private`ToNewCanonical;
	Sector=Sector/.xAct`PSALTer`PGT`Private`PO3PiActivate;
	Sector//=NoScalar;
	Sector//=xAct`PSALTer`Private`ToNewCanonical;
	Sector=Sector/.xAct`PSALTer`PGT`Private`PADMActivate;
	Sector//=NoScalar;
	Sector//=xAct`PSALTer`Private`ToNewCanonical;
	Sector=Sector/.xAct`PSALTer`PGT`Private`SourceCompose;
Sector];

End[];

EndPackage[];

(*==============================*)
(*ComputePSALTerquantities*)
(*==============================*)

DefClass[
	"PGT",
	xAct`PSALTer`PGT`Private`FieldSpinParityTensorHeadsPGT,
	xAct`PSALTer`PGT`Private`SourceSpinParityTensorHeadsPGT,
	xAct`PSALTer`PGT`Private`EngineeringDimensionsPGT,
	xAct`PSALTer`PGT`Private`DecomposeFieldsPGT,
	xAct`PSALTer`PGT`Private`FourierDecomposePGT,
	xAct`PSALTer`PGT`Private`FirstSpeciousFunctionPGT,
	xAct`PSALTer`PGT`Private`SecondSpeciousFunctionPGT,
	xAct`PSALTer`PGT`Private`ThirdSpeciousFunctionPGT,
ExportClass->True];
