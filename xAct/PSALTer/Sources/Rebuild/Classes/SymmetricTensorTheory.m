(*=========================*)
(*  SymmetricTensorTheory  *)
(*=========================*)

BeginPackage["xAct`PSALTer`SymmetricTensorTheory`",{"xAct`xTensor`","xAct`xPerm`","xAct`xCore`","xAct`xTras`","xAct`xCoba`","xAct`PSALTer`"}];

(*=================================================================*)
(*  Basic definitions of gauge fields and their conjugate sources  *)
(*=================================================================*)

xAct`PSALTer`SymmetricTensorTheory`Private`LinearMetricSymb="\[Psi]";
DefTensor[LinearMetric[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`SymmetricTensorTheory`Private`LinearMetricSymb],Dagger->Complex];

xAct`PSALTer`SymmetricTensorTheory`Private`StressEnergySymb="\[ScriptCapitalT]";
DefTensor[StressEnergy[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`SymmetricTensorTheory`Private`StressEnergySymb],Dagger->Complex];

(*==============*)
(*  Projectors  *)
(*==============*)

(*====================================*)
(*  Basic perpendicular and parallel  *)
(*====================================*)

xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[UpTee]\)]\)";
DefTensor[ProjPerp[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpSymb]];
xAct`PSALTer`SymmetricTensorTheory`Private`ProjParaSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[DoubleVerticalBar]\)]\)";
DefTensor[ProjPara[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`SymmetricTensorTheory`Private`ProjParaSymb]];

xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG=Join[
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

xAct`PSALTer`SymmetricTensorTheory`Private`LinearMetricPerpSymb="\!\(\*SuperscriptBox[\(\[Psi]\),\(\[UpTee]\)]\)";
DefTensor[LinearMetricPerp0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`SymmetricTensorTheory`Private`LinearMetricPerpSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];

DefTensor[LinearMetricPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`SymmetricTensorTheory`Private`LinearMetricPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

xAct`PSALTer`SymmetricTensorTheory`Private`LinearMetricParaSymb="\!\(\*SuperscriptBox[\(\[Psi]\),\(\[DoubleVerticalBar]\)]\)";

DefTensor[LinearMetricPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`SymmetricTensorTheory`Private`LinearMetricParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];

DefTensor[LinearMetricPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`SymmetricTensorTheory`Private`LinearMetricParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];


AutomaticRules[LinearMetricPara2p,MakeRule[{Evaluate@Dagger@LinearMetricPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[LinearMetricPara2p,MakeRule[{LinearMetricPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`SymmetricTensorTheory`Private`StressEnergyPerpSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalT]\),\(\[UpTee]\)]\)";
DefTensor[StressEnergyPerp0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`SymmetricTensorTheory`Private`StressEnergyPerpSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[StressEnergyPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`SymmetricTensorTheory`Private`StressEnergyPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
xAct`PSALTer`SymmetricTensorTheory`Private`StressEnergyParaSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalT]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[StressEnergyPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`SymmetricTensorTheory`Private`StressEnergyParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[StressEnergyPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`SymmetricTensorTheory`Private`StressEnergyParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];

