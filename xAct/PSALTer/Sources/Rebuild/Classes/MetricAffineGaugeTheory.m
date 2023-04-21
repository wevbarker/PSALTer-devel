(*===========================*)
(*  MetricAffineGaugeTheory  *)
(*===========================*)

BeginPackage["xAct`PSALTer`MetricAffineGaugeTheory`",{"xAct`xTensor`","xAct`xPerm`","xAct`xCore`","xAct`xTras`","xAct`xCoba`","xAct`PSALTer`"}];

(*=================================================================*)
(*  Basic definitions of gauge fields and their conjugate sources  *)
(*=================================================================*)

(*-------------------------------------------------------------------------------------------------------------------*)
(*  Will: Basic definitions of the symmetric metric perturbation and its conjugate source, the stress-energy tensor  *)
(*-------------------------------------------------------------------------------------------------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`LinearMetricSymb="\[ScriptH]";
DefTensor[LinearMetric[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`LinearMetricSymb],Dagger->Complex];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceLinearMetricSymb="\[ScriptCapitalT]";
DefTensor[ConjugateSourceLinearMetric[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceLinearMetricSymb],Dagger->Complex];

(*-----------------------------------------------------------------------------------------------------------------------------------------*)
(*  Will: Basic definitions of the asymmetric connection and its conjugate source "dilatospin", a portmanteau of dilaton current and spin  *)
(*-----------------------------------------------------------------------------------------------------------------------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymb="\[ScriptCapitalA]";
DefTensor[Connection[-i,-j,-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymb],Dagger->Complex];

xAct`PSALTer`MetricAffineGaugeTheory`Private`DilatospinSymb="\[ScriptCapitalW]";
DefTensor[Dilatospin[-i,-j,-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`DilatospinSymb],Dagger->Complex];

(*------------------------------------------------------------*)
(*  Will: Basic definitions of antisymmetric parts of fields  *)
(*------------------------------------------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`ASymb="\[ScriptCapitalA]";
DefTensor[A[a,c,-d],M4,Antisymmetric[{a,c}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ASymb],Dagger->Complex];

xAct`PSALTer`MetricAffineGaugeTheory`Private`YSymb="\[ScriptCapitalY]";
DefTensor[Y[-i,-j,-k],M4,Antisymmetric[{-j,-k}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`YSymb],Dagger->Complex];

(*----------------------------------------------------------------------------------------------*)
(*  Zhiyuan: Basic definitions of metric affine gauge fields(Q) and their conjugate sources(Z)  *)
(*----------------------------------------------------------------------------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`QSymb="\[ScriptCapitalQ]";
DefTensor[Q[-i,-j,-a],M4, Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`QSymb],Dagger->Complex];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ZSymb="\[ScriptCapitalZ]";
DefTensor[Z[-i,-j,-a],M4, Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ZSymb],Dagger->Complex];

(*----------------------------*)
(*  Will: combination script  *)
(*----------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionToAQ=Join[
	MakeRule[{Connection[-c,-a,-b],Evaluate[A[-a,-b,-c]+Q[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Connection[-c,-a,-b],Evaluate@Dagger[A[-a,-b,-c]+Q[-a,-b,-c]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`DilatospinToYZ=Join[
	MakeRule[{Dilatospin[-c,-a,-b],Evaluate[Y[-c,-a,-b]+Z[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Dilatospin[-c,-a,-b],Evaluate@Dagger[Y[-c,-a,-b]+Z[-a,-b,-c]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`AQToConnection=Join[
	MakeRule[{A[-a,-b,-c],Evaluate[(1/2)*(Connection[-c,-a,-b]-Connection[-c,-b,-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Q[-a,-b,-c],Evaluate[(1/2)*(Connection[-c,-a,-b]+Connection[-c,-b,-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@A[-a,-b,-c],Evaluate@Dagger[(1/2)*(Connection[-c,-a,-b]-Connection[-c,-b,-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Q[-a,-b,-c],Evaluate@Dagger[(1/2)*(Connection[-c,-a,-b]+Connection[-c,-b,-a])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`YZToDilatospin=Join[
	MakeRule[{Y[-c,-a,-b],Evaluate[(1/2)*(Dilatospin[-c,-a,-b]-Dilatospin[-c,-b,-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Z[-a,-b,-c],Evaluate[(1/2)*(Dilatospin[-c,-a,-b]+Dilatospin[-c,-b,-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Y[-c,-a,-b],Evaluate@Dagger[(1/2)*(Dilatospin[-c,-a,-b]-Dilatospin[-c,-b,-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Z[-a,-b,-c],Evaluate@Dagger[(1/2)*(Dilatospin[-c,-a,-b]+Dilatospin[-c,-b,-a])]},MetricOn->All,ContractMetrics->True]];

(*==============*)
(*  Projectors  *)
(*==============*)

(*----------------------------------------------------------------------------------*)
(*  Zhiyuan: Metric affine projectors into total and hook symmetric parts from Q,Z  *)
(*----------------------------------------------------------------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`totsymQZSymb="\!\(\*SubscriptBox[\[CapitalPi],\(ts\)]\)";
DefTensor[totsymQZ[k,l,b,-i,-j,-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`totsymQZSymb]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`remsymQZSymb="\!\(\*SubscriptBox[\[CapitalPi],\(hs\)]\)";
DefTensor[remsymQZ[k,l,b,-i,-j,-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`remsymQZSymb]];

AutomaticRules[totsymQZ,MakeRule[{totsymQZ[k,l,b,-i,-j,-a],Evaluate[(1/3)G[k,-i]G[l,-j]G[b,-a] +(1/3)G[k,-j]G[l,-a]G[b,-i] +(1/3)G[k,-i]G[l,-a]G[b,-j]]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[remsymQZ,MakeRule[{remsymQZ[k,l,b,-i,-j,-a],Evaluate[(2/3)G[k,-i]G[l,-j]G[b,-a] -(1/3)G[k,-j]G[l,-a]G[b,-i] -(1/3)G[k,-i]G[l,-a]G[b,-j]]},MetricOn->All,ContractMetrics->True]];

(*---------------------------------------------*)
(*  Zhiyuan: Basic perpendicular and parallel  *)
(*---------------------------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[UpTee]\)]\)";
DefTensor[ProjPerp[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpSymb]];
xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjParaSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[DoubleVerticalBar]\)]\)";
DefTensor[ProjPara[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjParaSymb]];

(*------------------------------------*)
(*  Will: a rule to invert the above  *)
(*------------------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG=Join[
	MakeRule[{ProjPerp[-a,b],Evaluate[V[-a]V[b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjPara[-a,b],Evaluate[G[-a,b]-V[-a]V[b]]},MetricOn->All,ContractMetrics->True]];

AutomaticRules[ProjPerp,MakeRule[{ProjPerp[-a,b],Evaluate[V[-a]V[b]]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ProjPara,MakeRule[{ProjPara[-a,b],Evaluate[G[-a,b]-V[-a]V[b]]},MetricOn->All,ContractMetrics->True]];

(*------------------------------------------*)
(*  Will: field perpendicular and parallel  *)
(*------------------------------------------*)

DefTensor[ProjAPerp[-a,-b,d,e,f],M4];
DefTensor[ProjAPara[-a,-b,-c,d,e,f],M4];
DefTensor[ProjFPerp[-a,d,e],M4];
DefTensor[ProjFPara[-a,-b,d,e],M4];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjAPerpParaToVG=Join[
	MakeRule[{ProjAPerp[-a,-b,d,e,f],Evaluate[
		V[d]ProjPara[-a,e]G[-b,f]/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjAPara[-a,-b,-c,d,e,f],Evaluate[
		ProjPara[-a,d]ProjPara[-b,e]G[-c,f]/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjFPerp[-a,d,e],Evaluate[
		V[d]G[-a,e]/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjFPara[-a,-b,d,e],Evaluate[
		ProjPara[-a,d]G[-b,e]/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*------------------------------------*)
(*  Will: Spin-parity or SO(3) parts  *)
(*------------------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjASymb="\!\(\*SubscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(\[Hacek]\)],\(\[ScriptCapitalA]\)]\)";
DefTensor[ProjA0p[c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjASymb,xAct`PSALTer`Private`Spin0p]];
DefTensor[ProjA0m[d,e,f],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjASymb,xAct`PSALTer`Private`Spin0m]];
DefTensor[ProjA1p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjASymb,xAct`PSALTer`Private`Spin1p]];
DefTensor[ProjA1m[-a,d,e,f],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjASymb,xAct`PSALTer`Private`Spin1m]];
DefTensor[ProjA2p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjASymb,xAct`PSALTer`Private`Spin2p]];
DefTensor[ProjA2m[-a,-b,-c,d,e,f],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjASymb,xAct`PSALTer`Private`Spin2m]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjASpinParityToVG=Join[
	MakeRule[{ProjA0p[c,d],Evaluate[
		ProjPara[c,-k]ProjPara[d,-l]G[k,l]/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjA1p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l]Antisymmetrize[G[-i,k]G[-j,l],{-i,-j}]/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjA2p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l](Symmetrize[G[-i,k]G[-j,l],{-i,-j}]-(1/3)G[-i,-j]G[k,l])/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjA0m[d,e,f],Evaluate[
		ProjPara[-i,d]ProjPara[-j,e]ProjPara[-k,f]epsilonG[i,j,k,g]V[-g]/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjA1m[-a,d,e,f],Evaluate[
		ProjPara[-i,d]ProjPara[-j,f]ProjPara[k,-a]ProjPara[-l,e]G[i,j]G[-k,l]/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjA2m[-a,-b,-c,d,e,f],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[-c,k]ProjPara[d,-l]ProjPara[e,-n]ProjPara[f,-m](3/4)((1/3)(2G[-i,l]G[-j,n]G[-k,m]-G[-j,l]G[-k,n]G[-i,m]-G[-k,l]G[-i,n]G[-j,m])-Antisymmetrize[G[-i,-k]G[-j,n]G[l,m],{-i,-j}])/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

(*---------------------------------------------------------------------------*)
(*  Will: decomposition of asymmetric part field perpendicular and parallel  *)
(*---------------------------------------------------------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`AParaSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalA]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[APara[-a,-b,-c],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`AParaSymb],OrthogonalTo->{V[c]},Dagger->Complex];
xAct`PSALTer`MetricAffineGaugeTheory`Private`APerpSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalA]\),\(\[UpTee]\)]\)";
DefTensor[APerp[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`APerpSymb],Dagger->Complex];

xAct`PSALTer`MetricAffineGaugeTheory`Private`AToAPerpPara=Join[
	MakeRule[{A[-a,-b,-c],Evaluate[APara[-a,-b,-c]+V[-c]APerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@A[-a,-b,-c],Evaluate[Dagger@(APara[-a,-b,-c]+V[-c]APerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`APerpParaToA=Join[
	MakeRule[{APara[-a,-e,-b],Evaluate[
		ProjPara[-b,c]A[-a,-e,-c]/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{APerp[-a,-e],Evaluate[
		V[c]A[-a,-e,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APara[-a,-e,-b],Evaluate[Dagger@(
		ProjPara[-b,c]A[-a,-e,-c]/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APerp[-a,-e],Evaluate[Dagger@(
		V[c]A[-a,-e,-c])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceAParaSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalY]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[ConjugateSourceAPara[-c,-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceAParaSymb],OrthogonalTo->{V[c]},Dagger->Complex];
xAct`PSALTer`MetricAffineGaugeTheory`Private`YPerpSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalY]\),\(\[UpTee]\)]\)";
DefTensor[YPerp[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`YPerpSymb],Dagger->Complex];

xAct`PSALTer`MetricAffineGaugeTheory`Private`YToYPerpPara=Join[
	MakeRule[{Y[-c,-a,-b],Evaluate[	
		ConjugateSourceAPara[-c,-a,-b]+V[-c]YPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Y[-c,-a,-b],Evaluate[Dagger@(	
		ConjugateSourceAPara[-c,-a,-b]+V[-c]YPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`YPerpParaToY=Join[
	MakeRule[{ConjugateSourceAPara[-b,-a,-e],Evaluate[
		ProjPara[-b,c]Y[-c,-a,-e]/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{YPerp[-a,-e],Evaluate[
		V[c]Y[-c,-a,-e]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceAPara[-b,-a,-e],Evaluate[Dagger@(
		ProjPara[-b,c]Y[-c,-a,-e]/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@YPerp[-a,-e],Evaluate[Dagger@(
		V[c]Y[-c,-a,-e])]},MetricOn->All,ContractMetrics->True]];

(*-------------------------------------------------------------------*)
(*  Zhiyuan: decomposition of Q,Z into full-indexed spin components  *)
(*-------------------------------------------------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`QParaSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalQ]\),\(\[DoubleVerticalBar]\)]\)";
xAct`PSALTer`MetricAffineGaugeTheory`Private`QParaTSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalQ]\),\(\[DoubleVerticalBar]t\)]\)";
xAct`PSALTer`MetricAffineGaugeTheory`Private`QParaHSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalQ]\),\(\[DoubleVerticalBar]h\)]\)";

xAct`PSALTer`MetricAffineGaugeTheory`Private`QPerpSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalQ]\),\(\[UpTee]\)]\)";
xAct`PSALTer`MetricAffineGaugeTheory`Private`QPerpTSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalQ]\),\(\[UpTee]t\)]\)";
xAct`PSALTer`MetricAffineGaugeTheory`Private`QPerpHSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalQ]\),\(\[UpTee]h\)]\)";

xAct`PSALTer`MetricAffineGaugeTheory`Private`ZParaSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalZ]\),\(\[DoubleVerticalBar]\)]\)";
xAct`PSALTer`MetricAffineGaugeTheory`Private`ZParaTSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalZ]\),\(\[DoubleVerticalBar]t\)]\)";
xAct`PSALTer`MetricAffineGaugeTheory`Private`ZParaHSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalZ]\),\(\[DoubleVerticalBar]h\)]\)";

xAct`PSALTer`MetricAffineGaugeTheory`Private`ZPerpSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalZ]\),\(\[UpTee]\)]\)";
xAct`PSALTer`MetricAffineGaugeTheory`Private`ZPerpTSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalZ]\),\(\[UpTee]t\)]\)";
xAct`PSALTer`MetricAffineGaugeTheory`Private`ZPerpHSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalZ]\),\(\[UpTee]h\)]\)";

DefTensor[QPerpT0pF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`QPerpTSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[QPerpT1mF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`QPerpTSymb,xAct`PSALTer`Private`Spin1m],Dagger->Complex];
DefTensor[QPara0pF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`QParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[QPara2pF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`QParaSymb,xAct`PSALTer`Private`Spin2p],Dagger->Complex];
DefTensor[QParaT1mF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`QParaTSymb,xAct`PSALTer`Private`Spin1m],Dagger->Complex];
DefTensor[QPara3mF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`QParaSymb,xAct`PSALTer`Private`Spin3m],Dagger->Complex];
DefTensor[QPerpH1mF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`QPerpHSymb,xAct`PSALTer`Private`Spin1m],Dagger->Complex];
DefTensor[QPara1pF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`QPerpSymb,xAct`PSALTer`Private`Spin1p],Dagger->Complex];
DefTensor[QPerpH0pF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`QPerpHSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[QPerp2pF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`QPerpSymb,xAct`PSALTer`Private`Spin2p],Dagger->Complex];
DefTensor[QParaH1mF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`QParaHSymb,xAct`PSALTer`Private`Spin1m],Dagger->Complex];
DefTensor[QPara2mF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`QParaSymb,xAct`PSALTer`Private`Spin2m],Dagger->Complex];

DefTensor[ConjugateSourceQPerpT0pF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ZPerpTSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ConjugateSourceQPerpT1mF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ZPerpTSymb,xAct`PSALTer`Private`Spin1m],Dagger->Complex];
DefTensor[ConjugateSourceQPara0pF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ZParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ConjugateSourceQPara2pF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ZParaSymb,xAct`PSALTer`Private`Spin2p],Dagger->Complex];
DefTensor[ConjugateSourceQParaT1mF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ZParaTSymb,xAct`PSALTer`Private`Spin1m],Dagger->Complex];
DefTensor[ConjugateSourceQPara3mF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ZParaSymb,xAct`PSALTer`Private`Spin3m],Dagger->Complex];
DefTensor[ConjugateSourceQPerpH1mF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ZPerpHSymb,xAct`PSALTer`Private`Spin1m],Dagger->Complex];
DefTensor[ConjugateSourceQPara1pF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ZPerpSymb,xAct`PSALTer`Private`Spin1p],Dagger->Complex];
DefTensor[ConjugateSourceQPerpH0pF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ZPerpHSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ConjugateSourceQPerp2pF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ZPerpSymb,xAct`PSALTer`Private`Spin2p],Dagger->Complex];
DefTensor[ConjugateSourceQParaH1mF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ZParaHSymb,xAct`PSALTer`Private`Spin1m],Dagger->Complex];
DefTensor[ConjugateSourceQPara2mF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ZParaSymb,xAct`PSALTer`Private`Spin2m],Dagger->Complex];

(*Make rule to decompose P\[CapitalPi]Q into full Q(J^P)_ija components,also Z*)
xAct`PSALTer`MetricAffineGaugeTheory`Private`ExpandQZtoF=Join[
	MakeRule[{Q[-i,-j,-a],Evaluate[QPerpT0pF[-i,-j,-a]+QPerpT1mF[-i,-j,-a]+QPara0pF[-i,-j,-a]+QPara2pF[-i,-j,-a]+QParaT1mF[-i,-j,-a]+QPara3mF[-i,-j,-a]+QPerpH1mF[-i,-j,-a]+QPara1pF[-i,-j,-a]+QPerpH0pF[-i,-j,-a]+QPerp2pF[-i,-j,-a]+QParaH1mF[-i,-j,-a]+QPara2mF[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Z[-i,-j,-a],Evaluate[ConjugateSourceQPerpT0pF[-i,-j,-a]+ConjugateSourceQPerpT1mF[-i,-j,-a]+ConjugateSourceQPara0pF[-i,-j,-a]+ConjugateSourceQPara2pF[-i,-j,-a]+ConjugateSourceQParaT1mF[-i,-j,-a]+ConjugateSourceQPara3mF[-i,-j,-a]+ConjugateSourceQPerpH1mF[-i,-j,-a]+ConjugateSourceQPara1pF[-i,-j,-a]+ConjugateSourceQPerpH0pF[-i,-j,-a]+ConjugateSourceQPerp2pF[-i,-j,-a]+ConjugateSourceQParaH1mF[-i,-j,-a]+ConjugateSourceQPara2mF[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{Evaluate@Dagger@Q[-i,-j,-a],Evaluate[Dagger@(QPerpT0pF[-i,-j,-a]+QPerpT1mF[-i,-j,-a]+QPara0pF[-i,-j,-a]+QPara2pF[-i,-j,-a]+QParaT1mF[-i,-j,-a]+QPara3mF[-i,-j,-a]+QPerpH1mF[-i,-j,-a]+QPara1pF[-i,-j,-a]+QPerpH0pF[-i,-j,-a]+QPerp2pF[-i,-j,-a]+QParaH1mF[-i,-j,-a]+QPara2mF[-i,-j,-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Z[-i,-j,-a],Evaluate[Dagger@(ConjugateSourceQPerpT0pF[-i,-j,-a]+ConjugateSourceQPerpT1mF[-i,-j,-a]+ConjugateSourceQPara0pF[-i,-j,-a]+ConjugateSourceQPara2pF[-i,-j,-a]+ConjugateSourceQParaT1mF[-i,-j,-a]+ConjugateSourceQPara3mF[-i,-j,-a]+ConjugateSourceQPerpH1mF[-i,-j,-a]+ConjugateSourceQPara1pF[-i,-j,-a]+ConjugateSourceQPerpH0pF[-i,-j,-a]+ConjugateSourceQPerp2pF[-i,-j,-a]+ConjugateSourceQParaH1mF[-i,-j,-a]+ConjugateSourceQPara2mF[-i,-j,-a])]},MetricOn->All,ContractMetrics->True]
];

(*==============================*)
(*  Spin-parity or SO(3) parts  *)
(*==============================*)

(*======================*)
(*  Tensor definitions  *)
(*======================*)

(*-------------------------------------------------------------------------*)
(*  Will: definition of metric perturbation reduced-index spin components  *)
(*-------------------------------------------------------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`LinearMetricPerpSymb="\!\(\*SuperscriptBox[\(\[ScriptH]\),\(\[UpTee]\)]\)";
xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceLinearMetricPerpSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalT]\),\(\[UpTee]\)]\)";

DefSpinParityMode[LinearMetricPerp0p[],Spin->0,Parity->Even,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`LinearMetricPerpSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceLinearMetricPerpSymb];
DefSpinParityMode[LinearMetricPerp1m[-a],Spin->1,Parity->Odd,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`LinearMetricPerpSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceLinearMetricPerpSymb];

xAct`PSALTer`MetricAffineGaugeTheory`Private`LinearMetricParaSymb="\!\(\*SuperscriptBox[\(\[ScriptH]\),\(\[DoubleVerticalBar]\)]\)";
xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceLinearMetricParaSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalT]\),\(\[DoubleVerticalBar]\)]\)";

DefSpinParityMode[LinearMetricPara0p[],Spin->0,Parity->Even,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`LinearMetricParaSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceLinearMetricParaSymb];
DefSpinParityMode[LinearMetricPara2p[-a,-b],Symmetric[{-a,-b}],Spin->2,Parity->Even,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`LinearMetricParaSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceLinearMetricParaSymb];

(*-------------------------------------------------------------------*)
(*  Will: definition of antisymmetric reduced-index spin components  *)
(*-------------------------------------------------------------------*)

DefSpinParityMode[APara0p[],Spin->0,Parity->Even,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`AParaSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceAParaSymb];
DefSpinParityMode[APara0m[],Spin->0,Parity->Odd,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`AParaSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceAParaSymb];
DefSpinParityMode[APara1p[-a,-b],Antisymmetric[{-a,-b}],Spin->1,Parity->Even,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`AParaSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceAParaSymb];
DefSpinParityMode[APara1m[-a],Spin->1,Parity->Odd,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`AParaSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceAParaSymb];
DefSpinParityMode[APara2p[-a,-b],Symmetric[{-a,-b}],Spin->2,Parity->Even,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`AParaSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceAParaSymb];
DefSpinParityMode[APara2m[-a,-b,-c],Antisymmetric[{-a,-b}],Spin->2,Parity->Odd,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`AParaSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceAParaSymb];

(*------------------------------------------------------------*)
(*  Zhiyuan: definition of Q,Z reduced-index spin components  *)
(*------------------------------------------------------------*)

DefSpinParityMode[QPerpT0p[],Spin->0,Parity->Even,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`QPerpTSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ZPerpTSymb];
DefSpinParityMode[QPerpT1m[-i],Spin->1,Parity->Odd,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`QPerpTSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ZPerpTSymb];
DefSpinParityMode[QPara0p[],Spin->0,Parity->Even,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`QParaSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ZParaSymb];
DefSpinParityMode[QPara2p[-i,-j],Symmetric[{-i,-j}],Spin->2,Parity->Even,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`QParaSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ZParaSymb];
DefSpinParityMode[QParaT1m[-i],Spin->1,Parity->Odd,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`QParaTSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ZParaTSymb];
DefSpinParityMode[QPara3m[-i,-j,-a],Symmetric[{-i,-j,-a}],Spin->3,Parity->Odd,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`QParaSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ZParaSymb];
DefSpinParityMode[QPerpH1m[-i],Spin->1,Parity->Odd,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`QPerpHSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ZPerpHSymb];
DefSpinParityMode[QPara1p[-i,-a],Antisymmetric[{-i,-a}],Spin->1,Parity->Even,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`QPerpSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ZPerpSymb];
DefSpinParityMode[QPerpH0p[],Spin->0,Parity->Even,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`QPerpHSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ZPerpHSymb];
DefSpinParityMode[QPerp2p[-i,-j],Symmetric[{-i,-j}],Spin->2,Parity->Even,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`QPerpSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ZPerpSymb];
DefSpinParityMode[QParaH1m[-i],Spin->1,Parity->Odd,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`QParaHSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ZParaHSymb];
DefSpinParityMode[QPara2m[-i,-j,-a],Symmetric[{-i,-j}],MultiTermSymmetries->{QPara2m[-i,-j,-a]+QPara2m[-a,-i,-j]+QPara2m[-j,-a,-i]},Spin->2,Parity->Odd,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`QParaSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ZParaSymb];

(*==============*)
(*  Expansions  *)
(*==============*)

(*----------------------------------------*)
(*  Will: metric perturbation expansions  *)
(*----------------------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`LinearMetricSpinParityToLinearMetric=Join[
	MakeRule[{LinearMetricPerp0p[],Evaluate[
		ProjPerp[a,b]LinearMetric[-a,-b](*/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG*)//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{LinearMetricPerp1m[-a],Evaluate[
		V[b]ProjPara[-a,c]LinearMetric[-c,-b](*/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG*)//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{LinearMetricPara0p[],Evaluate[
		ProjPara[a,b]LinearMetric[-a,-b](*/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG*)//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{LinearMetricPara2p[-a,-b],Evaluate[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*LinearMetric[-c,-d](*/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG*)//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@LinearMetricPerp0p[],Evaluate@Dagger[
		ProjPerp[a,b]LinearMetric[-a,-b](*/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG*)//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@LinearMetricPerp1m[-a],Evaluate@Dagger[
		V[b]ProjPara[-a,c]LinearMetric[-c,-b](*/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG*)//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@LinearMetricPara0p[],Evaluate@Dagger[
		ProjPara[a,b]LinearMetric[-a,-b](*/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG*)//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@LinearMetricPara2p[-a,-b],Evaluate@Dagger[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*LinearMetric[-c,-d](*/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG*)//ToCanonical]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceLinearMetricSpinParityToConjugateSourceLinearMetric=Join[
	MakeRule[{ConjugateSourceLinearMetricPerp0p[],Evaluate[
		ProjPerp[a,b]ConjugateSourceLinearMetric[-a,-b](*/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG*)//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceLinearMetricPerp1m[-a],Evaluate[
		V[b]ProjPara[-a,c]ConjugateSourceLinearMetric[-c,-b](*/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG*)//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceLinearMetricPara0p[],Evaluate[
		ProjPara[a,b]ConjugateSourceLinearMetric[-a,-b](*/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG*)//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceLinearMetricPara2p[-a,-b],Evaluate[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*ConjugateSourceLinearMetric[-c,-d](*/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG*)//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceLinearMetricPerp0p[],Evaluate@Dagger[
		ProjPerp[a,b]ConjugateSourceLinearMetric[-a,-b](*/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG*)//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceLinearMetricPerp1m[-a],Evaluate@Dagger[
		V[b]ProjPara[-a,c]ConjugateSourceLinearMetric[-c,-b](*/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG*)//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceLinearMetricPara0p[],Evaluate@Dagger[
		ProjPara[a,b]ConjugateSourceLinearMetric[-a,-b](*/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG*)//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceLinearMetricPara2p[-a,-b],Evaluate@Dagger[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*ConjugateSourceLinearMetric[-c,-d](*/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG*)//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*--------------------------*)
(*  Will: other expansions  *)
(*--------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`AParaSpinParityToA=Join[
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

DefTensor[APerp1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`APerpSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[APerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`APerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

xAct`PSALTer`MetricAffineGaugeTheory`Private`APerpSpinParityToA=Join[
	MakeRule[{APerp1p[-n,-m],Evaluate[
		ProjPara[-n,a]ProjPara[-m,b]APerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{APerp1m[-n],Evaluate[
		ProjPara[-n,a]V[b]APerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APerp1p[-n,-m],Evaluate[Dagger@(
		ProjPara[-n,a]ProjPara[-m,b]APerp[-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]V[b]APerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceAParaSpinParityToY=Join[
	MakeRule[{ConjugateSourceAPara0p[],Scalar[Evaluate[
		ProjA0p[e,f]ProjAPerp[-e,-f,a,b,c]ConjugateSourceAPara[-c,-a,-b]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceAPara0m[],Scalar[Evaluate[
		ProjA0m[d,e,f]ProjAPara[-d,-e,-f,a,b,c]ConjugateSourceAPara[-c,-a,-b]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceAPara1p[-n,-m],Evaluate[
		ProjA1p[-n,-m,e,f]ProjAPerp[-e,-f,a,b,c]ConjugateSourceAPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceAPara1m[-n],Evaluate[
		ProjA1m[-n,d,e,f]ProjAPara[-d,-e,-f,a,b,c]ConjugateSourceAPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceAPara2p[-n,-m],Evaluate[
		ProjA2p[-n,-m,e,f]ProjAPerp[-e,-f,a,b,c]ConjugateSourceAPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceAPara2m[-n,-m,-o],Evaluate[
		ProjA2m[-n,-m,-o,d,e,f]ProjAPara[-d,-e,-f,a,b,c]ConjugateSourceAPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceAPara0p[],Scalar[Evaluate[Dagger@(
		ProjA0p[e,f]ProjAPerp[-e,-f,a,b,c]ConjugateSourceAPara[-c,-a,-b])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceAPara0m[],Scalar[Evaluate[Dagger@(
		ProjA0m[d,e,f]ProjAPara[-d,-e,-f,a,b,c]ConjugateSourceAPara[-c,-a,-b])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceAPara1p[-n,-m],Evaluate[Dagger@(
		ProjA1p[-n,-m,e,f]ProjAPerp[-e,-f,a,b,c]ConjugateSourceAPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceAPara1m[-n],Evaluate[Dagger@(
		ProjA1m[-n,d,e,f]ProjAPara[-d,-e,-f,a,b,c]ConjugateSourceAPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceAPara2p[-n,-m],Evaluate[Dagger@(
		ProjA2p[-n,-m,e,f]ProjAPerp[-e,-f,a,b,c]ConjugateSourceAPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceAPara2m[-n,-m,-o],Evaluate[Dagger@(
		ProjA2m[-n,-m,-o,d,e,f]ProjAPara[-d,-e,-f,a,b,c]ConjugateSourceAPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True]];

DefTensor[YPerp1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`YPerpSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
DefTensor[YPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`YPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

xAct`PSALTer`MetricAffineGaugeTheory`Private`YPerpSpinParityToY=Join[
	MakeRule[{YPerp1p[-n,-m],Evaluate[
		ProjPara[-n,a]ProjPara[-m,b]YPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{YPerp1m[-n],Evaluate[
		ProjPara[-n,a]V[b]YPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@YPerp1p[-n,-m],Evaluate[Dagger@(
		ProjPara[-n,a]ProjPara[-m,b]YPerp[-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@YPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]V[b]YPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];


(*---------------------------------*)
(*  Zhiyuan: MAG expansions (Q,Z)  *)
(*---------------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`ExpandQFtoReduced=Join[
	MakeRule[{QPerpT0pF[-i,-j,-a],Evaluate[(V[-i]V[-j]V[-a]QPerpT0p[])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@QPerpT0pF[-i,-j,-a],Evaluate@Dagger[(V[-i]V[-j]V[-a]QPerpT0p[])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{QPerpT1mF[-i,-j,-a],Evaluate[(totsymQZ[k,l,b,-i,-j,-a]V[-k]V[-l]QPerpT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@QPerpT1mF[-i,-j,-a],Evaluate@Dagger[(totsymQZ[k,l,b,-i,-j,-a]V[-k]V[-l]QPerpT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{QPara0pF[-i,-j,-a],Evaluate[((QPara0p[]/3)totsymQZ[k,l,b,-i,-j,-a]ProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@QPara0pF[-i,-j,-a],Evaluate@Dagger[((QPara0p[]/3)totsymQZ[k,l,b,-i,-j,-a]ProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{QPara2pF[-i,-j,-a],Evaluate[(totsymQZ[k,l,b,-i,-j,-a]QPara2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@QPara2pF[-i,-j,-a],Evaluate@Dagger[(totsymQZ[k,l,b,-i,-j,-a]QPara2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{QParaT1mF[-i,-j,-a],Evaluate[((1/5)totsymQZ[k,l,b,-i,-j,-a]ProjPara[-k,-l]QParaT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@QParaT1mF[-i,-j,-a],Evaluate@Dagger[((1/5)totsymQZ[k,l,b,-i,-j,-a]ProjPara[-k,-l]QParaT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{QPara3mF[-i,-j,-a],Evaluate[QPara3m[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@QPara3mF[-i,-j,-a],Evaluate@Dagger[QPara3m[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{QPerpH1mF[-i,-j,-a],Evaluate[(remsymQZ[k,l,b,-i,-j,-a]V[-k]V[-l]QPerpH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@QPerpH1mF[-i,-j,-a],Evaluate@Dagger[(remsymQZ[k,l,b,-i,-j,-a]V[-k]V[-l]QPerpH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{QPara1pF[-i,-j,-a],Evaluate[((1/2)(V[-i]QPara1p[-j,-a]+V[-j]QPara1p[-i,-a]))//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@QPara1pF[-i,-j,-a],Evaluate@Dagger[((1/2)(V[-i]QPara1p[-j,-a]+V[-j]QPara1p[-i,-a]))//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{QPerpH0pF[-i,-j,-a],Evaluate[((QPerpH0p[]/3)remsymQZ[k,l,b,-i,-j,-a]ProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@QPerpH0pF[-i,-j,-a],Evaluate@Dagger[((QPerpH0p[]/3)remsymQZ[k,l,b,-i,-j,-a]ProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{QPerp2pF[-i,-j,-a],Evaluate[(remsymQZ[k,l,b,-i,-j,-a]QPerp2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@QPerp2pF[-i,-j,-a],Evaluate@Dagger[(remsymQZ[k,l,b,-i,-j,-a]QPerp2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{QParaH1mF[-i,-j,-a],Evaluate[((1/2)remsymQZ[k,l,b,-i,-j,-a]ProjPara[-k,-l]QParaH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@QParaH1mF[-i,-j,-a],Evaluate@Dagger[((1/2)remsymQZ[k,l,b,-i,-j,-a]ProjPara[-k,-l]QParaH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{QPara2mF[-i,-j,-a],Evaluate[QPara2m[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@QPara2mF[-i,-j,-a],Evaluate@Dagger[QPara2m[-i,-j,-a]]},MetricOn->All,ContractMetrics->True]	
];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ExpandZFtoReduced=Join[
	MakeRule[{ConjugateSourceQPerpT0pF[-i,-j,-a],Evaluate[(V[-i]V[-j]V[-a]ConjugateSourceQPerpT0p[])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceQPerpT0pF[-i,-j,-a],Evaluate@Dagger[(V[-i]V[-j]V[-a]ConjugateSourceQPerpT0p[])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceQPerpT1mF[-i,-j,-a],Evaluate[(totsymQZ[k,l,b,-i,-j,-a]V[-k]V[-l]ConjugateSourceQPerpT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceQPerpT1mF[-i,-j,-a],Evaluate@Dagger[(totsymQZ[k,l,b,-i,-j,-a]V[-k]V[-l]ConjugateSourceQPerpT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceQPara0pF[-i,-j,-a],Evaluate[((ConjugateSourceQPara0p[]/3)totsymQZ[k,l,b,-i,-j,-a]ProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceQPara0pF[-i,-j,-a],Evaluate@Dagger[((ConjugateSourceQPara0p[]/3)totsymQZ[k,l,b,-i,-j,-a]ProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceQPara2pF[-i,-j,-a],Evaluate[(totsymQZ[k,l,b,-i,-j,-a]ConjugateSourceQPara2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceQPara2pF[-i,-j,-a],Evaluate@Dagger[(totsymQZ[k,l,b,-i,-j,-a]ConjugateSourceQPara2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceQParaT1mF[-i,-j,-a],Evaluate[((1/5)totsymQZ[k,l,b,-i,-j,-a]ProjPara[-k,-l]ConjugateSourceQParaT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceQParaT1mF[-i,-j,-a],Evaluate@Dagger[((1/5)totsymQZ[k,l,b,-i,-j,-a]ProjPara[-k,-l]ConjugateSourceQParaT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceQPara3mF[-i,-j,-a],Evaluate[ConjugateSourceQPara3m[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceQPara3mF[-i,-j,-a],Evaluate@Dagger[ConjugateSourceQPara3m[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceQPerpH1mF[-i,-j,-a],Evaluate[(remsymQZ[k,l,b,-i,-j,-a]V[-k]V[-l]ConjugateSourceQPerpH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceQPerpH1mF[-i,-j,-a],Evaluate@Dagger[(remsymQZ[k,l,b,-i,-j,-a]V[-k]V[-l]ConjugateSourceQPerpH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceQPara1pF[-i,-j,-a],Evaluate[((1/2)(V[-i]ConjugateSourceQPara1p[-j,-a]+V[-j]ConjugateSourceQPara1p[-i,-a]))//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceQPara1pF[-i,-j,-a],Evaluate@Dagger[((1/2)(V[-i]ConjugateSourceQPara1p[-j,-a]+V[-j]ConjugateSourceQPara1p[-i,-a]))//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceQPerpH0pF[-i,-j,-a],Evaluate[((ConjugateSourceQPerpH0p[]/3)remsymQZ[k,l,b,-i,-j,-a]ProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceQPerpH0pF[-i,-j,-a],Evaluate@Dagger[((ConjugateSourceQPerpH0p[]/3)remsymQZ[k,l,b,-i,-j,-a]ProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceQPerp2pF[-i,-j,-a],Evaluate[(remsymQZ[k,l,b,-i,-j,-a]ConjugateSourceQPerp2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceQPerp2pF[-i,-j,-a],Evaluate@Dagger[(remsymQZ[k,l,b,-i,-j,-a]ConjugateSourceQPerp2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceQParaH1mF[-i,-j,-a],Evaluate[((1/2)remsymQZ[k,l,b,-i,-j,-a]ProjPara[-k,-l]ConjugateSourceQParaH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceQParaH1mF[-i,-j,-a],Evaluate@Dagger[((1/2)remsymQZ[k,l,b,-i,-j,-a]ProjPara[-k,-l]ConjugateSourceQParaH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceQPara2mF[-i,-j,-a],Evaluate[ConjugateSourceQPara2m[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceQPara2mF[-i,-j,-a],Evaluate@Dagger[ConjugateSourceQPara2m[-i,-j,-a]]},MetricOn->All,ContractMetrics->True]	
];

(*==================*)
(*  Decompositions  *)
(*==================*)

(*--------------------------------------------*)
(*  Will: metric perturbation decompositions  *)
(*--------------------------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`LinearMetricToLinearMetricSpinParity=Join[
	MakeRule[{LinearMetric[-a,-b],Evaluate[
		(
			LinearMetricPerp0p[]V[-a]V[-b]
			+LinearMetricPerp1m[-a]V[-b]
			+LinearMetricPerp1m[-b]V[-a]
			+(1/3)*LinearMetricPara0p[]ProjPara[-a,-b]
			+LinearMetricPara2p[-a,-b]
		)(*/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG*)//ToCanonical
	]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@LinearMetric[-a,-b],Evaluate@Dagger[
		(
			LinearMetricPerp0p[]V[-a]V[-b]
			+LinearMetricPerp1m[-a]V[-b]
			+LinearMetricPerp1m[-b]V[-a]
			+(1/3)*LinearMetricPara0p[]ProjPara[-a,-b]
			+LinearMetricPara2p[-a,-b]
		)(*/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG*)//ToCanonical
	]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceLinearMetricToConjugateSourceLinearMetricSpinParity=Join[
	MakeRule[{ConjugateSourceLinearMetric[-a,-b],Evaluate[
		(
			ConjugateSourceLinearMetricPerp0p[]V[-a]V[-b]
			+ConjugateSourceLinearMetricPerp1m[-a]V[-b]
			+ConjugateSourceLinearMetricPerp1m[-b]V[-a]
			+(1/3)*ConjugateSourceLinearMetricPara0p[]ProjPara[-a,-b]
			+ConjugateSourceLinearMetricPara2p[-a,-b]
		)(*/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG*)//ToCanonical
	]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceLinearMetric[-a,-b],Evaluate@Dagger[
		(
			ConjugateSourceLinearMetricPerp0p[]V[-a]V[-b]
			+ConjugateSourceLinearMetricPerp1m[-a]V[-b]
			+ConjugateSourceLinearMetricPerp1m[-b]V[-a]
			+(1/3)*ConjugateSourceLinearMetricPara0p[]ProjPara[-a,-b]
			+ConjugateSourceLinearMetricPara2p[-a,-b]
		)(*/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG*)//ToCanonical
	]},MetricOn->All,ContractMetrics->True]];

(*------------------------------*)
(*  Will: other decompositions  *)
(*------------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`AParaToAParaSpinParity=Join[
	MakeRule[{APara[-n,-m,-o],Evaluate[
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]APara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]APara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]APara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjA0m[-n,-m,-o]APara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]APara1m[-n],{-m,-n}]+
		(4/3)APara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjASpinParityToVG/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APara[-n,-m,-o],Evaluate[Dagger@(
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]APara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]APara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]APara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjA0m[-n,-m,-o]APara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]APara1m[-n],{-m,-n}]+
		(4/3)APara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjASpinParityToVG/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`APerpToAPerpSpinParity=Join[
	MakeRule[{APerp[-n,-m],Evaluate[APerp1p[-n,-m]+2Antisymmetrize[V[-m]APerp1m[-n],{-n,-m}]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@APerp[-n,-m],Evaluate[Dagger@(APerp1p[-n,-m]+2Antisymmetrize[V[-m]APerp1m[-n],{-n,-m}])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceAParaToConjugateSourceAParaSpinParity=Join[
	MakeRule[{ConjugateSourceAPara[-o,-n,-m],Evaluate[
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]ConjugateSourceAPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]ConjugateSourceAPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]ConjugateSourceAPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjA0m[-n,-m,-o]ConjugateSourceAPara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]ConjugateSourceAPara1m[-n],{-m,-n}]+
		(4/3)ConjugateSourceAPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjASpinParityToVG/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceAPara[-o,-n,-m],Evaluate[Dagger@(
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]ConjugateSourceAPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]ConjugateSourceAPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]ConjugateSourceAPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjA0m[-n,-m,-o]ConjugateSourceAPara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]ConjugateSourceAPara1m[-n],{-m,-n}]+
		(4/3)ConjugateSourceAPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjASpinParityToVG/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`YPerpToYPerpSpinParity=Join[
	MakeRule[{YPerp[-n,-m],Evaluate[YPerp1p[-n,-m]+2Antisymmetrize[V[-m]YPerp1m[-n],{-n,-m}]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@YPerp[-n,-m],Evaluate[Dagger@(YPerp1p[-n,-m]+2Antisymmetrize[V[-m]YPerp1m[-n],{-n,-m}])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`Patch2m=Join[
	MakeRule[{APara2m[-a,-c,-b]APara2m[a,b,c],(1/2)APara2m[-a,-b,-c]APara2m[a,b,c]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate[Dagger@APara2m[-a,-c,-b]APara2m[a,b,c]],Evaluate[(1/2)Dagger@APara2m[-a,-b,-c]APara2m[a,b,c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate[APara2m[-a,-c,-b]Dagger@APara2m[a,b,c]],Evaluate[(1/2)APara2m[-a,-b,-c]Dagger@APara2m[a,b,c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceAPara2m[-a,-c,-b]ConjugateSourceAPara2m[a,b,c],(1/2)ConjugateSourceAPara2m[-a,-b,-c]ConjugateSourceAPara2m[a,b,c]},MetricOn->All,ContractMetrics->True]];

(*
AutomaticRules[APara2m,MakeRule[{Evaluate[APara2m[-a,-c,-b]Dagger@APara2m[a,b,c]],Evaluate[(1/2)APara2m[-a,-b,-c]Dagger@APara2m[a,b,c]]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[Evaluate[Dagger@APara2m],MakeRule[{Evaluate[Dagger@APara2m[-a,-c,-b]APara2m[a,b,c]],Evaluate[(1/2)Dagger@APara2m[-a,-b,-c]APara2m[a,b,c]]},MetricOn->All,ContractMetrics->True]];
*)

(*-------------------------------------*)
(*  Zhiyuan: MAG decompositions (Q,Z)  *)
(*-------------------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`DecomposeQReducedtoQ=Join[
	MakeRule[{QPerpT0p[],Evaluate[V[i]V[j]V[a]Q[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@QPerpT0p[],Evaluate@Dagger[V[i]V[j]V[a]Q[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{QPerpT1m[-i],Evaluate[(3ProjPara[m,-i]V[n]V[c]totsymQZ[k,l,b,-m,-n,-c]Q[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@QPerpT1m[-i],Evaluate@Dagger[(3ProjPara[m,-i]V[n]V[c]totsymQZ[k,l,b,-m,-n,-c]Q[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{QPara0p[],Evaluate[(3ProjPara[m,-z]ProjPara[n,z]V[c]totsymQZ[k,l,b,-m,-n,-c]Q[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@QPara0p[],Evaluate@Dagger[(3ProjPara[m,-z]ProjPara[n,z]V[c]totsymQZ[k,l,b,-m,-n,-c]Q[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{QPara2p[-i,-j],Evaluate[((3ProjPara[m,-i]ProjPara[n,-j]-ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z])V[c]totsymQZ[k,l,b,-m,-n,-c]Q[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@QPara2p[-i,-j],Evaluate@Dagger[((3ProjPara[m,-i]ProjPara[n,-j]-ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z])V[c]totsymQZ[k,l,b,-m,-n,-c]Q[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{QParaT1m[-i],Evaluate[(3ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]totsymQZ[k,l,b,-m,-n,-c]Q[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@QParaT1m[-i],Evaluate@Dagger[(3ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]totsymQZ[k,l,b,-m,-n,-c]Q[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{QPara3m[-i,-j,-a],Evaluate[((ProjPara[m,-i]ProjPara[n,-j]ProjPara[c,-a]-(1/5)(ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z]ProjPara[c,-a]+ProjPara[-j,-a]ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]+ProjPara[-i,-a]ProjPara[m,-z]ProjPara[n,-j]ProjPara[c,z]))totsymQZ[k,l,b,-m,-n,-c]Q[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@QPara3m[-i,-j,-a],Evaluate@Dagger[((ProjPara[m,-i]ProjPara[n,-j]ProjPara[c,-a]-(1/5)(ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z]ProjPara[c,-a]+ProjPara[-j,-a]ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]+ProjPara[-i,-a]ProjPara[m,-z]ProjPara[n,-j]ProjPara[c,z]))totsymQZ[k,l,b,-m,-n,-c]Q[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{QPerpH1m[-i],Evaluate[((Q[-k,-l,-i]-Q[-i,-k,-l])V[k]V[l])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@QPerpH1m[-i],Evaluate@Dagger[((Q[-k,-l,-i]-Q[-i,-k,-l])V[k]V[l])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{QPara1p[-i,-a],Evaluate[((Q[-k,-i,-a]-Q[-k,-a,-i])V[k]+V[k]V[l]((Q[-k,-l,-i]-Q[-i,-k,-l])V[-a]-(Q[-k,-l,-a]-Q[-a,-k,-l])V[-i]))//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@QPara1p[-i,-a],Evaluate@Dagger[((Q[-k,-i,-a]-Q[-k,-a,-i])V[k]+V[k]V[l]((Q[-k,-l,-i]-Q[-i,-k,-l])V[-a]-(Q[-k,-l,-a]-Q[-a,-k,-l])V[-i]))//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{QPerpH0p[],Evaluate[(Q[k,-k,-i]-Q[-i,-k,k])V[i]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@QPerpH0p[],Evaluate@Dagger[(Q[k,-k,-i]-Q[-i,-k,k])V[i]]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{QPerp2p[-i,-j],Evaluate[((3/2)(ProjPara[m,-i]ProjPara[n,-j]-(ProjPara[-i,-j]/3)ProjPara[m,-z]ProjPara[n,z])V[c]remsymQZ[k,l,b,-m,-n,-c]Q[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@QPerp2p[-i,-j],Evaluate@Dagger[((3/2)(ProjPara[m,-i]ProjPara[n,-j]-(ProjPara[-i,-j]/3)ProjPara[m,-z]ProjPara[n,z])V[c]remsymQZ[k,l,b,-m,-n,-c]Q[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{QParaH1m[-i],Evaluate[((-3)ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]remsymQZ[k,l,b,-m,-n,-c]Q[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@QParaH1m[-i],Evaluate@Dagger[((-3)ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]remsymQZ[k,l,b,-m,-n,-c]Q[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{QPara2m[-i,-j,-a],Evaluate[((ProjPara[m,-i]ProjPara[n,-j]ProjPara[c,-a]-(1/2)(ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z]ProjPara[c,-a]+ProjPara[-j,-a]ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]+ProjPara[-i,-a]ProjPara[m,-z]ProjPara[n,-j]ProjPara[c,z]))remsymQZ[k,l,b,-m,-n,-c]Q[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@QPara2m[-i,-j,-a],Evaluate@Dagger[((ProjPara[m,-i]ProjPara[n,-j]ProjPara[c,-a]-(1/2)(ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z]ProjPara[c,-a]+ProjPara[-j,-a]ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]+ProjPara[-i,-a]ProjPara[m,-z]ProjPara[n,-j]ProjPara[c,z]))remsymQZ[k,l,b,-m,-n,-c]Q[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True]
];

xAct`PSALTer`MetricAffineGaugeTheory`Private`DecomposeZReducedtoZ=Join[
	MakeRule[{ConjugateSourceQPerpT0p[],Evaluate[V[i]V[j]V[a]Z[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceQPerpT0p[],Evaluate@Dagger[V[i]V[j]V[a]Z[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceQPerpT1m[-i],Evaluate[(3ProjPara[m,-i]V[n]V[c]totsymQZ[k,l,b,-m,-n,-c]Z[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceQPerpT1m[-i],Evaluate@Dagger[(3ProjPara[m,-i]V[n]V[c]totsymQZ[k,l,b,-m,-n,-c]Z[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceQPara0p[],Evaluate[(3ProjPara[m,-z]ProjPara[n,z]V[c]totsymQZ[k,l,b,-m,-n,-c]Z[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceQPara0p[],Evaluate@Dagger[(3ProjPara[m,-z]ProjPara[n,z]V[c]totsymQZ[k,l,b,-m,-n,-c]Z[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceQPara2p[-i,-j],Evaluate[((3ProjPara[m,-i]ProjPara[n,-j]-ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z])V[c]totsymQZ[k,l,b,-m,-n,-c]Z[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceQPara2p[-i,-j],Evaluate@Dagger[((3ProjPara[m,-i]ProjPara[n,-j]-ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z])V[c]totsymQZ[k,l,b,-m,-n,-c]Z[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceQParaT1m[-i],Evaluate[(3ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]totsymQZ[k,l,b,-m,-n,-c]Z[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceQParaT1m[-i],Evaluate@Dagger[(3ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]totsymQZ[k,l,b,-m,-n,-c]Z[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceQPara3m[-i,-j,-a],Evaluate[((ProjPara[m,-i]ProjPara[n,-j]ProjPara[c,-a]-(1/5)(ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z]ProjPara[c,-a]+ProjPara[-j,-a]ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]+ProjPara[-i,-a]ProjPara[m,-z]ProjPara[n,-j]ProjPara[c,z]))totsymQZ[k,l,b,-m,-n,-c]Z[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceQPara3m[-i,-j,-a],Evaluate@Dagger[((ProjPara[m,-i]ProjPara[n,-j]ProjPara[c,-a]-(1/5)(ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z]ProjPara[c,-a]+ProjPara[-j,-a]ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]+ProjPara[-i,-a]ProjPara[m,-z]ProjPara[n,-j]ProjPara[c,z]))totsymQZ[k,l,b,-m,-n,-c]Z[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceQPerpH1m[-i],Evaluate[((Z[-k,-l,-i]-Z[-i,-k,-l])V[k]V[l])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceQPerpH1m[-i],Evaluate@Dagger[((Z[-k,-l,-i]-Z[-i,-k,-l])V[k]V[l])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceQPara1p[-i,-a],Evaluate[((Z[-k,-i,-a]-Z[-k,-a,-i])V[k]+V[k]V[l]((Z[-k,-l,-i]-Z[-i,-k,-l])V[-a]-(Z[-k,-l,-a]-Z[-a,-k,-l])V[-i]))//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceQPara1p[-i,-a],Evaluate@Dagger[((Z[-k,-i,-a]-Z[-k,-a,-i])V[k]+V[k]V[l]((Z[-k,-l,-i]-Z[-i,-k,-l])V[-a]-(Z[-k,-l,-a]-Z[-a,-k,-l])V[-i]))//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceQPerpH0p[],Evaluate[(Z[k,-k,-i]-Z[-i,-k,k])V[i]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceQPerpH0p[],Evaluate@Dagger[(Z[k,-k,-i]-Z[-i,-k,k])V[i]]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceQPerp2p[-i,-j],Evaluate[((3/2)(ProjPara[m,-i]ProjPara[n,-j]-(ProjPara[-i,-j]/3)ProjPara[m,-z]ProjPara[n,z])V[c]remsymQZ[k,l,b,-m,-n,-c]Z[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceQPerp2p[-i,-j],Evaluate@Dagger[((3/2)(ProjPara[m,-i]ProjPara[n,-j]-(ProjPara[-i,-j]/3)ProjPara[m,-z]ProjPara[n,z])V[c]remsymQZ[k,l,b,-m,-n,-c]Z[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceQParaH1m[-i],Evaluate[((-3)ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]remsymQZ[k,l,b,-m,-n,-c]Z[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceQParaH1m[-i],Evaluate@Dagger[((-3)ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]remsymQZ[k,l,b,-m,-n,-c]Z[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceQPara2m[-i,-j,-a],Evaluate[((ProjPara[m,-i]ProjPara[n,-j]ProjPara[c,-a]-(1/2)(ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z]ProjPara[c,-a]+ProjPara[-j,-a]ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]+ProjPara[-i,-a]ProjPara[m,-z]ProjPara[n,-j]ProjPara[c,z]))remsymQZ[k,l,b,-m,-n,-c]Z[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceQPara2m[-i,-j,-a],Evaluate@Dagger[((ProjPara[m,-i]ProjPara[n,-j]ProjPara[c,-a]-(1/2)(ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z]ProjPara[c,-a]+ProjPara[-j,-a]ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]+ProjPara[-i,-a]ProjPara[m,-z]ProjPara[n,-j]ProjPara[c,z]))remsymQZ[k,l,b,-m,-n,-c]Z[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True]
];

(*==========================================================*)
(*  Basic definitions of the Lagrangian coupling constants  *)
(*==========================================================*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`ACouplingSymb="\[ScriptA]";

DefLagrangianCoupling[A0,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ACouplingSymb,CouplingIndex->0];
DefLagrangianCoupling[A1,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ACouplingSymb,CouplingIndex->1];
DefLagrangianCoupling[A2,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ACouplingSymb,CouplingIndex->2];
DefLagrangianCoupling[A3,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ACouplingSymb,CouplingIndex->3];
DefLagrangianCoupling[A4,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ACouplingSymb,CouplingIndex->4];
DefLagrangianCoupling[A5,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ACouplingSymb,CouplingIndex->5];
DefLagrangianCoupling[A6,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ACouplingSymb,CouplingIndex->6];
DefLagrangianCoupling[A7,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ACouplingSymb,CouplingIndex->7];
DefLagrangianCoupling[A8,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ACouplingSymb,CouplingIndex->8];
DefLagrangianCoupling[A9,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ACouplingSymb,CouplingIndex->9];
DefLagrangianCoupling[A10,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ACouplingSymb,CouplingIndex->10];
DefLagrangianCoupling[A11,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ACouplingSymb,CouplingIndex->11];

xAct`PSALTer`MetricAffineGaugeTheory`Private`CCouplingSymb="\[ScriptC]";

DefLagrangianCoupling[C0,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`CCouplingSymb,CouplingIndex->0];
DefLagrangianCoupling[C1,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`CCouplingSymb,CouplingIndex->1];
DefLagrangianCoupling[C2,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`CCouplingSymb,CouplingIndex->2];
DefLagrangianCoupling[C3,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`CCouplingSymb,CouplingIndex->3];
DefLagrangianCoupling[C4,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`CCouplingSymb,CouplingIndex->4];
DefLagrangianCoupling[C5,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`CCouplingSymb,CouplingIndex->5];
DefLagrangianCoupling[C6,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`CCouplingSymb,CouplingIndex->6];
DefLagrangianCoupling[C7,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`CCouplingSymb,CouplingIndex->7];
DefLagrangianCoupling[C8,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`CCouplingSymb,CouplingIndex->8];
DefLagrangianCoupling[C9,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`CCouplingSymb,CouplingIndex->9];
DefLagrangianCoupling[C10,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`CCouplingSymb,CouplingIndex->10];
DefLagrangianCoupling[C11,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`CCouplingSymb,CouplingIndex->11];
DefLagrangianCoupling[C12,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`CCouplingSymb,CouplingIndex->12];
DefLagrangianCoupling[C13,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`CCouplingSymb,CouplingIndex->13];
DefLagrangianCoupling[C14,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`CCouplingSymb,CouplingIndex->14];
DefLagrangianCoupling[C15,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`CCouplingSymb,CouplingIndex->15];
DefLagrangianCoupling[C16,CouplingSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`CCouplingSymb,CouplingIndex->16];

(*================================================*)
(*  Some infrastructure for linearising theories  *)
(*================================================*)

(*===================*)
(*  Private context  *)
(*===================*)

Begin["xAct`PSALTer`MetricAffineGaugeTheory`Private`"];

FieldSpinParityTensorHeads=<|
		LinearMetric-><|
			0-><|Even->{LinearMetricPerp0p,LinearMetricPara0p},Odd->{}|>,
			1-><|Even->{},Odd->{LinearMetricPerp1m}|>,
			2-><|Even->{LinearMetricPara2p},Odd->{}|>,
			3-><|Even->{},Odd->{}|>
		|>,
		Connection-><|
			0-><|Even->{APara0p,QPerpT0p,QPara0p,QPerpH0p},Odd->{APara0m}|>,
			1-><|Even->{APara1p,APerp1p,QPara1p},Odd->{APara1m,APerp1m,QPerpT1m,QParaT1m,QPerpH1m,QParaH1m}|>,
			2-><|Even->{APara2p,QPara2p,QPerp2p},Odd->{APara2m,QPara2m}|>,
			3-><|Even->{},Odd->{QPara3m}|>
		|>		
|>;

SourceSpinParityTensorHeads=<|
		ConjugateSourceLinearMetric-><|
			0-><|Even->{ConjugateSourceLinearMetricPerp0p,ConjugateSourceLinearMetricPara0p},Odd->{}|>,
			1-><|Even->{},Odd->{ConjugateSourceLinearMetricPerp1m}|>,
			2-><|Even->{ConjugateSourceLinearMetricPara2p},Odd->{}|>,
			3-><|Even->{},Odd->{}|>
		|>,
		Dilatospin-><|
			0-><|Even->{ConjugateSourceAPara0p,ConjugateSourceQPerpT0p,ConjugateSourceQPara0p,ConjugateSourceQPerpH0p},Odd->{ConjugateSourceAPara0m}|>,
			1-><|Even->{ConjugateSourceAPara1p,YPerp1p,ConjugateSourceQPara1p},Odd->{ConjugateSourceAPara1m,YPerp1m,ConjugateSourceQPerpT1m,ConjugateSourceQParaT1m,ConjugateSourceQPerpH1m,ConjugateSourceQParaH1m}|>,
			2-><|Even->{ConjugateSourceAPara2p,ConjugateSourceQPara2p,ConjugateSourceQPerp2p},Odd->{ConjugateSourceAPara2m,ConjugateSourceQPara2m}|>,
			3-><|Even->{},Odd->{ConjugateSourceQPara3m}|>
		|>		
|>;

SourceEngineeringDimensions=<|
		Dilatospin->0,
		ConjugateSourceLinearMetric->1
|>;

ExpandFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`LinearMetricSpinParityToLinearMetric;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;

	(*Q reduced then back to Q*)
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`DecomposeQReducedtoQ;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;	

	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`AParaSpinParityToA;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`APerpSpinParityToA;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjAPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjASpinParityToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`APerpParaToA;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;

	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`AQToConnection;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;

Expr];

ExpandSources[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceLinearMetricSpinParityToConjugateSourceLinearMetric;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;

	(*Z reduced then back to Z*)
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`DecomposeZReducedtoZ;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;	

	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceAParaSpinParityToY;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`YPerpSpinParityToY;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjAPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjASpinParityToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`YPerpParaToY;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;

	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`YZToDilatospin;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;

Expr];

DecomposeFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`LinearMetricToLinearMetricSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;

	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionToAQ;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;

	(*Zhiyuan,Q*)
	(*Q to Q reduced*)
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ExpandQZtoF/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ExpandQFtoReduced;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;

	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`AToAPerpPara;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`AParaToAParaSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`APerpToAPerpSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`Patch2m;
	(*Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ManualAll;*)
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;

Expr];

End[];

EndPackage[];

DefClass[
	"MetricAffineGaugeTheory",
	xAct`PSALTer`MetricAffineGaugeTheory`Private`FieldSpinParityTensorHeads,
	xAct`PSALTer`MetricAffineGaugeTheory`Private`SourceSpinParityTensorHeads,
	xAct`PSALTer`MetricAffineGaugeTheory`Private`SourceEngineeringDimensions,
	xAct`PSALTer`MetricAffineGaugeTheory`Private`ExpandFields,
	xAct`PSALTer`MetricAffineGaugeTheory`Private`DecomposeFields,
	xAct`PSALTer`MetricAffineGaugeTheory`Private`ExpandSources,
ExportClass->True];
