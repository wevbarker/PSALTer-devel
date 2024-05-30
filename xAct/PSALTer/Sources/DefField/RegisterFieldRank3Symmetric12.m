(*===============================*)
(*  RegisterFieldRank3Symmetric  *)
(*===============================*)

xAct`PSALTer`Private`DefFiducialField[Rank3Symmetric[-b,-c,-a],Symmetric[{-b,-c}]];
xAct`PSALTer`Private`DefSO3Irrep[Rank3SymmetricSymmPerpT0p[],xAct`PSALTer`Private`Spin->0,xAct`PSALTer`Private`Parity->xAct`PSALTer`Private`Even];
xAct`PSALTer`Private`DefSO3Irrep[Rank3SymmetricSymmPerpT1m[-i],xAct`PSALTer`Private`Spin->1,xAct`PSALTer`Private`Parity->xAct`PSALTer`Private`Odd];
xAct`PSALTer`Private`DefSO3Irrep[Rank3SymmetricSymmPara0p[],xAct`PSALTer`Private`Spin->0,xAct`PSALTer`Private`Parity->xAct`PSALTer`Private`Even];
xAct`PSALTer`Private`DefSO3Irrep[Rank3SymmetricSymmPara2p[-i,-j],Symmetric[{-i,-j}],xAct`PSALTer`Private`Spin->2,xAct`PSALTer`Private`Parity->xAct`PSALTer`Private`Even];
xAct`PSALTer`Private`DefSO3Irrep[Rank3SymmetricSymmParaT1m[-i],xAct`PSALTer`Private`Spin->1,xAct`PSALTer`Private`Parity->xAct`PSALTer`Private`Odd];
xAct`PSALTer`Private`DefSO3Irrep[Rank3SymmetricSymmPara3m[-i,-j,-a],Symmetric[{-i,-j,-a}],xAct`PSALTer`Private`Spin->3,xAct`PSALTer`Private`Parity->xAct`PSALTer`Private`Odd];
xAct`PSALTer`Private`DefSO3Irrep[Rank3SymmetricSymmPerpH1m[-i],xAct`PSALTer`Private`Spin->1,xAct`PSALTer`Private`Parity->xAct`PSALTer`Private`Odd];
xAct`PSALTer`Private`DefSO3Irrep[Rank3SymmetricSymmPara1p[-i,-a],Antisymmetric[{-i,-a}],xAct`PSALTer`Private`Spin->1,xAct`PSALTer`Private`Parity->xAct`PSALTer`Private`Even];
xAct`PSALTer`Private`DefSO3Irrep[Rank3SymmetricSymmPerpH0p[],xAct`PSALTer`Private`Spin->0,xAct`PSALTer`Private`Parity->xAct`PSALTer`Private`Even];
xAct`PSALTer`Private`DefSO3Irrep[Rank3SymmetricSymmPerp2p[-i,-j],Symmetric[{-i,-j}],xAct`PSALTer`Private`Spin->2,xAct`PSALTer`Private`Parity->xAct`PSALTer`Private`Even];
xAct`PSALTer`Private`DefSO3Irrep[Rank3SymmetricSymmParaH1m[-i],xAct`PSALTer`Private`Spin->1,xAct`PSALTer`Private`Parity->xAct`PSALTer`Private`Odd];
xAct`PSALTer`Private`DefSO3Irrep[Rank3SymmetricSymmPara2m[-i,-j,-a],Antisymmetric[{-i,-j}],MultiTermSymmetries->{Rank3SymmetricSymmPara2m[-i,-j,-a]+Rank3SymmetricSymmPara2m[-a,-i,-j]+Rank3SymmetricSymmPara2m[-j,-a,-i]},xAct`PSALTer`Private`Spin->2,xAct`PSALTer`Private`Parity->xAct`PSALTer`Private`Odd];

DefTensor[Rank3SymmetricSymm[-i,-j,-a],M4, Symmetric[{-i,-j}],Dagger->Complex];
DefTensor[SourceRank3SymmetricSymm[-i,-j,-a],M4,Symmetric[{-i,-j}],Dagger->Complex];
Rank3SymmetricToRank3SymmetricSymm=Join[
	MakeRule[{Rank3Symmetric[-a,-b,-c],Evaluate[Rank3SymmetricSymm[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3Symmetric[-a,-b,-c],Evaluate@Dagger[Rank3SymmetricSymm[-a,-b,-c]]},MetricOn->All,ContractMetrics->True]];
SourceRank3SymmetricToSourceRank3SymmetricSymm=Join[
	MakeRule[{SourceRank3Symmetric[-a,-b,-c],Evaluate[SourceRank3SymmetricSymm[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3Symmetric[-a,-b,-c],Evaluate@Dagger[SourceRank3SymmetricSymm[-a,-b,-c]]},MetricOn->All,ContractMetrics->True]];
Rank3SymmetricSymmToRank3Symmetric=Join[
	MakeRule[{Rank3SymmetricSymm[-a,-b,-c],Evaluate[(1/2)*(Rank3Symmetric[-a,-b,-c]+Rank3Symmetric[-b,-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3SymmetricSymm[-a,-b,-c],Evaluate@Dagger[(1/2)*(Rank3Symmetric[-a,-b,-c]+Rank3Symmetric[-b,-a,-c])]},MetricOn->All,ContractMetrics->True]];
SourceRank3SymmetricSymmToSourceRank3Symmetric=Join[
	MakeRule[{SourceRank3SymmetricSymm[-a,-b,-c],Evaluate[(1/2)*(SourceRank3Symmetric[-a,-b,-c]+SourceRank3Symmetric[-b,-a,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3SymmetricSymm[-a,-b,-c],Evaluate@Dagger[(1/2)*(SourceRank3Symmetric[-a,-b,-c]+SourceRank3Symmetric[-b,-a,-c])]},MetricOn->All,ContractMetrics->True]];
DefTensor[totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a],M4];
DefTensor[remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a],M4];
AutomaticRules[totsymRank3SymmetricSymmSourceRank3SymmetricSymm,MakeRule[{totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a],Evaluate[(1/3)G[k,-i]G[l,-j]G[b,-a] +(1/3)G[k,-j]G[l,-a]G[b,-i] +(1/3)G[k,-i]G[l,-a]G[b,-j]]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[remsymRank3SymmetricSymmSourceRank3SymmetricSymm,MakeRule[{remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a],Evaluate[(2/3)G[k,-i]G[l,-j]G[b,-a] -(1/3)G[k,-j]G[l,-a]G[b,-i] -(1/3)G[k,-i]G[l,-a]G[b,-j]]},MetricOn->All,ContractMetrics->True]];
DefTensor[ProjPerp[-a,-b],M4,Symmetric[{-a,-b}]];
DefTensor[ProjPara[-a,-b],M4,Symmetric[{-a,-b}]];
ProjPerpParaToVG=Join[
	MakeRule[{ProjPerp[-a,b],Evaluate[V[-a]V[b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjPara[-a,b],Evaluate[G[-a,b]-V[-a]V[b]]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ProjPerp,MakeRule[{ProjPerp[-a,b],Evaluate[V[-a]V[b]]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ProjPara,MakeRule[{ProjPara[-a,b],Evaluate[G[-a,b]-V[-a]V[b]]},MetricOn->All,ContractMetrics->True]];
DefTensor[ProjFPerp[-a,d,e],M4];
DefTensor[ProjFPara[-a,-b,d,e],M4];
ProjRank3SymmetricFPerpParaToVG=Join[
	MakeRule[{ProjFPerp[-a,d,e],Evaluate[
		V[d]G[-a,e]/.ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjFPara[-a,-b,d,e],Evaluate[
		ProjPara[-a,d]G[-b,e]/.ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];
DefTensor[Rank3SymmetricSymmPerpT0pF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],Dagger->Complex];
DefTensor[Rank3SymmetricSymmPerpT1mF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],Dagger->Complex];
DefTensor[Rank3SymmetricSymmPara0pF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],Dagger->Complex];
DefTensor[Rank3SymmetricSymmPara2pF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],Dagger->Complex];
DefTensor[Rank3SymmetricSymmParaT1mF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],Dagger->Complex];
DefTensor[Rank3SymmetricSymmPara3mF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],Dagger->Complex];
DefTensor[Rank3SymmetricSymmPerpH1mF[-i,-j,-a],M4,Symmetric[{-i,-j}],Dagger->Complex];
DefTensor[Rank3SymmetricSymmPara1pF[-i,-j,-a],M4,Symmetric[{-i,-j}],Dagger->Complex];
DefTensor[Rank3SymmetricSymmPerpH0pF[-i,-j,-a],M4,Symmetric[{-i,-j}],Dagger->Complex];
DefTensor[Rank3SymmetricSymmPerp2pF[-i,-j,-a],M4,Symmetric[{-i,-j}],Dagger->Complex];
DefTensor[Rank3SymmetricSymmParaH1mF[-i,-j,-a],M4,Symmetric[{-i,-j}],Dagger->Complex];
DefTensor[Rank3SymmetricSymmPara2mF[-i,-j,-a],M4,Symmetric[{-i,-j}],Dagger->Complex];
DefTensor[SourceRank3SymmetricSymmPerpT0pF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],Dagger->Complex];
DefTensor[SourceRank3SymmetricSymmPerpT1mF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],Dagger->Complex];
DefTensor[SourceRank3SymmetricSymmPara0pF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],Dagger->Complex];
DefTensor[SourceRank3SymmetricSymmPara2pF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],Dagger->Complex];
DefTensor[SourceRank3SymmetricSymmParaT1mF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],Dagger->Complex];
DefTensor[SourceRank3SymmetricSymmPara3mF[-i,-j,-a],M4,Symmetric[{-i,-j,-a}],Dagger->Complex];
DefTensor[SourceRank3SymmetricSymmPerpH1mF[-i,-j,-a],M4,Symmetric[{-i,-j}],Dagger->Complex];
DefTensor[SourceRank3SymmetricSymmPara1pF[-i,-j,-a],M4,Symmetric[{-i,-j}],Dagger->Complex];
DefTensor[SourceRank3SymmetricSymmPerpH0pF[-i,-j,-a],M4,Symmetric[{-i,-j}],Dagger->Complex];
DefTensor[SourceRank3SymmetricSymmPerp2pF[-i,-j,-a],M4,Symmetric[{-i,-j}],Dagger->Complex];
DefTensor[SourceRank3SymmetricSymmParaH1mF[-i,-j,-a],M4,Symmetric[{-i,-j}],Dagger->Complex];
DefTensor[SourceRank3SymmetricSymmPara2mF[-i,-j,-a],M4,Symmetric[{-i,-j}],Dagger->Complex];
ExpandRank3SymmetricSymmSourceRank3SymmetricSymmtoF=Join[
	MakeRule[{Rank3SymmetricSymm[-i,-j,-a],Evaluate[Rank3SymmetricSymmPerpT0pF[-i,-j,-a]+Rank3SymmetricSymmPerpT1mF[-i,-j,-a]+Rank3SymmetricSymmPara0pF[-i,-j,-a]+Rank3SymmetricSymmPara2pF[-i,-j,-a]+Rank3SymmetricSymmParaT1mF[-i,-j,-a]+Rank3SymmetricSymmPara3mF[-i,-j,-a]+Rank3SymmetricSymmPerpH1mF[-i,-j,-a]+Rank3SymmetricSymmPara1pF[-i,-j,-a]+Rank3SymmetricSymmPerpH0pF[-i,-j,-a]+Rank3SymmetricSymmPerp2pF[-i,-j,-a]+Rank3SymmetricSymmParaH1mF[-i,-j,-a]+Rank3SymmetricSymmPara2mF[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SourceRank3SymmetricSymm[-i,-j,-a],Evaluate[SourceRank3SymmetricSymmPerpT0pF[-i,-j,-a]+SourceRank3SymmetricSymmPerpT1mF[-i,-j,-a]+SourceRank3SymmetricSymmPara0pF[-i,-j,-a]+SourceRank3SymmetricSymmPara2pF[-i,-j,-a]+SourceRank3SymmetricSymmParaT1mF[-i,-j,-a]+SourceRank3SymmetricSymmPara3mF[-i,-j,-a]+SourceRank3SymmetricSymmPerpH1mF[-i,-j,-a]+SourceRank3SymmetricSymmPara1pF[-i,-j,-a]+SourceRank3SymmetricSymmPerpH0pF[-i,-j,-a]+SourceRank3SymmetricSymmPerp2pF[-i,-j,-a]+SourceRank3SymmetricSymmParaH1mF[-i,-j,-a]+SourceRank3SymmetricSymmPara2mF[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],	
	MakeRule[{Evaluate@Dagger@Rank3SymmetricSymm[-i,-j,-a],Evaluate[Dagger@(Rank3SymmetricSymmPerpT0pF[-i,-j,-a]+Rank3SymmetricSymmPerpT1mF[-i,-j,-a]+Rank3SymmetricSymmPara0pF[-i,-j,-a]+Rank3SymmetricSymmPara2pF[-i,-j,-a]+Rank3SymmetricSymmParaT1mF[-i,-j,-a]+Rank3SymmetricSymmPara3mF[-i,-j,-a]+Rank3SymmetricSymmPerpH1mF[-i,-j,-a]+Rank3SymmetricSymmPara1pF[-i,-j,-a]+Rank3SymmetricSymmPerpH0pF[-i,-j,-a]+Rank3SymmetricSymmPerp2pF[-i,-j,-a]+Rank3SymmetricSymmParaH1mF[-i,-j,-a]+Rank3SymmetricSymmPara2mF[-i,-j,-a])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3SymmetricSymm[-i,-j,-a],Evaluate[Dagger@(SourceRank3SymmetricSymmPerpT0pF[-i,-j,-a]+SourceRank3SymmetricSymmPerpT1mF[-i,-j,-a]+SourceRank3SymmetricSymmPara0pF[-i,-j,-a]+SourceRank3SymmetricSymmPara2pF[-i,-j,-a]+SourceRank3SymmetricSymmParaT1mF[-i,-j,-a]+SourceRank3SymmetricSymmPara3mF[-i,-j,-a]+SourceRank3SymmetricSymmPerpH1mF[-i,-j,-a]+SourceRank3SymmetricSymmPara1pF[-i,-j,-a]+SourceRank3SymmetricSymmPerpH0pF[-i,-j,-a]+SourceRank3SymmetricSymmPerp2pF[-i,-j,-a]+SourceRank3SymmetricSymmParaH1mF[-i,-j,-a]+SourceRank3SymmetricSymmPara2mF[-i,-j,-a])]},MetricOn->All,ContractMetrics->True]
];
ExpandRank3SymmetricSymmFtoReduced=Join[
	MakeRule[{Rank3SymmetricSymmPerpT0pF[-i,-j,-a],Evaluate[(V[-i]V[-j]V[-a]Rank3SymmetricSymmPerpT0p[])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3SymmetricSymmPerpT0pF[-i,-j,-a],Evaluate@Dagger[(V[-i]V[-j]V[-a]Rank3SymmetricSymmPerpT0p[])//ToCanonical]},MetricOn->All,ContractMetrics->True],	
	MakeRule[{Rank3SymmetricSymmPerpT1mF[-i,-j,-a],Evaluate[(totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]V[-k]V[-l]Rank3SymmetricSymmPerpT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3SymmetricSymmPerpT1mF[-i,-j,-a],Evaluate@Dagger[(totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]V[-k]V[-l]Rank3SymmetricSymmPerpT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],	
	MakeRule[{Rank3SymmetricSymmPara0pF[-i,-j,-a],Evaluate[((Rank3SymmetricSymmPara0p[]/3)totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3SymmetricSymmPara0pF[-i,-j,-a],Evaluate@Dagger[((Rank3SymmetricSymmPara0p[]/3)totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],	
	MakeRule[{Rank3SymmetricSymmPara2pF[-i,-j,-a],Evaluate[(totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]Rank3SymmetricSymmPara2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3SymmetricSymmPara2pF[-i,-j,-a],Evaluate@Dagger[(totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]Rank3SymmetricSymmPara2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],	
	MakeRule[{Rank3SymmetricSymmParaT1mF[-i,-j,-a],Evaluate[((1/5)totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]Rank3SymmetricSymmParaT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3SymmetricSymmParaT1mF[-i,-j,-a],Evaluate@Dagger[((1/5)totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]Rank3SymmetricSymmParaT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],	
	MakeRule[{Rank3SymmetricSymmPara3mF[-i,-j,-a],Evaluate[Rank3SymmetricSymmPara3m[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3SymmetricSymmPara3mF[-i,-j,-a],Evaluate@Dagger[Rank3SymmetricSymmPara3m[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],	
	MakeRule[{Rank3SymmetricSymmPerpH1mF[-i,-j,-a],Evaluate[(remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]V[-k]V[-l]Rank3SymmetricSymmPerpH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3SymmetricSymmPerpH1mF[-i,-j,-a],Evaluate@Dagger[(remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]V[-k]V[-l]Rank3SymmetricSymmPerpH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],	
	MakeRule[{Rank3SymmetricSymmPara1pF[-i,-j,-a],Evaluate[((1/2)(V[-i]Rank3SymmetricSymmPara1p[-j,-a]+V[-j]Rank3SymmetricSymmPara1p[-i,-a]))//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3SymmetricSymmPara1pF[-i,-j,-a],Evaluate@Dagger[((1/2)(V[-i]Rank3SymmetricSymmPara1p[-j,-a]+V[-j]Rank3SymmetricSymmPara1p[-i,-a]))//ToCanonical]},MetricOn->All,ContractMetrics->True],	
	MakeRule[{Rank3SymmetricSymmPerpH0pF[-i,-j,-a],Evaluate[((Rank3SymmetricSymmPerpH0p[]/3)remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3SymmetricSymmPerpH0pF[-i,-j,-a],Evaluate@Dagger[((Rank3SymmetricSymmPerpH0p[]/3)remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],	
	MakeRule[{Rank3SymmetricSymmPerp2pF[-i,-j,-a],Evaluate[(remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]Rank3SymmetricSymmPerp2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3SymmetricSymmPerp2pF[-i,-j,-a],Evaluate@Dagger[(remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]Rank3SymmetricSymmPerp2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],	
	MakeRule[{Rank3SymmetricSymmParaH1mF[-i,-j,-a],Evaluate[((1/2)remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]Rank3SymmetricSymmParaH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3SymmetricSymmParaH1mF[-i,-j,-a],Evaluate@Dagger[((1/2)remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]Rank3SymmetricSymmParaH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Rank3SymmetricSymmPara2mF[-i,-j,-a],Evaluate[(1/2)*(Rank3SymmetricSymmPara2m[-a,-i,-j]+Rank3SymmetricSymmPara2m[-a,-j,-i])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3SymmetricSymmPara2mF[-i,-j,-a],Evaluate@Dagger[(1/2)*(Rank3SymmetricSymmPara2m[-a,-i,-j]+Rank3SymmetricSymmPara2m[-a,-j,-i])]},MetricOn->All,ContractMetrics->True]	
];
ExpandSourceRank3SymmetricSymmFtoReduced=Join[
	MakeRule[{SourceRank3SymmetricSymmPerpT0pF[-i,-j,-a],Evaluate[(V[-i]V[-j]V[-a]SourceRank3SymmetricSymmPerpT0p[])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3SymmetricSymmPerpT0pF[-i,-j,-a],Evaluate@Dagger[(V[-i]V[-j]V[-a]SourceRank3SymmetricSymmPerpT0p[])//ToCanonical]},MetricOn->All,ContractMetrics->True],	
	MakeRule[{SourceRank3SymmetricSymmPerpT1mF[-i,-j,-a],Evaluate[(totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]V[-k]V[-l]SourceRank3SymmetricSymmPerpT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3SymmetricSymmPerpT1mF[-i,-j,-a],Evaluate@Dagger[(totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]V[-k]V[-l]SourceRank3SymmetricSymmPerpT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],	
	MakeRule[{SourceRank3SymmetricSymmPara0pF[-i,-j,-a],Evaluate[((SourceRank3SymmetricSymmPara0p[]/3)totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3SymmetricSymmPara0pF[-i,-j,-a],Evaluate@Dagger[((SourceRank3SymmetricSymmPara0p[]/3)totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],	
	MakeRule[{SourceRank3SymmetricSymmPara2pF[-i,-j,-a],Evaluate[(totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]SourceRank3SymmetricSymmPara2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3SymmetricSymmPara2pF[-i,-j,-a],Evaluate@Dagger[(totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]SourceRank3SymmetricSymmPara2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],	
	MakeRule[{SourceRank3SymmetricSymmParaT1mF[-i,-j,-a],Evaluate[((1/5)totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]SourceRank3SymmetricSymmParaT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3SymmetricSymmParaT1mF[-i,-j,-a],Evaluate@Dagger[((1/5)totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]SourceRank3SymmetricSymmParaT1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],	
	MakeRule[{SourceRank3SymmetricSymmPara3mF[-i,-j,-a],Evaluate[SourceRank3SymmetricSymmPara3m[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3SymmetricSymmPara3mF[-i,-j,-a],Evaluate@Dagger[SourceRank3SymmetricSymmPara3m[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],	
	MakeRule[{SourceRank3SymmetricSymmPerpH1mF[-i,-j,-a],Evaluate[(remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]V[-k]V[-l]SourceRank3SymmetricSymmPerpH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3SymmetricSymmPerpH1mF[-i,-j,-a],Evaluate@Dagger[(remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]V[-k]V[-l]SourceRank3SymmetricSymmPerpH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],	
	MakeRule[{SourceRank3SymmetricSymmPara1pF[-i,-j,-a],Evaluate[((1/2)(V[-i]SourceRank3SymmetricSymmPara1p[-j,-a]+V[-j]SourceRank3SymmetricSymmPara1p[-i,-a]))//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3SymmetricSymmPara1pF[-i,-j,-a],Evaluate@Dagger[((1/2)(V[-i]SourceRank3SymmetricSymmPara1p[-j,-a]+V[-j]SourceRank3SymmetricSymmPara1p[-i,-a]))//ToCanonical]},MetricOn->All,ContractMetrics->True],	
	MakeRule[{SourceRank3SymmetricSymmPerpH0pF[-i,-j,-a],Evaluate[((SourceRank3SymmetricSymmPerpH0p[]/3)remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3SymmetricSymmPerpH0pF[-i,-j,-a],Evaluate@Dagger[((SourceRank3SymmetricSymmPerpH0p[]/3)remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],	
	MakeRule[{SourceRank3SymmetricSymmPerp2pF[-i,-j,-a],Evaluate[(remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]SourceRank3SymmetricSymmPerp2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3SymmetricSymmPerp2pF[-i,-j,-a],Evaluate@Dagger[(remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]SourceRank3SymmetricSymmPerp2p[-k,-l]V[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],	
	MakeRule[{SourceRank3SymmetricSymmParaH1mF[-i,-j,-a],Evaluate[((1/2)remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]SourceRank3SymmetricSymmParaH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3SymmetricSymmParaH1mF[-i,-j,-a],Evaluate@Dagger[((1/2)remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-i,-j,-a]ProjPara[-k,-l]SourceRank3SymmetricSymmParaH1m[-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SourceRank3SymmetricSymmPara2mF[-i,-j,-a],Evaluate[(1/2)*(SourceRank3SymmetricSymmPara2m[-a,-i,-j]+SourceRank3SymmetricSymmPara2m[-a,-j,-i])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3SymmetricSymmPara2mF[-i,-j,-a],Evaluate@Dagger[(1/2)*(SourceRank3SymmetricSymmPara2m[-a,-i,-j]+SourceRank3SymmetricSymmPara2m[-a,-j,-i])]},MetricOn->All,ContractMetrics->True]	
];
DecomposeRank3SymmetricSymmReducedtoRank3SymmetricSymm=Join[
	MakeRule[{Rank3SymmetricSymmPerpT0p[],Evaluate[V[i]V[j]V[a]Rank3SymmetricSymm[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3SymmetricSymmPerpT0p[],Evaluate@Dagger[V[i]V[j]V[a]Rank3SymmetricSymm[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],	
	MakeRule[{Rank3SymmetricSymmPerpT1m[-i],Evaluate[(3ProjPara[m,-i]V[n]V[c]totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]Rank3SymmetricSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3SymmetricSymmPerpT1m[-i],Evaluate@Dagger[(3ProjPara[m,-i]V[n]V[c]totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]Rank3SymmetricSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Rank3SymmetricSymmPara0p[],Evaluate[(3ProjPara[m,-z]ProjPara[n,z]V[c]totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]Rank3SymmetricSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3SymmetricSymmPara0p[],Evaluate@Dagger[(3ProjPara[m,-z]ProjPara[n,z]V[c]totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]Rank3SymmetricSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Rank3SymmetricSymmPara2p[-i,-j],Evaluate[((3ProjPara[m,-i]ProjPara[n,-j]-ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z])V[c]totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]Rank3SymmetricSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3SymmetricSymmPara2p[-i,-j],Evaluate@Dagger[((3ProjPara[m,-i]ProjPara[n,-j]-ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z])V[c]totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]Rank3SymmetricSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Rank3SymmetricSymmParaT1m[-i],Evaluate[(3ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]Rank3SymmetricSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3SymmetricSymmParaT1m[-i],Evaluate@Dagger[(3ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]Rank3SymmetricSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Rank3SymmetricSymmPara3m[-i,-j,-a],Evaluate[((ProjPara[m,-i]ProjPara[n,-j]ProjPara[c,-a]-(1/5)(ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z]ProjPara[c,-a]+ProjPara[-j,-a]ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]+ProjPara[-i,-a]ProjPara[m,-z]ProjPara[n,-j]ProjPara[c,z]))totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]Rank3SymmetricSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3SymmetricSymmPara3m[-i,-j,-a],Evaluate@Dagger[((ProjPara[m,-i]ProjPara[n,-j]ProjPara[c,-a]-(1/5)(ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z]ProjPara[c,-a]+ProjPara[-j,-a]ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]+ProjPara[-i,-a]ProjPara[m,-z]ProjPara[n,-j]ProjPara[c,z]))totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]Rank3SymmetricSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Rank3SymmetricSymmPerpH1m[-i],Evaluate[((Rank3SymmetricSymm[-k,-l,-i]-Rank3SymmetricSymm[-i,-k,-l])V[k]V[l])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3SymmetricSymmPerpH1m[-i],Evaluate@Dagger[((Rank3SymmetricSymm[-k,-l,-i]-Rank3SymmetricSymm[-i,-k,-l])V[k]V[l])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Rank3SymmetricSymmPara1p[-i,-a],Evaluate[((Rank3SymmetricSymm[-k,-i,-a]-Rank3SymmetricSymm[-k,-a,-i])V[k]+V[k]V[l]((Rank3SymmetricSymm[-k,-l,-i]-Rank3SymmetricSymm[-i,-k,-l])V[-a]-(Rank3SymmetricSymm[-k,-l,-a]-Rank3SymmetricSymm[-a,-k,-l])V[-i]))//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3SymmetricSymmPara1p[-i,-a],Evaluate@Dagger[((Rank3SymmetricSymm[-k,-i,-a]-Rank3SymmetricSymm[-k,-a,-i])V[k]+V[k]V[l]((Rank3SymmetricSymm[-k,-l,-i]-Rank3SymmetricSymm[-i,-k,-l])V[-a]-(Rank3SymmetricSymm[-k,-l,-a]-Rank3SymmetricSymm[-a,-k,-l])V[-i]))//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Rank3SymmetricSymmPerpH0p[],Evaluate[(Rank3SymmetricSymm[k,-k,-i]-Rank3SymmetricSymm[-i,-k,k])V[i]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3SymmetricSymmPerpH0p[],Evaluate@Dagger[(Rank3SymmetricSymm[k,-k,-i]-Rank3SymmetricSymm[-i,-k,k])V[i]]},MetricOn->All,ContractMetrics->True],	
	MakeRule[{Rank3SymmetricSymmPerp2p[-i,-j],Evaluate[((3/2)(ProjPara[m,-i]ProjPara[n,-j]-(ProjPara[-i,-j]/3)ProjPara[m,-z]ProjPara[n,z])V[c]remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]Rank3SymmetricSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3SymmetricSymmPerp2p[-i,-j],Evaluate@Dagger[((3/2)(ProjPara[m,-i]ProjPara[n,-j]-(ProjPara[-i,-j]/3)ProjPara[m,-z]ProjPara[n,z])V[c]remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]Rank3SymmetricSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Rank3SymmetricSymmParaH1m[-i],Evaluate[((-3)ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]Rank3SymmetricSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3SymmetricSymmParaH1m[-i],Evaluate@Dagger[((-3)ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]Rank3SymmetricSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Rank3SymmetricSymmPara2m[-j,-a,-i],Evaluate[(-4/3)*Antisymmetrize[((ProjPara[m,-i]ProjPara[n,-j]ProjPara[c,-a]-(1/2)(ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z]ProjPara[c,-a]+ProjPara[-j,-a]ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]+ProjPara[-i,-a]ProjPara[m,-z]ProjPara[n,-j]ProjPara[c,z]))remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]Rank3SymmetricSymm[-k,-l,-b]),{-j,-a}]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3SymmetricSymmPara2m[-j,-a,-i],Evaluate@Dagger[(-4/3)*Antisymmetrize[((ProjPara[m,-i]ProjPara[n,-j]ProjPara[c,-a]-(1/2)(ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z]ProjPara[c,-a]+ProjPara[-j,-a]ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]+ProjPara[-i,-a]ProjPara[m,-z]ProjPara[n,-j]ProjPara[c,z]))remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]Rank3SymmetricSymm[-k,-l,-b]),{-j,-a}]//ToCanonical]},MetricOn->All,ContractMetrics->True]
];
DecomposeSourceRank3SymmetricSymmReducedtoSourceRank3SymmetricSymm=Join[
	MakeRule[{SourceRank3SymmetricSymmPerpT0p[],Evaluate[V[i]V[j]V[a]SourceRank3SymmetricSymm[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3SymmetricSymmPerpT0p[],Evaluate@Dagger[V[i]V[j]V[a]SourceRank3SymmetricSymm[-i,-j,-a]]},MetricOn->All,ContractMetrics->True],	
	MakeRule[{SourceRank3SymmetricSymmPerpT1m[-i],Evaluate[(3ProjPara[m,-i]V[n]V[c]totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]SourceRank3SymmetricSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3SymmetricSymmPerpT1m[-i],Evaluate@Dagger[(3ProjPara[m,-i]V[n]V[c]totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]SourceRank3SymmetricSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SourceRank3SymmetricSymmPara0p[],Evaluate[(3ProjPara[m,-z]ProjPara[n,z]V[c]totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]SourceRank3SymmetricSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3SymmetricSymmPara0p[],Evaluate@Dagger[(3ProjPara[m,-z]ProjPara[n,z]V[c]totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]SourceRank3SymmetricSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SourceRank3SymmetricSymmPara2p[-i,-j],Evaluate[((3ProjPara[m,-i]ProjPara[n,-j]-ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z])V[c]totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]SourceRank3SymmetricSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3SymmetricSymmPara2p[-i,-j],Evaluate@Dagger[((3ProjPara[m,-i]ProjPara[n,-j]-ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z])V[c]totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]SourceRank3SymmetricSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SourceRank3SymmetricSymmParaT1m[-i],Evaluate[(3ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]SourceRank3SymmetricSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3SymmetricSymmParaT1m[-i],Evaluate@Dagger[(3ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]SourceRank3SymmetricSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SourceRank3SymmetricSymmPara3m[-i,-j,-a],Evaluate[((ProjPara[m,-i]ProjPara[n,-j]ProjPara[c,-a]-(1/5)(ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z]ProjPara[c,-a]+ProjPara[-j,-a]ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]+ProjPara[-i,-a]ProjPara[m,-z]ProjPara[n,-j]ProjPara[c,z]))totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]SourceRank3SymmetricSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3SymmetricSymmPara3m[-i,-j,-a],Evaluate@Dagger[((ProjPara[m,-i]ProjPara[n,-j]ProjPara[c,-a]-(1/5)(ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z]ProjPara[c,-a]+ProjPara[-j,-a]ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]+ProjPara[-i,-a]ProjPara[m,-z]ProjPara[n,-j]ProjPara[c,z]))totsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]SourceRank3SymmetricSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SourceRank3SymmetricSymmPerpH1m[-i],Evaluate[((SourceRank3SymmetricSymm[-k,-l,-i]-SourceRank3SymmetricSymm[-i,-k,-l])V[k]V[l])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3SymmetricSymmPerpH1m[-i],Evaluate@Dagger[((SourceRank3SymmetricSymm[-k,-l,-i]-SourceRank3SymmetricSymm[-i,-k,-l])V[k]V[l])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SourceRank3SymmetricSymmPara1p[-i,-a],Evaluate[((SourceRank3SymmetricSymm[-k,-i,-a]-SourceRank3SymmetricSymm[-k,-a,-i])V[k]+V[k]V[l]((SourceRank3SymmetricSymm[-k,-l,-i]-SourceRank3SymmetricSymm[-i,-k,-l])V[-a]-(SourceRank3SymmetricSymm[-k,-l,-a]-SourceRank3SymmetricSymm[-a,-k,-l])V[-i]))//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3SymmetricSymmPara1p[-i,-a],Evaluate@Dagger[((SourceRank3SymmetricSymm[-k,-i,-a]-SourceRank3SymmetricSymm[-k,-a,-i])V[k]+V[k]V[l]((SourceRank3SymmetricSymm[-k,-l,-i]-SourceRank3SymmetricSymm[-i,-k,-l])V[-a]-(SourceRank3SymmetricSymm[-k,-l,-a]-SourceRank3SymmetricSymm[-a,-k,-l])V[-i]))//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SourceRank3SymmetricSymmPerpH0p[],Evaluate[(SourceRank3SymmetricSymm[k,-k,-i]-SourceRank3SymmetricSymm[-i,-k,k])V[i]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3SymmetricSymmPerpH0p[],Evaluate@Dagger[(SourceRank3SymmetricSymm[k,-k,-i]-SourceRank3SymmetricSymm[-i,-k,k])V[i]]},MetricOn->All,ContractMetrics->True],	
	MakeRule[{SourceRank3SymmetricSymmPerp2p[-i,-j],Evaluate[((3/2)(ProjPara[m,-i]ProjPara[n,-j]-(ProjPara[-i,-j]/3)ProjPara[m,-z]ProjPara[n,z])V[c]remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]SourceRank3SymmetricSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3SymmetricSymmPerp2p[-i,-j],Evaluate@Dagger[((3/2)(ProjPara[m,-i]ProjPara[n,-j]-(ProjPara[-i,-j]/3)ProjPara[m,-z]ProjPara[n,z])V[c]remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]SourceRank3SymmetricSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SourceRank3SymmetricSymmParaH1m[-i],Evaluate[((-3)ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]SourceRank3SymmetricSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3SymmetricSymmParaH1m[-i],Evaluate@Dagger[((-3)ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]SourceRank3SymmetricSymm[-k,-l,-b])//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SourceRank3SymmetricSymmPara2m[-j,-a,-i],Evaluate[(-4/3)*Antisymmetrize[((ProjPara[m,-i]ProjPara[n,-j]ProjPara[c,-a]-(1/2)(ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z]ProjPara[c,-a]+ProjPara[-j,-a]ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]+ProjPara[-i,-a]ProjPara[m,-z]ProjPara[n,-j]ProjPara[c,z]))remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]SourceRank3SymmetricSymm[-k,-l,-b]),{-j,-a}]//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3SymmetricSymmPara2m[-j,-a,-i],Evaluate@Dagger[(-4/3)*Antisymmetrize[((ProjPara[m,-i]ProjPara[n,-j]ProjPara[c,-a]-(1/2)(ProjPara[-i,-j]ProjPara[m,-z]ProjPara[n,z]ProjPara[c,-a]+ProjPara[-j,-a]ProjPara[m,-i]ProjPara[n,z]ProjPara[c,-z]+ProjPara[-i,-a]ProjPara[m,-z]ProjPara[n,-j]ProjPara[c,z]))remsymRank3SymmetricSymmSourceRank3SymmetricSymm[k,l,b,-m,-n,-c]SourceRank3SymmetricSymm[-k,-l,-b]),{-j,-a}]//ToCanonical]},MetricOn->All,ContractMetrics->True]
];
AutomaticRules[Rank3SymmetricSymmPara2m,MakeRule[{Rank3SymmetricSymmPara2m[-a,-b,-c]*Evaluate@Dagger[Rank3SymmetricSymmPara2m[a,c,b]],
					Evaluate[Rank3SymmetricSymmPara2m[-a,-b,-c]*Evaluate@Dagger[Rank3SymmetricSymmPara2m[a,b,c]]/2]},MetricOn->All,ContractMetrics->True]];

ExpandFieldsRules=Flatten@Map[MakeRule[{#,Evaluate@Module[{Expr=#},
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
	Expr=Expr/.DecomposeRank3SymmetricSymmReducedtoRank3SymmetricSymm;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;	
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.ProjRank3SymmetricFPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.ProjPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
	Expr=Expr/.Rank3SymmetricSymmToRank3Symmetric;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
	Expr]},
	MetricOn->All,ContractMetrics->True]&,{Rank3SymmetricSymmPerpT0p[],Rank3SymmetricSymmPerpT1m[-i],Rank3SymmetricSymmPara0p[],Rank3SymmetricSymmPara2p[-i,-j],Rank3SymmetricSymmParaT1m[-i],Rank3SymmetricSymmPara3m[-i,-j,-a],Rank3SymmetricSymmPerpH1m[-i],Rank3SymmetricSymmPara1p[-i,-a],Rank3SymmetricSymmPerpH0p[],Rank3SymmetricSymmPerp2p[-i,-j],Rank3SymmetricSymmParaH1m[-i],Rank3SymmetricSymmPara2m[-i,-j,-a],Dagger@Rank3SymmetricSymmPerpT0p[],Dagger@Rank3SymmetricSymmPerpT1m[-i],Dagger@Rank3SymmetricSymmPara0p[],Dagger@Rank3SymmetricSymmPara2p[-i,-j],Dagger@Rank3SymmetricSymmParaT1m[-i],Dagger@Rank3SymmetricSymmPara3m[-i,-j,-a],Dagger@Rank3SymmetricSymmPerpH1m[-i],Dagger@Rank3SymmetricSymmPara1p[-i,-a],Dagger@Rank3SymmetricSymmPerpH0p[],Dagger@Rank3SymmetricSymmPerp2p[-i,-j],Dagger@Rank3SymmetricSymmParaH1m[-i],Dagger@Rank3SymmetricSymmPara2m[-i,-j,-a]}];

ExpandSourcesRules=Flatten@Map[MakeRule[{#,Evaluate@Module[{Expr=#},
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.DecomposeSourceRank3SymmetricSymmReducedtoSourceRank3SymmetricSymm;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;	
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.ProjRank3SymmetricFPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.ProjPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.SourceRank3SymmetricSymmToSourceRank3Symmetric;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
	Expr]},
	MetricOn->All,ContractMetrics->True]&,{SourceRank3SymmetricSymmPerpT0p[],SourceRank3SymmetricSymmPerpT1m[-i],SourceRank3SymmetricSymmPara0p[],SourceRank3SymmetricSymmPara2p[-i,-j],SourceRank3SymmetricSymmParaT1m[-i],SourceRank3SymmetricSymmPara3m[-i,-j,-a],SourceRank3SymmetricSymmPerpH1m[-i],SourceRank3SymmetricSymmPara1p[-i,-a],SourceRank3SymmetricSymmPerpH0p[],SourceRank3SymmetricSymmPerp2p[-i,-j],SourceRank3SymmetricSymmParaH1m[-i],SourceRank3SymmetricSymmPara2m[-i,-j,-a],Dagger@SourceRank3SymmetricSymmPerpT0p[],Dagger@SourceRank3SymmetricSymmPerpT1m[-i],Dagger@SourceRank3SymmetricSymmPara0p[],Dagger@SourceRank3SymmetricSymmPara2p[-i,-j],Dagger@SourceRank3SymmetricSymmParaT1m[-i],Dagger@SourceRank3SymmetricSymmPara3m[-i,-j,-a],Dagger@SourceRank3SymmetricSymmPerpH1m[-i],Dagger@SourceRank3SymmetricSymmPara1p[-i,-a],Dagger@SourceRank3SymmetricSymmPerpH0p[],Dagger@SourceRank3SymmetricSymmPerp2p[-i,-j],Dagger@SourceRank3SymmetricSymmParaH1m[-i],Dagger@SourceRank3SymmetricSymmPara2m[-i,-j,-a]}];

DecomposeFieldsRules=Flatten@Map[MakeRule[{#,Evaluate@Module[{Expr=#},
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
	Expr=Expr/.Rank3SymmetricToRank3SymmetricSymm;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
	Expr=Expr/.ExpandRank3SymmetricSymmSourceRank3SymmetricSymmtoF/.ExpandRank3SymmetricSymmFtoReduced;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
	Expr]},
	MetricOn->All,ContractMetrics->True]&,{Rank3Symmetric[-a,-b,-c],Dagger@Rank3Symmetric[-a,-b,-c]}];

xAct`PSALTer`Private`CombineRules[ExpandFieldsRules,
			ExpandSourcesRules,
			DecomposeFieldsRules];
