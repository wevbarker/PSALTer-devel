(*=======================*)
(*  ZeroTorsionPalatini  *)
(*=======================*)

BeginPackage["xAct`PSALTer`ZeroTorsionPalatini`",{"xAct`xTensor`","xAct`xPerm`","xAct`xCore`","xAct`xTras`","xAct`xCoba`","xAct`PSALTer`"}];

(*=================================================================*)
(*  Basic definitions of gauge fields and their conjugate sources  *)
(*=================================================================*)

(*-------------------------------------------------------------------------------------------------------------------*)
(*  Will: Basic definitions of the symmetric metric perturbation and its conjugate source, the stress-energy tensor  *)
(*-------------------------------------------------------------------------------------------------------------------*)

xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniMetricPerturbationSymb="\[ScriptH]";
DefTensor[ZeroTorsionPalatiniMetricPerturbation[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniMetricPerturbationSymb],Dagger->Complex];

xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniMetricPerturbationSymb="\[ScriptCapitalT]";
DefTensor[ConjugateSourceZeroTorsionPalatiniMetricPerturbation[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniMetricPerturbationSymb],Dagger->Complex];

(*-----------------------------------------------------------------------------------------------------------------------------------------*)
(*  Will: Basic definitions of the asymmetric connection and its conjugate source "dilatospin", a portmanteau of dilaton current and spin  *)
(*-----------------------------------------------------------------------------------------------------------------------------------------*)

xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymb="\[ScriptCapitalA]";
DefTensor[ZeroTorsionPalatiniConnection[-i,-j,-a],M4,Symmetric[{-i,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymb],Dagger->Complex];

xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniDilatospinSymb="\[ScriptCapitalW]";
DefTensor[ZeroTorsionPalatiniDilatospin[-i,-j,-a],M4,Symmetric[{-i,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniDilatospinSymb],Dagger->Complex];

(*------------------------------------------------------------*)
(*  Will: Basic definitions of antisymmetric parts of fields  *)
(*------------------------------------------------------------*)

xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiSymb="\!\(\*SubscriptBox[\[ScriptCapitalA],\(a\)]\)";
DefTensor[ZeroTorsionPalatiniConnectionAnti[a,c,-d],M4,Antisymmetric[{a,c}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiSymb],Dagger->Complex];

xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionAntiSymb="\!\(\*SubscriptBox[\[ScriptCapitalW],\(a\)]\)";
DefTensor[ConjugateSourceZeroTorsionPalatiniConnectionAnti[-i,-j,-k],M4,Antisymmetric[{-j,-k}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionAntiSymb],Dagger->Complex];

(*----------------------------------------------------------------------------------------------*)
(*  ConjugateSourceZeroTorsionPalatiniConnectionSymmhiyuan: Basic definitions of metric affine gauge fields(ZeroTorsionPalatiniConnectionSymm) and their conjugate sources(ConjugateSourceZeroTorsionPalatiniConnectionSymm)  *)
(*----------------------------------------------------------------------------------------------*)

xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmSymb="\!\(\*SubscriptBox[\[ScriptCapitalA],\(s\)]\)";
DefTensor[ZeroTorsionPalatiniConnectionSymm[-i,-j,-a],M4, Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmSymb],Dagger->Complex];

xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmSymb="\!\(\*SubscriptBox[\[ScriptCapitalW],\(s\)]\)";
DefTensor[ConjugateSourceZeroTorsionPalatiniConnectionSymm[-i,-j,-a],M4, Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmSymb],Dagger->Complex];

(*----------------------------*)
(*  Will: combination script  *)
(*----------------------------*)

xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionToZeroTorsionPalatiniConnectionAntiZeroTorsionPalatiniConnectionSymm=Join[
	MakeRule[{ZeroTorsionPalatiniConnection[-a,-c,-b],Evaluate[ZeroTorsionPalatiniConnectionSymm[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnection[-a,-c,-b],Evaluate@Dagger[ZeroTorsionPalatiniConnectionSymm[-a,-b,-c]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniDilatospinToConjugateSourceZeroTorsionPalatiniConnectionAntiConjugateSourceZeroTorsionPalatiniConnectionSymm=Join[
	MakeRule[{ZeroTorsionPalatiniDilatospin[-a,-c,-b],Evaluate[ConjugateSourceZeroTorsionPalatiniConnectionSymm[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniDilatospin[-a,-c,-b],Evaluate@Dagger[ConjugateSourceZeroTorsionPalatiniConnectionSymm[-a,-b,-c]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiZeroTorsionPalatiniConnectionSymmToZeroTorsionPalatiniConnection=Join[
	MakeRule[{ZeroTorsionPalatiniConnectionAnti[-a,-b,-c],Evaluate[(1/2)*(ZeroTorsionPalatiniConnection[-a,-c,-b]-ZeroTorsionPalatiniConnection[-b,-c,-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ZeroTorsionPalatiniConnectionSymm[-a,-b,-c],Evaluate[(1/2)*(ZeroTorsionPalatiniConnection[-a,-c,-b]+ZeroTorsionPalatiniConnection[-b,-c,-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionAnti[-a,-b,-c],Evaluate@Dagger[(1/2)*(ZeroTorsionPalatiniConnection[-a,-c,-b]-ZeroTorsionPalatiniConnection[-b,-c,-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionSymm[-a,-b,-c],Evaluate@Dagger[(1/2)*(ZeroTorsionPalatiniConnection[-a,-c,-b]+ZeroTorsionPalatiniConnection[-b,-c,-a])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionAntiConjugateSourceZeroTorsionPalatiniConnectionSymmToZeroTorsionPalatiniDilatospin=Join[
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionAnti[-c,-a,-b],Evaluate[(1/2)*(ZeroTorsionPalatiniDilatospin[-a,-c,-b]-ZeroTorsionPalatiniDilatospin[-b,-c,-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionSymm[-a,-b,-c],Evaluate[(1/2)*(ZeroTorsionPalatiniDilatospin[-a,-c,-b]+ZeroTorsionPalatiniDilatospin[-b,-c,-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionAnti[-c,-a,-b],Evaluate@Dagger[(1/2)*(ZeroTorsionPalatiniDilatospin[-a,-c,-b]-ZeroTorsionPalatiniDilatospin[-b,-c,-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionSymm[-a,-b,-c],Evaluate@Dagger[(1/2)*(ZeroTorsionPalatiniDilatospin[-a,-c,-b]+ZeroTorsionPalatiniDilatospin[-b,-c,-a])]},MetricOn->All,ContractMetrics->True]];

(*==============*)
(*  Projectors  *)
(*==============*)

(*----------------------------------------------------------------------------------*)
(*  ConjugateSourceZeroTorsionPalatiniConnectionSymmhiyuan: Metric affine projectors into total and hook symmetric parts from ZeroTorsionPalatiniConnectionSymm,ConjugateSourceZeroTorsionPalatiniConnectionSymm  *)
(*----------------------------------------------------------------------------------*)

xAct`PSALTer`ZeroTorsionPalatini`Private`totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymmSymb="\!\(\*SubscriptBox[\[CapitalPi],\(ts\)]\)";
DefTensor[totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymmSymb]];

xAct`PSALTer`ZeroTorsionPalatini`Private`remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymmSymb="\!\(\*SubscriptBox[\[CapitalPi],\(hs\)]\)";
DefTensor[remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymmSymb]];

AutomaticRules[totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm,MakeRule[{totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a],Evaluate[(1/3)G[k,-i]G[l,-j]G[b,-a] +(1/3)G[k,-j]G[l,-a]G[b,-i] +(1/3)G[k,-i]G[l,-a]G[b,-j]]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm,MakeRule[{remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a],Evaluate[(2/3)G[k,-i]G[l,-j]G[b,-a] -(1/3)G[k,-j]G[l,-a]G[b,-i] -(1/3)G[k,-i]G[l,-a]G[b,-j]]},MetricOn->All,ContractMetrics->True]];

(*---------------------------------------------*)
(*  ConjugateSourceZeroTorsionPalatiniConnectionSymmhiyuan: Basic perpendicular and parallel  *)
(*---------------------------------------------*)

xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniProjPerpSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[UpTee]\)]\)";
DefTensor[ZeroTorsionPalatiniProjPerp[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniProjPerpSymb]];
xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniProjParaSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[DoubleVerticalBar]\)]\)";
DefTensor[ZeroTorsionPalatiniProjPara[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniProjParaSymb]];

(*------------------------------------*)
(*  Will: a rule to invert the above  *)
(*------------------------------------*)

xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniProjPerpParaToVG=Join[
	MakeRule[{ZeroTorsionPalatiniProjPerp[-a,b],Evaluate[V[-a]V[b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ZeroTorsionPalatiniProjPara[-a,b],Evaluate[G[-a,b]-V[-a]V[b]]},MetricOn->All,ContractMetrics->True]];

AutomaticRules[ZeroTorsionPalatiniProjPerp,MakeRule[{ZeroTorsionPalatiniProjPerp[-a,b],Evaluate[V[-a]V[b]]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ZeroTorsionPalatiniProjPara,MakeRule[{ZeroTorsionPalatiniProjPara[-a,b],Evaluate[G[-a,b]-V[-a]V[b]]},MetricOn->All,ContractMetrics->True]];

(*------------------------------------------*)
(*  Will: field perpendicular and parallel  *)
(*------------------------------------------*)

DefTensor[ProjZeroTorsionPalatiniConnectionAntiPerp[-a,-b,d,e,f],M4];
DefTensor[ProjZeroTorsionPalatiniConnectionAntiPara[-a,-b,-c,d,e,f],M4];
DefTensor[ZeroTorsionPalatiniProjFPerp[-a,d,e],M4];
DefTensor[ZeroTorsionPalatiniProjFPara[-a,-b,d,e],M4];

xAct`PSALTer`ZeroTorsionPalatini`Private`ProjZeroTorsionPalatiniConnectionAntiPerpParaToVG=Join[
	MakeRule[{ProjZeroTorsionPalatiniConnectionAntiPerp[-a,-b,d,e,f],Evaluate[
		V[d]ZeroTorsionPalatiniProjPara[-a,e]G[-b,f]/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjZeroTorsionPalatiniConnectionAntiPara[-a,-b,-c,d,e,f],Evaluate[
		ZeroTorsionPalatiniProjPara[-a,d]ZeroTorsionPalatiniProjPara[-b,e]G[-c,f]/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ZeroTorsionPalatiniProjFPerp[-a,d,e],Evaluate[
		V[d]G[-a,e]/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ZeroTorsionPalatiniProjFPara[-a,-b,d,e],Evaluate[
		ZeroTorsionPalatiniProjPara[-a,d]G[-b,e]/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*------------------------------------*)
(*  Will: Spin-parity or SO(3) parts  *)
(*------------------------------------*)

xAct`PSALTer`ZeroTorsionPalatini`Private`ProjZeroTorsionPalatiniConnectionAntiSymb="\!\(\*SubscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(\[Hacek]\)],\(\[ScriptCapitalA]\)]\)";
DefTensor[ProjZeroTorsionPalatiniConnectionAnti0p[c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ProjZeroTorsionPalatiniConnectionAntiSymb,xAct`PSALTer`Private`Spin0p]];
DefTensor[ProjZeroTorsionPalatiniConnectionAnti0m[d,e,f],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ProjZeroTorsionPalatiniConnectionAntiSymb,xAct`PSALTer`Private`Spin0m]];
DefTensor[ProjZeroTorsionPalatiniConnectionAnti1p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ProjZeroTorsionPalatiniConnectionAntiSymb,xAct`PSALTer`Private`Spin1p]];
DefTensor[ProjZeroTorsionPalatiniConnectionAnti1m[-a,d,e,f],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ProjZeroTorsionPalatiniConnectionAntiSymb,xAct`PSALTer`Private`Spin1m]];
DefTensor[ProjZeroTorsionPalatiniConnectionAnti2p[-a,-b,c,d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ProjZeroTorsionPalatiniConnectionAntiSymb,xAct`PSALTer`Private`Spin2p]];
DefTensor[ProjZeroTorsionPalatiniConnectionAnti2m[-a,-b,-c,d,e,f],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ProjZeroTorsionPalatiniConnectionAntiSymb,xAct`PSALTer`Private`Spin2m]];

xAct`PSALTer`ZeroTorsionPalatini`Private`ProjZeroTorsionPalatiniConnectionAntiSpinParityToVG=Join[
	MakeRule[{ProjZeroTorsionPalatiniConnectionAnti0p[c,d],Evaluate[
		ZeroTorsionPalatiniProjPara[c,-k]ZeroTorsionPalatiniProjPara[d,-l]G[k,l]/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjZeroTorsionPalatiniConnectionAnti1p[-a,-b,c,d],Evaluate[
		ZeroTorsionPalatiniProjPara[-a,i]ZeroTorsionPalatiniProjPara[-b,j]ZeroTorsionPalatiniProjPara[c,-k]ZeroTorsionPalatiniProjPara[d,-l]Antisymmetrize[G[-i,k]G[-j,l],{-i,-j}]/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjZeroTorsionPalatiniConnectionAnti2p[-a,-b,c,d],Evaluate[
		ZeroTorsionPalatiniProjPara[-a,i]ZeroTorsionPalatiniProjPara[-b,j]ZeroTorsionPalatiniProjPara[c,-k]ZeroTorsionPalatiniProjPara[d,-l](Symmetrize[G[-i,k]G[-j,l],{-i,-j}]-(1/3)G[-i,-j]G[k,l])/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjZeroTorsionPalatiniConnectionAnti0m[d,e,f],Evaluate[
		ZeroTorsionPalatiniProjPara[-i,d]ZeroTorsionPalatiniProjPara[-j,e]ZeroTorsionPalatiniProjPara[-k,f]epsilonG[i,j,k,g]V[-g]/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjZeroTorsionPalatiniConnectionAnti1m[-a,d,e,f],Evaluate[
		ZeroTorsionPalatiniProjPara[-i,d]ZeroTorsionPalatiniProjPara[-j,f]ZeroTorsionPalatiniProjPara[k,-a]ZeroTorsionPalatiniProjPara[-l,e]G[i,j]G[-k,l]/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjZeroTorsionPalatiniConnectionAnti2m[-a,-b,-c,d,e,f],Evaluate[
		ZeroTorsionPalatiniProjPara[-a,i]ZeroTorsionPalatiniProjPara[-b,j]ZeroTorsionPalatiniProjPara[-c,k]ZeroTorsionPalatiniProjPara[d,-l]ZeroTorsionPalatiniProjPara[e,-n]ZeroTorsionPalatiniProjPara[f,-m](3/4)((1/3)(2G[-i,l]G[-j,n]G[-k,m]-G[-j,l]G[-k,n]G[-i,m]-G[-k,l]G[-i,n]G[-j,m])-Antisymmetrize[G[-i,-k]G[-j,n]G[l,m],{-i,-j}])/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

(*---------------------------------------------------------------------------*)
(*  Will: decomposition of asymmetric part field perpendicular and parallel  *)
(*---------------------------------------------------------------------------*)

xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiParaSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalA],\(a\)]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[ZeroTorsionPalatiniConnectionAntiPara[-a,-b,-c],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiParaSymb],OrthogonalTo->{V[c]},Dagger->Complex];
xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiPerpSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalA],\(a\)]\),\(\[UpTee]\)]\)";
DefTensor[ZeroTorsionPalatiniConnectionAntiPerp[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiPerpSymb],Dagger->Complex];

xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiToZeroTorsionPalatiniConnectionAntiPerpPara=Join[
	MakeRule[{ZeroTorsionPalatiniConnectionAnti[-a,-b,-c],Evaluate[ZeroTorsionPalatiniConnectionAntiPara[-a,-b,-c]+V[-c]ZeroTorsionPalatiniConnectionAntiPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionAnti[-a,-b,-c],Evaluate[Dagger@(ZeroTorsionPalatiniConnectionAntiPara[-a,-b,-c]+V[-c]ZeroTorsionPalatiniConnectionAntiPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiPerpParaToZeroTorsionPalatiniConnectionAnti=Join[
	MakeRule[{ZeroTorsionPalatiniConnectionAntiPara[-a,-e,-b],Evaluate[
		ZeroTorsionPalatiniProjPara[-b,c]ZeroTorsionPalatiniConnectionAnti[-a,-e,-c]/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ZeroTorsionPalatiniConnectionAntiPerp[-a,-e],Evaluate[
		V[c]ZeroTorsionPalatiniConnectionAnti[-a,-e,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionAntiPara[-a,-e,-b],Evaluate[Dagger@(
		ZeroTorsionPalatiniProjPara[-b,c]ZeroTorsionPalatiniConnectionAnti[-a,-e,-c]/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionAntiPerp[-a,-e],Evaluate[Dagger@(
		V[c]ZeroTorsionPalatiniConnectionAnti[-a,-e,-c])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionAntiParaSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalW],\(a\)]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[ConjugateSourceZeroTorsionPalatiniConnectionAntiPara[-c,-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionAntiParaSymb],OrthogonalTo->{V[c]},Dagger->Complex];
xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionAntiPerpSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalW],\(a\)]\),\(\[UpTee]\)]\)";
DefTensor[ConjugateSourceZeroTorsionPalatiniConnectionAntiPerp[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionAntiPerpSymb],Dagger->Complex];

xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionAntiToConjugateSourceZeroTorsionPalatiniConnectionAntiPerpPara=Join[
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionAnti[-c,-a,-b],Evaluate[	
		ConjugateSourceZeroTorsionPalatiniConnectionAntiPara[-c,-a,-b]+V[-c]ConjugateSourceZeroTorsionPalatiniConnectionAntiPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionAnti[-c,-a,-b],Evaluate[Dagger@(	
		ConjugateSourceZeroTorsionPalatiniConnectionAntiPara[-c,-a,-b]+V[-c]ConjugateSourceZeroTorsionPalatiniConnectionAntiPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionAntiPerpParaToConjugateSourceZeroTorsionPalatiniConnectionAnti=Join[
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionAntiPara[-b,-a,-e],Evaluate[
		ZeroTorsionPalatiniProjPara[-b,c]ConjugateSourceZeroTorsionPalatiniConnectionAnti[-c,-a,-e]/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionAntiPerp[-a,-e],Evaluate[
		V[c]ConjugateSourceZeroTorsionPalatiniConnectionAnti[-c,-a,-e]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionAntiPara[-b,-a,-e],Evaluate[Dagger@(
		ZeroTorsionPalatiniProjPara[-b,c]ConjugateSourceZeroTorsionPalatiniConnectionAnti[-c,-a,-e]/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionAntiPerp[-a,-e],Evaluate[Dagger@(
		V[c]ConjugateSourceZeroTorsionPalatiniConnectionAnti[-c,-a,-e])]},MetricOn->All,ContractMetrics->True]];

(*-------------------------------------------------------------------*)
(*  ConjugateSourceZeroTorsionPalatiniConnectionSymmhiyuan: decomposition of ZeroTorsionPalatiniConnectionSymm,ConjugateSourceZeroTorsionPalatiniConnectionSymm into full-indexed spin components  *)
(*-------------------------------------------------------------------*)

xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmParaSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalA],\(s\)]\),\(\[DoubleVerticalBar]\)]\)";
xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmParaTSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalA],\(s\)]\),\(\[DoubleVerticalBar]t\)]\)";
xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmParaHSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalA],\(s\)]\),\(\[DoubleVerticalBar]h\)]\)";

xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmPerpSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalA],\(s\)]\),\(\[UpTee]\)]\)";
xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmPerpTSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalA],\(s\)]\),\(\[UpTee]t\)]\)";
xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmPerpHSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalA],\(s\)]\),\(\[UpTee]h\)]\)";

xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmParaSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalW],\(s\)]\),\(\[DoubleVerticalBar]\)]\)";
xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmParaTSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalW],\(s\)]\),\(\[DoubleVerticalBar]t\)]\)";
xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmParaHSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalW],\(s\)]\),\(\[DoubleVerticalBar]h\)]\)";

xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalW],\(s\)]\),\(\[UpTee]\)]\)";
xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpTSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalW],\(s\)]\),\(\[UpTee]t\)]\)";
xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpHSymb="\!\(\*SuperscriptBox[\(\*SubscriptBox[\[ScriptCapitalW],\(s\)]\),\(\[UpTee]h\)]\)";

