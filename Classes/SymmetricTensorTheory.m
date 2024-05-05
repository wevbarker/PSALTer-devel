(*=========================*)
(*  SymmetricTensorTheory  *)
(*=========================*)

BeginPackage["xAct`PSALTer`SymmetricTensorTheory`",{"xAct`xTensor`","xAct`xPerm`","xAct`xCore`","xAct`xTras`","xAct`xCoba`","xAct`PSALTer`"}];

(*=================================================================*)
(*  Basic definitions of gauge fields and their conjugate sources  *)
(*=================================================================*)

xAct`PSALTer`SymmetricTensorTheory`Private`SymmetricLinearMetricSymb="\[Theta]";
DefTensor[SymmetricLinearMetric[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`SymmetricTensorTheory`Private`SymmetricLinearMetricSymb],Dagger->Complex];

xAct`PSALTer`SymmetricTensorTheory`Private`SymmetricStressEnergySymb="\[ScriptCapitalT]";
DefTensor[SymmetricStressEnergy[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`SymmetricTensorTheory`Private`SymmetricStressEnergySymb],Dagger->Complex];

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

xAct`PSALTer`SymmetricTensorTheory`Private`SymmetricLinearMetricPerpSymb="\!\(\*SuperscriptBox[\(\[Theta]\),\(\[UpTee]\)]\)";
DefTensor[SymmetricLinearMetricPerp0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`SymmetricTensorTheory`Private`SymmetricLinearMetricPerpSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];

DefTensor[SymmetricLinearMetricPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`SymmetricTensorTheory`Private`SymmetricLinearMetricPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

xAct`PSALTer`SymmetricTensorTheory`Private`SymmetricLinearMetricParaSymb="\!\(\*SuperscriptBox[\(\[Theta]\),\(\[DoubleVerticalBar]\)]\)";

DefTensor[SymmetricLinearMetricPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`SymmetricTensorTheory`Private`SymmetricLinearMetricParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];

DefTensor[SymmetricLinearMetricPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`SymmetricTensorTheory`Private`SymmetricLinearMetricParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];


AutomaticRules[SymmetricLinearMetricPara2p,MakeRule[{Evaluate@Dagger@SymmetricLinearMetricPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[SymmetricLinearMetricPara2p,MakeRule[{SymmetricLinearMetricPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`SymmetricTensorTheory`Private`SymmetricStressEnergyPerpSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalT]\),\(\[UpTee]\)]\)";
DefTensor[SymmetricStressEnergyPerp0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`SymmetricTensorTheory`Private`SymmetricStressEnergyPerpSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[SymmetricStressEnergyPerp1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`SymmetricTensorTheory`Private`SymmetricStressEnergyPerpSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];
xAct`PSALTer`SymmetricTensorTheory`Private`SymmetricStressEnergyParaSymb="\!\(\*SuperscriptBox[\(\[ScriptCapitalT]\),\(\[DoubleVerticalBar]\)]\)";
DefTensor[SymmetricStressEnergyPara0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`SymmetricTensorTheory`Private`SymmetricStressEnergyParaSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[SymmetricStressEnergyPara2p[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`SymmetricTensorTheory`Private`SymmetricStressEnergyParaSymb,xAct`PSALTer`Private`Spin2p],OrthogonalTo->{V[a],V[b]},Dagger->Complex];

AutomaticRules[SymmetricStressEnergyPara2p,MakeRule[{Evaluate@Dagger@SymmetricStressEnergyPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[SymmetricStressEnergyPara2p,MakeRule[{SymmetricStressEnergyPara2p[a,-a],0},MetricOn->All,ContractMetrics->True]];

(*==============*)
(*  Expansions  *)
(*==============*)

xAct`PSALTer`SymmetricTensorTheory`Private`SymmetricLinearMetricSpinParityToSymmetricLinearMetric=Join[
	MakeRule[{SymmetricLinearMetricPerp0p[],Evaluate[
		ProjPerp[a,b]SymmetricLinearMetric[-a,-b]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SymmetricLinearMetricPerp1m[-a],Evaluate[
		V[b]ProjPara[-a,c]SymmetricLinearMetric[-c,-b]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SymmetricLinearMetricPara0p[],Evaluate[
		ProjPara[a,b]SymmetricLinearMetric[-a,-b]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SymmetricLinearMetricPara2p[-a,-b],Evaluate[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*SymmetricLinearMetric[-c,-d]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SymmetricLinearMetricPerp0p[],Evaluate@Dagger[
		ProjPerp[a,b]SymmetricLinearMetric[-a,-b]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SymmetricLinearMetricPerp1m[-a],Evaluate@Dagger[
		V[b]ProjPara[-a,c]SymmetricLinearMetric[-c,-b]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SymmetricLinearMetricPara0p[],Evaluate@Dagger[
		ProjPara[a,b]SymmetricLinearMetric[-a,-b]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SymmetricLinearMetricPara2p[-a,-b],Evaluate@Dagger[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*SymmetricLinearMetric[-c,-d]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`SymmetricTensorTheory`Private`SymmetricStressEnergySpinParityToSymmetricStressEnergy=Join[
	MakeRule[{SymmetricStressEnergyPerp0p[],Evaluate[
		ProjPerp[a,b]SymmetricStressEnergy[-a,-b]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SymmetricStressEnergyPerp1m[-a],Evaluate[
		V[b]ProjPara[-a,c]SymmetricStressEnergy[-c,-b]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SymmetricStressEnergyPara0p[],Evaluate[
		ProjPara[a,b]SymmetricStressEnergy[-a,-b]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{SymmetricStressEnergyPara2p[-a,-b],Evaluate[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*SymmetricStressEnergy[-c,-d]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SymmetricStressEnergyPerp0p[],Evaluate@Dagger[
		ProjPerp[a,b]SymmetricStressEnergy[-a,-b]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SymmetricStressEnergyPerp1m[-a],Evaluate@Dagger[
		V[b]ProjPara[-a,c]SymmetricStressEnergy[-c,-b]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SymmetricStressEnergyPara0p[],Evaluate@Dagger[
		ProjPara[a,b]SymmetricStressEnergy[-a,-b]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SymmetricStressEnergyPara2p[-a,-b],Evaluate@Dagger[
		(ProjPara[-a,c]ProjPara[-b,d]-(1/3)*ProjPara[-a,-b]ProjPara[c,d])*SymmetricStressEnergy[-c,-d]/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

xAct`PSALTer`SymmetricTensorTheory`Private`SymmetricLinearMetricToSymmetricLinearMetricSpinParity=Join[
	MakeRule[{SymmetricLinearMetric[-a,-b],Evaluate[
		(
			SymmetricLinearMetricPerp0p[]V[-a]V[-b]
			+SymmetricLinearMetricPerp1m[-a]V[-b]
			+SymmetricLinearMetricPerp1m[-b]V[-a]
			+(1/3)*SymmetricLinearMetricPara0p[]ProjPara[-a,-b]
			+SymmetricLinearMetricPara2p[-a,-b]
		)/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical
	]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SymmetricLinearMetric[-a,-b],Evaluate@Dagger[
		(
			SymmetricLinearMetricPerp0p[]V[-a]V[-b]
			+SymmetricLinearMetricPerp1m[-a]V[-b]
			+SymmetricLinearMetricPerp1m[-b]V[-a]
			+(1/3)*SymmetricLinearMetricPara0p[]ProjPara[-a,-b]
			+SymmetricLinearMetricPara2p[-a,-b]
		)/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical
	]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`SymmetricTensorTheory`Private`SymmetricStressEnergyToSymmetricStressEnergySpinParity=Join[
	MakeRule[{SymmetricStressEnergy[-a,-b],Evaluate[
		(
			SymmetricStressEnergyPerp0p[]V[-a]V[-b]
			+SymmetricStressEnergyPerp1m[-a]V[-b]
			+SymmetricStressEnergyPerp1m[-b]V[-a]
			+(1/3)*SymmetricStressEnergyPara0p[]ProjPara[-a,-b]
			+SymmetricStressEnergyPara2p[-a,-b]
		)/.xAct`PSALTer`SymmetricTensorTheory`Private`ProjPerpParaToVG//ToCanonical
	]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@SymmetricStressEnergy[-a,-b],Evaluate@Dagger[
		(
			SymmetricStressEnergyPerp0p[]V[-a]V[-b]
			+SymmetricStressEnergyPerp1m[-a]V[-b]
			+SymmetricStressEnergyPerp1m[-b]V[-a]
			+(1/3)*SymmetricStressEnergyPara0p[]ProjPara[-a,-b]
			+SymmetricStressEnergyPara2p[-a,-b]
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
		SymmetricLinearMetric-><|
			0-><|Even->{SymmetricLinearMetricPerp0p,SymmetricLinearMetricPara0p},Odd->{}|>,
			1-><|Even->{},Odd->{SymmetricLinearMetricPerp1m}|>,
			2-><|Even->{SymmetricLinearMetricPara2p},Odd->{}|>
		|>
|>;

SourceSpinParityTensorHeads=<|
		SymmetricStressEnergy-><|
			0-><|Even->{SymmetricStressEnergyPerp0p,SymmetricStressEnergyPara0p},Odd->{}|>,
			1-><|Even->{},Odd->{SymmetricStressEnergyPerp1m}|>,
			2-><|Even->{SymmetricStressEnergyPara2p},Odd->{}|>
		|>
|>;

SourceEngineeringDimensions=<|
		SymmetricStressEnergy->1
|>;

ExpandFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`SymmetricTensorTheory`Private`SymmetricLinearMetricSpinParityToSymmetricLinearMetric;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

ExpandSources[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`SymmetricTensorTheory`Private`SymmetricStressEnergySpinParityToSymmetricStressEnergy;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
Expr];

DecomposeFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`SymmetricTensorTheory`Private`SymmetricLinearMetricToSymmetricLinearMetricSpinParity;
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