AutomaticRules[StressEnergyPara2p,MakeRule[{Evaluate@Dagger@StressEnergyPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[StressEnergyPara2p,MakeRule[{StressEnergyPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

(*==============*)
(*  Expansions  *)
(*==============*)

xAct`PSALTer`SymmetricTensorTheory`Private`LinearMetricSpinParityToLinearMetric=Join[
	MakeRule[{LinearMetricPerp0p[],Evaluate[
		ProjPerp[a,b]LinearMetric[-a,-b]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{LinearMetricPerp1m[-a],Evaluate[
		V[b]ProjPara[-a,c]LinearMetric[-c,-b]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{LinearMetricPara0p[],Evaluate[
		ProjPara[a,b]LinearMetric[-a,-b]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{LinearMetricPara2p[-a,-b],Evaluate[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*LinearMetric[-c,-d]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@LinearMetricPerp0p[],Evaluate@Dagger[
		ProjPerp[a,b]LinearMetric[-a,-b]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@LinearMetricPerp1m[-a],Evaluate@Dagger[
		V[b]ProjPara[-a,c]LinearMetric[-c,-b]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@LinearMetricPara0p[],Evaluate@Dagger[
		ProjPara[a,b]LinearMetric[-a,-b]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@LinearMetricPara2p[-a,-b],Evaluate@Dagger[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*LinearMetric[-c,-d]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`SymmetricTensorTheory`Private`StressEnergySpinParityToStressEnergy=Join[
	MakeRule[{StressEnergyPerp0p[],Evaluate[
		ProjPerp[a,b]StressEnergy[-a,-b]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{StressEnergyPerp1m[-a],Evaluate[
		V[b]ProjPara[-a,c]StressEnergy[-c,-b]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{StressEnergyPara0p[],Evaluate[
		ProjPara[a,b]StressEnergy[-a,-b]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{StressEnergyPara2p[-a,-b],Evaluate[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*StressEnergy[-c,-d]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@StressEnergyPerp0p[],Evaluate@Dagger[
		ProjPerp[a,b]StressEnergy[-a,-b]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@StressEnergyPerp1m[-a],Evaluate@Dagger[
		V[b]ProjPara[-a,c]StressEnergy[-c,-b]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@StressEnergyPara0p[],Evaluate@Dagger[
		ProjPara[a,b]StressEnergy[-a,-b]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@StressEnergyPara2p[-a,-b],Evaluate@Dagger[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*StressEnergy[-c,-d]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

xAct`PSALTer`SymmetricTensorTheory`Private`LinearMetricToLinearMetricSpinParity=Join[
	MakeRule[{LinearMetric[-a,-b],Evaluate[
		(
			LinearMetricPerp0p[]V[-a]V[-b]
			+LinearMetricPerp1m[-a]V[-b]
			+LinearMetricPerp1m[-b]V[-a]
			+(1/3)*LinearMetricPara0p[]ProjPara[-a,-b]
			+LinearMetricPara2p[-a,-b]
		)/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical
	]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@LinearMetric[-a,-b],Evaluate@Dagger[
		(
			LinearMetricPerp0p[]V[-a]V[-b]
			+LinearMetricPerp1m[-a]V[-b]
			+LinearMetricPerp1m[-b]V[-a]
			+(1/3)*LinearMetricPara0p[]ProjPara[-a,-b]
			+LinearMetricPara2p[-a,-b]
		)/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical
	]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`SymmetricTensorTheory`Private`StressEnergyToStressEnergySpinParity=Join[
	MakeRule[{StressEnergy[-a,-b],Evaluate[
		(
			StressEnergyPerp0p[]V[-a]V[-b]
			+StressEnergyPerp1m[-a]V[-b]
			+StressEnergyPerp1m[-b]V[-a]
			+(1/3)*StressEnergyPara0p[]ProjPara[-a,-b]
			+StressEnergyPara2p[-a,-b]
		)/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical
	]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@StressEnergy[-a,-b],Evaluate@Dagger[
		(
			StressEnergyPerp0p[]V[-a]V[-b]
			+StressEnergyPerp1m[-a]V[-b]
			+StressEnergyPerp1m[-b]V[-a]
			+(1/3)*StressEnergyPara0p[]ProjPara[-a,-b]
			+StressEnergyPara2p[-a,-b]
		)/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical
	]},MetricOn->All,ContractMetrics->True]];

(*==========================================================*)
(*  Basic definitions of the Lagrangian coupling constants  *)
(*==========================================================*)

xAct`PSALTer`SymmetricTensorTheory`Private`CouplingSymb="\[Alpha]";
DefLagrangianCoupling[Coupling1,
	CouplingSymbol->xAct`PSALTer`SymmetricTensorTheory`Private`CouplingSymb,CouplingIndex->1];
DefLagrangianCoupling[Coupling2,
	CouplingSymbol->xAct`PSALTer`SymmetricTensorTheory`Private`CouplingSymb,CouplingIndex->2];
DefLagrangianCoupling[Coupling3,
	CouplingSymbol->xAct`PSALTer`SymmetricTensorTheory`Private`CouplingSymb,CouplingIndex->3];
DefLagrangianCoupling[EinsteinConstant,
	CouplingSymbol->"\[Kappa]"];

(*================================================*)
(*  Some infrastructure for linearising theories  *)
(*================================================*)

(*===================*)
(*  Private context  *)
(*===================*)

Begin["xAct`PSALTer`SymmetricTensorTheory`Private`"];

LagrangianCouplings={Coupling1,Coupling2,Coupling3};

FieldSpinParityTensorHeads=<|
		LinearMetric-><|
			0-><|Even->{LinearMetricPerp0p,LinearMetricPara0p},Odd->{}|>,
			1-><|Even->{},Odd->{LinearMetricPerp1m}|>,
			2-><|Even->{LinearMetricPara2p},Odd->{}|>
		|>
|>;

SourceSpinParityTensorHeads=<|
		StressEnergy-><|
			0-><|Even->{StressEnergyPerp0p,StressEnergyPara0p},Odd->{}|>,
			1-><|Even->{},Odd->{StressEnergyPerp1m}|>,
			2-><|Even->{StressEnergyPara2p},Odd->{}|>
		|>
|>;

SourceEngineeringDimensions=<|
		StressEnergy->1
|>;

ExpandFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`SymmetricTensorTheory`Private`LinearMetricSpinParityToLinearMetric;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

ExpandSources[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`SymmetricTensorTheory`Private`StressEnergySpinParityToStressEnergy;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
Expr];

DecomposeFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`SymmetricTensorTheory`Private`LinearMetricToLinearMetricSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

End[];

EndPackage[];

DefClass[
	"SymmetricTensorTheory",
	xAct`PSALTer`SymmetricTensorTheory`Private`LagrangianCouplings,
	xAct`PSALTer`SymmetricTensorTheory`Private`FieldSpinParityTensorHeads,
	xAct`PSALTer`SymmetricTensorTheory`Private`SourceSpinParityTensorHeads,
	xAct`PSALTer`SymmetricTensorTheory`Private`SourceEngineeringDimensions,
	xAct`PSALTer`SymmetricTensorTheory`Private`ExpandFields,
	xAct`PSALTer`SymmetricTensorTheory`Private`DecomposeFields,
	xAct`PSALTer`SymmetricTensorTheory`Private`ExpandSources,
ExportClass->False];