DefTensor[ZeroTorsionPalatiniConnectionSymmPerpT0pF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmPerpTSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ZeroTorsionPalatiniConnectionSymmPerpT1mF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmPerpTSymb,xAct`PSALTer`Private`Spin1m],Dagger->Complex];
DefTensor[ZeroTorsionPalatiniConnectionSymmPara0pF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ZeroTorsionPalatiniConnectionSymmPara2pF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmParaSymb,xAct`PSALTer`Private`Spin2p],Dagger->Complex];
DefTensor[ZeroTorsionPalatiniConnectionSymmParaT1mF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmParaTSymb,xAct`PSALTer`Private`Spin1m],Dagger->Complex];
DefTensor[ZeroTorsionPalatiniConnectionSymmPara3mF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmParaSymb,xAct`PSALTer`Private`Spin3m],Dagger->Complex];
DefTensor[ZeroTorsionPalatiniConnectionSymmPerpH1mF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmPerpHSymb,xAct`PSALTer`Private`Spin1m],Dagger->Complex];
DefTensor[ZeroTorsionPalatiniConnectionSymmPara1pF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmPerpSymb,xAct`PSALTer`Private`Spin1p],Dagger->Complex];
DefTensor[ZeroTorsionPalatiniConnectionSymmPerpH0pF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmPerpHSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ZeroTorsionPalatiniConnectionSymmPerp2pF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmPerpSymb,xAct`PSALTer`Private`Spin2p],Dagger->Complex];
DefTensor[ZeroTorsionPalatiniConnectionSymmParaH1mF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmParaHSymb,xAct`PSALTer`Private`Spin1m],Dagger->Complex];
DefTensor[ZeroTorsionPalatiniConnectionSymmPara2mF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmParaSymb,xAct`PSALTer`Private`Spin2m],Dagger->Complex];

DefTensor[ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpT0pF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpTSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpT1mF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpTSymb,xAct`PSALTer`Private`Spin1m],Dagger->Complex];
DefTensor[ConjugateSourceZeroTorsionPalatiniConnectionSymmPara0pF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ConjugateSourceZeroTorsionPalatiniConnectionSymmPara2pF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmParaSymb,xAct`PSALTer`Private`Spin2p],Dagger->Complex];
DefTensor[ConjugateSourceZeroTorsionPalatiniConnectionSymmParaT1mF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmParaTSymb,xAct`PSALTer`Private`Spin1m],Dagger->Complex];
DefTensor[ConjugateSourceZeroTorsionPalatiniConnectionSymmPara3mF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmParaSymb,xAct`PSALTer`Private`Spin3m],Dagger->Complex];
DefTensor[ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpH1mF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpHSymb,xAct`PSALTer`Private`Spin1m],Dagger->Complex];
DefTensor[ConjugateSourceZeroTorsionPalatiniConnectionSymmPara1pF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpSymb,xAct`PSALTer`Private`Spin1p],Dagger->Complex];
DefTensor[ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpH0pF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpHSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[ConjugateSourceZeroTorsionPalatiniConnectionSymmPerp2pF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpSymb,xAct`PSALTer`Private`Spin2p],Dagger->Complex];
DefTensor[ConjugateSourceZeroTorsionPalatiniConnectionSymmParaH1mF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmParaHSymb,xAct`PSALTer`Private`Spin1m],Dagger->Complex];
DefTensor[ConjugateSourceZeroTorsionPalatiniConnectionSymmPara2mF[-i,-j,-a],M4,Symmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmParaSymb,xAct`PSALTer`Private`Spin2m],Dagger->Complex];

