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

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiSymb="\!\(\*SubscriptBox[\[ScriptCapitalA],\(a\)]\)";
DefTensor[ConnectionAnti[a,c,-d],M4,Antisymmetric[{a,c}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiSymb],Dagger->Complex];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionAntiSymb="\!\(\*SubscriptBox[\[ScriptCapitalW],\(a\)]\)";
DefTensor[ConjugateSourceConnectionAnti[-i,-j,-k],M4,Antisymmetric[{-j,-k}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionAntiSymb],Dagger->Complex];

(*----------------------------------------------------------------------------------------------*)
(*  ConjugateSourceConnectionSymmhiyuan: Basic definitions of metric affine gauge fields(ConnectionSymm) and their conjugate sources(ConjugateSourceConnectionSymm)  *)
(*----------------------------------------------------------------------------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmSymb="\!\(\*SubscriptBox[\[ScriptCapitalA],\(s\)]\)";
DefTensor[ConnectionSymm[-i,-j,-a],M4, Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmSymb],Dagger->Complex];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmSymb="\!\(\*SubscriptBox[\[ScriptCapitalW],\(s\)]\)";
DefTensor[ConjugateSourceConnectionSymm[-i,-j,-a],M4, Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmSymb],Dagger->Complex];

(*----------------------------*)
(*  Will: combination script  *)
(*----------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionToConnectionAntiConnectionSymm=Join[
	MakeRule[{Connection[-c,-a,-b],Evaluate[ConnectionAnti[-a,-b,-c]+ConnectionSymm[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Connection[-c,-a,-b],Evaluate@Dagger[ConnectionAnti[-a,-b,-c]+ConnectionSymm[-a,-b,-c]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`DilatospinToConjugateSourceConnectionAntiConjugateSourceConnectionSymm=Join[
	MakeRule[{Dilatospin[-c,-a,-b],Evaluate[ConjugateSourceConnectionAnti[-c,-a,-b]+ConjugateSourceConnectionSymm[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Dilatospin[-c,-a,-b],Evaluate@Dagger[ConjugateSourceConnectionAnti[-c,-a,-b]+ConjugateSourceConnectionSymm[-a,-b,-c]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiConnectionSymmToConnection=Join[
	MakeRule[{ConnectionAnti[-a,-b,-c],Evaluate[(1/2)*(Connection[-c,-a,-b]-Connection[-c,-b,-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConnectionSymm[-a,-b,-c],Evaluate[(1/2)*(Connection[-c,-a,-b]+Connection[-c,-b,-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionAnti[-a,-b,-c],Evaluate@Dagger[(1/2)*(Connection[-c,-a,-b]-Connection[-c,-b,-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionSymm[-a,-b,-c],Evaluate@Dagger[(1/2)*(Connection[-c,-a,-b]+Connection[-c,-b,-a])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionAntiConjugateSourceConnectionSymmToDilatospin=Join[
	MakeRule[{ConjugateSourceConnectionAnti[-c,-a,-b],Evaluate[(1/2)*(Dilatospin[-c,-a,-b]-Dilatospin[-c,-b,-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceConnectionSymm[-a,-b,-c],Evaluate[(1/2)*(Dilatospin[-c,-a,-b]+Dilatospin[-c,-b,-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionAnti[-c,-a,-b],Evaluate@Dagger[(1/2)*(Dilatospin[-c,-a,-b]-Dilatospin[-c,-b,-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionSymm[-a,-b,-c],Evaluate@Dagger[(1/2)*(Dilatospin[-c,-a,-b]+Dilatospin[-c,-b,-a])]},MetricOn->All,ContractMetrics->True]];

(*==============*)
(*  Projectors  *)
(*==============*)

(*----------------------------------------------------------------------------------*)
(*  ConjugateSourceConnectionSymmhiyuan: Metric affine projectors into total and hook symmetric parts from ConnectionSymm,ConjugateSourceConnectionSymm  *)
(*----------------------------------------------------------------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`totsymConnectionSymmConjugateSourceConnectionSymmSymb="\!\(\*SubscriptBox[\[CapitalPi],\(ts\)]\)";
DefTensor[totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`totsymConnectionSymmConjugateSourceConnectionSymmSymb]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`remsymConnectionSymmConjugateSourceConnectionSymmSymb="\!\(\*SubscriptBox[\[CapitalPi],\(hs\)]\)";
DefTensor[remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`remsymConnectionSymmConjugateSourceConnectionSymmSymb]];

AutomaticRules[totsymConnectionSymmConjugateSourceConnectionSymm,MakeRule[{totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a],Evaluate[(1/3)G[k,-i]G[l,-j]G[b,-a] +(1/3)G[k,-j]G[l,-a]G[b,-i] +(1/3)G[k,-i]G[l,-a]G[b,-j]]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[remsymConnectionSymmConjugateSourceConnectionSymm,MakeRule[{remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a],Evaluate[(2/3)G[k,-i]G[l,-j]G[b,-a] -(1/3)G[k,-j]G[l,-a]G[b,-i] -(1/3)G[k,-i]G[l,-a]G[b,-j]]},MetricOn->All,ContractMetrics->True]];

(*---------------------------------------------*)
(*  ConjugateSourceConnectionSymmhiyuan: Basic perpendicular and parallel  *)
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

DefTensor[ProjConnectionAntiPerp[-a,-b,d,e,f],M4];
DefTensor[ProjConnectionAntiPara[-a,-b,-c,d,e,f],M4];
DefTensor[ProjFPerp[-a,d,e],M4];
DefTensor[ProjFPara[-a,-b,d,e],M4];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjConnectionAntiPerpParaToVG=Join[
	MakeRule[{ProjConnectionAntiPerp[-a,-b,d,e,f],Evaluate[
		V[d]ProjPara[-a,e]G[-b,f]/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjConnectionAntiPara[-a,-b,-c,d,e,f],Evaluate[
		ProjPara[-a,d]ProjPara[-b,e]G[-c,f]/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjFPerp[-a,d,e],Evaluate[
		V[d]G[-a,e]/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjFPara[-a,-b,d,e],Evaluate[
		ProjPara[-a,d]G[-b,e]/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*------------------------------------*)
(*  Will: Spin-parity or SO(3) parts  *)
(*------------------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjConnectionAntiSymb="\!\(\*SubscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(\[Hacek]\)],\(\[ScriptCapitalA]\)]\)";
DefTensor[ProjConnectionAnti0p[c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjConnectionAntiSymb,xAct`PSALTer`Private`Spin0p]];
DefTensor[ProjConnectionAnti0m[d,e,f],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjConnectionAntiSymb,xAct`PSALTer`Private`Spin0m]];
DefTensor[ProjConnectionAnti1p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjConnectionAntiSymb,xAct`PSALTer`Private`Spin1p]];
DefTensor[ProjConnectionAnti1m[-a,d,e,f],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjConnectionAntiSymb,xAct`PSALTer`Private`Spin1m]];
DefTensor[ProjConnectionAnti2p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjConnectionAntiSymb,xAct`PSALTer`Private`Spin2p]];
DefTensor[ProjConnectionAnti2m[-a,-b,-c,d,e,f],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjConnectionAntiSymb,xAct`PSALTer`Private`Spin2m]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjConnectionAntiSpinParityToVG=Join[
	MakeRule[{ProjConnectionAnti0p[c,d],Evaluate[
		ProjPara[c,-k]ProjPara[d,-l]G[k,l]/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjConnectionAnti1p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l]Antisymmetrize[G[-i,k]G[-j,l],{-i,-j}]/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjConnectionAnti2p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l](Symmetrize[G[-i,k]G[-j,l],{-i,-j}]-(1/3)G[-i,-j]G[k,l])/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjConnectionAnti0m[d,e,f],Evaluate[
		ProjPara[-i,d]ProjPara[-j,e]ProjPara[-k,f]epsilonG[i,j,k,g]V[-g]/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjConnectionAnti1m[-a,d,e,f],Evaluate[
		ProjPara[-i,d]ProjPara[-j,f]ProjPara[k,-a]ProjPara[-l,e]G[i,j]G[-k,l]/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjConnectionAnti2m[-a,-b,-c,d,e,f],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[-c,k]ProjPara[d,-l]ProjPara[e,-n]ProjPara[f,-m](3/4)((1/3)(2G[-i,l]G[-j,n]G[-k,m]-G[-j,l]G[-k,n]G[-i,m]-G[-k,l]G[-i,n]G[-j,m])-Antisymmetrize[G[-i,-k]G[-j,n]G[l,m],{-i,-j}])/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

(*---------------------------------------------------------------------------*)
(*  Will: decomposition of asymmetric part field perpendicular and parallel  *)
(*---------------------------------------------------------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiParaSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalA],\(a\)]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[ConnectionAntiPara[-a,-b,-c],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiParaSymb],OrthogonalTo->{V[c]},Dagger->Complex];
xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiPerpSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalA],\(a\)]\),\(\[UpTee]\)]\)";
DefTensor[ConnectionAntiPerp[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiPerpSymb],Dagger->Complex];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiToConnectionAntiPerpPara=Join[
	MakeRule[{ConnectionAnti[-a,-b,-c],Evaluate[ConnectionAntiPara[-a,-b,-c]+V[-c]ConnectionAntiPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionAnti[-a,-b,-c],Evaluate[Dagger@(ConnectionAntiPara[-a,-b,-c]+V[-c]ConnectionAntiPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiPerpParaToConnectionAnti=Join[
	MakeRule[{ConnectionAntiPara[-a,-e,-b],Evaluate[
		ProjPara[-b,c]ConnectionAnti[-a,-e,-c]/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConnectionAntiPerp[-a,-e],Evaluate[
		V[c]ConnectionAnti[-a,-e,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionAntiPara[-a,-e,-b],Evaluate[Dagger@(
		ProjPara[-b,c]ConnectionAnti[-a,-e,-c]/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionAntiPerp[-a,-e],Evaluate[Dagger@(
		V[c]ConnectionAnti[-a,-e,-c])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionAntiParaSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalW],\(a\)]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[ConjugateSourceConnectionAntiPara[-c,-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionAntiParaSymb],OrthogonalTo->{V[c]},Dagger->Complex];
xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionAntiPerpSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalW],\(a\)]\),\(\[UpTee]\)]\)";
DefTensor[ConjugateSourceConnectionAntiPerp[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionAntiPerpSymb],Dagger->Complex];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionAntiToConjugateSourceConnectionAntiPerpPara=Join[
	MakeRule[{ConjugateSourceConnectionAnti[-c,-a,-b],Evaluate[	
		ConjugateSourceConnectionAntiPara[-c,-a,-b]+V[-c]ConjugateSourceConnectionAntiPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionAnti[-c,-a,-b],Evaluate[Dagger@(	
		ConjugateSourceConnectionAntiPara[-c,-a,-b]+V[-c]ConjugateSourceConnectionAntiPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionAntiPerpParaToConjugateSourceConnectionAnti=Join[
	MakeRule[{ConjugateSourceConnectionAntiPara[-b,-a,-e],Evaluate[
		ProjPara[-b,c]ConjugateSourceConnectionAnti[-c,-a,-e]/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceConnectionAntiPerp[-a,-e],Evaluate[
		V[c]ConjugateSourceConnectionAnti[-c,-a,-e]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionAntiPara[-b,-a,-e],Evaluate[Dagger@(
		ProjPara[-b,c]ConjugateSourceConnectionAnti[-c,-a,-e]/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionAntiPerp[-a,-e],Evaluate[Dagger@(
		V[c]ConjugateSourceConnectionAnti[-c,-a,-e])]},MetricOn->All,ContractMetrics->True]];

(*-------------------------------------------------------------------*)
(*  ConjugateSourceConnectionSymmhiyuan: decomposition of ConnectionSymm,ConjugateSourceConnectionSymm into full-indexed spin components  *)
(*-------------------------------------------------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmParaSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalA],\(s\)]\),\(\[DoubleVerticalBar]\)]\)";
xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmParaTSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalA],\(s\)]\),\(\[DoubleVerticalBar]t\)]\)";
xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmParaHSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalA],\(s\)]\),\(\[DoubleVerticalBar]h\)]\)";

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmPerpSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalA],\(s\)]\),\(\[UpTee]\)]\)";
xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmPerpTSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalA],\(s\)]\),\(\[UpTee]t\)]\)";
xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmPerpHSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalA],\(s\)]\),\(\[UpTee]h\)]\)";

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmParaSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalW],\(s\)]\),\(\[DoubleVerticalBar]\)]\)";
xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmParaTSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalW],\(s\)]\),\(\[DoubleVerticalBar]t\)]\)";
xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmParaHSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalW],\(s\)]\),\(\[DoubleVerticalBar]h\)]\)";

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmPerpSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalW],\(s\)]\),\(\[UpTee]\)]\)";
xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmPerpTSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalW],\(s\)]\),\(\[UpTee]t\)]\)";
xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmPerpHSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalW],\(s\)]\),\(\[UpTee]h\)]\)";

DefTensor[ConnectionSymmPerpT0pF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmPerpTSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ConnectionSymmPerpT1mF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmPerpTSymb,xAct`PSALTer`Private`Spin1m],Dagger->Complex];
DefTensor[ConnectionSymmPara0pF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ConnectionSymmPara2pF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmParaSymb,xAct`PSALTer`Private`Spin2p],Dagger->Complex];
DefTensor[ConnectionSymmParaT1mF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmParaTSymb,xAct`PSALTer`Private`Spin1m],Dagger->Complex];
DefTensor[ConnectionSymmPara3mF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmParaSymb,xAct`PSALTer`Private`Spin3m],Dagger->Complex];
DefTensor[ConnectionSymmPerpH1mF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmPerpHSymb,xAct`PSALTer`Private`Spin1m],Dagger->Complex];
DefTensor[ConnectionSymmPara1pF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmPerpSymb,xAct`PSALTer`Private`Spin1p],Dagger->Complex];
DefTensor[ConnectionSymmPerpH0pF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmPerpHSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ConnectionSymmPerp2pF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmPerpSymb,xAct`PSALTer`Private`Spin2p],Dagger->Complex];
DefTensor[ConnectionSymmParaH1mF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmParaHSymb,xAct`PSALTer`Private`Spin1m],Dagger->Complex];
DefTensor[ConnectionSymmPara2mF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmParaSymb,xAct`PSALTer`Private`Spin2m],Dagger->Complex];

