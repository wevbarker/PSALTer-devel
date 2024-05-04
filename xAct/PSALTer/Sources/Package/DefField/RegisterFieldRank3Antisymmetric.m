(*===================================*)
(*  RegisterFieldRank3Antisymmetric  *)
(*===================================*)

xAct`PSALTer`Private`DefFiducialField[Rank3Antisymmetric[-a,-b,-c],Antisymmetric[{-a,-b}]];
xAct`PSALTer`Private`DefSO3Irrep[Rank3AntisymmetricPara0p[],Spin->0,Parity->Even];
xAct`PSALTer`Private`DefSO3Irrep[Rank3AntisymmetricPara0m[],Spin->0,Parity->Odd];
xAct`PSALTer`Private`DefSO3Irrep[Rank3AntisymmetricPara1p[-a,-b],Antisymmetric[{-a,-b}],Spin->1,Parity->Even];
xAct`PSALTer`Private`DefSO3Irrep[Rank3AntisymmetricPara1m[-a],Spin->1,Parity->Odd];
xAct`PSALTer`Private`DefSO3Irrep[Rank3AntisymmetricPara2p[-a,-b],Symmetric[{-a,-b}],Spin->2,Parity->Even];
xAct`PSALTer`Private`DefSO3Irrep[Rank3AntisymmetricPara2m[-a,-b,-c],Antisymmetric[{-a,-b}],Spin->2,Parity->Odd];
xAct`PSALTer`Private`DefSO3Irrep[Rank3AntisymmetricPerp1p[-a,-b],Antisymmetric[{-a,-b}],Spin->1,Parity->Even];
xAct`PSALTer`Private`DefSO3Irrep[Rank3AntisymmetricPerp1m[-a],Spin->1,Parity->Odd];

DefTensor[Rank3Antisymmetric[a,c,-d],M4,Antisymmetric[{a,c}],Dagger->Complex];
DefTensor[SourceRank3Antisymmetric[-i,-j,-k],M4,Antisymmetric[{-j,-k}],Dagger->Complex];
DefTensor[ProjPerp[-a,-b],M4,Symmetric[{-a,-b}]];
DefTensor[ProjPara[-a,-b],M4,Symmetric[{-a,-b}]];
ProjPerpParaToVG=Join[
	MakeRule[{ProjPerp[-a,b],Evaluate[V[-a]V[b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjPara[-a,b],Evaluate[G[-a,b]-V[-a]V[b]]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ProjPerp,MakeRule[{ProjPerp[-a,b],Evaluate[V[-a]V[b]]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ProjPara,MakeRule[{ProjPara[-a,b],Evaluate[G[-a,b]-V[-a]V[b]]},MetricOn->All,ContractMetrics->True]];
DefTensor[ProjRank3AntisymmetricPerp[-a,-b,d,e,f],M4];
DefTensor[ProjRank3AntisymmetricPara[-a,-b,-c,d,e,f],M4];
DefTensor[ProjFPerp[-a,d,e],M4];
DefTensor[ProjFPara[-a,-b,d,e],M4];
ProjRank3AntisymmetricPerpParaToVG=Join[
	MakeRule[{ProjRank3AntisymmetricPerp[-a,-b,d,e,f],Evaluate[
		V[d]ProjPara[-a,e]G[-b,f]/.ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjRank3AntisymmetricPara[-a,-b,-c,d,e,f],Evaluate[
		ProjPara[-a,d]ProjPara[-b,e]G[-c,f]/.ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjFPerp[-a,d,e],Evaluate[
		V[d]G[-a,e]/.ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjFPara[-a,-b,d,e],Evaluate[
		ProjPara[-a,d]G[-b,e]/.ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];
DefTensor[ProjRank3Antisymmetric0p[c,d],M4];
DefTensor[ProjRank3Antisymmetric0m[d,e,f],M4];
DefTensor[ProjRank3Antisymmetric1p[-a,-b,c,d],M4];
DefTensor[ProjRank3Antisymmetric1m[-a,d,e,f],M4];
DefTensor[ProjRank3Antisymmetric2p[-a,-b,c,d],M4];
DefTensor[ProjRank3Antisymmetric2m[-a,-b,-c,d,e,f],M4];
ProjRank3AntisymmetricSpinParityToVG=Join[
	MakeRule[{ProjRank3Antisymmetric0p[c,d],Evaluate[
		ProjPara[c,-k]ProjPara[d,-l]G[k,l]/.ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjRank3Antisymmetric1p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l]Antisymmetrize[G[-i,k]G[-j,l],{-i,-j}]/.ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjRank3Antisymmetric2p[-a,-b,c,d],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[c,-k]ProjPara[d,-l](Symmetrize[G[-i,k]G[-j,l],{-i,-j}]-(1/3)G[-i,-j]G[k,l])/.ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjRank3Antisymmetric0m[d,e,f],Evaluate[
		ProjPara[-i,d]ProjPara[-j,e]ProjPara[-k,f]epsilonG[i,j,k,g]V[-g]/.ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjRank3Antisymmetric1m[-a,d,e,f],Evaluate[
		ProjPara[-i,d]ProjPara[-j,f]ProjPara[k,-a]ProjPara[-l,e]G[i,j]G[-k,l]/.ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjRank3Antisymmetric2m[-a,-b,-c,d,e,f],Evaluate[
		ProjPara[-a,i]ProjPara[-b,j]ProjPara[-c,k]ProjPara[d,-l]ProjPara[e,-n]ProjPara[f,-m](3/4)((1/3)(2G[-i,l]G[-j,n]G[-k,m]-G[-j,l]G[-k,n]G[-i,m]-G[-k,l]G[-i,n]G[-j,m])-Antisymmetrize[G[-i,-k]G[-j,n]G[l,m],{-i,-j}])/.ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];
DefTensor[Rank3AntisymmetricPara[-a,-b,-c],M4,Antisymmetric[{-a,-b}],OrthogonalTo->{V[c]},Dagger->Complex];
DefTensor[Rank3AntisymmetricPerp[-a,-b],M4,Antisymmetric[{-a,-b}],Dagger->Complex];
Rank3AntisymmetricToRank3AntisymmetricPerpPara=Join[
	MakeRule[{Rank3Antisymmetric[-a,-b,-c],Evaluate[Rank3AntisymmetricPara[-a,-b,-c]+V[-c]Rank3AntisymmetricPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3Antisymmetric[-a,-b,-c],Evaluate[Dagger@(Rank3AntisymmetricPara[-a,-b,-c]+V[-c]Rank3AntisymmetricPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];
Rank3AntisymmetricPerpParaToRank3Antisymmetric=Join[
	MakeRule[{Rank3AntisymmetricPara[-a,-e,-b],Evaluate[
		ProjPara[-b,c]Rank3Antisymmetric[-a,-e,-c]/.ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Rank3AntisymmetricPerp[-a,-e],Evaluate[
		V[c]Rank3Antisymmetric[-a,-e,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3AntisymmetricPara[-a,-e,-b],Evaluate[Dagger@(
		ProjPara[-b,c]Rank3Antisymmetric[-a,-e,-c]/.ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3AntisymmetricPerp[-a,-e],Evaluate[Dagger@(
		V[c]Rank3Antisymmetric[-a,-e,-c])]},MetricOn->All,ContractMetrics->True]];
DefTensor[SourceRank3AntisymmetricPara[-c,-a,-b],M4,Antisymmetric[{-a,-b}],OrthogonalTo->{V[c]},Dagger->Complex];
DefTensor[SourceRank3AntisymmetricPerp[-a,-b],M4,Antisymmetric[{-a,-b}],Dagger->Complex];
SourceRank3AntisymmetricToSourceRank3AntisymmetricPerpPara=Join[
	MakeRule[{SourceRank3Antisymmetric[-c,-a,-b],Evaluate[	
		SourceRank3AntisymmetricPara[-c,-a,-b]+V[-c]SourceRank3AntisymmetricPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3Antisymmetric[-c,-a,-b],Evaluate[Dagger@(	
		SourceRank3AntisymmetricPara[-c,-a,-b]+V[-c]SourceRank3AntisymmetricPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];
SourceRank3AntisymmetricPerpParaToSourceRank3Antisymmetric=Join[
	MakeRule[{SourceRank3AntisymmetricPara[-b,-a,-e],Evaluate[
		ProjPara[-b,c]SourceRank3Antisymmetric[-c,-a,-e]/.ProjPerpParaToVG]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SourceRank3AntisymmetricPerp[-a,-e],Evaluate[
		V[c]SourceRank3Antisymmetric[-c,-a,-e]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3AntisymmetricPara[-b,-a,-e],Evaluate[Dagger@(
		ProjPara[-b,c]SourceRank3Antisymmetric[-c,-a,-e]/.ProjPerpParaToVG)]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3AntisymmetricPerp[-a,-e],Evaluate[Dagger@(
		V[c]SourceRank3Antisymmetric[-c,-a,-e])]},MetricOn->All,ContractMetrics->True]];
Rank3AntisymmetricParaSpinParityToRank3Antisymmetric=Join[
	MakeRule[{Rank3AntisymmetricPara0p[],Scalar[Evaluate[
		ProjRank3Antisymmetric0p[e,f]ProjRank3AntisymmetricPerp[-e,-f,a,b,c]Rank3AntisymmetricPara[-a,-b,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Rank3AntisymmetricPara0m[],Scalar[Evaluate[
		ProjRank3Antisymmetric0m[d,e,f]ProjRank3AntisymmetricPara[-d,-e,-f,a,b,c]Rank3AntisymmetricPara[-a,-b,-c]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Rank3AntisymmetricPara1p[-n,-m],Evaluate[
		ProjRank3Antisymmetric1p[-n,-m,e,f]ProjRank3AntisymmetricPerp[-e,-f,a,b,c]Rank3AntisymmetricPara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Rank3AntisymmetricPara1m[-n],Evaluate[
		ProjRank3Antisymmetric1m[-n,d,e,f]ProjRank3AntisymmetricPara[-d,-e,-f,a,b,c]Rank3AntisymmetricPara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Rank3AntisymmetricPara2p[-n,-m],Evaluate[
		ProjRank3Antisymmetric2p[-n,-m,e,f]ProjRank3AntisymmetricPerp[-e,-f,a,b,c]Rank3AntisymmetricPara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Rank3AntisymmetricPara2m[-n,-m,-o],Evaluate[
		ProjRank3Antisymmetric2m[-n,-m,-o,d,e,f]ProjRank3AntisymmetricPara[-d,-e,-f,a,b,c]Rank3AntisymmetricPara[-a,-b,-c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3AntisymmetricPara0p[],Scalar[Evaluate[Dagger@(
		ProjRank3Antisymmetric0p[e,f]ProjRank3AntisymmetricPerp[-e,-f,a,b,c]Rank3AntisymmetricPara[-a,-b,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3AntisymmetricPara0m[],Scalar[Evaluate[Dagger@(
		ProjRank3Antisymmetric0m[d,e,f]ProjRank3AntisymmetricPara[-d,-e,-f,a,b,c]Rank3AntisymmetricPara[-a,-b,-c])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3AntisymmetricPara1p[-n,-m],Evaluate[Dagger@(
		ProjRank3Antisymmetric1p[-n,-m,e,f]ProjRank3AntisymmetricPerp[-e,-f,a,b,c]Rank3AntisymmetricPara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3AntisymmetricPara1m[-n],Evaluate[Dagger@(
		ProjRank3Antisymmetric1m[-n,d,e,f]ProjRank3AntisymmetricPara[-d,-e,-f,a,b,c]Rank3AntisymmetricPara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3AntisymmetricPara2p[-n,-m],Evaluate[Dagger@(
		ProjRank3Antisymmetric2p[-n,-m,e,f]ProjRank3AntisymmetricPerp[-e,-f,a,b,c]Rank3AntisymmetricPara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3AntisymmetricPara2m[-n,-m,-o],Evaluate[Dagger@(
		ProjRank3Antisymmetric2m[-n,-m,-o,d,e,f]ProjRank3AntisymmetricPara[-d,-e,-f,a,b,c]Rank3AntisymmetricPara[-a,-b,-c])]},MetricOn->All,ContractMetrics->True]];
Rank3AntisymmetricPerpSpinParityToRank3Antisymmetric=Join[
	MakeRule[{Rank3AntisymmetricPerp1p[-n,-m],Evaluate[
		ProjPara[-n,a]ProjPara[-m,b]Rank3AntisymmetricPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Rank3AntisymmetricPerp1m[-n],Evaluate[
		ProjPara[-n,a]V[b]Rank3AntisymmetricPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3AntisymmetricPerp1p[-n,-m],Evaluate[Dagger@(
		ProjPara[-n,a]ProjPara[-m,b]Rank3AntisymmetricPerp[-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3AntisymmetricPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]V[b]Rank3AntisymmetricPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];
SourceRank3AntisymmetricParaSpinParityToSourceRank3Antisymmetric=Join[
	MakeRule[{SourceRank3AntisymmetricPara0p[],Scalar[Evaluate[
		ProjRank3Antisymmetric0p[e,f]ProjRank3AntisymmetricPerp[-e,-f,a,b,c]SourceRank3AntisymmetricPara[-c,-a,-b]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SourceRank3AntisymmetricPara0m[],Scalar[Evaluate[
		ProjRank3Antisymmetric0m[d,e,f]ProjRank3AntisymmetricPara[-d,-e,-f,a,b,c]SourceRank3AntisymmetricPara[-c,-a,-b]]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SourceRank3AntisymmetricPara1p[-n,-m],Evaluate[
		ProjRank3Antisymmetric1p[-n,-m,e,f]ProjRank3AntisymmetricPerp[-e,-f,a,b,c]SourceRank3AntisymmetricPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SourceRank3AntisymmetricPara1m[-n],Evaluate[
		ProjRank3Antisymmetric1m[-n,d,e,f]ProjRank3AntisymmetricPara[-d,-e,-f,a,b,c]SourceRank3AntisymmetricPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SourceRank3AntisymmetricPara2p[-n,-m],Evaluate[
		ProjRank3Antisymmetric2p[-n,-m,e,f]ProjRank3AntisymmetricPerp[-e,-f,a,b,c]SourceRank3AntisymmetricPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SourceRank3AntisymmetricPara2m[-n,-m,-o],Evaluate[
		ProjRank3Antisymmetric2m[-n,-m,-o,d,e,f]ProjRank3AntisymmetricPara[-d,-e,-f,a,b,c]SourceRank3AntisymmetricPara[-c,-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3AntisymmetricPara0p[],Scalar[Evaluate[Dagger@(
		ProjRank3Antisymmetric0p[e,f]ProjRank3AntisymmetricPerp[-e,-f,a,b,c]SourceRank3AntisymmetricPara[-c,-a,-b])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3AntisymmetricPara0m[],Scalar[Evaluate[Dagger@(
		ProjRank3Antisymmetric0m[d,e,f]ProjRank3AntisymmetricPara[-d,-e,-f,a,b,c]SourceRank3AntisymmetricPara[-c,-a,-b])]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3AntisymmetricPara1p[-n,-m],Evaluate[Dagger@(
		ProjRank3Antisymmetric1p[-n,-m,e,f]ProjRank3AntisymmetricPerp[-e,-f,a,b,c]SourceRank3AntisymmetricPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3AntisymmetricPara1m[-n],Evaluate[Dagger@(
		ProjRank3Antisymmetric1m[-n,d,e,f]ProjRank3AntisymmetricPara[-d,-e,-f,a,b,c]SourceRank3AntisymmetricPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3AntisymmetricPara2p[-n,-m],Evaluate[Dagger@(
		ProjRank3Antisymmetric2p[-n,-m,e,f]ProjRank3AntisymmetricPerp[-e,-f,a,b,c]SourceRank3AntisymmetricPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3AntisymmetricPara2m[-n,-m,-o],Evaluate[Dagger@(
		ProjRank3Antisymmetric2m[-n,-m,-o,d,e,f]ProjRank3AntisymmetricPara[-d,-e,-f,a,b,c]SourceRank3AntisymmetricPara[-c,-a,-b])]},MetricOn->All,ContractMetrics->True]];
SourceRank3AntisymmetricPerpSpinParityToSourceRank3Antisymmetric=Join[
	MakeRule[{SourceRank3AntisymmetricPerp1p[-n,-m],Evaluate[
		ProjPara[-n,a]ProjPara[-m,b]SourceRank3AntisymmetricPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SourceRank3AntisymmetricPerp1m[-n],Evaluate[
		ProjPara[-n,a]V[b]SourceRank3AntisymmetricPerp[-a,-b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3AntisymmetricPerp1p[-n,-m],Evaluate[Dagger@(
		ProjPara[-n,a]ProjPara[-m,b]SourceRank3AntisymmetricPerp[-a,-b])]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3AntisymmetricPerp1m[-n],Evaluate[Dagger@(
		ProjPara[-n,a]V[b]SourceRank3AntisymmetricPerp[-a,-b])]},MetricOn->All,ContractMetrics->True]];
Rank3AntisymmetricParaToRank3AntisymmetricParaSpinParity=Join[
	MakeRule[{Rank3AntisymmetricPara[-n,-m,-o],Evaluate[
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]Rank3AntisymmetricPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]Rank3AntisymmetricPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]Rank3AntisymmetricPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjRank3Antisymmetric0m[-n,-m,-o]Rank3AntisymmetricPara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]Rank3AntisymmetricPara1m[-n],{-m,-n}]+
		(4/3)Rank3AntisymmetricPara2m[-n,-m,-o],{-n,-m}])/.ProjRank3AntisymmetricSpinParityToVG/.ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3AntisymmetricPara[-n,-m,-o],Evaluate[Dagger@(
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]Rank3AntisymmetricPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]Rank3AntisymmetricPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]Rank3AntisymmetricPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjRank3Antisymmetric0m[-n,-m,-o]Rank3AntisymmetricPara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]Rank3AntisymmetricPara1m[-n],{-m,-n}]+
		(4/3)Rank3AntisymmetricPara2m[-n,-m,-o],{-n,-m}])/.ProjRank3AntisymmetricSpinParityToVG/.ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True]];
Rank3AntisymmetricPerpToRank3AntisymmetricPerpSpinParity=Join[
	MakeRule[{Rank3AntisymmetricPerp[-n,-m],Evaluate[Rank3AntisymmetricPerp1p[-n,-m]+2Antisymmetrize[V[-m]Rank3AntisymmetricPerp1m[-n],{-n,-m}]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rank3AntisymmetricPerp[-n,-m],Evaluate[Dagger@(Rank3AntisymmetricPerp1p[-n,-m]+2Antisymmetrize[V[-m]Rank3AntisymmetricPerp1m[-n],{-n,-m}])]},MetricOn->All,ContractMetrics->True]];
SourceRank3AntisymmetricParaToSourceRank3AntisymmetricParaSpinParity=Join[
	MakeRule[{SourceRank3AntisymmetricPara[-o,-n,-m],Evaluate[
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]SourceRank3AntisymmetricPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]SourceRank3AntisymmetricPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]SourceRank3AntisymmetricPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjRank3Antisymmetric0m[-n,-m,-o]SourceRank3AntisymmetricPara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]SourceRank3AntisymmetricPara1m[-n],{-m,-n}]+
		(4/3)SourceRank3AntisymmetricPara2m[-n,-m,-o],{-n,-m}])/.ProjRank3AntisymmetricSpinParityToVG/.ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3AntisymmetricPara[-o,-n,-m],Evaluate[Dagger@(
		(Antisymmetrize[2Antisymmetrize[V[-n](1/3)ProjPara[-m,-o]SourceRank3AntisymmetricPara0p[],{-n,-m}]+
		2Antisymmetrize[V[-n]SourceRank3AntisymmetricPara1p[-m,-o],{-n,-m}]+
		2Antisymmetrize[V[-n]SourceRank3AntisymmetricPara2p[-m,-o],{-n,-m}]+
		(-1/6)ProjRank3Antisymmetric0m[-n,-m,-o]SourceRank3AntisymmetricPara0m[]+
		Antisymmetrize[-ProjPara[-m,-o]SourceRank3AntisymmetricPara1m[-n],{-m,-n}]+
		(4/3)SourceRank3AntisymmetricPara2m[-n,-m,-o],{-n,-m}])/.ProjRank3AntisymmetricSpinParityToVG/.ProjPerpParaToVG//xAct`PSALTer`Private`ToNewCanonical)]},MetricOn->All,ContractMetrics->True]];