xAct`PSALTer`ZeroTorsionPalatini`Private`ExpandZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymmtoF=Join[
	MakeRule[{ZeroTorsionPalatiniConnectionSymm[-i,-j,-a],Evaluate[ZeroTorsionPalatiniConnectionSymmPerpT0pF[-i,-j,-a]+ZeroTorsionPalatiniConnectionSymmPerpT1mF[-i,-j,-a]+ZeroTorsionPalatiniConnectionSymmPara0pF[-i,-j,-a]+ZeroTorsionPalatiniConnectionSymmPara2pF[-i,-j,-a]+ZeroTorsionPalatiniConnectionSymmParaT1mF[-i,-j,-a]+ZeroTorsionPalatiniConnectionSymmPara3mF[-i,-j,-a]+ZeroTorsionPalatiniConnectionSymmPerpH1mF[-i,-j,-a]+ZeroTorsionPalatiniConnectionSymmPara1pF[-i,-j,-a]+ZeroTorsionPalatiniConnectionSymmPerpH0pF[-i,-j,-a]+ZeroTorsionPalatiniConnectionSymmPerp2pF[-i,-j,-a]+ZeroTorsionPalatiniConnectionSymmParaH1mF[-i,-j,-a]+ZeroTorsionPalatiniConnectionSymmPara2mF[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionSymm[-i,-j,-a],Evaluate[ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpT0pF[-i,-j,-a]+ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpT1mF[-i,-j,-a]+ConjugateSourceZeroTorsionPalatiniConnectionSymmPara0pF[-i,-j,-a]+ConjugateSourceZeroTorsionPalatiniConnectionSymmPara2pF[-i,-j,-a]+ConjugateSourceZeroTorsionPalatiniConnectionSymmParaT1mF[-i,-j,-a]+ConjugateSourceZeroTorsionPalatiniConnectionSymmPara3mF[-i,-j,-a]+ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpH1mF[-i,-j,-a]+ConjugateSourceZeroTorsionPalatiniConnectionSymmPara1pF[-i,-j,-a]+ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpH0pF[-i,-j,-a]+ConjugateSourceZeroTorsionPalatiniConnectionSymmPerp2pF[-i,-j,-a]+ConjugateSourceZeroTorsionPalatiniConnectionSymmParaH1mF[-i,-j,-a]+ConjugateSourceZeroTorsionPalatiniConnectionSymmPara2mF[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionSymm[-i,-j,-a],Evaluate[Dagger@(ZeroTorsionPalatiniConnectionSymmPerpT0pF[-i,-j,-a]+ZeroTorsionPalatiniConnectionSymmPerpT1mF[-i,-j,-a]+ZeroTorsionPalatiniConnectionSymmPara0pF[-i,-j,-a]+ZeroTorsionPalatiniConnectionSymmPara2pF[-i,-j,-a]+ZeroTorsionPalatiniConnectionSymmParaT1mF[-i,-j,-a]+ZeroTorsionPalatiniConnectionSymmPara3mF[-i,-j,-a]+ZeroTorsionPalatiniConnectionSymmPerpH1mF[-i,-j,-a]+ZeroTorsionPalatiniConnectionSymmPara1pF[-i,-j,-a]+ZeroTorsionPalatiniConnectionSymmPerpH0pF[-i,-j,-a]+ZeroTorsionPalatiniConnectionSymmPerp2pF[-i,-j,-a]+ZeroTorsionPalatiniConnectionSymmParaH1mF[-i,-j,-a]+ZeroTorsionPalatiniConnectionSymmPara2mF[-i,-j,-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionSymm[-i,-j,-a],Evaluate[Dagger@(ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpT0pF[-i,-j,-a]+ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpT1mF[-i,-j,-a]+ConjugateSourceZeroTorsionPalatiniConnectionSymmPara0pF[-i,-j,-a]+ConjugateSourceZeroTorsionPalatiniConnectionSymmPara2pF[-i,-j,-a]+ConjugateSourceZeroTorsionPalatiniConnectionSymmParaT1mF[-i,-j,-a]+ConjugateSourceZeroTorsionPalatiniConnectionSymmPara3mF[-i,-j,-a]+ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpH1mF[-i,-j,-a]+ConjugateSourceZeroTorsionPalatiniConnectionSymmPara1pF[-i,-j,-a]+ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpH0pF[-i,-j,-a]+ConjugateSourceZeroTorsionPalatiniConnectionSymmPerp2pF[-i,-j,-a]+ConjugateSourceZeroTorsionPalatiniConnectionSymmParaH1mF[-i,-j,-a]+ConjugateSourceZeroTorsionPalatiniConnectionSymmPara2mF[-i,-j,-a])]},MetricOn->All,ContractMetrics->True]
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

xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniMetricPerturbationPerpSymb="\!\(\*SuperscriptBox[\(\[ScriptH]\),\(\[UpTee]\)]\)";
xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniMetricPerturbationPerpSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalT]\),\(\[UpTee]\)]\)";

DefSpinParityMode[ZeroTorsionPalatiniMetricPerturbationPerp0p[],Spin->0,Parity->Even,
	FieldSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniMetricPerturbationPerpSymb,
	SourceSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniMetricPerturbationPerpSymb];
DefSpinParityMode[ZeroTorsionPalatiniMetricPerturbationPerp1m[-a],Spin->1,Parity->Odd,
	FieldSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniMetricPerturbationPerpSymb,
	SourceSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniMetricPerturbationPerpSymb];

xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniMetricPerturbationParaSymb="\!\(\*SuperscriptBox[\(\[ScriptH]\),\(\[DoubleVerticalBar]\)]\)";
xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniMetricPerturbationParaSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalT]\),\(\[DoubleVerticalBar]\)]\)";

DefSpinParityMode[ZeroTorsionPalatiniMetricPerturbationPara0p[],Spin->0,Parity->Even,
	FieldSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniMetricPerturbationParaSymb,
	SourceSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniMetricPerturbationParaSymb];
DefSpinParityMode[ZeroTorsionPalatiniMetricPerturbationPara2p[-a,-b],Symmetric[{-a,-b}],Spin->2,Parity->Even,
	FieldSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniMetricPerturbationParaSymb,
	SourceSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniMetricPerturbationParaSymb];

(*-------------------------------------------------------------------*)
(*  Will: definition of antisymmetric reduced-index spin components  *)
(*-------------------------------------------------------------------*)

DefSpinParityMode[ZeroTorsionPalatiniConnectionAntiPara0p[],Spin->0,Parity->Even,
	FieldSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiParaSymb,
	SourceSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionAntiParaSymb];
DefSpinParityMode[ZeroTorsionPalatiniConnectionAntiPara0m[],Spin->0,Parity->Odd,
	FieldSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiParaSymb,
	SourceSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionAntiParaSymb];
DefSpinParityMode[ZeroTorsionPalatiniConnectionAntiPara1p[-a,-b],Antisymmetric[{-a,-b}],Spin->1,Parity->Even,
	FieldSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiParaSymb,
	SourceSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionAntiParaSymb];
DefSpinParityMode[ZeroTorsionPalatiniConnectionAntiPara1m[-a],Spin->1,Parity->Odd,
	FieldSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiParaSymb,
	SourceSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionAntiParaSymb];
DefSpinParityMode[ZeroTorsionPalatiniConnectionAntiPara2p[-a,-b],Symmetric[{-a,-b}],Spin->2,Parity->Even,
	FieldSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiParaSymb,
	SourceSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionAntiParaSymb];
DefSpinParityMode[ZeroTorsionPalatiniConnectionAntiPara2m[-a,-b,-c],Antisymmetric[{-a,-b}],Spin->2,Parity->Odd,
	FieldSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiParaSymb,
	SourceSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionAntiParaSymb];
DefSpinParityMode[ZeroTorsionPalatiniConnectionAntiPerp1p[-a,-b],Antisymmetric[{-a,-b}],Spin->1,Parity->Even,
	FieldSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiPerpSymb,
	SourceSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionAntiPerpSymb];
DefSpinParityMode[ZeroTorsionPalatiniConnectionAntiPerp1m[-a],Spin->1,Parity->Odd,
	FieldSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiPerpSymb,
	SourceSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionAntiPerpSymb];