DefTensor[ConjugateSourceConnectionSymmPerpT0pF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmPerpTSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ConjugateSourceConnectionSymmPerpT1mF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmPerpTSymb,xAct`PSALTer`Private`Spin1m],Dagger->Complex];
DefTensor[ConjugateSourceConnectionSymmPara0pF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ConjugateSourceConnectionSymmPara2pF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmParaSymb,xAct`PSALTer`Private`Spin2p],Dagger->Complex];
DefTensor[ConjugateSourceConnectionSymmParaT1mF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmParaTSymb,xAct`PSALTer`Private`Spin1m],Dagger->Complex];
DefTensor[ConjugateSourceConnectionSymmPara3mF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmParaSymb,xAct`PSALTer`Private`Spin3m],Dagger->Complex];
DefTensor[ConjugateSourceConnectionSymmPerpH1mF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmPerpHSymb,xAct`PSALTer`Private`Spin1m],Dagger->Complex];
DefTensor[ConjugateSourceConnectionSymmPara1pF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmPerpSymb,xAct`PSALTer`Private`Spin1p],Dagger->Complex];
DefTensor[ConjugateSourceConnectionSymmPerpH0pF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmPerpHSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ConjugateSourceConnectionSymmPerp2pF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmPerpSymb,xAct`PSALTer`Private`Spin2p],Dagger->Complex];
DefTensor[ConjugateSourceConnectionSymmParaH1mF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmParaHSymb,xAct`PSALTer`Private`Spin1m],Dagger->Complex];
DefTensor[ConjugateSourceConnectionSymmPara2mF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmParaSymb,xAct`PSALTer`Private`Spin2m],Dagger->Complex];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ExpandConnectionSymmConjugateSourceConnectionSymmtoF=Join[
	MakeRule[{ConnectionSymm[-i,-j,-a],Evaluate[ConnectionSymmPerpT0pF[-i,-j,-a]+ConnectionSymmPerpT1mF[-i,-j,-a]+ConnectionSymmPara0pF[-i,-j,-a]+ConnectionSymmPara2pF[-i,-j,-a]+ConnectionSymmParaT1mF[-i,-j,-a]+ConnectionSymmPara3mF[-i,-j,-a]+ConnectionSymmPerpH1mF[-i,-j,-a]+ConnectionSymmPara1pF[-i,-j,-a]+ConnectionSymmPerpH0pF[-i,-j,-a]+ConnectionSymmPerp2pF[-i,-j,-a]+ConnectionSymmParaH1mF[-i,-j,-a]+ConnectionSymmPara2mF[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceConnectionSymm[-i,-j,-a],Evaluate[ConjugateSourceConnectionSymmPerpT0pF[-i,-j,-a]+ConjugateSourceConnectionSymmPerpT1mF[-i,-j,-a]+ConjugateSourceConnectionSymmPara0pF[-i,-j,-a]+ConjugateSourceConnectionSymmPara2pF[-i,-j,-a]+ConjugateSourceConnectionSymmParaT1mF[-i,-j,-a]+ConjugateSourceConnectionSymmPara3mF[-i,-j,-a]+ConjugateSourceConnectionSymmPerpH1mF[-i,-j,-a]+ConjugateSourceConnectionSymmPara1pF[-i,-j,-a]+ConjugateSourceConnectionSymmPerpH0pF[-i,-j,-a]+ConjugateSourceConnectionSymmPerp2pF[-i,-j,-a]+ConjugateSourceConnectionSymmParaH1mF[-i,-j,-a]+ConjugateSourceConnectionSymmPara2mF[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{Evaluate@Dagger@ConnectionSymm[-i,-j,-a],Evaluate[Dagger@(ConnectionSymmPerpT0pF[-i,-j,-a]+ConnectionSymmPerpT1mF[-i,-j,-a]+ConnectionSymmPara0pF[-i,-j,-a]+ConnectionSymmPara2pF[-i,-j,-a]+ConnectionSymmParaT1mF[-i,-j,-a]+ConnectionSymmPara3mF[-i,-j,-a]+ConnectionSymmPerpH1mF[-i,-j,-a]+ConnectionSymmPara1pF[-i,-j,-a]+ConnectionSymmPerpH0pF[-i,-j,-a]+ConnectionSymmPerp2pF[-i,-j,-a]+ConnectionSymmParaH1mF[-i,-j,-a]+ConnectionSymmPara2mF[-i,-j,-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionSymm[-i,-j,-a],Evaluate[Dagger@(ConjugateSourceConnectionSymmPerpT0pF[-i,-j,-a]+ConjugateSourceConnectionSymmPerpT1mF[-i,-j,-a]+ConjugateSourceConnectionSymmPara0pF[-i,-j,-a]+ConjugateSourceConnectionSymmPara2pF[-i,-j,-a]+ConjugateSourceConnectionSymmParaT1mF[-i,-j,-a]+ConjugateSourceConnectionSymmPara3mF[-i,-j,-a]+ConjugateSourceConnectionSymmPerpH1mF[-i,-j,-a]+ConjugateSourceConnectionSymmPara1pF[-i,-j,-a]+ConjugateSourceConnectionSymmPerpH0pF[-i,-j,-a]+ConjugateSourceConnectionSymmPerp2pF[-i,-j,-a]+ConjugateSourceConnectionSymmParaH1mF[-i,-j,-a]+ConjugateSourceConnectionSymmPara2mF[-i,-j,-a])]},MetricOn->All,ContractMetrics->True]
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

DefSpinParityMode[ConnectionAntiPara0p[],Spin->0,Parity->Even,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiParaSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionAntiParaSymb];
DefSpinParityMode[ConnectionAntiPara0m[],Spin->0,Parity->Odd,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiParaSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionAntiParaSymb];
DefSpinParityMode[ConnectionAntiPara1p[-a,-b],Antisymmetric[{-a,-b}],Spin->1,Parity->Even,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiParaSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionAntiParaSymb];
DefSpinParityMode[ConnectionAntiPara1m[-a],Spin->1,Parity->Odd,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiParaSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionAntiParaSymb];
DefSpinParityMode[ConnectionAntiPara2p[-a,-b],Symmetric[{-a,-b}],Spin->2,Parity->Even,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiParaSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionAntiParaSymb];
DefSpinParityMode[ConnectionAntiPara2m[-a,-b,-c],Antisymmetric[{-a,-b}],Spin->2,Parity->Odd,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiParaSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionAntiParaSymb];
DefSpinParityMode[ConnectionAntiPerp1p[-a,-b],Antisymmetric[{-a,-b}],Spin->1,Parity->Even,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiPerpSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionAntiPerpSymb];
DefSpinParityMode[ConnectionAntiPerp1m[-a],Spin->1,Parity->Odd,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiPerpSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionAntiPerpSymb];

(*
DefTensor[ConnectionAntiPerp1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiPerpSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
*)
(*
DefTensor[ConnectionAntiPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
*)
(*
DefTensor[ConjugateSourceConnectionAntiPerp1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionAntiPerpSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
*)
(*
DefTensor[ConjugateSourceConnectionAntiPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionAntiPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
*)

(*------------------------------------------------------------*)
(*  ConjugateSourceConnectionSymmhiyuan: definition of ConnectionSymm,ConjugateSourceConnectionSymm reduced-index spin components  *)
(*------------------------------------------------------------*)

DefSpinParityMode[ConnectionSymmPerpT0p[],Spin->0,Parity->Even,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmPerpTSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmPerpTSymb];
DefSpinParityMode[ConnectionSymmPerpT1m[-i],Spin->1,Parity->Odd,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmPerpTSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmPerpTSymb];
DefSpinParityMode[ConnectionSymmPara0p[],Spin->0,Parity->Even,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmParaSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmParaSymb];
DefSpinParityMode[ConnectionSymmPara2p[-i,-j],Symmetric[{-i,-j}],Spin->2,Parity->Even,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmParaSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmParaSymb];
DefSpinParityMode[ConnectionSymmParaT1m[-i],Spin->1,Parity->Odd,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmParaTSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmParaTSymb];
DefSpinParityMode[ConnectionSymmPara3m[-i,-j,-a],Symmetric[{-i,-j,-a}],Spin->3,Parity->Odd,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmParaSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmParaSymb];
DefSpinParityMode[ConnectionSymmPerpH1m[-i],Spin->1,Parity->Odd,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmPerpHSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmPerpHSymb];
DefSpinParityMode[ConnectionSymmPara1p[-i,-a],Antisymmetric[{-i,-a}],Spin->1,Parity->Even,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmPerpSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmPerpSymb];
DefSpinParityMode[ConnectionSymmPerpH0p[],Spin->0,Parity->Even,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmPerpHSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmPerpHSymb];
DefSpinParityMode[ConnectionSymmPerp2p[-i,-j],Symmetric[{-i,-j}],Spin->2,Parity->Even,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmPerpSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmPerpSymb];
DefSpinParityMode[ConnectionSymmParaH1m[-i],Spin->1,Parity->Odd,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmParaHSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmParaHSymb];
DefSpinParityMode[ConnectionSymmPara2m[-i,-j,-a],Symmetric[{-i,-j}],MultiTermSymmetries->{ConnectionSymmPara2m[-i,-j,-a]+ConnectionSymmPara2m[-a,-i,-j]+ConnectionSymmPara2m[-j,-a,-i]},Spin->2,Parity->Odd,
	FieldSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionSymmParaSymb,
	SourceSymbol->xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionSymmParaSymb];

(*==============*)
(*  Expansions  *)
(*==============*)

(*----------------------------------------*)
(*  Will: metric perturbation expansions  *)
(*----------------------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`LinearMetricSpinParityToLinearMetric=Join[
	MakeRule[{LinearMetricPerp0p[],Evaluate[
		ProjPerp[a,b]LinearMetric[-a,-b]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{LinearMetricPerp1m[-a],Evaluate[
		V[b]ProjPara[-a,c]LinearMetric[-c,-b]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{LinearMetricPara0p[],Evaluate[
		ProjPara[a,b]LinearMetric[-a,-b]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{LinearMetricPara2p[-a,-b],Evaluate[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*LinearMetric[-c,-d]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@LinearMetricPerp0p[],Evaluate@Dagger[
		ProjPerp[a,b]LinearMetric[-a,-b]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@LinearMetricPerp1m[-a],Evaluate@Dagger[
		V[b]ProjPara[-a,c]LinearMetric[-c,-b]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@LinearMetricPara0p[],Evaluate@Dagger[
		ProjPara[a,b]LinearMetric[-a,-b]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@LinearMetricPara2p[-a,-b],Evaluate@Dagger[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*LinearMetric[-c,-d]//ToCanonical]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceLinearMetricSpinParityToConjugateSourceLinearMetric=Join[
	MakeRule[{ConjugateSourceLinearMetricPerp0p[],Evaluate[
		ProjPerp[a,b]ConjugateSourceLinearMetric[-a,-b]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceLinearMetricPerp1m[-a],Evaluate[
		V[b]ProjPara[-a,c]ConjugateSourceLinearMetric[-c,-b]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceLinearMetricPara0p[],Evaluate[
		ProjPara[a,b]ConjugateSourceLinearMetric[-a,-b]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceLinearMetricPara2p[-a,-b],Evaluate[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*ConjugateSourceLinearMetric[-c,-d]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceLinearMetricPerp0p[],Evaluate@Dagger[
		ProjPerp[a,b]ConjugateSourceLinearMetric[-a,-b]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceLinearMetricPerp1m[-a],Evaluate@Dagger[
		V[b]ProjPara[-a,c]ConjugateSourceLinearMetric[-c,-b]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceLinearMetricPara0p[],Evaluate@Dagger[
		ProjPara[a,b]ConjugateSourceLinearMetric[-a,-b]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceLinearMetricPara2p[-a,-b],Evaluate@Dagger[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*ConjugateSourceLinearMetric[-c,-d]//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*--------------------------*)
(*  Will: other expansions  *)
(*--------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiParaSpinParityToConnectionAnti=Join[
	MakeRule[{ConnectionAntiPara0p[],Scalar[Evaluate[
		ProjConnectionAnti0p[e,f]ProjConnectionAntiPerp[-e,-f,a,b,c]ConnectionAntiPara[-a,-b,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConnectionAntiPara0m[],Scalar[Evaluate[
		ProjConnectionAnti0m[d,e,f]ProjConnectionAntiPara[-d,-e,-f,a,b,c]ConnectionAntiPara[-a,-b,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConnectionAntiPara1p[-n,-m],Evaluate[
		ProjConnectionAnti1p[-n,-m,e,f]ProjConnectionAntiPerp[-e,-f,a,b,c]ConnectionAntiPara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConnectionAntiPara1m[-n],Evaluate[
		ProjConnectionAnti1m[-n,d,e,f]ProjConnectionAntiPara[-d,-e,-f,a,b,c]ConnectionAntiPara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConnectionAntiPara2p[-n,-m],Evaluate[
		ProjConnectionAnti2p[-n,-m,e,f]ProjConnectionAntiPerp[-e,-f,a,b,c]ConnectionAntiPara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConnectionAntiPara2m[-n,-m,-o],Evaluate[
		ProjConnectionAnti2m[-n,-m,-o,d,e,f]ProjConnectionAntiPara[-d,-e,-f,a,b,c]ConnectionAntiPara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionAntiPara0p[],Scalar[Evaluate[Dagger@(
		ProjConnectionAnti0p[e,f]ProjConnectionAntiPerp[-e,-f,a,b,c]ConnectionAntiPara[-a,-b,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionAntiPara0m[],Scalar[Evaluate[Dagger@(
		ProjConnectionAnti0m[d,e,f]ProjConnectionAntiPara[-d,-e,-f,a,b,c]ConnectionAntiPara[-a,-b,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionAntiPara1p[-n,-m],Evaluate[Dagger@(
		ProjConnectionAnti1p[-n,-m,e,f]ProjConnectionAntiPerp[-e,-f,a,b,c]ConnectionAntiPara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionAntiPara1m[-n],Evaluate[Dagger@(
		ProjConnectionAnti1m[-n,d,e,f]ProjConnectionAntiPara[-d,-e,-f,a,b,c]ConnectionAntiPara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionAntiPara2p[-n,-m],Evaluate[Dagger@(
		ProjConnectionAnti2p[-n,-m,e,f]ProjConnectionAntiPerp[-e,-f,a,b,c]ConnectionAntiPara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionAntiPara2m[-n,-m,-o],Evaluate[Dagger@(
		ProjConnectionAnti2m[-n,-m,-o,d,e,f]ProjConnectionAntiPara[-d,-e,-f,a,b,c]ConnectionAntiPara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiPerpSpinParityToConnectionAnti=Join[
	MakeRule[{ConnectionAntiPerp1p[-n,-m],Evaluate[
		ProjPara[-n,a]ProjPara[-m,b]ConnectionAntiPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConnectionAntiPerp1m[-n],Evaluate[
		ProjPara[-n,a]V[b]ConnectionAntiPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionAntiPerp1p[-n,-m],Evaluate[Dagger@(
		ProjPara[-n,a]ProjPara[-m,b]ConnectionAntiPerp[-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionAntiPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]V[b]ConnectionAntiPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionAntiParaSpinParityToConjugateSourceConnectionAnti=Join[
	MakeRule[{ConjugateSourceConnectionAntiPara0p[],Scalar[Evaluate[
		ProjConnectionAnti0p[e,f]ProjConnectionAntiPerp[-e,-f,a,b,c]ConjugateSourceConnectionAntiPara[-c,-a,-b]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceConnectionAntiPara0m[],Scalar[Evaluate[
		ProjConnectionAnti0m[d,e,f]ProjConnectionAntiPara[-d,-e,-f,a,b,c]ConjugateSourceConnectionAntiPara[-c,-a,-b]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceConnectionAntiPara1p[-n,-m],Evaluate[
		ProjConnectionAnti1p[-n,-m,e,f]ProjConnectionAntiPerp[-e,-f,a,b,c]ConjugateSourceConnectionAntiPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceConnectionAntiPara1m[-n],Evaluate[
		ProjConnectionAnti1m[-n,d,e,f]ProjConnectionAntiPara[-d,-e,-f,a,b,c]ConjugateSourceConnectionAntiPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceConnectionAntiPara2p[-n,-m],Evaluate[
		ProjConnectionAnti2p[-n,-m,e,f]ProjConnectionAntiPerp[-e,-f,a,b,c]ConjugateSourceConnectionAntiPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceConnectionAntiPara2m[-n,-m,-o],Evaluate[
		ProjConnectionAnti2m[-n,-m,-o,d,e,f]ProjConnectionAntiPara[-d,-e,-f,a,b,c]ConjugateSourceConnectionAntiPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionAntiPara0p[],Scalar[Evaluate[Dagger@(
		ProjConnectionAnti0p[e,f]ProjConnectionAntiPerp[-e,-f,a,b,c]ConjugateSourceConnectionAntiPara[-c,-a,-b])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionAntiPara0m[],Scalar[Evaluate[Dagger@(
		ProjConnectionAnti0m[d,e,f]ProjConnectionAntiPara[-d,-e,-f,a,b,c]ConjugateSourceConnectionAntiPara[-c,-a,-b])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionAntiPara1p[-n,-m],Evaluate[Dagger@(
		ProjConnectionAnti1p[-n,-m,e,f]ProjConnectionAntiPerp[-e,-f,a,b,c]ConjugateSourceConnectionAntiPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionAntiPara1m[-n],Evaluate[Dagger@(
		ProjConnectionAnti1m[-n,d,e,f]ProjConnectionAntiPara[-d,-e,-f,a,b,c]ConjugateSourceConnectionAntiPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionAntiPara2p[-n,-m],Evaluate[Dagger@(
		ProjConnectionAnti2p[-n,-m,e,f]ProjConnectionAntiPerp[-e,-f,a,b,c]ConjugateSourceConnectionAntiPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionAntiPara2m[-n,-m,-o],Evaluate[Dagger@(
		ProjConnectionAnti2m[-n,-m,-o,d,e,f]ProjConnectionAntiPara[-d,-e,-f,a,b,c]ConjugateSourceConnectionAntiPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionAntiPerpSpinParityToConjugateSourceConnectionAnti=Join[
	MakeRule[{ConjugateSourceConnectionAntiPerp1p[-n,-m],Evaluate[
		ProjPara[-n,a]ProjPara[-m,b]ConjugateSourceConnectionAntiPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceConnectionAntiPerp1m[-n],Evaluate[
		ProjPara[-n,a]V[b]ConjugateSourceConnectionAntiPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionAntiPerp1p[-n,-m],Evaluate[Dagger@(
		ProjPara[-n,a]ProjPara[-m,b]ConjugateSourceConnectionAntiPerp[-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionAntiPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]V[b]ConjugateSourceConnectionAntiPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

(*---------------------------------*)
(*  ConjugateSourceConnectionSymmhiyuan: MAG expansions (ConnectionSymm,ConjugateSourceConnectionSymm)  *)
(*---------------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`ExpandConnectionSymmFtoReduced=Join[
	MakeRule[{ConnectionSymmPerpT0pF[-i,-j,-a],Evaluate[(V[-i]V[-j]V[-a]ConnectionSymmPerpT0p[])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionSymmPerpT0pF[-i,-j,-a],Evaluate@Dagger[(V[-i]V[-j]V[-a]ConnectionSymmPerpT0p[])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConnectionSymmPerpT1mF[-i,-j,-a],Evaluate[(totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]V[-k]V[-l]ConnectionSymmPerpT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionSymmPerpT1mF[-i,-j,-a],Evaluate@Dagger[(totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]V[-k]V[-l]ConnectionSymmPerpT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConnectionSymmPara0pF[-i,-j,-a],Evaluate[((ConnectionSymmPara0p[]/3)totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionSymmPara0pF[-i,-j,-a],Evaluate@Dagger[((ConnectionSymmPara0p[]/3)totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConnectionSymmPara2pF[-i,-j,-a],Evaluate[(totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]ConnectionSymmPara2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionSymmPara2pF[-i,-j,-a],Evaluate@Dagger[(totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]ConnectionSymmPara2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConnectionSymmParaT1mF[-i,-j,-a],Evaluate[((1/5)totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]ConnectionSymmParaT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionSymmParaT1mF[-i,-j,-a],Evaluate@Dagger[((1/5)totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]ConnectionSymmParaT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConnectionSymmPara3mF[-i,-j,-a],Evaluate[ConnectionSymmPara3m[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionSymmPara3mF[-i,-j,-a],Evaluate@Dagger[ConnectionSymmPara3m[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConnectionSymmPerpH1mF[-i,-j,-a],Evaluate[(remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]V[-k]V[-l]ConnectionSymmPerpH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionSymmPerpH1mF[-i,-j,-a],Evaluate@Dagger[(remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]V[-k]V[-l]ConnectionSymmPerpH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConnectionSymmPara1pF[-i,-j,-a],Evaluate[((1/2)(V[-i]ConnectionSymmPara1p[-j,-a]+V[-j]ConnectionSymmPara1p[-i,-a]))//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionSymmPara1pF[-i,-j,-a],Evaluate@Dagger[((1/2)(V[-i]ConnectionSymmPara1p[-j,-a]+V[-j]ConnectionSymmPara1p[-i,-a]))//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConnectionSymmPerpH0pF[-i,-j,-a],Evaluate[((ConnectionSymmPerpH0p[]/3)remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionSymmPerpH0pF[-i,-j,-a],Evaluate@Dagger[((ConnectionSymmPerpH0p[]/3)remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConnectionSymmPerp2pF[-i,-j,-a],Evaluate[(remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]ConnectionSymmPerp2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionSymmPerp2pF[-i,-j,-a],Evaluate@Dagger[(remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]ConnectionSymmPerp2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConnectionSymmParaH1mF[-i,-j,-a],Evaluate[((1/2)remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]ConnectionSymmParaH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionSymmParaH1mF[-i,-j,-a],Evaluate@Dagger[((1/2)remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]ConnectionSymmParaH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConnectionSymmPara2mF[-i,-j,-a],Evaluate[ConnectionSymmPara2m[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionSymmPara2mF[-i,-j,-a],Evaluate@Dagger[ConnectionSymmPara2m[-i,-j,-a]]},MetricOn->All,ContractMetrics->True]	
];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ExpandConjugateSourceConnectionSymmFtoReduced=Join[
	MakeRule[{ConjugateSourceConnectionSymmPerpT0pF[-i,-j,-a],Evaluate[(V[-i]V[-j]V[-a]ConjugateSourceConnectionSymmPerpT0p[])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionSymmPerpT0pF[-i,-j,-a],Evaluate@Dagger[(V[-i]V[-j]V[-a]ConjugateSourceConnectionSymmPerpT0p[])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceConnectionSymmPerpT1mF[-i,-j,-a],Evaluate[(totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]V[-k]V[-l]ConjugateSourceConnectionSymmPerpT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionSymmPerpT1mF[-i,-j,-a],Evaluate@Dagger[(totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]V[-k]V[-l]ConjugateSourceConnectionSymmPerpT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceConnectionSymmPara0pF[-i,-j,-a],Evaluate[((ConjugateSourceConnectionSymmPara0p[]/3)totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionSymmPara0pF[-i,-j,-a],Evaluate@Dagger[((ConjugateSourceConnectionSymmPara0p[]/3)totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceConnectionSymmPara2pF[-i,-j,-a],Evaluate[(totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]ConjugateSourceConnectionSymmPara2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionSymmPara2pF[-i,-j,-a],Evaluate@Dagger[(totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]ConjugateSourceConnectionSymmPara2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceConnectionSymmParaT1mF[-i,-j,-a],Evaluate[((1/5)totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]ConjugateSourceConnectionSymmParaT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionSymmParaT1mF[-i,-j,-a],Evaluate@Dagger[((1/5)totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]ConjugateSourceConnectionSymmParaT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceConnectionSymmPara3mF[-i,-j,-a],Evaluate[ConjugateSourceConnectionSymmPara3m[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionSymmPara3mF[-i,-j,-a],Evaluate@Dagger[ConjugateSourceConnectionSymmPara3m[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceConnectionSymmPerpH1mF[-i,-j,-a],Evaluate[(remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]V[-k]V[-l]ConjugateSourceConnectionSymmPerpH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionSymmPerpH1mF[-i,-j,-a],Evaluate@Dagger[(remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]V[-k]V[-l]ConjugateSourceConnectionSymmPerpH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceConnectionSymmPara1pF[-i,-j,-a],Evaluate[((1/2)(V[-i]ConjugateSourceConnectionSymmPara1p[-j,-a]+V[-j]ConjugateSourceConnectionSymmPara1p[-i,-a]))//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionSymmPara1pF[-i,-j,-a],Evaluate@Dagger[((1/2)(V[-i]ConjugateSourceConnectionSymmPara1p[-j,-a]+V[-j]ConjugateSourceConnectionSymmPara1p[-i,-a]))//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceConnectionSymmPerpH0pF[-i,-j,-a],Evaluate[((ConjugateSourceConnectionSymmPerpH0p[]/3)remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionSymmPerpH0pF[-i,-j,-a],Evaluate@Dagger[((ConjugateSourceConnectionSymmPerpH0p[]/3)remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceConnectionSymmPerp2pF[-i,-j,-a],Evaluate[(remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]ConjugateSourceConnectionSymmPerp2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionSymmPerp2pF[-i,-j,-a],Evaluate@Dagger[(remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]ConjugateSourceConnectionSymmPerp2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceConnectionSymmParaH1mF[-i,-j,-a],Evaluate[((1/2)remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]ConjugateSourceConnectionSymmParaH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionSymmParaH1mF[-i,-j,-a],Evaluate@Dagger[((1/2)remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]ConjugateSourceConnectionSymmParaH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceConnectionSymmPara2mF[-i,-j,-a],Evaluate[ConjugateSourceConnectionSymmPara2m[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionSymmPara2mF[-i,-j,-a],Evaluate@Dagger[ConjugateSourceConnectionSymmPara2m[-i,-j,-a]]},MetricOn->All,ContractMetrics->True]	
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
		)//ToCanonical
	]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@LinearMetric[-a,-b],Evaluate@Dagger[
		(
			LinearMetricPerp0p[]V[-a]V[-b]
			+LinearMetricPerp1m[-a]V[-b]
			+LinearMetricPerp1m[-b]V[-a]
			+(1/3)*LinearMetricPara0p[]ProjPara[-a,-b]
			+LinearMetricPara2p[-a,-b]
		)//ToCanonical
	]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceLinearMetricToConjugateSourceLinearMetricSpinParity=Join[
	MakeRule[{ConjugateSourceLinearMetric[-a,-b],Evaluate[
		(
			ConjugateSourceLinearMetricPerp0p[]V[-a]V[-b]
			+ConjugateSourceLinearMetricPerp1m[-a]V[-b]
			+ConjugateSourceLinearMetricPerp1m[-b]V[-a]
			+(1/3)*ConjugateSourceLinearMetricPara0p[]ProjPara[-a,-b]
			+ConjugateSourceLinearMetricPara2p[-a,-b]
		)//ToCanonical
	]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceLinearMetric[-a,-b],Evaluate@Dagger[
		(
			ConjugateSourceLinearMetricPerp0p[]V[-a]V[-b]
			+ConjugateSourceLinearMetricPerp1m[-a]V[-b]
			+ConjugateSourceLinearMetricPerp1m[-b]V[-a]
			+(1/3)*ConjugateSourceLinearMetricPara0p[]ProjPara[-a,-b]
			+ConjugateSourceLinearMetricPara2p[-a,-b]
		)//ToCanonical
	]},MetricOn->All,ContractMetrics->True]];

(*------------------------------*)
(*  Will: other decompositions  *)
(*------------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiParaToConnectionAntiParaSpinParity=Join[
	MakeRule[{ConnectionAntiPara[-n,-m,-o],Evaluate[
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]ConnectionAntiPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]ConnectionAntiPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]ConnectionAntiPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjConnectionAnti0m[-n,-m,-o]ConnectionAntiPara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]ConnectionAntiPara1m[-n],{-m,-n}]+
		(4/3)ConnectionAntiPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjConnectionAntiSpinParityToVG/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionAntiPara[-n,-m,-o],Evaluate[Dagger@(
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]ConnectionAntiPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]ConnectionAntiPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]ConnectionAntiPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjConnectionAnti0m[-n,-m,-o]ConnectionAntiPara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]ConnectionAntiPara1m[-n],{-m,-n}]+
		(4/3)ConnectionAntiPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjConnectionAntiSpinParityToVG/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiPerpToConnectionAntiPerpSpinParity=Join[
	MakeRule[{ConnectionAntiPerp[-n,-m],Evaluate[ConnectionAntiPerp1p[-n,-m]+2Antisymmetrize[V[-m]ConnectionAntiPerp1m[-n],{-n,-m}]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionAntiPerp[-n,-m],Evaluate[Dagger@(ConnectionAntiPerp1p[-n,-m]+2Antisymmetrize[V[-m]ConnectionAntiPerp1m[-n],{-n,-m}])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionAntiParaToConjugateSourceConnectionAntiParaSpinParity=Join[
	MakeRule[{ConjugateSourceConnectionAntiPara[-o,-n,-m],Evaluate[
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]ConjugateSourceConnectionAntiPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]ConjugateSourceConnectionAntiPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]ConjugateSourceConnectionAntiPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjConnectionAnti0m[-n,-m,-o]ConjugateSourceConnectionAntiPara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]ConjugateSourceConnectionAntiPara1m[-n],{-m,-n}]+
		(4/3)ConjugateSourceConnectionAntiPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjConnectionAntiSpinParityToVG/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionAntiPara[-o,-n,-m],Evaluate[Dagger@(
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]ConjugateSourceConnectionAntiPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]ConjugateSourceConnectionAntiPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]ConjugateSourceConnectionAntiPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjConnectionAnti0m[-n,-m,-o]ConjugateSourceConnectionAntiPara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]ConjugateSourceConnectionAntiPara1m[-n],{-m,-n}]+
		(4/3)ConjugateSourceConnectionAntiPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjConnectionAntiSpinParityToVG/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionAntiPerpToConjugateSourceConnectionAntiPerpSpinParity=Join[
	MakeRule[{ConjugateSourceConnectionAntiPerp[-n,-m],Evaluate[ConjugateSourceConnectionAntiPerp1p[-n,-m]+2Antisymmetrize[V[-m]ConjugateSourceConnectionAntiPerp1m[-n],{-n,-m}]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionAntiPerp[-n,-m],Evaluate[Dagger@(ConjugateSourceConnectionAntiPerp1p[-n,-m]+2Antisymmetrize[V[-m]ConjugateSourceConnectionAntiPerp1m[-n],{-n,-m}])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`MetricAffineGaugeTheory`Private`Patch2m=Join[
	MakeRule[{ConnectionAntiPara2m[-a,-c,-b]ConnectionAntiPara2m[a,b,c],(1/2)ConnectionAntiPara2m[-a,-b,-c]ConnectionAntiPara2m[a,b,c]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate[Dagger@ConnectionAntiPara2m[-a,-c,-b]ConnectionAntiPara2m[a,b,c]],Evaluate[(1/2)Dagger@ConnectionAntiPara2m[-a,-b,-c]ConnectionAntiPara2m[a,b,c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate[ConnectionAntiPara2m[-a,-c,-b]Dagger@ConnectionAntiPara2m[a,b,c]],Evaluate[(1/2)ConnectionAntiPara2m[-a,-b,-c]Dagger@ConnectionAntiPara2m[a,b,c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceConnectionAntiPara2m[-a,-c,-b]ConjugateSourceConnectionAntiPara2m[a,b,c],(1/2)ConjugateSourceConnectionAntiPara2m[-a,-b,-c]ConjugateSourceConnectionAntiPara2m[a,b,c]},MetricOn->All,ContractMetrics->True]];

(*-------------------------------------*)
(*  ConjugateSourceConnectionSymmhiyuan: MAG decompositions (ConnectionSymm,ConjugateSourceConnectionSymm)  *)
(*-------------------------------------*)

xAct`PSALTer`MetricAffineGaugeTheory`Private`DecomposeConnectionSymmReducedtoConnectionSymm=Join[
	MakeRule[{ConnectionSymmPerpT0p[],Evaluate[V[i]V[j]V[a]ConnectionSymm[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionSymmPerpT0p[],Evaluate@Dagger[V[i]V[j]V[a]ConnectionSymm[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConnectionSymmPerpT1m[-i],Evaluate[(3ProjPara[m,-i]V[n]V[c]totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionSymmPerpT1m[-i],Evaluate@Dagger[(3ProjPara[m,-i]V[n]V[c]totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConnectionSymmPara0p[],Evaluate[(3ProjPara[m,-z]ProjPara[n,z]V[c]totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionSymmPara0p[],Evaluate@Dagger[(3ProjPara[m,-z]ProjPara[n,z]V[c]totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConnectionSymmPara2p[-i,-j],Evaluate[((3ProjPara[m,-i]ProjPara[n,-j]-ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z])V[c]totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionSymmPara2p[-i,-j],Evaluate@Dagger[((3ProjPara[m,-i]ProjPara[n,-j]-ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z])V[c]totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConnectionSymmParaT1m[-i],Evaluate[(3ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionSymmParaT1m[-i],Evaluate@Dagger[(3ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConnectionSymmPara3m[-i,-j,-a],Evaluate[((ProjPara[m,-i]ProjPara[n,-j]ProjPara[c,-a]-(1/5)(ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z]ProjPara[c,-a]+ProjPara[-j,-a]ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]+ProjPara[-i,-a]ProjPara[m,-z]ProjPara[n,-j]ProjPara[c,z]))totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionSymmPara3m[-i,-j,-a],Evaluate@Dagger[((ProjPara[m,-i]ProjPara[n,-j]ProjPara[c,-a]-(1/5)(ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z]ProjPara[c,-a]+ProjPara[-j,-a]ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]+ProjPara[-i,-a]ProjPara[m,-z]ProjPara[n,-j]ProjPara[c,z]))totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConnectionSymmPerpH1m[-i],Evaluate[((ConnectionSymm[-k,-l,-i]-ConnectionSymm[-i,-k,-l])V[k]V[l])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionSymmPerpH1m[-i],Evaluate@Dagger[((ConnectionSymm[-k,-l,-i]-ConnectionSymm[-i,-k,-l])V[k]V[l])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConnectionSymmPara1p[-i,-a],Evaluate[((ConnectionSymm[-k,-i,-a]-ConnectionSymm[-k,-a,-i])V[k]+V[k]V[l]((ConnectionSymm[-k,-l,-i]-ConnectionSymm[-i,-k,-l])V[-a]-(ConnectionSymm[-k,-l,-a]-ConnectionSymm[-a,-k,-l])V[-i]))//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionSymmPara1p[-i,-a],Evaluate@Dagger[((ConnectionSymm[-k,-i,-a]-ConnectionSymm[-k,-a,-i])V[k]+V[k]V[l]((ConnectionSymm[-k,-l,-i]-ConnectionSymm[-i,-k,-l])V[-a]-(ConnectionSymm[-k,-l,-a]-ConnectionSymm[-a,-k,-l])V[-i]))//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConnectionSymmPerpH0p[],Evaluate[(ConnectionSymm[k,-k,-i]-ConnectionSymm[-i,-k,k])V[i]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionSymmPerpH0p[],Evaluate@Dagger[(ConnectionSymm[k,-k,-i]-ConnectionSymm[-i,-k,k])V[i]]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConnectionSymmPerp2p[-i,-j],Evaluate[((3/2)(ProjPara[m,-i]ProjPara[n,-j]-(ProjPara[-i,-j]/3)ProjPara[m,-z]ProjPara[n,z])V[c]remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionSymmPerp2p[-i,-j],Evaluate@Dagger[((3/2)(ProjPara[m,-i]ProjPara[n,-j]-(ProjPara[-i,-j]/3)ProjPara[m,-z]ProjPara[n,z])V[c]remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConnectionSymmParaH1m[-i],Evaluate[((-3)ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionSymmParaH1m[-i],Evaluate@Dagger[((-3)ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConnectionSymmPara2m[-i,-j,-a],Evaluate[((ProjPara[m,-i]ProjPara[n,-j]ProjPara[c,-a]-(1/2)(ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z]ProjPara[c,-a]+ProjPara[-j,-a]ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]+ProjPara[-i,-a]ProjPara[m,-z]ProjPara[n,-j]ProjPara[c,z]))remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConnectionSymmPara2m[-i,-j,-a],Evaluate@Dagger[((ProjPara[m,-i]ProjPara[n,-j]ProjPara[c,-a]-(1/2)(ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z]ProjPara[c,-a]+ProjPara[-j,-a]ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]+ProjPara[-i,-a]ProjPara[m,-z]ProjPara[n,-j]ProjPara[c,z]))remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True]
];

xAct`PSALTer`MetricAffineGaugeTheory`Private`DecomposeConjugateSourceConnectionSymmReducedtoConjugateSourceConnectionSymm=Join[
	MakeRule[{ConjugateSourceConnectionSymmPerpT0p[],Evaluate[V[i]V[j]V[a]ConjugateSourceConnectionSymm[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionSymmPerpT0p[],Evaluate@Dagger[V[i]V[j]V[a]ConjugateSourceConnectionSymm[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceConnectionSymmPerpT1m[-i],Evaluate[(3ProjPara[m,-i]V[n]V[c]totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionSymmPerpT1m[-i],Evaluate@Dagger[(3ProjPara[m,-i]V[n]V[c]totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceConnectionSymmPara0p[],Evaluate[(3ProjPara[m,-z]ProjPara[n,z]V[c]totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionSymmPara0p[],Evaluate@Dagger[(3ProjPara[m,-z]ProjPara[n,z]V[c]totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceConnectionSymmPara2p[-i,-j],Evaluate[((3ProjPara[m,-i]ProjPara[n,-j]-ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z])V[c]totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionSymmPara2p[-i,-j],Evaluate@Dagger[((3ProjPara[m,-i]ProjPara[n,-j]-ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z])V[c]totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceConnectionSymmParaT1m[-i],Evaluate[(3ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionSymmParaT1m[-i],Evaluate@Dagger[(3ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceConnectionSymmPara3m[-i,-j,-a],Evaluate[((ProjPara[m,-i]ProjPara[n,-j]ProjPara[c,-a]-(1/5)(ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z]ProjPara[c,-a]+ProjPara[-j,-a]ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]+ProjPara[-i,-a]ProjPara[m,-z]ProjPara[n,-j]ProjPara[c,z]))totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionSymmPara3m[-i,-j,-a],Evaluate@Dagger[((ProjPara[m,-i]ProjPara[n,-j]ProjPara[c,-a]-(1/5)(ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z]ProjPara[c,-a]+ProjPara[-j,-a]ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]+ProjPara[-i,-a]ProjPara[m,-z]ProjPara[n,-j]ProjPara[c,z]))totsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceConnectionSymmPerpH1m[-i],Evaluate[((ConjugateSourceConnectionSymm[-k,-l,-i]-ConjugateSourceConnectionSymm[-i,-k,-l])V[k]V[l])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionSymmPerpH1m[-i],Evaluate@Dagger[((ConjugateSourceConnectionSymm[-k,-l,-i]-ConjugateSourceConnectionSymm[-i,-k,-l])V[k]V[l])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceConnectionSymmPara1p[-i,-a],Evaluate[((ConjugateSourceConnectionSymm[-k,-i,-a]-ConjugateSourceConnectionSymm[-k,-a,-i])V[k]+V[k]V[l]((ConjugateSourceConnectionSymm[-k,-l,-i]-ConjugateSourceConnectionSymm[-i,-k,-l])V[-a]-(ConjugateSourceConnectionSymm[-k,-l,-a]-ConjugateSourceConnectionSymm[-a,-k,-l])V[-i]))//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionSymmPara1p[-i,-a],Evaluate@Dagger[((ConjugateSourceConnectionSymm[-k,-i,-a]-ConjugateSourceConnectionSymm[-k,-a,-i])V[k]+V[k]V[l]((ConjugateSourceConnectionSymm[-k,-l,-i]-ConjugateSourceConnectionSymm[-i,-k,-l])V[-a]-(ConjugateSourceConnectionSymm[-k,-l,-a]-ConjugateSourceConnectionSymm[-a,-k,-l])V[-i]))//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceConnectionSymmPerpH0p[],Evaluate[(ConjugateSourceConnectionSymm[k,-k,-i]-ConjugateSourceConnectionSymm[-i,-k,k])V[i]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionSymmPerpH0p[],Evaluate@Dagger[(ConjugateSourceConnectionSymm[k,-k,-i]-ConjugateSourceConnectionSymm[-i,-k,k])V[i]]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceConnectionSymmPerp2p[-i,-j],Evaluate[((3/2)(ProjPara[m,-i]ProjPara[n,-j]-(ProjPara[-i,-j]/3)ProjPara[m,-z]ProjPara[n,z])V[c]remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionSymmPerp2p[-i,-j],Evaluate@Dagger[((3/2)(ProjPara[m,-i]ProjPara[n,-j]-(ProjPara[-i,-j]/3)ProjPara[m,-z]ProjPara[n,z])V[c]remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceConnectionSymmParaH1m[-i],Evaluate[((-3)ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionSymmParaH1m[-i],Evaluate@Dagger[((-3)ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceConnectionSymmPara2m[-i,-j,-a],Evaluate[((ProjPara[m,-i]ProjPara[n,-j]ProjPara[c,-a]-(1/2)(ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z]ProjPara[c,-a]+ProjPara[-j,-a]ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]+ProjPara[-i,-a]ProjPara[m,-z]ProjPara[n,-j]ProjPara[c,z]))remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceConnectionSymmPara2m[-i,-j,-a],Evaluate@Dagger[((ProjPara[m,-i]ProjPara[n,-j]ProjPara[c,-a]-(1/2)(ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z]ProjPara[c,-a]+ProjPara[-j,-a]ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]+ProjPara[-i,-a]ProjPara[m,-z]ProjPara[n,-j]ProjPara[c,z]))remsymConnectionSymmConjugateSourceConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True]
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
			0-><|Even->{ConnectionAntiPara0p,ConnectionSymmPerpT0p,ConnectionSymmPara0p,ConnectionSymmPerpH0p},Odd->{ConnectionAntiPara0m}|>,
			1-><|Even->{ConnectionAntiPara1p,ConnectionAntiPerp1p,ConnectionSymmPara1p},Odd->{ConnectionAntiPara1m,ConnectionAntiPerp1m,ConnectionSymmPerpT1m,ConnectionSymmParaT1m,ConnectionSymmPerpH1m,ConnectionSymmParaH1m}|>,
			2-><|Even->{ConnectionAntiPara2p,ConnectionSymmPara2p,ConnectionSymmPerp2p},Odd->{ConnectionAntiPara2m,ConnectionSymmPara2m}|>,
			3-><|Even->{},Odd->{ConnectionSymmPara3m}|>
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
			0-><|Even->{ConjugateSourceConnectionAntiPara0p,ConjugateSourceConnectionSymmPerpT0p,ConjugateSourceConnectionSymmPara0p,ConjugateSourceConnectionSymmPerpH0p},Odd->{ConjugateSourceConnectionAntiPara0m}|>,
			1-><|Even->{ConjugateSourceConnectionAntiPara1p,ConjugateSourceConnectionAntiPerp1p,ConjugateSourceConnectionSymmPara1p},Odd->{ConjugateSourceConnectionAntiPara1m,ConjugateSourceConnectionAntiPerp1m,ConjugateSourceConnectionSymmPerpT1m,ConjugateSourceConnectionSymmParaT1m,ConjugateSourceConnectionSymmPerpH1m,ConjugateSourceConnectionSymmParaH1m}|>,
			2-><|Even->{ConjugateSourceConnectionAntiPara2p,ConjugateSourceConnectionSymmPara2p,ConjugateSourceConnectionSymmPerp2p},Odd->{ConjugateSourceConnectionAntiPara2m,ConjugateSourceConnectionSymmPara2m}|>,
			3-><|Even->{},Odd->{ConjugateSourceConnectionSymmPara3m}|>
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

	(*ConnectionSymm reduced then back to ConnectionSymm*)
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`DecomposeConnectionSymmReducedtoConnectionSymm;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;	

	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiParaSpinParityToConnectionAnti;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiPerpSpinParityToConnectionAnti;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjConnectionAntiPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjConnectionAntiSpinParityToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiPerpParaToConnectionAnti;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;

	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiConnectionSymmToConnection;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;

Expr];

ExpandSources[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceLinearMetricSpinParityToConjugateSourceLinearMetric;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;

	(*ConjugateSourceConnectionSymm reduced then back to ConjugateSourceConnectionSymm*)
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`DecomposeConjugateSourceConnectionSymmReducedtoConjugateSourceConnectionSymm;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;	

	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionAntiParaSpinParityToConjugateSourceConnectionAnti;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionAntiPerpSpinParityToConjugateSourceConnectionAnti;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjConnectionAntiPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjConnectionAntiSpinParityToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ProjPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionAntiPerpParaToConjugateSourceConnectionAnti;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;

	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ConjugateSourceConnectionAntiConjugateSourceConnectionSymmToDilatospin;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;

Expr];

DecomposeFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`LinearMetricToLinearMetricSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;

	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionToConnectionAntiConnectionSymm;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;

	(*ConjugateSourceConnectionSymmhiyuan,ConnectionSymm*)
	(*ConnectionSymm to ConnectionSymm reduced*)
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ExpandConnectionSymmConjugateSourceConnectionSymmtoF/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ExpandConnectionSymmFtoReduced;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;

	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiToConnectionAntiPerpPara;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiParaToConnectionAntiParaSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`MetricAffineGaugeTheory`Private`ConnectionAntiPerpToConnectionAntiPerpSpinParity;
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
