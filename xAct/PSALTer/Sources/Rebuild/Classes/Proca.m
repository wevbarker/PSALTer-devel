(*=========*)
(*  Proca  *)
(*=========*)

(*===============================================*)
(*  The context for the Proca class of theories  *)
(*===============================================*)

BeginPackage["xAct`PSALTer`Proca`",{"xAct`xTensor`","xAct`xPerm`","xAct`xCore`","xAct`xTras`","xAct`xCoba`","xAct`PSALTer`"}];

(*=================================================================*)
(*  Basic definitions of gauge fields and their conjugate sources  *)
(*=================================================================*)

xAct`PSALTer`Proca`Private`BSymb="\[ScriptCapitalB]";
DefTensor[B[-d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`Proca`Private`BSymb],Dagger->Complex];

xAct`PSALTer`Proca`Private`JSymb="\[ScriptCapitalJ]";
DefTensor[J[-d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`Proca`Private`JSymb],Dagger->Complex];

(*==============*)
(*  Projectors  *)
(*==============*)

(*====================================*)
(*  Basic perpendicular and parallel  *)
(*====================================*)

xAct`PSALTer`Proca`Private`ProjPerpSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[UpTee]\)]\)";
DefTensor[ProjPerp[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`Proca`Private`ProjPerpSymb]];
xAct`PSALTer`Proca`Private`ProjParaSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[DoubleVerticalBar]\)]\)";
DefTensor[ProjPara[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`Proca`Private`ProjParaSymb]];

xAct`PSALTer`Proca`Private`ProjPerpParaToVG=Join[
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

DefTensor[B0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`Proca`Private`BSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[B1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`Proca`Private`BSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

DefTensor[J0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`Proca`Private`JSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[J1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`Proca`Private`JSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

(*==============*)
(*  Expansions  *)
(*==============*)

xAct`PSALTer`Proca`Private`BSpinParityToB=Join[
	MakeRule[{B0p[],Evaluate[V[a]B[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{B1m[-a],Evaluate[
		ProjPara[-a,b]B[-b]/.xAct`PSALTer`Proca`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@B0p[],Evaluate@Dagger[V[a]B[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@B1m[-a],Evaluate@Dagger[
		ProjPara[-a,b]B[-b]/.xAct`PSALTer`Proca`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`Proca`Private`JSpinParityToJ=Join[
	MakeRule[{J0p[],Evaluate[V[a]J[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{J1m[-a],Evaluate[
		ProjPara[-a,b]J[-b]/.xAct`PSALTer`Proca`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@J0p[],Evaluate@Dagger[V[a]J[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@J1m[-a],Evaluate@Dagger[
		ProjPara[-a,b]J[-b]/.xAct`PSALTer`Proca`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

xAct`PSALTer`Proca`Private`BToBSpinParity=Join[
	MakeRule[{B[-a],Evaluate[V[-a]B0p[]+B1m[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@B[-a],Evaluate@Dagger[V[-a]B0p[]+B1m[-a]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`Proca`Private`JToJSpinParity=Join[
	MakeRule[{J[-a],Evaluate[V[-a]J0p[]+J1m[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@J[-a],Evaluate@Dagger[V[-a]J0p[]+J1m[-a]]},MetricOn->All,ContractMetrics->True]];

(*==========================================================*)
(*  Basic definitions of the Lagrangian coupling constants  *)
(*==========================================================*)

xAct`PSALTer`Proca`Private`CouplingSymb="\[Alpha]";
DefConstantSymbol[Coupling1,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`Proca`Private`CouplingSymb,xAct`PSALTer`Private`dSO1,xAct`PSALTer`Private`IsConstantSymbol->True]];
DefConstantSymbol[Coupling2,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`Proca`Private`CouplingSymb,xAct`PSALTer`Private`dSO2,xAct`PSALTer`Private`IsConstantSymbol->True]];
DefConstantSymbol[Coupling3,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`Proca`Private`CouplingSymb,xAct`PSALTer`Private`dSO3,xAct`PSALTer`Private`IsConstantSymbol->True]];

(*================================================*)
(*  Some infrastructure for linearising theories  *)
(*================================================*)

(*===================*)
(*  Private context  *)
(*===================*)

Begin["xAct`PSALTer`Proca`Private`"];

FieldSpinParityTensorHeads=<|
		B-><|
			0-><|Even->{B0p},Odd->{}|>,
			1-><|Even->{},Odd->{B1m}|>
		|>
|>;

SourceSpinParityTensorHeads=<|
		J-><|
			0-><|Even->{J0p},Odd->{}|>,
			1-><|Even->{},Odd->{J1m}|>
		|>
|>;

SourceEngineeringDimensions=<|
		J->0
|>;

ExpandFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`Proca`Private`BSpinParityToB;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

ExpandSources[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`Proca`Private`JSpinParityToJ;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
Expr];

DecomposeFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`Proca`Private`BToBSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

End[];

EndPackage[];

(*================================================================================*)
(*  Run DefClass from PSALTer to fully define the Proca class based on the above  *)
(*================================================================================*)

DefClass[
	"Proca",
	xAct`PSALTer`Proca`Private`FieldSpinParityTensorHeads,
	xAct`PSALTer`Proca`Private`SourceSpinParityTensorHeads,
	xAct`PSALTer`Proca`Private`SourceEngineeringDimensions,
	xAct`PSALTer`Proca`Private`ExpandFields,
	xAct`PSALTer`Proca`Private`DecomposeFields,
	xAct`PSALTer`Proca`Private`ExpandSources,
ExportClass->True];