(*
DefTensor[ZeroTorsionPalatiniConnectionAntiPerp1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiPerpSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
*)
(*
DefTensor[ZeroTorsionPalatiniConnectionAntiPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
*)
(*
DefTensor[ConjugateSourceZeroTorsionPalatiniConnectionAntiPerp1p[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionAntiPerpSymb,xAct`PSALTer`Private`Spin1p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];
*)
(*
DefTensor[ConjugateSourceZeroTorsionPalatiniConnectionAntiPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionAntiPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
*)

(*------------------------------------------------------------*)
(*  ConjugateSourceZeroTorsionPalatiniConnectionSymmhiyuan: definition of ZeroTorsionPalatiniConnectionSymm,ConjugateSourceZeroTorsionPalatiniConnectionSymm reduced-index spin components  *)
(*------------------------------------------------------------*)

DefSpinParityMode[ZeroTorsionPalatiniConnectionSymmPerpT0p[],Spin->0,Parity->Even,
	FieldSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmPerpTSymb,
	SourceSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpTSymb];
DefSpinParityMode[ZeroTorsionPalatiniConnectionSymmPerpT1m[-i],Spin->1,Parity->Odd,
	FieldSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmPerpTSymb,
	SourceSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpTSymb];
DefSpinParityMode[ZeroTorsionPalatiniConnectionSymmPara0p[],Spin->0,Parity->Even,
	FieldSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmParaSymb,
	SourceSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmParaSymb];
DefSpinParityMode[ZeroTorsionPalatiniConnectionSymmPara2p[-i,-j],Symmetric[{-i,-j}],Spin->2,Parity->Even,
	FieldSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmParaSymb,
	SourceSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmParaSymb];
DefSpinParityMode[ZeroTorsionPalatiniConnectionSymmParaT1m[-i],Spin->1,Parity->Odd,
	FieldSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmParaTSymb,
	SourceSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmParaTSymb];
DefSpinParityMode[ZeroTorsionPalatiniConnectionSymmPara3m[-i,-j,-a],Symmetric[{-i,-j,-a}],Spin->3,Parity->Odd,
	FieldSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmParaSymb,
	SourceSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmParaSymb];
DefSpinParityMode[ZeroTorsionPalatiniConnectionSymmPerpH1m[-i],Spin->1,Parity->Odd,
	FieldSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmPerpHSymb,
	SourceSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpHSymb];
DefSpinParityMode[ZeroTorsionPalatiniConnectionSymmPara1p[-i,-a],Antisymmetric[{-i,-a}],Spin->1,Parity->Even,
	FieldSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmPerpSymb,
	SourceSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpSymb];
DefSpinParityMode[ZeroTorsionPalatiniConnectionSymmPerpH0p[],Spin->0,Parity->Even,
	FieldSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmPerpHSymb,
	SourceSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpHSymb];
DefSpinParityMode[ZeroTorsionPalatiniConnectionSymmPerp2p[-i,-j],Symmetric[{-i,-j}],Spin->2,Parity->Even,
	FieldSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmPerpSymb,
	SourceSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpSymb];
DefSpinParityMode[ZeroTorsionPalatiniConnectionSymmParaH1m[-i],Spin->1,Parity->Odd,
	FieldSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmParaHSymb,
	SourceSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmParaHSymb];
DefSpinParityMode[ZeroTorsionPalatiniConnectionSymmPara2m[-i,-j,-a],Symmetric[{-i,-j}],MultiTermSymmetries->{ZeroTorsionPalatiniConnectionSymmPara2m[-i,-j,-a]+ZeroTorsionPalatiniConnectionSymmPara2m[-a,-i,-j]+ZeroTorsionPalatiniConnectionSymmPara2m[-j,-a,-i]},Spin->2,Parity->Odd,
	FieldSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionSymmParaSymb,
	SourceSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionSymmParaSymb];

(*==============*)
(*  Expansions  *)
(*==============*)

(*----------------------------------------*)
(*  Will: metric perturbation expansions  *)
(*----------------------------------------*)

xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniMetricPerturbationSpinParityToZeroTorsionPalatiniMetricPerturbation=Join[
	MakeRule[{ZeroTorsionPalatiniMetricPerturbationPerp0p[],Evaluate[
		ZeroTorsionPalatiniProjPerp[a,b]ZeroTorsionPalatiniMetricPerturbation[-a,-b]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ZeroTorsionPalatiniMetricPerturbationPerp1m[-a],Evaluate[
		V[b]ZeroTorsionPalatiniProjPara[-a,c]ZeroTorsionPalatiniMetricPerturbation[-c,-b]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ZeroTorsionPalatiniMetricPerturbationPara0p[],Evaluate[
		ZeroTorsionPalatiniProjPara[a,b]ZeroTorsionPalatiniMetricPerturbation[-a,-b]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ZeroTorsionPalatiniMetricPerturbationPara2p[-a,-b],Evaluate[
		(ZeroTorsionPalatiniProjPara[-a,c]ZeroTorsionPalatiniProjPara[-b,d]-(1/3)*ZeroTorsionPalatiniProjPara[-a,-b]ZeroTorsionPalatiniProjPara[c,d])*ZeroTorsionPalatiniMetricPerturbation[-c,-d]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniMetricPerturbationPerp0p[],Evaluate@Dagger[
		ZeroTorsionPalatiniProjPerp[a,b]ZeroTorsionPalatiniMetricPerturbation[-a,-b]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniMetricPerturbationPerp1m[-a],Evaluate@Dagger[
		V[b]ZeroTorsionPalatiniProjPara[-a,c]ZeroTorsionPalatiniMetricPerturbation[-c,-b]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniMetricPerturbationPara0p[],Evaluate@Dagger[
		ZeroTorsionPalatiniProjPara[a,b]ZeroTorsionPalatiniMetricPerturbation[-a,-b]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniMetricPerturbationPara2p[-a,-b],Evaluate@Dagger[
		(ZeroTorsionPalatiniProjPara[-a,c]ZeroTorsionPalatiniProjPara[-b,d]-(1/3)*ZeroTorsionPalatiniProjPara[-a,-b]ZeroTorsionPalatiniProjPara[c,d])*ZeroTorsionPalatiniMetricPerturbation[-c,-d]//ToCanonical]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniMetricPerturbationSpinParityToConjugateSourceZeroTorsionPalatiniMetricPerturbation=Join[
	MakeRule[{ConjugateSourceZeroTorsionPalatiniMetricPerturbationPerp0p[],Evaluate[
		ZeroTorsionPalatiniProjPerp[a,b]ConjugateSourceZeroTorsionPalatiniMetricPerturbation[-a,-b]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceZeroTorsionPalatiniMetricPerturbationPerp1m[-a],Evaluate[
		V[b]ZeroTorsionPalatiniProjPara[-a,c]ConjugateSourceZeroTorsionPalatiniMetricPerturbation[-c,-b]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceZeroTorsionPalatiniMetricPerturbationPara0p[],Evaluate[
		ZeroTorsionPalatiniProjPara[a,b]ConjugateSourceZeroTorsionPalatiniMetricPerturbation[-a,-b]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceZeroTorsionPalatiniMetricPerturbationPara2p[-a,-b],Evaluate[
		(ZeroTorsionPalatiniProjPara[-a,c]ZeroTorsionPalatiniProjPara[-b,d]-(1/3)*ZeroTorsionPalatiniProjPara[-a,-b]ZeroTorsionPalatiniProjPara[c,d])*ConjugateSourceZeroTorsionPalatiniMetricPerturbation[-c,-d]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniMetricPerturbationPerp0p[],Evaluate@Dagger[
		ZeroTorsionPalatiniProjPerp[a,b]ConjugateSourceZeroTorsionPalatiniMetricPerturbation[-a,-b]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniMetricPerturbationPerp1m[-a],Evaluate@Dagger[
		V[b]ZeroTorsionPalatiniProjPara[-a,c]ConjugateSourceZeroTorsionPalatiniMetricPerturbation[-c,-b]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniMetricPerturbationPara0p[],Evaluate@Dagger[
		ZeroTorsionPalatiniProjPara[a,b]ConjugateSourceZeroTorsionPalatiniMetricPerturbation[-a,-b]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniMetricPerturbationPara2p[-a,-b],Evaluate@Dagger[
		(ZeroTorsionPalatiniProjPara[-a,c]ZeroTorsionPalatiniProjPara[-b,d]-(1/3)*ZeroTorsionPalatiniProjPara[-a,-b]ZeroTorsionPalatiniProjPara[c,d])*ConjugateSourceZeroTorsionPalatiniMetricPerturbation[-c,-d]//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*--------------------------*)
(*  Will: other expansions  *)
(*--------------------------*)

xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiParaSpinParityToZeroTorsionPalatiniConnectionAnti=Join[
	MakeRule[{ZeroTorsionPalatiniConnectionAntiPara0p[],Scalar[Evaluate[
		ProjZeroTorsionPalatiniConnectionAnti0p[e,f]ProjZeroTorsionPalatiniConnectionAntiPerp[-e,-f,a,b,c]ZeroTorsionPalatiniConnectionAntiPara[-a,-b,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ZeroTorsionPalatiniConnectionAntiPara0m[],Scalar[Evaluate[
		ProjZeroTorsionPalatiniConnectionAnti0m[d,e,f]ProjZeroTorsionPalatiniConnectionAntiPara[-d,-e,-f,a,b,c]ZeroTorsionPalatiniConnectionAntiPara[-a,-b,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ZeroTorsionPalatiniConnectionAntiPara1p[-n,-m],Evaluate[
		ProjZeroTorsionPalatiniConnectionAnti1p[-n,-m,e,f]ProjZeroTorsionPalatiniConnectionAntiPerp[-e,-f,a,b,c]ZeroTorsionPalatiniConnectionAntiPara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ZeroTorsionPalatiniConnectionAntiPara1m[-n],Evaluate[
		ProjZeroTorsionPalatiniConnectionAnti1m[-n,d,e,f]ProjZeroTorsionPalatiniConnectionAntiPara[-d,-e,-f,a,b,c]ZeroTorsionPalatiniConnectionAntiPara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ZeroTorsionPalatiniConnectionAntiPara2p[-n,-m],Evaluate[
		ProjZeroTorsionPalatiniConnectionAnti2p[-n,-m,e,f]ProjZeroTorsionPalatiniConnectionAntiPerp[-e,-f,a,b,c]ZeroTorsionPalatiniConnectionAntiPara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ZeroTorsionPalatiniConnectionAntiPara2m[-n,-m,-o],Evaluate[
		ProjZeroTorsionPalatiniConnectionAnti2m[-n,-m,-o,d,e,f]ProjZeroTorsionPalatiniConnectionAntiPara[-d,-e,-f,a,b,c]ZeroTorsionPalatiniConnectionAntiPara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionAntiPara0p[],Scalar[Evaluate[Dagger@(
		ProjZeroTorsionPalatiniConnectionAnti0p[e,f]ProjZeroTorsionPalatiniConnectionAntiPerp[-e,-f,a,b,c]ZeroTorsionPalatiniConnectionAntiPara[-a,-b,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionAntiPara0m[],Scalar[Evaluate[Dagger@(
		ProjZeroTorsionPalatiniConnectionAnti0m[d,e,f]ProjZeroTorsionPalatiniConnectionAntiPara[-d,-e,-f,a,b,c]ZeroTorsionPalatiniConnectionAntiPara[-a,-b,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionAntiPara1p[-n,-m],Evaluate[Dagger@(
		ProjZeroTorsionPalatiniConnectionAnti1p[-n,-m,e,f]ProjZeroTorsionPalatiniConnectionAntiPerp[-e,-f,a,b,c]ZeroTorsionPalatiniConnectionAntiPara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionAntiPara1m[-n],Evaluate[Dagger@(
		ProjZeroTorsionPalatiniConnectionAnti1m[-n,d,e,f]ProjZeroTorsionPalatiniConnectionAntiPara[-d,-e,-f,a,b,c]ZeroTorsionPalatiniConnectionAntiPara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionAntiPara2p[-n,-m],Evaluate[Dagger@(
		ProjZeroTorsionPalatiniConnectionAnti2p[-n,-m,e,f]ProjZeroTorsionPalatiniConnectionAntiPerp[-e,-f,a,b,c]ZeroTorsionPalatiniConnectionAntiPara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionAntiPara2m[-n,-m,-o],Evaluate[Dagger@(
		ProjZeroTorsionPalatiniConnectionAnti2m[-n,-m,-o,d,e,f]ProjZeroTorsionPalatiniConnectionAntiPara[-d,-e,-f,a,b,c]ZeroTorsionPalatiniConnectionAntiPara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiPerpSpinParityToZeroTorsionPalatiniConnectionAnti=Join[
	MakeRule[{ZeroTorsionPalatiniConnectionAntiPerp1p[-n,-m],Evaluate[
		ZeroTorsionPalatiniProjPara[-n,a]ZeroTorsionPalatiniProjPara[-m,b]ZeroTorsionPalatiniConnectionAntiPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ZeroTorsionPalatiniConnectionAntiPerp1m[-n],Evaluate[
		ZeroTorsionPalatiniProjPara[-n,a]V[b]ZeroTorsionPalatiniConnectionAntiPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionAntiPerp1p[-n,-m],Evaluate[Dagger@(
		ZeroTorsionPalatiniProjPara[-n,a]ZeroTorsionPalatiniProjPara[-m,b]ZeroTorsionPalatiniConnectionAntiPerp[-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionAntiPerp1m[-n],Evaluate[Dagger@(
		ZeroTorsionPalatiniProjPara[-n,a]V[b]ZeroTorsionPalatiniConnectionAntiPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionAntiParaSpinParityToConjugateSourceZeroTorsionPalatiniConnectionAnti=Join[
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionAntiPara0p[],Scalar[Evaluate[
		ProjZeroTorsionPalatiniConnectionAnti0p[e,f]ProjZeroTorsionPalatiniConnectionAntiPerp[-e,-f,a,b,c]ConjugateSourceZeroTorsionPalatiniConnectionAntiPara[-c,-a,-b]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionAntiPara0m[],Scalar[Evaluate[
		ProjZeroTorsionPalatiniConnectionAnti0m[d,e,f]ProjZeroTorsionPalatiniConnectionAntiPara[-d,-e,-f,a,b,c]ConjugateSourceZeroTorsionPalatiniConnectionAntiPara[-c,-a,-b]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionAntiPara1p[-n,-m],Evaluate[
		ProjZeroTorsionPalatiniConnectionAnti1p[-n,-m,e,f]ProjZeroTorsionPalatiniConnectionAntiPerp[-e,-f,a,b,c]ConjugateSourceZeroTorsionPalatiniConnectionAntiPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionAntiPara1m[-n],Evaluate[
		ProjZeroTorsionPalatiniConnectionAnti1m[-n,d,e,f]ProjZeroTorsionPalatiniConnectionAntiPara[-d,-e,-f,a,b,c]ConjugateSourceZeroTorsionPalatiniConnectionAntiPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionAntiPara2p[-n,-m],Evaluate[
		ProjZeroTorsionPalatiniConnectionAnti2p[-n,-m,e,f]ProjZeroTorsionPalatiniConnectionAntiPerp[-e,-f,a,b,c]ConjugateSourceZeroTorsionPalatiniConnectionAntiPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionAntiPara2m[-n,-m,-o],Evaluate[
		ProjZeroTorsionPalatiniConnectionAnti2m[-n,-m,-o,d,e,f]ProjZeroTorsionPalatiniConnectionAntiPara[-d,-e,-f,a,b,c]ConjugateSourceZeroTorsionPalatiniConnectionAntiPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionAntiPara0p[],Scalar[Evaluate[Dagger@(
		ProjZeroTorsionPalatiniConnectionAnti0p[e,f]ProjZeroTorsionPalatiniConnectionAntiPerp[-e,-f,a,b,c]ConjugateSourceZeroTorsionPalatiniConnectionAntiPara[-c,-a,-b])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionAntiPara0m[],Scalar[Evaluate[Dagger@(
		ProjZeroTorsionPalatiniConnectionAnti0m[d,e,f]ProjZeroTorsionPalatiniConnectionAntiPara[-d,-e,-f,a,b,c]ConjugateSourceZeroTorsionPalatiniConnectionAntiPara[-c,-a,-b])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionAntiPara1p[-n,-m],Evaluate[Dagger@(
		ProjZeroTorsionPalatiniConnectionAnti1p[-n,-m,e,f]ProjZeroTorsionPalatiniConnectionAntiPerp[-e,-f,a,b,c]ConjugateSourceZeroTorsionPalatiniConnectionAntiPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionAntiPara1m[-n],Evaluate[Dagger@(
		ProjZeroTorsionPalatiniConnectionAnti1m[-n,d,e,f]ProjZeroTorsionPalatiniConnectionAntiPara[-d,-e,-f,a,b,c]ConjugateSourceZeroTorsionPalatiniConnectionAntiPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionAntiPara2p[-n,-m],Evaluate[Dagger@(
		ProjZeroTorsionPalatiniConnectionAnti2p[-n,-m,e,f]ProjZeroTorsionPalatiniConnectionAntiPerp[-e,-f,a,b,c]ConjugateSourceZeroTorsionPalatiniConnectionAntiPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionAntiPara2m[-n,-m,-o],Evaluate[Dagger@(
		ProjZeroTorsionPalatiniConnectionAnti2m[-n,-m,-o,d,e,f]ProjZeroTorsionPalatiniConnectionAntiPara[-d,-e,-f,a,b,c]ConjugateSourceZeroTorsionPalatiniConnectionAntiPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionAntiPerpSpinParityToConjugateSourceZeroTorsionPalatiniConnectionAnti=Join[
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionAntiPerp1p[-n,-m],Evaluate[
		ZeroTorsionPalatiniProjPara[-n,a]ZeroTorsionPalatiniProjPara[-m,b]ConjugateSourceZeroTorsionPalatiniConnectionAntiPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionAntiPerp1m[-n],Evaluate[
		ZeroTorsionPalatiniProjPara[-n,a]V[b]ConjugateSourceZeroTorsionPalatiniConnectionAntiPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionAntiPerp1p[-n,-m],Evaluate[Dagger@(
		ZeroTorsionPalatiniProjPara[-n,a]ZeroTorsionPalatiniProjPara[-m,b]ConjugateSourceZeroTorsionPalatiniConnectionAntiPerp[-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionAntiPerp1m[-n],Evaluate[Dagger@(
		ZeroTorsionPalatiniProjPara[-n,a]V[b]ConjugateSourceZeroTorsionPalatiniConnectionAntiPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];

(*---------------------------------*)
(*  ConjugateSourceZeroTorsionPalatiniConnectionSymmhiyuan: MAG expansions (ZeroTorsionPalatiniConnectionSymm,ConjugateSourceZeroTorsionPalatiniConnectionSymm)  *)
(*---------------------------------*)

xAct`PSALTer`ZeroTorsionPalatini`Private`ExpandZeroTorsionPalatiniConnectionSymmFtoReduced=Join[
	MakeRule[{ZeroTorsionPalatiniConnectionSymmPerpT0pF[-i,-j,-a],Evaluate[(V[-i]V[-j]V[-a]ZeroTorsionPalatiniConnectionSymmPerpT0p[])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionSymmPerpT0pF[-i,-j,-a],Evaluate@Dagger[(V[-i]V[-j]V[-a]ZeroTorsionPalatiniConnectionSymmPerpT0p[])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ZeroTorsionPalatiniConnectionSymmPerpT1mF[-i,-j,-a],Evaluate[(totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]V[-k]V[-l]ZeroTorsionPalatiniConnectionSymmPerpT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionSymmPerpT1mF[-i,-j,-a],Evaluate@Dagger[(totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]V[-k]V[-l]ZeroTorsionPalatiniConnectionSymmPerpT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ZeroTorsionPalatiniConnectionSymmPara0pF[-i,-j,-a],Evaluate[((ZeroTorsionPalatiniConnectionSymmPara0p[]/3)totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]ZeroTorsionPalatiniProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionSymmPara0pF[-i,-j,-a],Evaluate@Dagger[((ZeroTorsionPalatiniConnectionSymmPara0p[]/3)totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]ZeroTorsionPalatiniProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ZeroTorsionPalatiniConnectionSymmPara2pF[-i,-j,-a],Evaluate[(totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]ZeroTorsionPalatiniConnectionSymmPara2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionSymmPara2pF[-i,-j,-a],Evaluate@Dagger[(totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]ZeroTorsionPalatiniConnectionSymmPara2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ZeroTorsionPalatiniConnectionSymmParaT1mF[-i,-j,-a],Evaluate[((1/5)totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]ZeroTorsionPalatiniProjPara[-k,-l]ZeroTorsionPalatiniConnectionSymmParaT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionSymmParaT1mF[-i,-j,-a],Evaluate@Dagger[((1/5)totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]ZeroTorsionPalatiniProjPara[-k,-l]ZeroTorsionPalatiniConnectionSymmParaT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ZeroTorsionPalatiniConnectionSymmPara3mF[-i,-j,-a],Evaluate[ZeroTorsionPalatiniConnectionSymmPara3m[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionSymmPara3mF[-i,-j,-a],Evaluate@Dagger[ZeroTorsionPalatiniConnectionSymmPara3m[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ZeroTorsionPalatiniConnectionSymmPerpH1mF[-i,-j,-a],Evaluate[(remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]V[-k]V[-l]ZeroTorsionPalatiniConnectionSymmPerpH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionSymmPerpH1mF[-i,-j,-a],Evaluate@Dagger[(remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]V[-k]V[-l]ZeroTorsionPalatiniConnectionSymmPerpH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ZeroTorsionPalatiniConnectionSymmPara1pF[-i,-j,-a],Evaluate[((1/2)(V[-i]ZeroTorsionPalatiniConnectionSymmPara1p[-j,-a]+V[-j]ZeroTorsionPalatiniConnectionSymmPara1p[-i,-a]))//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionSymmPara1pF[-i,-j,-a],Evaluate@Dagger[((1/2)(V[-i]ZeroTorsionPalatiniConnectionSymmPara1p[-j,-a]+V[-j]ZeroTorsionPalatiniConnectionSymmPara1p[-i,-a]))//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ZeroTorsionPalatiniConnectionSymmPerpH0pF[-i,-j,-a],Evaluate[((ZeroTorsionPalatiniConnectionSymmPerpH0p[]/3)remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]ZeroTorsionPalatiniProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionSymmPerpH0pF[-i,-j,-a],Evaluate@Dagger[((ZeroTorsionPalatiniConnectionSymmPerpH0p[]/3)remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]ZeroTorsionPalatiniProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ZeroTorsionPalatiniConnectionSymmPerp2pF[-i,-j,-a],Evaluate[(remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]ZeroTorsionPalatiniConnectionSymmPerp2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionSymmPerp2pF[-i,-j,-a],Evaluate@Dagger[(remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]ZeroTorsionPalatiniConnectionSymmPerp2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ZeroTorsionPalatiniConnectionSymmParaH1mF[-i,-j,-a],Evaluate[((1/2)remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]ZeroTorsionPalatiniProjPara[-k,-l]ZeroTorsionPalatiniConnectionSymmParaH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionSymmParaH1mF[-i,-j,-a],Evaluate@Dagger[((1/2)remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]ZeroTorsionPalatiniProjPara[-k,-l]ZeroTorsionPalatiniConnectionSymmParaH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ZeroTorsionPalatiniConnectionSymmPara2mF[-i,-j,-a],Evaluate[ZeroTorsionPalatiniConnectionSymmPara2m[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionSymmPara2mF[-i,-j,-a],Evaluate@Dagger[ZeroTorsionPalatiniConnectionSymmPara2m[-i,-j,-a]]},MetricOn->All,ContractMetrics->True]	
];

xAct`PSALTer`ZeroTorsionPalatini`Private`ExpandConjugateSourceZeroTorsionPalatiniConnectionSymmFtoReduced=Join[
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpT0pF[-i,-j,-a],Evaluate[(V[-i]V[-j]V[-a]ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpT0p[])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpT0pF[-i,-j,-a],Evaluate@Dagger[(V[-i]V[-j]V[-a]ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpT0p[])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpT1mF[-i,-j,-a],Evaluate[(totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]V[-k]V[-l]ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpT1mF[-i,-j,-a],Evaluate@Dagger[(totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]V[-k]V[-l]ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionSymmPara0pF[-i,-j,-a],Evaluate[((ConjugateSourceZeroTorsionPalatiniConnectionSymmPara0p[]/3)totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]ZeroTorsionPalatiniProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionSymmPara0pF[-i,-j,-a],Evaluate@Dagger[((ConjugateSourceZeroTorsionPalatiniConnectionSymmPara0p[]/3)totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]ZeroTorsionPalatiniProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionSymmPara2pF[-i,-j,-a],Evaluate[(totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]ConjugateSourceZeroTorsionPalatiniConnectionSymmPara2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionSymmPara2pF[-i,-j,-a],Evaluate@Dagger[(totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]ConjugateSourceZeroTorsionPalatiniConnectionSymmPara2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionSymmParaT1mF[-i,-j,-a],Evaluate[((1/5)totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]ZeroTorsionPalatiniProjPara[-k,-l]ConjugateSourceZeroTorsionPalatiniConnectionSymmParaT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionSymmParaT1mF[-i,-j,-a],Evaluate@Dagger[((1/5)totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]ZeroTorsionPalatiniProjPara[-k,-l]ConjugateSourceZeroTorsionPalatiniConnectionSymmParaT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionSymmPara3mF[-i,-j,-a],Evaluate[ConjugateSourceZeroTorsionPalatiniConnectionSymmPara3m[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionSymmPara3mF[-i,-j,-a],Evaluate@Dagger[ConjugateSourceZeroTorsionPalatiniConnectionSymmPara3m[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpH1mF[-i,-j,-a],Evaluate[(remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]V[-k]V[-l]ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpH1mF[-i,-j,-a],Evaluate@Dagger[(remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]V[-k]V[-l]ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionSymmPara1pF[-i,-j,-a],Evaluate[((1/2)(V[-i]ConjugateSourceZeroTorsionPalatiniConnectionSymmPara1p[-j,-a]+V[-j]ConjugateSourceZeroTorsionPalatiniConnectionSymmPara1p[-i,-a]))//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionSymmPara1pF[-i,-j,-a],Evaluate@Dagger[((1/2)(V[-i]ConjugateSourceZeroTorsionPalatiniConnectionSymmPara1p[-j,-a]+V[-j]ConjugateSourceZeroTorsionPalatiniConnectionSymmPara1p[-i,-a]))//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpH0pF[-i,-j,-a],Evaluate[((ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpH0p[]/3)remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]ZeroTorsionPalatiniProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpH0pF[-i,-j,-a],Evaluate@Dagger[((ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpH0p[]/3)remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]ZeroTorsionPalatiniProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionSymmPerp2pF[-i,-j,-a],Evaluate[(remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]ConjugateSourceZeroTorsionPalatiniConnectionSymmPerp2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionSymmPerp2pF[-i,-j,-a],Evaluate@Dagger[(remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]ConjugateSourceZeroTorsionPalatiniConnectionSymmPerp2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionSymmParaH1mF[-i,-j,-a],Evaluate[((1/2)remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]ZeroTorsionPalatiniProjPara[-k,-l]ConjugateSourceZeroTorsionPalatiniConnectionSymmParaH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionSymmParaH1mF[-i,-j,-a],Evaluate@Dagger[((1/2)remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-i,-j,-a]ZeroTorsionPalatiniProjPara[-k,-l]ConjugateSourceZeroTorsionPalatiniConnectionSymmParaH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionSymmPara2mF[-i,-j,-a],Evaluate[ConjugateSourceZeroTorsionPalatiniConnectionSymmPara2m[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionSymmPara2mF[-i,-j,-a],Evaluate@Dagger[ConjugateSourceZeroTorsionPalatiniConnectionSymmPara2m[-i,-j,-a]]},MetricOn->All,ContractMetrics->True]	
];

(*==================*)
(*  Decompositions  *)
(*==================*)

(*--------------------------------------------*)
(*  Will: metric perturbation decompositions  *)
(*--------------------------------------------*)

xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniMetricPerturbationToZeroTorsionPalatiniMetricPerturbationSpinParity=Join[
	MakeRule[{ZeroTorsionPalatiniMetricPerturbation[-a,-b],Evaluate[
		(
			ZeroTorsionPalatiniMetricPerturbationPerp0p[]V[-a]V[-b]
			+ZeroTorsionPalatiniMetricPerturbationPerp1m[-a]V[-b]
			+ZeroTorsionPalatiniMetricPerturbationPerp1m[-b]V[-a]
			+(1/3)*ZeroTorsionPalatiniMetricPerturbationPara0p[]ZeroTorsionPalatiniProjPara[-a,-b]
			+ZeroTorsionPalatiniMetricPerturbationPara2p[-a,-b]
		)//ToCanonical
	]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniMetricPerturbation[-a,-b],Evaluate@Dagger[
		(
			ZeroTorsionPalatiniMetricPerturbationPerp0p[]V[-a]V[-b]
			+ZeroTorsionPalatiniMetricPerturbationPerp1m[-a]V[-b]
			+ZeroTorsionPalatiniMetricPerturbationPerp1m[-b]V[-a]
			+(1/3)*ZeroTorsionPalatiniMetricPerturbationPara0p[]ZeroTorsionPalatiniProjPara[-a,-b]
			+ZeroTorsionPalatiniMetricPerturbationPara2p[-a,-b]
		)//ToCanonical
	]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniMetricPerturbationToConjugateSourceZeroTorsionPalatiniMetricPerturbationSpinParity=Join[
	MakeRule[{ConjugateSourceZeroTorsionPalatiniMetricPerturbation[-a,-b],Evaluate[
		(
			ConjugateSourceZeroTorsionPalatiniMetricPerturbationPerp0p[]V[-a]V[-b]
			+ConjugateSourceZeroTorsionPalatiniMetricPerturbationPerp1m[-a]V[-b]
			+ConjugateSourceZeroTorsionPalatiniMetricPerturbationPerp1m[-b]V[-a]
			+(1/3)*ConjugateSourceZeroTorsionPalatiniMetricPerturbationPara0p[]ZeroTorsionPalatiniProjPara[-a,-b]
			+ConjugateSourceZeroTorsionPalatiniMetricPerturbationPara2p[-a,-b]
		)//ToCanonical
	]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniMetricPerturbation[-a,-b],Evaluate@Dagger[
		(
			ConjugateSourceZeroTorsionPalatiniMetricPerturbationPerp0p[]V[-a]V[-b]
			+ConjugateSourceZeroTorsionPalatiniMetricPerturbationPerp1m[-a]V[-b]
			+ConjugateSourceZeroTorsionPalatiniMetricPerturbationPerp1m[-b]V[-a]
			+(1/3)*ConjugateSourceZeroTorsionPalatiniMetricPerturbationPara0p[]ZeroTorsionPalatiniProjPara[-a,-b]
			+ConjugateSourceZeroTorsionPalatiniMetricPerturbationPara2p[-a,-b]
		)//ToCanonical
	]},MetricOn->All,ContractMetrics->True]];

(*------------------------------*)
(*  Will: other decompositions  *)
(*------------------------------*)

xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiParaToZeroTorsionPalatiniConnectionAntiParaSpinParity=Join[
	MakeRule[{ZeroTorsionPalatiniConnectionAntiPara[-n,-m,-o],Evaluate[
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ZeroTorsionPalatiniProjPara[-m,-o]ZeroTorsionPalatiniConnectionAntiPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]ZeroTorsionPalatiniConnectionAntiPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]ZeroTorsionPalatiniConnectionAntiPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjZeroTorsionPalatiniConnectionAnti0m[-n,-m,-o]ZeroTorsionPalatiniConnectionAntiPara0m[]+
		Antisymmetrize[-ZeroTorsionPalatiniProjPara[-m,-o]ZeroTorsionPalatiniConnectionAntiPara1m[-n],{-m,-n}]+
		(4/3)ZeroTorsionPalatiniConnectionAntiPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`ZeroTorsionPalatini`Private`ProjZeroTorsionPalatiniConnectionAntiSpinParityToVG/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionAntiPara[-n,-m,-o],Evaluate[Dagger@(
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ZeroTorsionPalatiniProjPara[-m,-o]ZeroTorsionPalatiniConnectionAntiPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]ZeroTorsionPalatiniConnectionAntiPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]ZeroTorsionPalatiniConnectionAntiPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjZeroTorsionPalatiniConnectionAnti0m[-n,-m,-o]ZeroTorsionPalatiniConnectionAntiPara0m[]+
		Antisymmetrize[-ZeroTorsionPalatiniProjPara[-m,-o]ZeroTorsionPalatiniConnectionAntiPara1m[-n],{-m,-n}]+
		(4/3)ZeroTorsionPalatiniConnectionAntiPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`ZeroTorsionPalatini`Private`ProjZeroTorsionPalatiniConnectionAntiSpinParityToVG/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiPerpToZeroTorsionPalatiniConnectionAntiPerpSpinParity=Join[
	MakeRule[{ZeroTorsionPalatiniConnectionAntiPerp[-n,-m],Evaluate[ZeroTorsionPalatiniConnectionAntiPerp1p[-n,-m]+2Antisymmetrize[V[-m]ZeroTorsionPalatiniConnectionAntiPerp1m[-n],{-n,-m}]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionAntiPerp[-n,-m],Evaluate[Dagger@(ZeroTorsionPalatiniConnectionAntiPerp1p[-n,-m]+2Antisymmetrize[V[-m]ZeroTorsionPalatiniConnectionAntiPerp1m[-n],{-n,-m}])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionAntiParaToConjugateSourceZeroTorsionPalatiniConnectionAntiParaSpinParity=Join[
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionAntiPara[-o,-n,-m],Evaluate[
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ZeroTorsionPalatiniProjPara[-m,-o]ConjugateSourceZeroTorsionPalatiniConnectionAntiPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]ConjugateSourceZeroTorsionPalatiniConnectionAntiPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]ConjugateSourceZeroTorsionPalatiniConnectionAntiPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjZeroTorsionPalatiniConnectionAnti0m[-n,-m,-o]ConjugateSourceZeroTorsionPalatiniConnectionAntiPara0m[]+
		Antisymmetrize[-ZeroTorsionPalatiniProjPara[-m,-o]ConjugateSourceZeroTorsionPalatiniConnectionAntiPara1m[-n],{-m,-n}]+
		(4/3)ConjugateSourceZeroTorsionPalatiniConnectionAntiPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`ZeroTorsionPalatini`Private`ProjZeroTorsionPalatiniConnectionAntiSpinParityToVG/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionAntiPara[-o,-n,-m],Evaluate[Dagger@(
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ZeroTorsionPalatiniProjPara[-m,-o]ConjugateSourceZeroTorsionPalatiniConnectionAntiPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]ConjugateSourceZeroTorsionPalatiniConnectionAntiPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]ConjugateSourceZeroTorsionPalatiniConnectionAntiPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjZeroTorsionPalatiniConnectionAnti0m[-n,-m,-o]ConjugateSourceZeroTorsionPalatiniConnectionAntiPara0m[]+
		Antisymmetrize[-ZeroTorsionPalatiniProjPara[-m,-o]ConjugateSourceZeroTorsionPalatiniConnectionAntiPara1m[-n],{-m,-n}]+
		(4/3)ConjugateSourceZeroTorsionPalatiniConnectionAntiPara2m[-n,-m,-o],{-n,-m}])/.xAct`PSALTer`ZeroTorsionPalatini`Private`ProjZeroTorsionPalatiniConnectionAntiSpinParityToVG/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionAntiPerpToConjugateSourceZeroTorsionPalatiniConnectionAntiPerpSpinParity=Join[
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionAntiPerp[-n,-m],Evaluate[ConjugateSourceZeroTorsionPalatiniConnectionAntiPerp1p[-n,-m]+2Antisymmetrize[V[-m]ConjugateSourceZeroTorsionPalatiniConnectionAntiPerp1m[-n],{-n,-m}]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionAntiPerp[-n,-m],Evaluate[Dagger@(ConjugateSourceZeroTorsionPalatiniConnectionAntiPerp1p[-n,-m]+2Antisymmetrize[V[-m]ConjugateSourceZeroTorsionPalatiniConnectionAntiPerp1m[-n],{-n,-m}])]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`ZeroTorsionPalatini`Private`Patch2m=Join[
	MakeRule[{ZeroTorsionPalatiniConnectionAntiPara2m[-a,-c,-b]ZeroTorsionPalatiniConnectionAntiPara2m[a,b,c],(1/2)ZeroTorsionPalatiniConnectionAntiPara2m[-a,-b,-c]ZeroTorsionPalatiniConnectionAntiPara2m[a,b,c]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate[Dagger@ZeroTorsionPalatiniConnectionAntiPara2m[-a,-c,-b]ZeroTorsionPalatiniConnectionAntiPara2m[a,b,c]],Evaluate[(1/2)Dagger@ZeroTorsionPalatiniConnectionAntiPara2m[-a,-b,-c]ZeroTorsionPalatiniConnectionAntiPara2m[a,b,c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate[ZeroTorsionPalatiniConnectionAntiPara2m[-a,-c,-b]Dagger@ZeroTorsionPalatiniConnectionAntiPara2m[a,b,c]],Evaluate[(1/2)ZeroTorsionPalatiniConnectionAntiPara2m[-a,-b,-c]Dagger@ZeroTorsionPalatiniConnectionAntiPara2m[a,b,c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionAntiPara2m[-a,-c,-b]ConjugateSourceZeroTorsionPalatiniConnectionAntiPara2m[a,b,c],(1/2)ConjugateSourceZeroTorsionPalatiniConnectionAntiPara2m[-a,-b,-c]ConjugateSourceZeroTorsionPalatiniConnectionAntiPara2m[a,b,c]},MetricOn->All,ContractMetrics->True]];

(*-------------------------------------*)
(*  ConjugateSourceZeroTorsionPalatiniConnectionSymmhiyuan: MAG decompositions (ZeroTorsionPalatiniConnectionSymm,ConjugateSourceZeroTorsionPalatiniConnectionSymm)  *)
(*-------------------------------------*)

xAct`PSALTer`ZeroTorsionPalatini`Private`DecomposeZeroTorsionPalatiniConnectionSymmReducedtoZeroTorsionPalatiniConnectionSymm=Join[
	MakeRule[{ZeroTorsionPalatiniConnectionSymmPerpT0p[],Evaluate[V[i]V[j]V[a]ZeroTorsionPalatiniConnectionSymm[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionSymmPerpT0p[],Evaluate@Dagger[V[i]V[j]V[a]ZeroTorsionPalatiniConnectionSymm[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ZeroTorsionPalatiniConnectionSymmPerpT1m[-i],Evaluate[(3ZeroTorsionPalatiniProjPara[m,-i]V[n]V[c]totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionSymmPerpT1m[-i],Evaluate@Dagger[(3ZeroTorsionPalatiniProjPara[m,-i]V[n]V[c]totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ZeroTorsionPalatiniConnectionSymmPara0p[],Evaluate[(3ZeroTorsionPalatiniProjPara[m,-z]ZeroTorsionPalatiniProjPara[n,z]V[c]totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionSymmPara0p[],Evaluate@Dagger[(3ZeroTorsionPalatiniProjPara[m,-z]ZeroTorsionPalatiniProjPara[n,z]V[c]totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ZeroTorsionPalatiniConnectionSymmPara2p[-i,-j],Evaluate[((3ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,-j]-ZeroTorsionPalatiniProjPara[-i,-j]ZeroTorsionPalatiniProjPara[m,-z]ZeroTorsionPalatiniProjPara[n,z])V[c]totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionSymmPara2p[-i,-j],Evaluate@Dagger[((3ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,-j]-ZeroTorsionPalatiniProjPara[-i,-j]ZeroTorsionPalatiniProjPara[m,-z]ZeroTorsionPalatiniProjPara[n,z])V[c]totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ZeroTorsionPalatiniConnectionSymmParaT1m[-i],Evaluate[(3ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,z]ZeroTorsionPalatiniProjPara[c,-z]totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionSymmParaT1m[-i],Evaluate@Dagger[(3ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,z]ZeroTorsionPalatiniProjPara[c,-z]totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ZeroTorsionPalatiniConnectionSymmPara3m[-i,-j,-a],Evaluate[((ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,-j]ZeroTorsionPalatiniProjPara[c,-a]-(1/5)(ZeroTorsionPalatiniProjPara[-i,-j]ZeroTorsionPalatiniProjPara[m,-z]ZeroTorsionPalatiniProjPara[n,z]ZeroTorsionPalatiniProjPara[c,-a]+ZeroTorsionPalatiniProjPara[-j,-a]ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,z]ZeroTorsionPalatiniProjPara[c,-z]+ZeroTorsionPalatiniProjPara[-i,-a]ZeroTorsionPalatiniProjPara[m,-z]ZeroTorsionPalatiniProjPara[n,-j]ZeroTorsionPalatiniProjPara[c,z]))totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionSymmPara3m[-i,-j,-a],Evaluate@Dagger[((ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,-j]ZeroTorsionPalatiniProjPara[c,-a]-(1/5)(ZeroTorsionPalatiniProjPara[-i,-j]ZeroTorsionPalatiniProjPara[m,-z]ZeroTorsionPalatiniProjPara[n,z]ZeroTorsionPalatiniProjPara[c,-a]+ZeroTorsionPalatiniProjPara[-j,-a]ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,z]ZeroTorsionPalatiniProjPara[c,-z]+ZeroTorsionPalatiniProjPara[-i,-a]ZeroTorsionPalatiniProjPara[m,-z]ZeroTorsionPalatiniProjPara[n,-j]ZeroTorsionPalatiniProjPara[c,z]))totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ZeroTorsionPalatiniConnectionSymmPerpH1m[-i],Evaluate[((ZeroTorsionPalatiniConnectionSymm[-k,-l,-i]-ZeroTorsionPalatiniConnectionSymm[-i,-k,-l])V[k]V[l])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionSymmPerpH1m[-i],Evaluate@Dagger[((ZeroTorsionPalatiniConnectionSymm[-k,-l,-i]-ZeroTorsionPalatiniConnectionSymm[-i,-k,-l])V[k]V[l])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ZeroTorsionPalatiniConnectionSymmPara1p[-i,-a],Evaluate[((ZeroTorsionPalatiniConnectionSymm[-k,-i,-a]-ZeroTorsionPalatiniConnectionSymm[-k,-a,-i])V[k]+V[k]V[l]((ZeroTorsionPalatiniConnectionSymm[-k,-l,-i]-ZeroTorsionPalatiniConnectionSymm[-i,-k,-l])V[-a]-(ZeroTorsionPalatiniConnectionSymm[-k,-l,-a]-ZeroTorsionPalatiniConnectionSymm[-a,-k,-l])V[-i]))//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionSymmPara1p[-i,-a],Evaluate@Dagger[((ZeroTorsionPalatiniConnectionSymm[-k,-i,-a]-ZeroTorsionPalatiniConnectionSymm[-k,-a,-i])V[k]+V[k]V[l]((ZeroTorsionPalatiniConnectionSymm[-k,-l,-i]-ZeroTorsionPalatiniConnectionSymm[-i,-k,-l])V[-a]-(ZeroTorsionPalatiniConnectionSymm[-k,-l,-a]-ZeroTorsionPalatiniConnectionSymm[-a,-k,-l])V[-i]))//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ZeroTorsionPalatiniConnectionSymmPerpH0p[],Evaluate[(ZeroTorsionPalatiniConnectionSymm[k,-k,-i]-ZeroTorsionPalatiniConnectionSymm[-i,-k,k])V[i]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionSymmPerpH0p[],Evaluate@Dagger[(ZeroTorsionPalatiniConnectionSymm[k,-k,-i]-ZeroTorsionPalatiniConnectionSymm[-i,-k,k])V[i]]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ZeroTorsionPalatiniConnectionSymmPerp2p[-i,-j],Evaluate[((3/2)(ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,-j]-(ZeroTorsionPalatiniProjPara[-i,-j]/3)ZeroTorsionPalatiniProjPara[m,-z]ZeroTorsionPalatiniProjPara[n,z])V[c]remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionSymmPerp2p[-i,-j],Evaluate@Dagger[((3/2)(ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,-j]-(ZeroTorsionPalatiniProjPara[-i,-j]/3)ZeroTorsionPalatiniProjPara[m,-z]ZeroTorsionPalatiniProjPara[n,z])V[c]remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ZeroTorsionPalatiniConnectionSymmParaH1m[-i],Evaluate[((-3)ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,z]ZeroTorsionPalatiniProjPara[c,-z]remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionSymmParaH1m[-i],Evaluate@Dagger[((-3)ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,z]ZeroTorsionPalatiniProjPara[c,-z]remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ZeroTorsionPalatiniConnectionSymmPara2m[-i,-j,-a],Evaluate[((ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,-j]ZeroTorsionPalatiniProjPara[c,-a]-(1/2)(ZeroTorsionPalatiniProjPara[-i,-j]ZeroTorsionPalatiniProjPara[m,-z]ZeroTorsionPalatiniProjPara[n,z]ZeroTorsionPalatiniProjPara[c,-a]+ZeroTorsionPalatiniProjPara[-j,-a]ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,z]ZeroTorsionPalatiniProjPara[c,-z]+ZeroTorsionPalatiniProjPara[-i,-a]ZeroTorsionPalatiniProjPara[m,-z]ZeroTorsionPalatiniProjPara[n,-j]ZeroTorsionPalatiniProjPara[c,z]))remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ZeroTorsionPalatiniConnectionSymmPara2m[-i,-j,-a],Evaluate@Dagger[((ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,-j]ZeroTorsionPalatiniProjPara[c,-a]-(1/2)(ZeroTorsionPalatiniProjPara[-i,-j]ZeroTorsionPalatiniProjPara[m,-z]ZeroTorsionPalatiniProjPara[n,z]ZeroTorsionPalatiniProjPara[c,-a]+ZeroTorsionPalatiniProjPara[-j,-a]ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,z]ZeroTorsionPalatiniProjPara[c,-z]+ZeroTorsionPalatiniProjPara[-i,-a]ZeroTorsionPalatiniProjPara[m,-z]ZeroTorsionPalatiniProjPara[n,-j]ZeroTorsionPalatiniProjPara[c,z]))remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True]
];

xAct`PSALTer`ZeroTorsionPalatini`Private`DecomposeConjugateSourceZeroTorsionPalatiniConnectionSymmReducedtoConjugateSourceZeroTorsionPalatiniConnectionSymm=Join[
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpT0p[],Evaluate[V[i]V[j]V[a]ConjugateSourceZeroTorsionPalatiniConnectionSymm[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpT0p[],Evaluate@Dagger[V[i]V[j]V[a]ConjugateSourceZeroTorsionPalatiniConnectionSymm[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpT1m[-i],Evaluate[(3ZeroTorsionPalatiniProjPara[m,-i]V[n]V[c]totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpT1m[-i],Evaluate@Dagger[(3ZeroTorsionPalatiniProjPara[m,-i]V[n]V[c]totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionSymmPara0p[],Evaluate[(3ZeroTorsionPalatiniProjPara[m,-z]ZeroTorsionPalatiniProjPara[n,z]V[c]totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionSymmPara0p[],Evaluate@Dagger[(3ZeroTorsionPalatiniProjPara[m,-z]ZeroTorsionPalatiniProjPara[n,z]V[c]totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionSymmPara2p[-i,-j],Evaluate[((3ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,-j]-ZeroTorsionPalatiniProjPara[-i,-j]ZeroTorsionPalatiniProjPara[m,-z]ZeroTorsionPalatiniProjPara[n,z])V[c]totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionSymmPara2p[-i,-j],Evaluate@Dagger[((3ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,-j]-ZeroTorsionPalatiniProjPara[-i,-j]ZeroTorsionPalatiniProjPara[m,-z]ZeroTorsionPalatiniProjPara[n,z])V[c]totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionSymmParaT1m[-i],Evaluate[(3ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,z]ZeroTorsionPalatiniProjPara[c,-z]totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionSymmParaT1m[-i],Evaluate@Dagger[(3ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,z]ZeroTorsionPalatiniProjPara[c,-z]totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionSymmPara3m[-i,-j,-a],Evaluate[((ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,-j]ZeroTorsionPalatiniProjPara[c,-a]-(1/5)(ZeroTorsionPalatiniProjPara[-i,-j]ZeroTorsionPalatiniProjPara[m,-z]ZeroTorsionPalatiniProjPara[n,z]ZeroTorsionPalatiniProjPara[c,-a]+ZeroTorsionPalatiniProjPara[-j,-a]ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,z]ZeroTorsionPalatiniProjPara[c,-z]+ZeroTorsionPalatiniProjPara[-i,-a]ZeroTorsionPalatiniProjPara[m,-z]ZeroTorsionPalatiniProjPara[n,-j]ZeroTorsionPalatiniProjPara[c,z]))totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionSymmPara3m[-i,-j,-a],Evaluate@Dagger[((ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,-j]ZeroTorsionPalatiniProjPara[c,-a]-(1/5)(ZeroTorsionPalatiniProjPara[-i,-j]ZeroTorsionPalatiniProjPara[m,-z]ZeroTorsionPalatiniProjPara[n,z]ZeroTorsionPalatiniProjPara[c,-a]+ZeroTorsionPalatiniProjPara[-j,-a]ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,z]ZeroTorsionPalatiniProjPara[c,-z]+ZeroTorsionPalatiniProjPara[-i,-a]ZeroTorsionPalatiniProjPara[m,-z]ZeroTorsionPalatiniProjPara[n,-j]ZeroTorsionPalatiniProjPara[c,z]))totsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpH1m[-i],Evaluate[((ConjugateSourceZeroTorsionPalatiniConnectionSymm[-k,-l,-i]-ConjugateSourceZeroTorsionPalatiniConnectionSymm[-i,-k,-l])V[k]V[l])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpH1m[-i],Evaluate@Dagger[((ConjugateSourceZeroTorsionPalatiniConnectionSymm[-k,-l,-i]-ConjugateSourceZeroTorsionPalatiniConnectionSymm[-i,-k,-l])V[k]V[l])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionSymmPara1p[-i,-a],Evaluate[((ConjugateSourceZeroTorsionPalatiniConnectionSymm[-k,-i,-a]-ConjugateSourceZeroTorsionPalatiniConnectionSymm[-k,-a,-i])V[k]+V[k]V[l]((ConjugateSourceZeroTorsionPalatiniConnectionSymm[-k,-l,-i]-ConjugateSourceZeroTorsionPalatiniConnectionSymm[-i,-k,-l])V[-a]-(ConjugateSourceZeroTorsionPalatiniConnectionSymm[-k,-l,-a]-ConjugateSourceZeroTorsionPalatiniConnectionSymm[-a,-k,-l])V[-i]))//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionSymmPara1p[-i,-a],Evaluate@Dagger[((ConjugateSourceZeroTorsionPalatiniConnectionSymm[-k,-i,-a]-ConjugateSourceZeroTorsionPalatiniConnectionSymm[-k,-a,-i])V[k]+V[k]V[l]((ConjugateSourceZeroTorsionPalatiniConnectionSymm[-k,-l,-i]-ConjugateSourceZeroTorsionPalatiniConnectionSymm[-i,-k,-l])V[-a]-(ConjugateSourceZeroTorsionPalatiniConnectionSymm[-k,-l,-a]-ConjugateSourceZeroTorsionPalatiniConnectionSymm[-a,-k,-l])V[-i]))//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpH0p[],Evaluate[(ConjugateSourceZeroTorsionPalatiniConnectionSymm[k,-k,-i]-ConjugateSourceZeroTorsionPalatiniConnectionSymm[-i,-k,k])V[i]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpH0p[],Evaluate@Dagger[(ConjugateSourceZeroTorsionPalatiniConnectionSymm[k,-k,-i]-ConjugateSourceZeroTorsionPalatiniConnectionSymm[-i,-k,k])V[i]]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionSymmPerp2p[-i,-j],Evaluate[((3/2)(ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,-j]-(ZeroTorsionPalatiniProjPara[-i,-j]/3)ZeroTorsionPalatiniProjPara[m,-z]ZeroTorsionPalatiniProjPara[n,z])V[c]remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionSymmPerp2p[-i,-j],Evaluate@Dagger[((3/2)(ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,-j]-(ZeroTorsionPalatiniProjPara[-i,-j]/3)ZeroTorsionPalatiniProjPara[m,-z]ZeroTorsionPalatiniProjPara[n,z])V[c]remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionSymmParaH1m[-i],Evaluate[((-3)ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,z]ZeroTorsionPalatiniProjPara[c,-z]remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionSymmParaH1m[-i],Evaluate@Dagger[((-3)ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,z]ZeroTorsionPalatiniProjPara[c,-z]remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],

	MakeRule[{ConjugateSourceZeroTorsionPalatiniConnectionSymmPara2m[-i,-j,-a],Evaluate[((ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,-j]ZeroTorsionPalatiniProjPara[c,-a]-(1/2)(ZeroTorsionPalatiniProjPara[-i,-j]ZeroTorsionPalatiniProjPara[m,-z]ZeroTorsionPalatiniProjPara[n,z]ZeroTorsionPalatiniProjPara[c,-a]+ZeroTorsionPalatiniProjPara[-j,-a]ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,z]ZeroTorsionPalatiniProjPara[c,-z]+ZeroTorsionPalatiniProjPara[-i,-a]ZeroTorsionPalatiniProjPara[m,-z]ZeroTorsionPalatiniProjPara[n,-j]ZeroTorsionPalatiniProjPara[c,z]))remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceZeroTorsionPalatiniConnectionSymmPara2m[-i,-j,-a],Evaluate@Dagger[((ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,-j]ZeroTorsionPalatiniProjPara[c,-a]-(1/2)(ZeroTorsionPalatiniProjPara[-i,-j]ZeroTorsionPalatiniProjPara[m,-z]ZeroTorsionPalatiniProjPara[n,z]ZeroTorsionPalatiniProjPara[c,-a]+ZeroTorsionPalatiniProjPara[-j,-a]ZeroTorsionPalatiniProjPara[m,-i]ZeroTorsionPalatiniProjPara[n,z]ZeroTorsionPalatiniProjPara[c,-z]+ZeroTorsionPalatiniProjPara[-i,-a]ZeroTorsionPalatiniProjPara[m,-z]ZeroTorsionPalatiniProjPara[n,-j]ZeroTorsionPalatiniProjPara[c,z]))remsymZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymm[k,l,b,-m,-n,-c]ConjugateSourceZeroTorsionPalatiniConnectionSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True]
];

(*==========================================================*)
(*  Basic definitions of the Lagrangian coupling constants  *)
(*==========================================================*)

xAct`PSALTer`ZeroTorsionPalatini`Private`ACouplingSymb="\[ScriptA]";

DefLagrangianCoupling[A0,CouplingSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ACouplingSymb,CouplingIndex->0];
DefLagrangianCoupling[A4,CouplingSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ACouplingSymb,CouplingIndex->4];
DefLagrangianCoupling[A5,CouplingSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ACouplingSymb,CouplingIndex->5];
DefLagrangianCoupling[A6,CouplingSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ACouplingSymb,CouplingIndex->6];
DefLagrangianCoupling[A7,CouplingSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ACouplingSymb,CouplingIndex->7];
DefLagrangianCoupling[A8,CouplingSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`ACouplingSymb,CouplingIndex->8];

xAct`PSALTer`ZeroTorsionPalatini`Private`HCouplingSymb="\[ScriptH]";

DefLagrangianCoupling[H1,CouplingSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`HCouplingSymb,CouplingIndex->1];
DefLagrangianCoupling[H2,CouplingSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`HCouplingSymb,CouplingIndex->2];
DefLagrangianCoupling[H3,CouplingSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`HCouplingSymb,CouplingIndex->3];
DefLagrangianCoupling[H4,CouplingSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`HCouplingSymb,CouplingIndex->4];
DefLagrangianCoupling[H7,CouplingSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`HCouplingSymb,CouplingIndex->7];
DefLagrangianCoupling[H8,CouplingSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`HCouplingSymb,CouplingIndex->8];
DefLagrangianCoupling[H9,CouplingSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`HCouplingSymb,CouplingIndex->9];
DefLagrangianCoupling[H10,CouplingSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`HCouplingSymb,CouplingIndex->10];
DefLagrangianCoupling[H11,CouplingSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`HCouplingSymb,CouplingIndex->11];
DefLagrangianCoupling[H12,CouplingSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`HCouplingSymb,CouplingIndex->12];
DefLagrangianCoupling[H16,CouplingSymbol->xAct`PSALTer`ZeroTorsionPalatini`Private`HCouplingSymb,CouplingIndex->16];

(*================================================*)
(*  Some infrastructure for linearising theories  *)
(*================================================*)

(*===================*)
(*  Private context  *)
(*===================*)

Begin["xAct`PSALTer`ZeroTorsionPalatini`Private`"];

LagrangianCouplings={A0,A4,A5,A6,A7,A8,H1,H2,H3,H4,H7,H8,H9,H10,H11,H12,H16};

FieldSpinParityTensorHeads=<|
		ZeroTorsionPalatiniMetricPerturbation-><|
			0-><|Even->{ZeroTorsionPalatiniMetricPerturbationPerp0p,ZeroTorsionPalatiniMetricPerturbationPara0p},Odd->{}|>,
			1-><|Even->{},Odd->{ZeroTorsionPalatiniMetricPerturbationPerp1m}|>,
			2-><|Even->{ZeroTorsionPalatiniMetricPerturbationPara2p},Odd->{}|>,
			3-><|Even->{},Odd->{}|>
		|>,
		ZeroTorsionPalatiniConnection-><|
			0-><|Even->{ZeroTorsionPalatiniConnectionSymmPerpT0p,ZeroTorsionPalatiniConnectionSymmPara0p,ZeroTorsionPalatiniConnectionSymmPerpH0p},Odd->{}|>,
			1-><|Even->{ZeroTorsionPalatiniConnectionSymmPara1p},Odd->{ZeroTorsionPalatiniConnectionSymmPerpT1m,ZeroTorsionPalatiniConnectionSymmParaT1m,ZeroTorsionPalatiniConnectionSymmPerpH1m,ZeroTorsionPalatiniConnectionSymmParaH1m}|>,
			2-><|Even->{ZeroTorsionPalatiniConnectionSymmPara2p,ZeroTorsionPalatiniConnectionSymmPerp2p},Odd->{ZeroTorsionPalatiniConnectionSymmPara2m}|>,
			3-><|Even->{},Odd->{ZeroTorsionPalatiniConnectionSymmPara3m}|>
		|>		
|>;

SourceSpinParityTensorHeads=<|
		ConjugateSourceZeroTorsionPalatiniMetricPerturbation-><|
			0-><|Even->{ConjugateSourceZeroTorsionPalatiniMetricPerturbationPerp0p,ConjugateSourceZeroTorsionPalatiniMetricPerturbationPara0p},Odd->{}|>,
			1-><|Even->{},Odd->{ConjugateSourceZeroTorsionPalatiniMetricPerturbationPerp1m}|>,
			2-><|Even->{ConjugateSourceZeroTorsionPalatiniMetricPerturbationPara2p},Odd->{}|>,
			3-><|Even->{},Odd->{}|>
		|>,
		ZeroTorsionPalatiniDilatospin-><|
			0-><|Even->{ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpT0p,ConjugateSourceZeroTorsionPalatiniConnectionSymmPara0p,ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpH0p},Odd->{}|>,
			1-><|Even->{ConjugateSourceZeroTorsionPalatiniConnectionSymmPara1p},Odd->{ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpT1m,ConjugateSourceZeroTorsionPalatiniConnectionSymmParaT1m,ConjugateSourceZeroTorsionPalatiniConnectionSymmPerpH1m,ConjugateSourceZeroTorsionPalatiniConnectionSymmParaH1m}|>,
			2-><|Even->{ConjugateSourceZeroTorsionPalatiniConnectionSymmPara2p,ConjugateSourceZeroTorsionPalatiniConnectionSymmPerp2p},Odd->{ConjugateSourceZeroTorsionPalatiniConnectionSymmPara2m}|>,
			3-><|Even->{},Odd->{ConjugateSourceZeroTorsionPalatiniConnectionSymmPara3m}|>
		|>		
|>;

SourceEngineeringDimensions=<|
		ZeroTorsionPalatiniDilatospin->0,
		ConjugateSourceZeroTorsionPalatiniMetricPerturbation->1
|>;

ExpandFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniMetricPerturbationSpinParityToZeroTorsionPalatiniMetricPerturbation;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;

	(*ZeroTorsionPalatiniConnectionSymm reduced then back to ZeroTorsionPalatiniConnectionSymm*)
	Expr=Expr/.xAct`PSALTer`ZeroTorsionPalatini`Private`DecomposeZeroTorsionPalatiniConnectionSymmReducedtoZeroTorsionPalatiniConnectionSymm;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;	

	Expr=Expr/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiParaSpinParityToZeroTorsionPalatiniConnectionAnti;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiPerpSpinParityToZeroTorsionPalatiniConnectionAnti;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`ZeroTorsionPalatini`Private`ProjZeroTorsionPalatiniConnectionAntiPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`ZeroTorsionPalatini`Private`ProjZeroTorsionPalatiniConnectionAntiSpinParityToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniProjPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiPerpParaToZeroTorsionPalatiniConnectionAnti;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;

	Expr=Expr/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiZeroTorsionPalatiniConnectionSymmToZeroTorsionPalatiniConnection;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;

Expr];

ExpandSources[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniMetricPerturbationSpinParityToConjugateSourceZeroTorsionPalatiniMetricPerturbation;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;

	(*ConjugateSourceZeroTorsionPalatiniConnectionSymm reduced then back to ConjugateSourceZeroTorsionPalatiniConnectionSymm*)
	Expr=Expr/.xAct`PSALTer`ZeroTorsionPalatini`Private`DecomposeConjugateSourceZeroTorsionPalatiniConnectionSymmReducedtoConjugateSourceZeroTorsionPalatiniConnectionSymm;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;	

	Expr=Expr/.xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionAntiParaSpinParityToConjugateSourceZeroTorsionPalatiniConnectionAnti;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionAntiPerpSpinParityToConjugateSourceZeroTorsionPalatiniConnectionAnti;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`ZeroTorsionPalatini`Private`ProjZeroTorsionPalatiniConnectionAntiPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`ZeroTorsionPalatini`Private`ProjZeroTorsionPalatiniConnectionAntiSpinParityToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniProjPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionAntiPerpParaToConjugateSourceZeroTorsionPalatiniConnectionAnti;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;

	Expr=Expr/.xAct`PSALTer`ZeroTorsionPalatini`Private`ConjugateSourceZeroTorsionPalatiniConnectionAntiConjugateSourceZeroTorsionPalatiniConnectionSymmToZeroTorsionPalatiniDilatospin;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;

Expr];

DecomposeFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniMetricPerturbationToZeroTorsionPalatiniMetricPerturbationSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;

	Expr=Expr/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionToZeroTorsionPalatiniConnectionAntiZeroTorsionPalatiniConnectionSymm;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;

	(*ConjugateSourceZeroTorsionPalatiniConnectionSymmhiyuan,ZeroTorsionPalatiniConnectionSymm*)
	(*ZeroTorsionPalatiniConnectionSymm to ZeroTorsionPalatiniConnectionSymm reduced*)
	Expr=Expr/.xAct`PSALTer`ZeroTorsionPalatini`Private`ExpandZeroTorsionPalatiniConnectionSymmConjugateSourceZeroTorsionPalatiniConnectionSymmtoF/.xAct`PSALTer`ZeroTorsionPalatini`Private`ExpandZeroTorsionPalatiniConnectionSymmFtoReduced;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;

	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiToZeroTorsionPalatiniConnectionAntiPerpPara;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiParaToZeroTorsionPalatiniConnectionAntiParaSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`ZeroTorsionPalatini`Private`ZeroTorsionPalatiniConnectionAntiPerpToZeroTorsionPalatiniConnectionAntiPerpSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
	Expr=Expr/.xAct`PSALTer`ZeroTorsionPalatini`Private`Patch2m;
	(*Expr=Expr/.xAct`PSALTer`ZeroTorsionPalatini`Private`ManualAll;*)
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;

Expr];

End[];

EndPackage[];

DefClass[
	"ZeroTorsionPalatini",
	xAct`PSALTer`ZeroTorsionPalatini`Private`LagrangianCouplings,
	xAct`PSALTer`ZeroTorsionPalatini`Private`FieldSpinParityTensorHeads,
	xAct`PSALTer`ZeroTorsionPalatini`Private`SourceSpinParityTensorHeads,
	xAct`PSALTer`ZeroTorsionPalatini`Private`SourceEngineeringDimensions,
	xAct`PSALTer`ZeroTorsionPalatini`Private`ExpandFields,
	xAct`PSALTer`ZeroTorsionPalatini`Private`DecomposeFields,
	xAct`PSALTer`ZeroTorsionPalatini`Private`ExpandSources,
ExportClass->False];
