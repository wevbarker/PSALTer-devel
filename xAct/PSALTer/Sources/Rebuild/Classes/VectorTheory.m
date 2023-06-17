(*================*)
(*  VectorTheory  *)
(*================*)

BeginPackage["xAct`PSALTer`VectorTheory`",{"xAct`xTensor`","xAct`xPerm`","xAct`xCore`","xAct`xTras`","xAct`xCoba`","xAct`PSALTer`"}];

(*=================================================================*)
(*  Basic definitions of gauge fields and their conjugate sources  *)
(*=================================================================*)

xAct`PSALTer`VectorTheory`Private`BSymb="\[ScriptCapitalB]";
DefTensor[B[-d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`VectorTheory`Private`BSymb],Dagger->Complex];

xAct`PSALTer`VectorTheory`Private`JSymb="\[ScriptCapitalJ]";
DefTensor[J[-d],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`VectorTheory`Private`JSymb],Dagger->Complex];

(*==============*)
(*  Projectors  *)
(*==============*)

(*====================================*)
(*  Basic perpendicular and parallel  *)
(*====================================*)

xAct`PSALTer`VectorTheory`Private`ProjPerpSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[UpTee]\)]\)";
DefTensor[ProjPerp[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`VectorTheory`Private`ProjPerpSymb]];
xAct`PSALTer`VectorTheory`Private`ProjParaSymb="\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalP]\),\(^\)],\(\[DoubleVerticalBar]\)]\)";
DefTensor[ProjPara[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`VectorTheory`Private`ProjParaSymb]];

xAct`PSALTer`VectorTheory`Private`ProjPerpParaToVG=Join[
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

DefTensor[B0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`VectorTheory`Private`BSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[B1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`VectorTheory`Private`BSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

DefTensor[J0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`VectorTheory`Private`JSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];
DefTensor[J1m[-a],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`VectorTheory`Private`JSymb,xAct`PSALTer`Private`Spin1m],OrthogonalTo->{V[a]},Dagger->Complex];

(*==============*)
(*  Expansions  *)
(*==============*)

xAct`PSALTer`VectorTheory`Private`BSpinParityToB=Join[
	MakeRule[{B0p[],Evaluate[V[a]B[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{B1m[-a],Evaluate[
		ProjPara[-a,b]B[-b]/.xAct`PSALTer`VectorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@B0p[],Evaluate@Dagger[V[a]B[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@B1m[-a],Evaluate@Dagger[
		ProjPara[-a,b]B[-b]/.xAct`PSALTer`VectorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`VectorTheory`Private`JSpinParityToJ=Join[
	MakeRule[{J0p[],Evaluate[V[a]J[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{J1m[-a],Evaluate[
		ProjPara[-a,b]J[-b]/.xAct`PSALTer`VectorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@J0p[],Evaluate@Dagger[V[a]J[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@J1m[-a],Evaluate@Dagger[
		ProjPara[-a,b]J[-b]/.xAct`PSALTer`VectorTheory`Private`ProjPerpParaToVG//ToCanonical]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

xAct`PSALTer`VectorTheory`Private`BToBSpinParity=Join[
	MakeRule[{B[-a],Evaluate[V[-a]B0p[]+B1m[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@B[-a],Evaluate@Dagger[V[-a]B0p[]+B1m[-a]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`VectorTheory`Private`JToJSpinParity=Join[
	MakeRule[{J[-a],Evaluate[V[-a]J0p[]+J1m[-a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@J[-a],Evaluate@Dagger[V[-a]J0p[]+J1m[-a]]},MetricOn->All,ContractMetrics->True]];

(*==========================================================*)
(*  Basic definitions of the Lagrangian coupling constants  *)
(*==========================================================*)

xAct`PSALTer`VectorTheory`Private`CouplingSymb="\[Alpha]";
DefConstantSymbol[Coupling1,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`VectorTheory`Private`CouplingSymb,xAct`PSALTer`Private`dSO1,xAct`PSALTer`Private`IsConstantSymbol->True]];
DefConstantSymbol[Coupling2,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`VectorTheory`Private`CouplingSymb,xAct`PSALTer`Private`dSO2,xAct`PSALTer`Private`IsConstantSymbol->True]];
DefConstantSymbol[Coupling3,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`VectorTheory`Private`CouplingSymb,xAct`PSALTer`Private`dSO3,xAct`PSALTer`Private`IsConstantSymbol->True]];

(*================================================*)
(*  Some infrastructure for linearising theories  *)
(*================================================*)

(*===================*)
(*  Private context  *)
(*===================*)

Begin["xAct`PSALTer`VectorTheory`Private`"];

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
	Expr=Expr/.xAct`PSALTer`VectorTheory`Private`BSpinParityToB;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

ExpandSources[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`VectorTheory`Private`JSpinParityToJ;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
Expr];

DecomposeFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`VectorTheory`Private`BToBSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

End[];

EndPackage[];

DefClass[
	"VectorTheory",
	xAct`PSALTer`VectorTheory`Private`FieldSpinParityTensorHeads,
	xAct`PSALTer`VectorTheory`Private`SourceSpinParityTensorHeads,
	xAct`PSALTer`VectorTheory`Private`SourceEngineeringDimensions,
	xAct`PSALTer`VectorTheory`Private`ExpandFields,
	xAct`PSALTer`VectorTheory`Private`DecomposeFields,
	xAct`PSALTer`VectorTheory`Private`ExpandSources,
ExportClass->True];
