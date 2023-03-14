(*======*)
(*  KG  *)
(*======*)

(*============================================*)
(*  The context for the KG class of theories  *)
(*============================================*)

BeginPackage["xAct`PSALTer`KG`",{"xAct`xTensor`","xAct`xPerm`","xAct`xCore`","xAct`xTras`","xAct`xCoba`","xAct`PSALTer`"}];

(*=================================================================*)
(*  Basic definitions of gauge fields and their conjugate sources  *)
(*=================================================================*)

xAct`PSALTer`KG`Private`PhiSymb="\[CurlyPhi]";
DefTensor[Phi[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`KG`Private`PhiSymb],Dagger->Complex];

xAct`PSALTer`KG`Private`RhoSymb="\[Rho]";
DefTensor[Rho[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`KG`Private`RhoSymb],Dagger->Complex];

(*==============*)
(*  Projectors  *)
(*==============*)

(*====================================*)
(*  Basic perpendicular and parallel  *)
(*====================================*)

(*not needed!*)

(*==================*)
(*  Decompositions  *)
(*==================*)

(*==============================*)
(*  Spin-parity or SO(3) parts  *)
(*==============================*)

(*======================*)
(*  Tensor definitions  *)
(*======================*)

DefTensor[Phi0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`KG`Private`PhiSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];

DefTensor[Rho0p[],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`KG`Private`RhoSymb,xAct`PSALTer`Private`Spin0p],Dagger->Complex];

(*==============*)
(*  Expansions  *)
(*==============*)

xAct`PSALTer`KG`Private`PhiSpinParityToPhi=Join[
	MakeRule[{Phi0p[],Phi[]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Phi0p[],Evaluate@Dagger[Phi[]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`KG`Private`RhoSpinParityToRho=Join[
	MakeRule[{Rho0p[],Rho[]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rho0p[],Evaluate@Dagger[Rho[]]},MetricOn->All,ContractMetrics->True]];

(*==================*)
(*  Decompositions  *)
(*==================*)

xAct`PSALTer`KG`Private`PhiToPhiSpinParity=Join[
	MakeRule[{Phi[],Phi0p[]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Phi[],Evaluate@Dagger[Phi0p[]]},MetricOn->All,ContractMetrics->True]];

xAct`PSALTer`KG`Private`RhoToRhoSpinParity=Join[
	MakeRule[{Rho[],Rho0p[]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@Rho[],Evaluate@Dagger[Rho0p[]]},MetricOn->All,ContractMetrics->True]];

(*==========================================================*)
(*  Basic definitions of the Lagrangian coupling constants  *)
(*==========================================================*)

xAct`PSALTer`KG`Private`CouplingSymb="\[Alpha]";
DefConstantSymbol[Coupling1,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`KG`Private`CouplingSymb,xAct`PSALTer`Private`dSO1,xAct`PSALTer`Private`IsConstantSymbol->True]];
DefConstantSymbol[Coupling2,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`KG`Private`CouplingSymb,xAct`PSALTer`Private`dSO2,xAct`PSALTer`Private`IsConstantSymbol->True]];
DefConstantSymbol[Coupling3,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`KG`Private`CouplingSymb,xAct`PSALTer`Private`dSO3,xAct`PSALTer`Private`IsConstantSymbol->True]];

(*================================================*)
(*  Some infrastructure for linearising theories  *)
(*================================================*)

(*===================*)
(*  Private context  *)
(*===================*)

Begin["xAct`PSALTer`KG`Private`"];

FieldSpinParityTensorHeads=<|
		Phi-><|
			0-><|Even->{Phi0p},Odd->{}|>
		|>
|>;

SourceSpinParityTensorHeads=<|
		Rho-><|
			0-><|Even->{Rho0p},Odd->{}|>
		|>
|>;

SourceEngineeringDimensions=<|
		Rho->0
|>;

ExpandFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`KG`Private`PhiSpinParityToPhi;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

ExpandSources[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.xAct`PSALTer`KG`Private`RhoSpinParityToRho;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
Expr];

DecomposeFields[InputExpr_]:=Module[{Expr=InputExpr},
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr=Expr/.xAct`PSALTer`KG`Private`PhiToPhiSpinParity;
	Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr//=CollectTensors;
Expr];

End[];

EndPackage[];

(*=============================================================================*)
(*  Run DefClass from PSALTer to fully define the KG class based on the above  *)
(*=============================================================================*)

DefClass[
	"KG",
	xAct`PSALTer`KG`Private`FieldSpinParityTensorHeads,
	xAct`PSALTer`KG`Private`SourceSpinParityTensorHeads,
	xAct`PSALTer`KG`Private`SourceEngineeringDimensions,
	xAct`PSALTer`KG`Private`ExpandFields,
	xAct`PSALTer`KG`Private`DecomposeFields,
	xAct`PSALTer`KG`Private`ExpandSources,
ExportClass->True];
