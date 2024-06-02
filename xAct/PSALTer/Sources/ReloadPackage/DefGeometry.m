(*===============*)
(*  DefGeometry  *)
(*===============*)

DefManifold[M4,4,IndexRange[{a,z}]];
Quiet@DefMetric[-1,G[-a,-c],CD,{",","\[PartialD]"},
	PrintAs->"\[Eta]",FlatMetric->True,SymCovDQ->True];
xAct`PSALTer`Private`StandardIndices=ToExpression/@Alphabet[];
xAct`PSALTer`Private`StandardIndicesSymb=(ToString@#)&/@Evaluate@((#[[2]])&/@{
	{a,"\[Alpha]"},
	{b,"\[Beta]"},
	{c,"\[Chi]"},
	{d,"\[Delta]"},
	{e,"\[Epsilon]"},
	{f,"\[Phi]"},
	{g,"\[Gamma]"},
	{h,"\[Eta]"},
	{i,"\[Iota]"},
	{j,"\[Theta]"},
	{k,"\[Kappa]"},
	{l,"\[Lambda]"},
	{m,"\[Mu]"},
	{n,"\[Nu]"},
	{o,"\[Omicron]"},
	{p,"\[Pi]"},
	{q,"\[Omega]"},
	{r,"\[Rho]"},
	{s,"\[Sigma]"},
	{t,"\[Tau]"},
	{u,"\[Upsilon]"},
	{v,"\[Psi]"},
	{w,"\[Omega]"},
	{x,"\[Xi]"},
	{y,"\[CurlyPhi]"},
	{z,"\[Zeta]"}
});
(PrintAs@Evaluate@#1^=Evaluate@#2)&~MapThread~{xAct`PSALTer`Private`StandardIndices,xAct`PSALTer`Private`StandardIndicesSymb};

$DefInfoQ=False;
$CVVerbose=False;
DefTensor[V[-a],M4,PrintAs->"\[ScriptN]"];
AutomaticRules[V,MakeRule[{V[-a]V[a],1}],Verbose->False];
DefTensor[Eps[-a,-b,-c],M4,Antisymmetric[{-a,-b,-c}],
	OrthogonalTo->{V[a],V[b],V[c]},
	PrintAs->"\!\(\*SuperscriptBox[\(\[Epsilon]\), \(\[DoubleVerticalBar]\)]\)"];
DefConstantSymbol[Def,PrintAs->"\[ScriptK]"];
DefConstantSymbol[xAct`PSALTer`Private`DefSquared,PrintAs->"\[ScriptX]"];
DefConstantSymbol[Action,PrintAs->"\!\(\*SuperscriptBox[\(\[ScriptCapitalS]\), \(F\)]\)"];
	(*PrintAs->"\[ScriptCapitalS]"];*)
DefConstantSymbol[xAct`PSALTer`Private`TCoordinate,PrintAs->"\[ScriptT]"];
DefConstantSymbol[xAct`PSALTer`Private`XCoordinate,PrintAs->"\[ScriptX]"];
DefConstantSymbol[xAct`PSALTer`Private`YCoordinate,PrintAs->"\[ScriptY]"];
DefConstantSymbol[xAct`PSALTer`Private`ZCoordinate,PrintAs->"\[ScriptZ]"];
DefTensor[P[i],M4,PrintAs->"\[ScriptK]"];
AutomaticRules[P,MakeRule[{CD[-a][P[-b]],0},
	MetricOn->All,ContractMetrics->True],Verbose->False];
xAct`PSALTer`Private`ToV=MakeRule[{P[-i],Def V[-i]},MetricOn->All,ContractMetrics->True];
xAct`PSALTer`Private`ToP=MakeRule[{V[-i],P[-i]/Def},MetricOn->All,ContractMetrics->True];
$CVVerbose=True;
$DefInfoQ=True;

$DefInfoQ=False;
$CVVerbose=False;
DefBasis[cartesian,TangentM4,{0,1,2,3},BasisColor->RGBColor[0,1,0]];
DefConstantSymbol[En,PrintAs->"\[ScriptCapitalE]"];
DefConstantSymbol[Mo,PrintAs->"\[ScriptP]"];
AllComponentValues[P[{a,cartesian}],{En,0,0,Mo}];
AllComponentValues[P[{-a,-cartesian}],{En,0,0,-Mo}];
AllComponentValues[G[{a,cartesian},{b,cartesian}],DiagonalMatrix@{1,-1,-1,-1}];
AllComponentValues[G[{-a,-cartesian},{-b,-cartesian}],DiagonalMatrix@{1,-1,-1,-1}];
Off@ValidateSymbol::used;
Begin["xAct`PSALTer`Private`"];
(*
DefConstantSymbol[
	Symbol["X"<>ToString@#],
	PrintAs->"\!\(\*SubscriptBox[\(\[ScriptCapitalX]\), \("
		<>ColorString[ToString@#,RGBColor[1.,0.,1.]]<>"\)]\)",
	Dagger->Complex
]&/@Table[i,{i,100}];
DefConstantSymbol[
	Symbol["UniqueCoefficient"<>ToString@#],
	PrintAs->"\!\(\*SubscriptBox[\(\[ScriptCapitalC]\), \("
		<>ColorString[ToString@#,RGBColor[1.,0.,1.]]<>"\)]\)",
	Dagger->Complex
]&/@Table[i,{i,10000}];
DefConstantSymbol[
	Symbol["l"<>ToString@#],
	PrintAs->"\!\(\*SubscriptBox[\(\[ScriptL]\), \("
		<>ColorString[ToString@#,RGBColor[1.,0.,1.]]<>"\)]\)",
	Dagger->Complex
]&/@Table[i,{i,100}];
Table[DefConstantSymbol[
	Quiet@Symbol["r"<>ToString@i<>ToString@j],
	PrintAs->"\!\(\*SubscriptBox[\(\[ScriptR]\), \("<>ColorString[ToString@i<>ToString@j,RGBColor[1.,0.,1.]]<>"\)]\)",
	Dagger->Complex],{i,20},{j,20}];
Table[DefConstantSymbol[
	Quiet@Symbol["i"<>ToString@i<>ToString@j],
	PrintAs->"\!\(\*SubscriptBox[\(\[ScriptI]\), \("<>ColorString[ToString@i<>ToString@j,RGBColor[1.,0.,1.]]<>"\)]\)",
	Dagger->Complex],{i,20},{j,20}];
*)
End[];
On@ValidateSymbol::used;
DefConstantSymbol[PoleResidue,PrintAs->"\[Lambda]"];
$CVVerbose=True;
$DefInfoQ=True;
