(*=======================*)
(*  WeylGaugeTheory  *)
(*=======================*)

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

xAct`PSALTer`WeylGaugeTheory`Private`ASymb="\[ScriptCapitalA]";
DefTensor[A[a,c,-d],M4,Antisymmetric[{a,c}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ASymb],Dagger->Complex];

xAct`PSALTer`WeylGaugeTheory`Private`SigmaSymb="\[Sigma]";
DefTensor[Sigma[-i,-j,-k],M4,Antisymmetric[{-j,-k}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`SigmaSymb],Dagger->Complex];

xAct`PSALTer`WeylGaugeTheory`Private`FSymb="\[ScriptF]";
DefTensor[F[-i,-j],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`FSymb],Dagger->Complex];

xAct`PSALTer`WeylGaugeTheory`Private`TauSymb="\[Tau](\[CapitalDelta]+\[ScriptCapitalK])";
DefTensor[Tau[-i,-j],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`TauSymb],Dagger->Complex];

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

DefTensor[ProjAPerp[-a,-b,d,e,f],M4];
DefTensor[ProjAPara[-a,-b,-c,d,e,f],M4];
DefTensor[ProjFPerp[-a,d,e],M4];
DefTensor[ProjFPara[-a,-b,d,e],M4];

xAct`PSALTer`WeylGaugeTheory`Private`ProjFAPerpParaToVG=Join[
	MakeRule[{ProjAPerp[-a,-b,d,e,f],Evaluate[
		V[d]ProjPara[-a,e]G[-b,f]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjAPara[-a,-b,-c,d,e,f],Evaluate[
		ProjPara[-a,d]ProjPara[-b,e]G[-c,f]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjFPerp[-a,d,e],Evaluate[
		V[d]G[-a,e]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjFPara[-a,-b,d,e],Evaluate[
		ProjPara[-a,d]G[-b,e]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*==============================*)
(*  Spin-parity or SO(3) parts  *)
(*==============================*)

xAct`PSALTer`WeylGaugeTheory`Private`ProjASymb="\!\(\*SubscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(\[Hacek]\)],\(\[ScriptCapitalA]\)]\)";
DefTensor[ProjA0p[c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ProjASymb,xAct`PSALTer`Private`Spin0p]];
DefTensor[ProjA0m[d,e,f],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ProjASymb,xAct`PSALTer`Private`Spin0m]];
DefTensor[ProjA1p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ProjASymb,xAct`PSALTer`Private`Spin1p]];
DefTensor[ProjA1m[-a,d,e,f],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ProjASymb,xAct`PSALTer`Private`Spin1m]];
DefTensor[ProjA2p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ProjASymb,xAct`PSALTer`Private`Spin2p]];
DefTensor[ProjA2m[-a,-b,-c,d,e,f],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ProjASymb,xAct`PSALTer`Private`Spin2m]];

xAct`PSALTer`WeylGaugeTheory`Private`ProjFSymb="\!\(\*SubscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(\[Hacek]\)],\(\[ScriptB]\)]\)";
DefTensor[ProjF0p[c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ProjFSymb,xAct`PSALTer`Private`Spin0p]];
DefTensor[ProjF1p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ProjFSymb,xAct`PSALTer`Private`Spin1p]];
DefTensor[ProjF2p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ProjFSymb,xAct`PSALTer`Private`Spin2p]];
DefTensor[ProjF1m[-a,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`ProjFSymb,xAct`PSALTer`Private`Spin1m]];

