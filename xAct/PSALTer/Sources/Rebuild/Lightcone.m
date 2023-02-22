(*=============*)
(*  Lightcone  *)
(*=============*)

DefBasis[cartesian,TangentM4,{0,1,2,3},BasisColor->RGBColor[0,1,0]];

EnSymb="\[ScriptCapitalE]";
DefConstantSymbol[En,PrintAs->xAct`HiGGS`Private`SymbolBuild@EnSymb];

MoSymb="\[ScriptP]";
DefConstantSymbol[Mo,PrintAs->xAct`HiGGS`Private`SymbolBuild@MoSymb];

AllComponentValues[P[{a,cartesian}],{En,0,0,Mo}];
AllComponentValues[P[{-a,-cartesian}],{En,0,0,-Mo}];

AllComponentValues[G[{a,cartesian},{b,cartesian}],DiagonalMatrix@{1,-1,-1,-1}];
AllComponentValues[G[{-a,-cartesian},{-b,-cartesian}],DiagonalMatrix@{1,-1,-1,-1}];

DefConstantSymbol[
	Symbol["X"<>ToString@#],
	PrintAs->"\!\(\*SubscriptBox[\(\[ScriptCapitalX]\), \("
		<>ColorString[ToString@#,RGBColor[1.,0.,1.]]<>"\)]\)",
	Dagger->Complex
]&/@Table[i,{i,100}];
