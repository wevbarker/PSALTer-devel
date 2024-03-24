(*==============================*)
(*  BiScalarVectorTensorTheory  *)
(*==============================*)

BeginPackage["xAct`PSALTer`BiScalarVectorTensorTheory`",{"xAct`xTensor`","xAct`xPerm`","xAct`xCore`","xAct`xTras`","xAct`xCoba`","xAct`PSALTer`"}];

(*=================================================================*)
(*  Basic definitions of gauge fields and their conjugate sources  *)
(*=================================================================*)

xAct`PSALTer`BiScalarVectorTensorTheory`Private`LinearMetricSymb="\[ScriptH]";
DefTensor[LinearMetric[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BiScalarVectorTensorTheory`Private`LinearMetricSymb],Dagger->Complex];

xAct`PSALTer`BiScalarVectorTensorTheory`Private`StressEnergySymb="\[ScriptCapitalT]";
DefTensor[StressEnergy[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BiScalarVectorTensorTheory`Private`StressEnergySymb],Dagger->Complex];

xAct`PSALTer`BiScalarVectorTensorTheory`Private`BSymb="\[ScriptCapitalB]";
DefTensor[B[-d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BiScalarVectorTensorTheory`Private`BSymb],Dagger->Complex];

xAct`PSALTer`BiScalarVectorTensorTheory`Private`ConjugateSourceBSymb="\[ScriptCapitalJ]";
DefTensor[ConjugateSourceB[-d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BiScalarVectorTensorTheory`Private`ConjugateSourceBSymb],Dagger->Complex];

xAct`PSALTer`BiScalarVectorTensorTheory`Private`PhiSymb="\[Phi]";
DefTensor[Phi[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BiScalarVectorTensorTheory`Private`PhiSymb],Dagger->Complex];

xAct`PSALTer`BiScalarVectorTensorTheory`Private`ConjugateSourcePhiSymb="\[Rho]";
DefTensor[ConjugateSourcePhi[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BiScalarVectorTensorTheory`Private`ConjugateSourcePhiSymb],Dagger->Complex];

xAct`PSALTer`BiScalarVectorTensorTheory`Private`VarPhiSymb="\[CurlyPhi]";
DefTensor[VarPhi[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BiScalarVectorTensorTheory`Private`VarPhiSymb],Dagger->Complex];

xAct`PSALTer`BiScalarVectorTensorTheory`Private`ConjugateSourceVarPhiSymb="\[CurlyRho]";
DefTensor[ConjugateSourceVarPhi[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BiScalarVectorTensorTheory`Private`ConjugateSourceVarPhiSymb],Dagger->Complex];

(*==============*)
(*  Projectors  *)
(*==============*)

(*====================================*)
(*  Basic perpendicular and parallel  *)
(*====================================*)

xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjPerpSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[UpTee]\)]\)";
DefTensor[ProjPerp[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjPerpSymb]];
xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjParaSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[DoubleVerticalBar]\)]\)";
DefTensor[ProjPara[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjParaSymb]];

xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjPerpParaToVG=Join[
	MakeRule[{ProjPerp[-a,b],Evaluate[V[-a]V[b]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ProjPara[-a,b],Evaluate[G[-a,b]-V[-a]V[b]]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

(*==============================*)
(*  Spin-parity or SO(3) parts  *)
(*==============================*)

(*======================*)
(*  Tensor definitions  *)
(*======================*)

xAct`PSALTer`BiScalarVectorTensorTheory`Private`LinearMetricPerpSymb="\!\(\*SuperscriptBox[\(\[ScriptH]\),\(\[UpTee]\)]\)";
DefTensor[LinearMetricPerp0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BiScalarVectorTensorTheory`Private`LinearMetricPerpSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];

DefTensor[LinearMetricPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BiScalarVectorTensorTheory`Private`LinearMetricPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

xAct`PSALTer`BiScalarVectorTensorTheory`Private`LinearMetricParaSymb="\!\(\*SuperscriptBox[\(\[ScriptH]\),\(\[DoubleVerticalBar]\)]\)";

DefTensor[LinearMetricPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BiScalarVectorTensorTheory`Private`LinearMetricParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];

DefTensor[LinearMetricPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BiScalarVectorTensorTheory`Private`LinearMetricParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];


AutomaticRules[LinearMetricPara2p,MakeRule[{Evaluate@Dagger@LinearMetricPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[LinearMetricPara2p,MakeRule[{LinearMetricPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BiScalarVectorTensorTheory`Private`StressEnergyPerpSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalT]\),\(\[UpTee]\)]\)";
DefTensor[StressEnergyPerp0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BiScalarVectorTensorTheory`Private`StressEnergyPerpSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[StressEnergyPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BiScalarVectorTensorTheory`Private`StressEnergyPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
xAct`PSALTer`BiScalarVectorTensorTheory`Private`StressEnergyParaSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalT]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[StressEnergyPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BiScalarVectorTensorTheory`Private`StressEnergyParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[StressEnergyPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`BiScalarVectorTensorTheory`Private`StressEnergyParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];

AutomaticRules[StressEnergyPara2p,MakeRule[{Evaluate@Dagger@StressEnergyPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[StressEnergyPara2p,MakeRule[{StressEnergyPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

DefSpinParityMode[B0p[],Spin->0,Parity->Even,
	FieldSymbol->xAct`PSALTer`BiScalarVectorTensorTheory`Private`BSymb,
	SourceSymbol->xAct`PSALTer`BiScalarVectorTensorTheory`Private`ConjugateSourceBSymb];

DefSpinParityMode[B1m[-a],Spin->1,Parity->Odd,
	FieldSymbol->xAct`PSALTer`BiScalarVectorTensorTheory`Private`BSymb,
	SourceSymbol->xAct`PSALTer`BiScalarVectorTensorTheory`Private`ConjugateSourceBSymb];

DefSpinParityMode[Phi0p[],Spin->0,Parity->Even,
	FieldSymbol->xAct`PSALTer`BiScalarVectorTensorTheory`Private`PhiSymb,
	SourceSymbol->xAct`PSALTer`BiScalarVectorTensorTheory`Private`ConjugateSourcePhiSymb];

DefSpinParityMode[VarPhi0p[],Spin->0,Parity->Even,
	FieldSymbol->xAct`PSALTer`BiScalarVectorTensorTheory`Private`VarPhiSymb,
	SourceSymbol->xAct`PSALTer`BiScalarVectorTensorTheory`Private`ConjugateSourceVarPhiSymb];

(*==============*)
(*  Expansions  *)
(*==============*)

xAct`PSALTer`BiScalarVectorTensorTheory`Private`LinearMetricSpinParityToLinearMetric=Join[
	MakeRule[{LinearMetricPerp0p[],Evaluate[
		ProjPerp[a,b]LinearMetric[-a,-b]/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{LinearMetricPerp1m[-a],Evaluate[
		V[b]ProjPara[-a,c]LinearMetric[-c,-b]/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{LinearMetricPara0p[],Evaluate[
		ProjPara[a,b]LinearMetric[-a,-b]/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{LinearMetricPara2p[-a,-b],Evaluate[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*LinearMetric[-c,-d]/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@LinearMetricPerp0p[],Evaluate@Dagger[
		ProjPerp[a,b]LinearMetric[-a,-b]/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@LinearMetricPerp1m[-a],Evaluate@Dagger[
		V[b]ProjPara[-a,c]LinearMetric[-c,-b]/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@LinearMetricPara0p[],Evaluate@Dagger[
		ProjPara[a,b]LinearMetric[-a,-b]/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@LinearMetricPara2p[-a,-b],Evaluate@Dagger[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*LinearMetric[-c,-d]/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BiScalarVectorTensorTheory`Private`StressEnergySpinParityToStressEnergy=Join[
	MakeRule[{StressEnergyPerp0p[],Evaluate[
		ProjPerp[a,b]StressEnergy[-a,-b]/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{StressEnergyPerp1m[-a],Evaluate[
		V[b]ProjPara[-a,c]StressEnergy[-c,-b]/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{StressEnergyPara0p[],Evaluate[
		ProjPara[a,b]StressEnergy[-a,-b]/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{StressEnergyPara2p[-a,-b],Evaluate[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*StressEnergy[-c,-d]/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@StressEnergyPerp0p[],Evaluate@Dagger[
		ProjPerp[a,b]StressEnergy[-a,-b]/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@StressEnergyPerp1m[-a],Evaluate@Dagger[
		V[b]ProjPara[-a,c]StressEnergy[-c,-b]/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@StressEnergyPara0p[],Evaluate@Dagger[
		ProjPara[a,b]StressEnergy[-a,-b]/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@StressEnergyPara2p[-a,-b],Evaluate@Dagger[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*StressEnergy[-c,-d]/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BiScalarVectorTensorTheory`Private`BSpinParityToB=Join[
	MakeRule[{B0p[],Evaluate[V[a]B[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{B1m[-a],Evaluate[
		ProjPara[-a,b]B[-b]/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@B0p[],Evaluate@Dagger[V[a]B[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@B1m[-a],Evaluate@Dagger[
		ProjPara[-a,b]B[-b]/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BiScalarVectorTensorTheory`Private`ConjugateSourceBSpinParityToConjugateSourceB=Join[
	MakeRule[{ConjugateSourceB0p[],Evaluate[V[a]ConjugateSourceB[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ConjugateSourceB1m[-a],Evaluate[
		ProjPara[-a,b]ConjugateSourceB[-b]/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceB0p[],Evaluate@Dagger[V[a]ConjugateSourceB[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceB1m[-a],Evaluate@Dagger[
		ProjPara[-a,b]ConjugateSourceB[-b]/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BiScalarVectorTensorTheory`Private`PhiSpinParityToPhi=Join[
	MakeRule[{Phi0p[],Phi[]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Phi0p[],Evaluate@Dagger[Phi[]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BiScalarVectorTensorTheory`Private`ConjugateSourcePhiSpinParityToConjugateSourcePhi=Join[
	MakeRule[{ConjugateSourcePhi0p[],ConjugateSourcePhi[]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourcePhi0p[],Evaluate@Dagger[ConjugateSourcePhi[]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BiScalarVectorTensorTheory`Private`VarPhiSpinParityToVarPhi=Join[
	MakeRule[{VarPhi0p[],VarPhi[]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@VarPhi0p[],Evaluate@Dagger[VarPhi[]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BiScalarVectorTensorTheory`Private`ConjugateSourceVarPhiSpinParityToConjugateSourceVarPhi=Join[
	MakeRule[{ConjugateSourceVarPhi0p[],ConjugateSourceVarPhi[]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceVarPhi0p[],Evaluate@Dagger[ConjugateSourceVarPhi[]]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

xAct`PSALTer`BiScalarVectorTensorTheory`Private`LinearMetricToLinearMetricSpinParity=Join[
	MakeRule[{LinearMetric[-a,-b],Evaluate[
		(
			LinearMetricPerp0p[]V[-a]V[-b]
			+LinearMetricPerp1m[-a]V[-b]
			+LinearMetricPerp1m[-b]V[-a]
			+(1/3)*LinearMetricPara0p[]ProjPara[-a,-b]
			+LinearMetricPara2p[-a,-b]
		)/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjPerpParaToVG//ToCanonical
	]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@LinearMetric[-a,-b],Evaluate@Dagger[
		(
			LinearMetricPerp0p[]V[-a]V[-b]
			+LinearMetricPerp1m[-a]V[-b]
			+LinearMetricPerp1m[-b]V[-a]
			+(1/3)*LinearMetricPara0p[]ProjPara[-a,-b]
			+LinearMetricPara2p[-a,-b]
		)/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjPerpParaToVG//ToCanonical
	]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BiScalarVectorTensorTheory`Private`StressEnergyToStressEnergySpinParity=Join[
	MakeRule[{StressEnergy[-a,-b],Evaluate[
		(
			StressEnergyPerp0p[]V[-a]V[-b]
			+StressEnergyPerp1m[-a]V[-b]
			+StressEnergyPerp1m[-b]V[-a]
			+(1/3)*StressEnergyPara0p[]ProjPara[-a,-b]
			+StressEnergyPara2p[-a,-b]
		)/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjPerpParaToVG//ToCanonical
	]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@StressEnergy[-a,-b],Evaluate@Dagger[
		(
			StressEnergyPerp0p[]V[-a]V[-b]
			+StressEnergyPerp1m[-a]V[-b]
			+StressEnergyPerp1m[-b]V[-a]
			+(1/3)*StressEnergyPara0p[]ProjPara[-a,-b]
			+StressEnergyPara2p[-a,-b]
		)/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`ProjPerpParaToVG//ToCanonical
	]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BiScalarVectorTensorTheory`Private`BToBSpinParity=Join[
	MakeRule[{B[-a],Evaluate[V[-a]B0p[]+B1m[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@B[-a],Evaluate@Dagger[V[-a]B0p[]+B1m[-a]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BiScalarVectorTensorTheory`Private`ConjugateSourceBToConjugateSourceBSpinParity=Join[
	MakeRule[{ConjugateSourceB[-a],Evaluate[V[-a]ConjugateSourceB0p[]+ConjugateSourceB1m[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceB[-a],Evaluate@Dagger[V[-a]ConjugateSourceB0p[]+ConjugateSourceB1m[-a]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BiScalarVectorTensorTheory`Private`PhiToPhiSpinParity=Join[
	MakeRule[{Phi[],Phi0p[]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Phi[],Evaluate@Dagger[Phi0p[]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BiScalarVectorTensorTheory`Private`ConjugateSourcePhiToConjugateSourcePhiSpinParity=Join[
	MakeRule[{ConjugateSourcePhi[],ConjugateSourcePhi0p[]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourcePhi[],Evaluate@Dagger[ConjugateSourcePhi0p[]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BiScalarVectorTensorTheory`Private`VarPhiToVarPhiSpinParity=Join[
	MakeRule[{VarPhi[],VarPhi0p[]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@VarPhi[],Evaluate@Dagger[VarPhi0p[]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`BiScalarVectorTensorTheory`Private`ConjugateSourceVarPhiToConjugateSourceVarPhiSpinParity=Join[
	MakeRule[{ConjugateSourceVarPhi[],ConjugateSourceVarPhi0p[]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@ConjugateSourceVarPhi[],Evaluate@Dagger[ConjugateSourceVarPhi0p[]]},MetricOn->All,ContractMetrics->True]];

(*==========================================================*)
(*  Basic definitions of the Lagrangian coupling constants  *)
(*==========================================================*)

DefLagrangianCoupling[CouplingNu,
	CouplingSymbol->"\[Nu]",CouplingIndex->1];
DefLagrangianCoupling[CouplingXi,
	CouplingSymbol->"\[Xi]",CouplingIndex->1];
DefLagrangianCoupling[CouplingPhi0,
	CouplingSymbol->"\[Phi]",CouplingIndex->0];
DefLagrangianCoupling[CouplingVarPhi0,
	CouplingSymbol->"\[CurlyPhi]",CouplingIndex->0];
DefLagrangianCoupling[CouplingMu,
	CouplingSymbol->"\[Mu]",CouplingIndex->1];

(*================================================*)
(*  Some infrastructure for linearising theories  *)
(*================================================*)

(*===================*)
(*  Private context  *)
(*===================*)

Begin["xAct`PSALTer`BiScalarVectorTensorTheory`Private`"];

LagrangianCouplings={CouplingNu,CouplingXi,CouplingPhi0,CouplingVarPhi0,CouplingMu};

FieldSpinParityTensorHeads=<|
		LinearMetric-><|
			0-><|Even->{LinearMetricPerp0p,LinearMetricPara0p},Odd->{}|>,
			1-><|Even->{},Odd->{LinearMetricPerp1m}|>,
			2-><|Even->{LinearMetricPara2p},Odd->{}|>
		|>,
		B-><|
			0-><|Even->{B0p},Odd->{}|>,
			1-><|Even->{},Odd->{B1m}|>,
			2-><|Even->{},Odd->{}|>
		|>,
		Phi-><|
			0-><|Even->{Phi0p},Odd->{}|>,
			1-><|Even->{},Odd->{}|>,
			2-><|Even->{},Odd->{}|>
		|>,
		VarPhi-><|
			0-><|Even->{VarPhi0p},Odd->{}|>,
			1-><|Even->{},Odd->{}|>,
			2-><|Even->{},Odd->{}|>
		|>
|>;

SourceSpinParityTensorHeads=<|
		StressEnergy-><|
			0-><|Even->{StressEnergyPerp0p,StressEnergyPara0p},Odd->{}|>,
			1-><|Even->{},Odd->{StressEnergyPerp1m}|>,
			2-><|Even->{StressEnergyPara2p},Odd->{}|>
		|>,
		ConjugateSourceB-><|
			0-><|Even->{ConjugateSourceB0p},Odd->{}|>,
			1-><|Even->{},Odd->{ConjugateSourceB1m}|>,
			2-><|Even->{},Odd->{}|>
		|>,
		ConjugateSourcePhi-><|
			0-><|Even->{ConjugateSourcePhi0p},Odd->{}|>,
			1-><|Even->{},Odd->{}|>,
			2-><|Even->{},Odd->{}|>
		|>,
		ConjugateSourceVarPhi-><|
			0-><|Even->{ConjugateSourceVarPhi0p},Odd->{}|>,
			1-><|Even->{},Odd->{}|>,
			2-><|Even->{},Odd->{}|>
		|>
|>;

SourceEngineeringDimensions=<|
		StressEnergy->1,
		ConjugateSourceB->0,
		ConjugateSourcePhi->0,
		ConjugateSourceVarPhi->0
|>;

ExpandFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`LinearMetricSpinParityToLinearMetric;
	Expr=Expr/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`BSpinParityToB;
	Expr=Expr/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`PhiSpinParityToPhi;
	Expr=Expr/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`VarPhiSpinParityToVarPhi;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

ExpandSources[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`StressEnergySpinParityToStressEnergy;
	Expr=Expr/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`ConjugateSourceBSpinParityToConjugateSourceB;
	Expr=Expr/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`ConjugateSourcePhiSpinParityToConjugateSourcePhi;
	Expr=Expr/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`ConjugateSourceVarPhiSpinParityToConjugateSourceVarPhi;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
Expr];

DecomposeFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`LinearMetricToLinearMetricSpinParity;
	Expr=Expr/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`BToBSpinParity;
	Expr=Expr/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`PhiToPhiSpinParity;
	Expr=Expr/.xAct`PSALTer`BiScalarVectorTensorTheory`Private`VarPhiToVarPhiSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

End[];

EndPackage[];

DefClass[
	"BiScalarVectorTensorTheory",
	xAct`PSALTer`BiScalarVectorTensorTheory`Private`LagrangianCouplings,
	xAct`PSALTer`BiScalarVectorTensorTheory`Private`FieldSpinParityTensorHeads,
	xAct`PSALTer`BiScalarVectorTensorTheory`Private`SourceSpinParityTensorHeads,
	xAct`PSALTer`BiScalarVectorTensorTheory`Private`SourceEngineeringDimensions,
	xAct`PSALTer`BiScalarVectorTensorTheory`Private`ExpandFields,
	xAct`PSALTer`BiScalarVectorTensorTheory`Private`DecomposeFields,
	xAct`PSALTer`BiScalarVectorTensorTheory`Private`ExpandSources,
ExportClass->False];