xAct`PSALTer`WeylGaugeTheory`Private`ProjFASpinParityToVG=Join[
	MakeRule[{ProjA0p[c,d],Evaluate[
		ProjPara[c,-k]ProjPara[d,-l]G[k,l]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjA1p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l]Antisymmetrize[G[-i,k]G[-j,l],{-i,-j}]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjA2p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l](Symmetrize[G[-i,k]G[-j,l],{-i,-j}]-(1/3)G[-i,-j]G[k,l])/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjA0m[d,e,f],Evaluate[
		ProjPara[-i,d]ProjPara[-j,e]ProjPara[-k,f]epsilonG[i,j,k,g]V[-g]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjA1m[-a,d,e,f],Evaluate[
		ProjPara[-i,d]ProjPara[-j,f]ProjPara[k,-a]ProjPara[-l,e]G[i,j]G[-k,l]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjA2m[-a,-b,-c,d,e,f],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[-c,k]ProjPara[d,-l]ProjPara[e,-n]ProjPara[f,-m](3/4)((1/3)(2G[-i,l]G[-j,n]G[-k,m]-G[-j,l]G[-k,n]G[-i,m]-G[-k,l]G[-i,n]G[-j,m])-Antisymmetrize[G[-i,-k]G[-j,n]G[l,m],{-i,-j}])/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjF0p[c,d],Evaluate[
		ProjPara[c,-k]ProjPara[d,-l]G[k,l]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjF1p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l]Antisymmetrize[G[-i,k]G[-j,l],{-i,-j}]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjF1m[-a,d],Evaluate[
		ProjPara[d,-j]ProjPara[-a,i]G[-i,j]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjF2p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l](Symmetrize[G[-i,k]G[-j,l],{-i,-j}]-(1/3)G[-i,-j]G[k,l])/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

(*====================================*)
(*  Field perpendicular and parallel  *)
(*====================================*)

xAct`PSALTer`WeylGaugeTheory`Private`FParaSymb="\!\(\*SuperscriptBox[\(\[ScriptF]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[FPara[-a,-b],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`FParaSymb],OrthogonalTo->{V[b]},Dagger->Complex];
xAct`PSALTer`WeylGaugeTheory`Private`AParaSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalA]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[APara[-a,-b,-c],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`AParaSymb],OrthogonalTo->{V[c]},Dagger->Complex];
xAct`PSALTer`WeylGaugeTheory`Private`FPerpSymb="\!\(\*SuperscriptBox[\(\[ScriptF]\),\(\[UpTee]\)]\)";
DefTensor[FPerp[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`FPerpSymb],Dagger->Complex];
xAct`PSALTer`WeylGaugeTheory`Private`APerpSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalA]\),\(\[UpTee]\)]\)";
DefTensor[APerp[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`APerpSymb],Dagger->Complex];

xAct`PSALTer`WeylGaugeTheory`Private`FAToFAPerpPara=Join[
	MakeRule[{F[-a,-b],Evaluate[FPara[-a,-b]+V[-b]FPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{A[-a,-b,-c],Evaluate[APara[-a,-b,-c]+V[-c]APerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@F[-a,-b],Evaluate[Dagger@(FPara[-a,-b]+V[-b]FPerp[-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@A[-a,-b,-c],Evaluate[Dagger@(APara[-a,-b,-c]+V[-c]APerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`FAPerpParaToFA=Join[
	MakeRule[{FPara[-a,-b],Evaluate[
		ProjPara[-b,c]F[-a,-c]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{FPerp[-a],Evaluate[
		V[c]F[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{APara[-a,-e,-b],Evaluate[
		ProjPara[-b,c]A[-a,-e,-c]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{APerp[-a,-e],Evaluate[
		V[c]A[-a,-e,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPara[-a,-b],Evaluate[Dagger@(
		ProjPara[-b,c]F[-a,-c]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPerp[-a],Evaluate[Dagger@(
		V[c]F[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APara[-a,-e,-b],Evaluate[Dagger@(
		ProjPara[-b,c]A[-a,-e,-c]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APerp[-a,-e],Evaluate[Dagger@(
		V[c]A[-a,-e,-c])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`TauParaSymb="\!\(\*SuperscriptBox[\(\[Tau]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[TauPara[-a,-b],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`TauParaSymb],OrthogonalTo->{V[b]},Dagger->Complex];
xAct`PSALTer`WeylGaugeTheory`Private`SigmaParaSymb="\!\(\*SuperscriptBox[\(\[Sigma]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[SigmaPara[-c,-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`SigmaParaSymb],OrthogonalTo->{V[c]},Dagger->Complex];
xAct`PSALTer`WeylGaugeTheory`Private`TauPerpSymb="\!\(\*SuperscriptBox[\(\[Tau]\),\(\[UpTee]\)]\)";
DefTensor[TauPerp[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`TauPerpSymb],Dagger->Complex];
xAct`PSALTer`WeylGaugeTheory`Private`SigmaPerpSymb="\!\(\*SuperscriptBox[\(\[Sigma]\),\(\[UpTee]\)]\)";
DefTensor[SigmaPerp[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`SigmaPerpSymb],Dagger->Complex];

xAct`PSALTer`WeylGaugeTheory`Private`TauSigmaToTauSigmaPerpPara=Join[
	MakeRule[{Tau[-a,-b],Evaluate[
		TauPara[-a,-b]+V[-b]TauPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Sigma[-c,-a,-b],Evaluate[	
		SigmaPara[-c,-a,-b]+V[-c]SigmaPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Tau[-a,-b],Evaluate[Dagger@(	
		TauPara[-a,-b]+V[-b]TauPerp[-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Sigma[-c,-a,-b],Evaluate[Dagger@(	
		SigmaPara[-c,-a,-b]+V[-c]SigmaPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`TauSigmaPerpParaToTauSigma=Join[
	MakeRule[{TauPara[-a,-b],Evaluate[	
		ProjPara[-b,c]Tau[-a,-c]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{TauPerp[-a],Evaluate[
		V[c]Tau[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SigmaPara[-b,-a,-e],Evaluate[
		ProjPara[-b,c]Sigma[-c,-a,-e]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SigmaPerp[-a,-e],Evaluate[
		V[c]Sigma[-c,-a,-e]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPara[-a,-b],Evaluate[Dagger@(
		ProjPara[-b,c]Tau[-a,-c]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPerp[-a],Evaluate[Dagger@(
		V[c]Tau[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SigmaPara[-b,-a,-e],Evaluate[Dagger@(
		ProjPara[-b,c]Sigma[-c,-a,-e]/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SigmaPerp[-a,-e],Evaluate[Dagger@(
		V[c]Sigma[-c,-a,-e])]},MetricOn->All,ContractMetrics->True]];

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

DefTensor[FPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`FParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[FPara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`FParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[FPara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`FParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[FPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`FParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];

DefTensor[APara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`AParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[APara0m[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`AParaSymb,xAct`PSALTer`Private`Spin0m],Dagger->Complex];
DefTensor[APara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`AParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[APara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`AParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[APara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`AParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[APara2m[-a,-b,-c],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`AParaSymb,xAct`PSALTer`Private`Spin2m],OrthogonalTo->{V[a],V[b],V[c]},Dagger->Complex];

AutomaticRules[APara2m,MakeRule[{Evaluate@Dagger@APara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[APara2m,MakeRule[{Evaluate@Dagger[epsilonG[a,b,c,d]APara2m[-a,-b,-c]],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[FPara2p,MakeRule[{Evaluate@Dagger@FPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[APara2p,MakeRule[{Evaluate@Dagger@APara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`ManualAll=Join[
	MakeRule[{Evaluate@Dagger@APara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger[epsilonG[a,b,c,d]APara2m[-a,-b,-c]],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPara2p[a,-a],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

AutomaticRules[APara2m,MakeRule[{APara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[APara2m,MakeRule[{epsilonG[a,b,c,d]APara2m[-a,-b,-c],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[FPara2p,MakeRule[{FPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[APara2p,MakeRule[{APara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

DefTensor[TauPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`TauParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[TauPara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`TauParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[TauPara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`TauParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[TauPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`TauParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];

DefTensor[SigmaPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`SigmaParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[SigmaPara0m[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`SigmaParaSymb,xAct`PSALTer`Private`Spin0m],Dagger->Complex];
DefTensor[SigmaPara1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`SigmaParaSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[SigmaPara1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`SigmaParaSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[SigmaPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`SigmaParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[SigmaPara2m[-a,-b,-c],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`SigmaParaSymb,xAct`PSALTer`Private`Spin2m],OrthogonalTo->{V[a],V[b],V[c]},Dagger->Complex];

AutomaticRules[SigmaPara2m,MakeRule[{Evaluate@Dagger@SigmaPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[SigmaPara2m,MakeRule[{Evaluate@Dagger[epsilonG[a,b,c,d]SigmaPara2m[-a,-b,-c]],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[TauPara2p,MakeRule[{Evaluate@Dagger@TauPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[SigmaPara2p,MakeRule[{Evaluate@Dagger@SigmaPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`ManualAll=Join[xAct`PSALTer`WeylGaugeTheory`Private`ManualAll,
	MakeRule[{Evaluate@Dagger@SigmaPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger[epsilonG[a,b,c,d]SigmaPara2m[-a,-b,-c]],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPara2p[a,-a],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SigmaPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

AutomaticRules[SigmaPara2m,MakeRule[{SigmaPara2m[a,-b,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[SigmaPara2m,MakeRule[{epsilonG[a,b,c,d]SigmaPara2m[-a,-b,-c],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[TauPara2p,MakeRule[{TauPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[SigmaPara2p,MakeRule[{SigmaPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

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

xAct`PSALTer`WeylGaugeTheory`Private`FAParaSpinParityToFA=Join[
	MakeRule[{FPara0p[],Scalar[Evaluate[
		ProjF0p[e,f]ProjFPara[-e,-f,a,c]FPara[-a,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{FPara1p[-n,-m],Evaluate[
		ProjF1p[-n,-m,e,f]ProjFPara[-e,-f,a,c]FPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{FPara1m[-n],Evaluate[
		ProjF1m[-n,f]ProjFPerp[-f,a,c]FPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{FPara2p[-n,-m],Evaluate[
		ProjF2p[-n,-m,e,f]ProjFPara[-e,-f,a,c]FPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{APara0p[],Scalar[Evaluate[
		ProjA0p[e,f]ProjAPerp[-e,-f,a,b,c]APara[-a,-b,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{APara0m[],Scalar[Evaluate[
		ProjA0m[d,e,f]ProjAPara[-d,-e,-f,a,b,c]APara[-a,-b,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{APara1p[-n,-m],Evaluate[
		ProjA1p[-n,-m,e,f]ProjAPerp[-e,-f,a,b,c]APara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{APara1m[-n],Evaluate[
		ProjA1m[-n,d,e,f]ProjAPara[-d,-e,-f,a,b,c]APara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{APara2p[-n,-m],Evaluate[
		ProjA2p[-n,-m,e,f]ProjAPerp[-e,-f,a,b,c]APara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{APara2m[-n,-m,-o],Evaluate[
		ProjA2m[-n,-m,-o,d,e,f]ProjAPara[-d,-e,-f,a,b,c]APara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPara0p[],Scalar[Evaluate[Dagger@(
		ProjF0p[e,f]ProjFPara[-e,-f,a,c]FPara[-a,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPara1p[-n,-m],Evaluate[Dagger@(
		ProjF1p[-n,-m,e,f]ProjFPara[-e,-f,a,c]FPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPara1m[-n],Evaluate[Dagger@(
		ProjF1m[-n,f]ProjFPerp[-f,a,c]FPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPara2p[-n,-m],Evaluate[Dagger@(
		ProjF2p[-n,-m,e,f]ProjFPara[-e,-f,a,c]FPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APara0p[],Scalar[Evaluate[Dagger@(
		ProjA0p[e,f]ProjAPerp[-e,-f,a,b,c]APara[-a,-b,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APara0m[],Scalar[Evaluate[Dagger@(
		ProjA0m[d,e,f]ProjAPara[-d,-e,-f,a,b,c]APara[-a,-b,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APara1p[-n,-m],Evaluate[Dagger@(
		ProjA1p[-n,-m,e,f]ProjAPerp[-e,-f,a,b,c]APara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APara1m[-n],Evaluate[Dagger@(
		ProjA1m[-n,d,e,f]ProjAPara[-d,-e,-f,a,b,c]APara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APara2p[-n,-m],Evaluate[Dagger@(
		ProjA2p[-n,-m,e,f]ProjAPerp[-e,-f,a,b,c]APara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APara2m[-n,-m,-o],Evaluate[Dagger@(
		ProjA2m[-n,-m,-o,d,e,f]ProjAPara[-d,-e,-f,a,b,c]APara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True]];

DefTensor[FPerp0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`FPerpSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[FPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`FPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[APerp1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`APerpSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[APerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`APerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

xAct`PSALTer`WeylGaugeTheory`Private`FAPerpSpinParityToFA=Join[
	MakeRule[{FPerp0p[],Scalar[Evaluate[
		V[a]FPerp[-a]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{FPerp1m[-n],Evaluate[
		ProjPara[-n,a]FPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{APerp1p[-n,-m],Evaluate[
		ProjPara[-n,a]ProjPara[-m,b]APerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{APerp1m[-n],Evaluate[
		ProjPara[-n,a]V[b]APerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPerp0p[],Scalar[Evaluate[Dagger@(
		V[a]FPerp[-a])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]FPerp[-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APerp1p[-n,-m],Evaluate[Dagger@(
		ProjPara[-n,a]ProjPara[-m,b]APerp[-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]V[b]APerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`TauSigmaParaSpinParityToTauSigma=Join[
	MakeRule[{TauPara0p[],Scalar[Evaluate[
		ProjF0p[e,f]ProjFPara[-e,-f,a,c]TauPara[-a,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{TauPara1p[-n,-m],Evaluate[
		ProjF1p[-n,-m,e,f]ProjFPara[-e,-f,a,c]TauPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{TauPara1m[-n],Evaluate[
		ProjF1m[-n,f]ProjFPerp[-f,a,c]TauPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{TauPara2p[-n,-m],Evaluate[
		ProjF2p[-n,-m,e,f]ProjFPara[-e,-f,a,c]TauPara[-a,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SigmaPara0p[],Scalar[Evaluate[
		ProjA0p[e,f]ProjAPerp[-e,-f,a,b,c]SigmaPara[-c,-a,-b]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SigmaPara0m[],Scalar[Evaluate[
		ProjA0m[d,e,f]ProjAPara[-d,-e,-f,a,b,c]SigmaPara[-c,-a,-b]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SigmaPara1p[-n,-m],Evaluate[
		ProjA1p[-n,-m,e,f]ProjAPerp[-e,-f,a,b,c]SigmaPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SigmaPara1m[-n],Evaluate[
		ProjA1m[-n,d,e,f]ProjAPara[-d,-e,-f,a,b,c]SigmaPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SigmaPara2p[-n,-m],Evaluate[
		ProjA2p[-n,-m,e,f]ProjAPerp[-e,-f,a,b,c]SigmaPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SigmaPara2m[-n,-m,-o],Evaluate[
		ProjA2m[-n,-m,-o,d,e,f]ProjAPara[-d,-e,-f,a,b,c]SigmaPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPara0p[],Scalar[Evaluate[Dagger@(
		ProjF0p[e,f]ProjFPara[-e,-f,a,c]TauPara[-a,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPara1p[-n,-m],Evaluate[Dagger@(
		ProjF1p[-n,-m,e,f]ProjFPara[-e,-f,a,c]TauPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPara1m[-n],Evaluate[Dagger@(
		ProjF1m[-n,f]ProjFPerp[-f,a,c]TauPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPara2p[-n,-m],Evaluate[Dagger@(
		ProjF2p[-n,-m,e,f]ProjFPara[-e,-f,a,c]TauPara[-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SigmaPara0p[],Scalar[Evaluate[Dagger@(
		ProjA0p[e,f]ProjAPerp[-e,-f,a,b,c]SigmaPara[-c,-a,-b])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SigmaPara0m[],Scalar[Evaluate[Dagger@(
		ProjA0m[d,e,f]ProjAPara[-d,-e,-f,a,b,c]SigmaPara[-c,-a,-b])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SigmaPara1p[-n,-m],Evaluate[Dagger@(
		ProjA1p[-n,-m,e,f]ProjAPerp[-e,-f,a,b,c]SigmaPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SigmaPara1m[-n],Evaluate[Dagger@(
		ProjA1m[-n,d,e,f]ProjAPara[-d,-e,-f,a,b,c]SigmaPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SigmaPara2p[-n,-m],Evaluate[Dagger@(
		ProjA2p[-n,-m,e,f]ProjAPerp[-e,-f,a,b,c]SigmaPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SigmaPara2m[-n,-m,-o],Evaluate[Dagger@(
		ProjA2m[-n,-m,-o,d,e,f]ProjAPara[-d,-e,-f,a,b,c]SigmaPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True]];

DefTensor[TauPerp0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`TauPerpSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[TauPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`TauPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
DefTensor[SigmaPerp1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`SigmaPerpSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[SigmaPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`SigmaPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

xAct`PSALTer`WeylGaugeTheory`Private`TauSigmaPerpSpinParityToTauSigma=Join[
	MakeRule[{TauPerp0p[],Scalar[Evaluate[
		V[a]TauPerp[-a]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{TauPerp1m[-n],Evaluate[
		ProjPara[-n,a]TauPerp[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SigmaPerp1p[-n,-m],Evaluate[
		ProjPara[-n,a]ProjPara[-m,b]SigmaPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SigmaPerp1m[-n],Evaluate[
		ProjPara[-n,a]V[b]SigmaPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPerp0p[],Scalar[Evaluate[Dagger@(
		V[a]TauPerp[-a])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]TauPerp[-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SigmaPerp1p[-n,-m],Evaluate[Dagger@(
		ProjPara[-n,a]ProjPara[-m,b]SigmaPerp[-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SigmaPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]V[b]SigmaPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

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

xAct`PSALTer`WeylGaugeTheory`Private`FAParaToFAParaSpinParity=Join[
	MakeRule[{FPara[-n,-m],Evaluate[
		((1/3)ProjPara[-n,-m]FPara0p[]+
		FPara1p[-n,-m]+
		FPara2p[-n,-m]+
		V[-n]FPara1m[-m])/.xAct`PSALTer`WeylGaugeTheory`Private`ProjFASpinParityToVG/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{APara[-n,-m,-o],Evaluate[
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]APara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]APara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]APara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjA0m[-n,-m,-o]APara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]APara1m[-n],{-m,-n}]+
		(4/3)APara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`WeylGaugeTheory`Private`ProjFASpinParityToVG/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPara[-n,-m],Evaluate[Dagger@(
		((1/3)ProjPara[-n,-m]FPara0p[]+
		FPara1p[-n,-m]+
		FPara2p[-n,-m]+
		V[-n]FPara1m[-m])/.xAct`PSALTer`WeylGaugeTheory`Private`ProjFASpinParityToVG/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APara[-n,-m,-o],Evaluate[Dagger@(
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]APara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]APara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]APara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjA0m[-n,-m,-o]APara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]APara1m[-n],{-m,-n}]+
		(4/3)APara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`WeylGaugeTheory`Private`ProjFASpinParityToVG/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`FAPerpToFAPerpSpinParity=Join[
	MakeRule[{FPerp[-n],Evaluate[FPerp0p[]V[-n]+FPerp1m[-n]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{APerp[-n,-m],Evaluate[APerp1p[-n,-m]+2Antisymmetrize[V[-m]APerp1m[-n],{-n,-m}]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@FPerp[-n],Evaluate[Dagger@(FPerp0p[]V[-n]+FPerp1m[-n])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APerp[-n,-m],Evaluate[Dagger@(APerp1p[-n,-m]+2Antisymmetrize[V[-m]APerp1m[-n],{-n,-m}])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`TauSigmaParaToTauSigmaParaSpinParity=Join[
	MakeRule[{TauPara[-n,-m],Evaluate[
		((1/3)ProjPara[-n,-m]TauPara0p[]+
		TauPara1p[-n,-m]+
		TauPara2p[-n,-m]+
		V[-n]TauPara1m[-m])/.xAct`PSALTer`WeylGaugeTheory`Private`ProjFASpinParityToVG/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SigmaPara[-o,-n,-m],Evaluate[
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]SigmaPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]SigmaPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]SigmaPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjA0m[-n,-m,-o]SigmaPara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]SigmaPara1m[-n],{-m,-n}]+
		(4/3)SigmaPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`WeylGaugeTheory`Private`ProjFASpinParityToVG/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPara[-n,-m],Evaluate[Dagger@(
		((1/3)ProjPara[-n,-m]TauPara0p[]+
		TauPara1p[-n,-m]+
		TauPara2p[-n,-m]+
		V[-n]TauPara1m[-m])/.xAct`PSALTer`WeylGaugeTheory`Private`ProjFASpinParityToVG/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SigmaPara[-o,-n,-m],Evaluate[Dagger@(
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]SigmaPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]SigmaPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]SigmaPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjA0m[-n,-m,-o]SigmaPara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]SigmaPara1m[-n],{-m,-n}]+
		(4/3)SigmaPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`WeylGaugeTheory`Private`ProjFASpinParityToVG/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`TauSigmaPerpToTauSigmaPerpSpinParity=Join[
	MakeRule[{TauPerp[-n],Evaluate[TauPerp0p[]V[-n]+TauPerp1m[-n]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SigmaPerp[-n,-m],Evaluate[SigmaPerp1p[-n,-m]+2Antisymmetrize[V[-m]SigmaPerp1m[-n],{-n,-m}]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@TauPerp[-n],Evaluate[Dagger@(TauPerp0p[]V[-n]+TauPerp1m[-n])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SigmaPerp[-n,-m],Evaluate[Dagger@(SigmaPerp1p[-n,-m]+2Antisymmetrize[V[-m]SigmaPerp1m[-n],{-n,-m}])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`Patch2m=Join[
	MakeRule[{APara2m[-a,-c,-b]APara2m[a,b,c],(1/2)APara2m[-a,-b,-c]APara2m[a,b,c]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate[Dagger@APara2m[-a,-c,-b]APara2m[a,b,c]],Evaluate[(1/2)Dagger@APara2m[-a,-b,-c]APara2m[a,b,c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate[APara2m[-a,-c,-b]Dagger@APara2m[a,b,c]],Evaluate[(1/2)APara2m[-a,-b,-c]Dagger@APara2m[a,b,c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SigmaPara2m[-a,-c,-b]SigmaPara2m[a,b,c],(1/2)SigmaPara2m[-a,-b,-c]SigmaPara2m[a,b,c]},MetricOn->All,ContractMetrics->True]];

AutomaticRules[APara2m,MakeRule[{Evaluate[APara2m[-a,-c,-b]Dagger@APara2m[a,b,c]],Evaluate[(1/2)APara2m[-a,-b,-c]Dagger@APara2m[a,b,c]]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[Evaluate[Dagger@APara2m],MakeRule[{Evaluate[Dagger@APara2m[-a,-c,-b]APara2m[a,b,c]],Evaluate[(1/2)Dagger@APara2m[-a,-b,-c]APara2m[a,b,c]]},MetricOn->All,ContractMetrics->True]];

(*==========================================================*)
(*  Basic definitions of the Lagrangian coupling constants  *)
(*==========================================================*)

xAct`PSALTer`WeylGaugeTheory`Private`kRSymb="\[ScriptR]";
xAct`PSALTer`WeylGaugeTheory`Private`kLambdaSymb="\[Lambda]";
DefConstantSymbol[kLambda,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`kLambdaSymb,xAct`PSALTer`Private`dSOX,xAct`PSALTer`Private`IsConstantSymbol->True]];
DefConstantSymbol[kR1,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`kRSymb,xAct`PSALTer`Private`dSO1,xAct`PSALTer`Private`IsConstantSymbol->True]];
DefConstantSymbol[kR2,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`kRSymb,xAct`PSALTer`Private`dSO2,xAct`PSALTer`Private`IsConstantSymbol->True]];
DefConstantSymbol[kR3,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`kRSymb,xAct`PSALTer`Private`dSO3,xAct`PSALTer`Private`IsConstantSymbol->True]];
DefConstantSymbol[kR4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`kRSymb,xAct`PSALTer`Private`dSO4,xAct`PSALTer`Private`IsConstantSymbol->True]];
DefConstantSymbol[kR5,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`kRSymb,xAct`PSALTer`Private`dSO5,xAct`PSALTer`Private`IsConstantSymbol->True]];
DefConstantSymbol[kR6,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`kRSymb,xAct`PSALTer`Private`dSO6,xAct`PSALTer`Private`IsConstantSymbol->True]];

xAct`PSALTer`WeylGaugeTheory`Private`kTSymb="\[ScriptT]";
DefConstantSymbol[kT1,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`kTSymb,xAct`PSALTer`Private`dSO1,xAct`PSALTer`Private`IsConstantSymbol->True]];
DefConstantSymbol[kT2,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`kTSymb,xAct`PSALTer`Private`dSO2,xAct`PSALTer`Private`IsConstantSymbol->True]];
DefConstantSymbol[kT3,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`kTSymb,xAct`PSALTer`Private`dSO3,xAct`PSALTer`Private`IsConstantSymbol->True]];
DefConstantSymbol[kT4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`kTSymb,xAct`PSALTer`Private`dSO4,xAct`PSALTer`Private`IsConstantSymbol->True]];
DefConstantSymbol[kT5,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`kTSymb,xAct`PSALTer`Private`dSO5,xAct`PSALTer`Private`IsConstantSymbol->True]];
DefConstantSymbol[kT6,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`kTSymb,xAct`PSALTer`Private`dSO6,xAct`PSALTer`Private`IsConstantSymbol->True]];

(*================================================*)
(*  Some infrastructure for linearising theories  *)
(*================================================*)

xAct`PSALTer`WeylGaugeTheory`Private`RSymb="\[ScriptCapitalR]";
DefTensor[R[a, b, -d, -e], M4, {Antisymmetric[{a, b}], Antisymmetric[{-d, -e}]},PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`RSymb]]; 
xAct`PSALTer`WeylGaugeTheory`Private`TSymb="\[ScriptCapitalT]";
DefTensor[T[a, -b, -c], M4, Antisymmetric[{-b, -c}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`TSymb]]; 

xAct`PSALTer`WeylGaugeTheory`Private`HSymb="\[ScriptH]";
DefTensor[H[-a,c],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`HSymb]];
xAct`PSALTer`WeylGaugeTheory`Private`BSymb="\[ScriptB]";
DefTensor[B[a,-c],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`WeylGaugeTheory`Private`BSymb]];

xAct`PSALTer`WeylGaugeTheory`Private`HBToGF=Join[
	MakeRule[{H[-i,-j],G[-i,-j]+F[-i,-j]},MetricOn->All,ContractMetrics->True],
	MakeRule[{B[-i,-j],G[-i,-j]-F[-j,-i]+F[-i,-m]F[m,-j]},MetricOn->All,ContractMetrics->True]
];

AutomaticRules[H,MakeRule[{H[-a,i]B[a,-j],G[i,-j]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[H,MakeRule[{H[-a,i]B[c,-i],G[-a,c]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[H,MakeRule[{CD[-a][H[-j,n]],Evaluate[-H[-i,n]H[-j,m]CD[-a][B[i,-m]]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`WeylGaugeTheory`Private`RTToHBACDBCDA=Join[	
	MakeRule[{R[a,b,-d,-e],H[-d,i]H[-e,j](CD[-i][A[a,b,-j]]-CD[-j][A[a,b,-i]]+A[a,-k,-i]A[k,b,-j]-A[a,-k,-j]A[k,b,-i])},MetricOn->All,ContractMetrics->True],
	MakeRule[{T[a,-b,-c],H[-b,i]H[-c,j](CD[-i][B[a,-j]]-CD[-j][B[a,-i]]+A[a,-k,-i]B[k,-j]-A[a,-k,-j]B[k,-i])},MetricOn->All,ContractMetrics->True]
];

(*===================*)
(*  Private context  *)
(*===================*)

Begin["xAct`PSALTer`WeylGaugeTheory`Private`"];

FieldSpinParityTensorHeads=<|
		WeylVector-><|
			0-><|Even->{WeylVector0p},Odd->{}|>,
			1-><|Even->{},Odd->{WeylVector1m}|>
		|>,
		Compensator-><|
			0-><|Even->{Compensator0p},Odd->{}|>
		|>,
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

SourceSpinParityTensorHeads=<|
		ConjugateSourceWeylVector-><|
			0-><|Even->{ConjugateSourceWeylVector0p},Odd->{}|>,
			1-><|Even->{},Odd->{ConjugateSourceWeylVector1m}|>
		|>,
		ConjugateSourceCompensator-><|
			0-><|Even->{ConjugateSourceCompensator0p},Odd->{}|>
		|>,
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

SourceEngineeringDimensions=<|
		Sigma->0,
		Tau->1
|>;

ExpandFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`WeylVectorSpinParityToWeylVector;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`CompensatorSpinParityToCompensator;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`FAParaSpinParityToFA;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`FAPerpSpinParityToFA;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`ProjFAPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`ProjFASpinParityToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`FAPerpParaToFA;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

ExpandSources[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceWeylVectorSpinParityToConjugateSourceWeylVector;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`ConjugateSourceCompensatorSpinParityToConjugateSourceCompensator;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`TauSigmaParaSpinParityToTauSigma;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`TauSigmaPerpSpinParityToTauSigma;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`ProjFAPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`ProjFASpinParityToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`ProjPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`TauSigmaPerpParaToTauSigma;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
Expr];

DecomposeFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`WeylVectorToWeylVectorSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`CompensatorToCompensatorSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`FAToFAPerpPara;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`FAParaToFAParaSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`WeylGaugeTheory`Private`FAPerpToFAPerpSpinParity;
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
	xAct`PSALTer`WeylGaugeTheory`Private`FieldSpinParityTensorHeads,
	xAct`PSALTer`WeylGaugeTheory`Private`SourceSpinParityTensorHeads,
	xAct`PSALTer`WeylGaugeTheory`Private`SourceEngineeringDimensions,
	xAct`PSALTer`WeylGaugeTheory`Private`ExpandFields,
	xAct`PSALTer`WeylGaugeTheory`Private`DecomposeFields,
	xAct`PSALTer`WeylGaugeTheory`Private`ExpandSources,
ExportClass->True];
