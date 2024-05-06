(*=============*)
(*  Lightcone  *)
(*=============*)

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
End[];
On@ValidateSymbol::used;
DefConstantSymbol[PoleResidue,PrintAs->"\[Lambda]"];
$CVVerbose=True;
$DefInfoQ=True;