SourceRank3AntisymmetricPerpToSourceRank3AntisymmetricPerpSpinParity=Join[
	MakeRule[{SourceRank3AntisymmetricPerp[-n,-m],Evaluate[SourceRank3AntisymmetricPerp1p[-n,-m]+2Antisymmetrize[V[-m]SourceRank3AntisymmetricPerp1m[-n],{-n,-m}]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SourceRank3AntisymmetricPerp[-n,-m],Evaluate[Dagger@(SourceRank3AntisymmetricPerp1p[-n,-m]+2Antisymmetrize[V[-m]SourceRank3AntisymmetricPerp1m[-n],{-n,-m}])]},MetricOn->All,ContractMetrics->True]];
Patch2m=Join[
	MakeRule[{Rank3AntisymmetricPara2m[-a,-c,-b]Rank3AntisymmetricPara2m[a,b,c],(1/2)Rank3AntisymmetricPara2m[-a,-b,-c]Rank3AntisymmetricPara2m[a,b,c]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate[Dagger@Rank3AntisymmetricPara2m[-a,-c,-b]Rank3AntisymmetricPara2m[a,b,c]],Evaluate[(1/2)Dagger@Rank3AntisymmetricPara2m[-a,-b,-c]Rank3AntisymmetricPara2m[a,b,c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate[Rank3AntisymmetricPara2m[-a,-c,-b]Dagger@Rank3AntisymmetricPara2m[a,b,c]],Evaluate[(1/2)Rank3AntisymmetricPara2m[-a,-b,-c]Dagger@Rank3AntisymmetricPara2m[a,b,c]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SourceRank3AntisymmetricPara2m[-a,-c,-b]SourceRank3AntisymmetricPara2m[a,b,c],(1/2)SourceRank3AntisymmetricPara2m[-a,-b,-c]SourceRank3AntisymmetricPara2m[a,b,c]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[Rank3AntisymmetricPara2m,MakeRule[{Rank3AntisymmetricPara2m[-a,-b,-c]*Evaluate@Dagger[Rank3AntisymmetricPara2m[a,c,b]],
					Evaluate[Rank3AntisymmetricPara2m[-a,-b,-c]*Evaluate@Dagger[Rank3AntisymmetricPara2m[a,b,c]]/2]},MetricOn->All,ContractMetrics->True]];

ExpandFieldsRules=Flatten@Map[MakeRule[{#,Evaluate@Module[{Expr=#},
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;	
	Expr=Expr/.Rank3AntisymmetricParaSpinParityToRank3Antisymmetric;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.Rank3AntisymmetricPerpSpinParityToRank3Antisymmetric;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.ProjRank3AntisymmetricPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.ProjRank3AntisymmetricSpinParityToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.ProjPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.Rank3AntisymmetricPerpParaToRank3Antisymmetric;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
	Expr]},
	MetricOn->All,ContractMetrics->True]&,{Rank3AntisymmetricPara0p[],Rank3AntisymmetricPara0m[],Rank3AntisymmetricPara1p[-a,-b],Rank3AntisymmetricPara1m[-a],Rank3AntisymmetricPara2p[-a,-b],Rank3AntisymmetricPara2m[-a,-b,-c],Rank3AntisymmetricPerp1p[-a,-b],Rank3AntisymmetricPerp1m[-a],Dagger@Rank3AntisymmetricPara0p[],Dagger@Rank3AntisymmetricPara0m[],Dagger@Rank3AntisymmetricPara1p[-a,-b],Dagger@Rank3AntisymmetricPara1m[-a],Dagger@Rank3AntisymmetricPara2p[-a,-b],Dagger@Rank3AntisymmetricPara2m[-a,-b,-c],Dagger@Rank3AntisymmetricPerp1p[-a,-b],Dagger@Rank3AntisymmetricPerp1m[-a]}];

ExpandSourcesRules=Flatten@Map[MakeRule[{#,Evaluate@Module[{Expr=#},
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;	
	Expr=Expr/.SourceRank3AntisymmetricParaSpinParityToSourceRank3Antisymmetric;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.SourceRank3AntisymmetricPerpSpinParityToSourceRank3Antisymmetric;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.ProjRank3AntisymmetricPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.ProjRank3AntisymmetricSpinParityToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.ProjPerpParaToVG;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.SourceRank3AntisymmetricPerpParaToSourceRank3Antisymmetric;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
	Expr]},
	MetricOn->All,ContractMetrics->True]&,{SourceRank3AntisymmetricPara0p[],SourceRank3AntisymmetricPara0m[],SourceRank3AntisymmetricPara1p[-a,-b],SourceRank3AntisymmetricPara1m[-a],SourceRank3AntisymmetricPara2p[-a,-b],SourceRank3AntisymmetricPara2m[-a,-b,-c],SourceRank3AntisymmetricPerp1p[-a,-b],SourceRank3AntisymmetricPerp1m[-a],Dagger@SourceRank3AntisymmetricPara0p[],Dagger@SourceRank3AntisymmetricPara0m[],Dagger@SourceRank3AntisymmetricPara1p[-a,-b],Dagger@SourceRank3AntisymmetricPara1m[-a],Dagger@SourceRank3AntisymmetricPara2p[-a,-b],Dagger@SourceRank3AntisymmetricPara2m[-a,-b,-c],Dagger@SourceRank3AntisymmetricPerp1p[-a,-b],Dagger@SourceRank3AntisymmetricPerp1m[-a]}];

DecomposeFieldsRules=Flatten@Map[MakeRule[{#,Evaluate@Module[{Expr=#},
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.Rank3AntisymmetricToRank3AntisymmetricPerpPara;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.Rank3AntisymmetricParaToRank3AntisymmetricParaSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.Rank3AntisymmetricPerpToRank3AntisymmetricPerpSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
	Expr=Expr/.Patch2m;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
	Expr]},
	MetricOn->All,ContractMetrics->True]&,{Rank3Antisymmetric[-a,-b,-c],Dagger@Rank3Antisymmetric[-a,-b,-c]}];

xAct`PSALTer`Private`CombineRules[ExpandFieldsRules,
			ExpandSourcesRules,
			DecomposeFieldsRules];
