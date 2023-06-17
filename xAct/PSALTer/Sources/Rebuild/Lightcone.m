(*=============*)
(*  Lightcone  *)
(*=============*)

DefBasis[cartesian,TangentM4,{0,1,2,3},BasisColor->RGBColor[0,1,0]];

xAct`PSALTer`Private`EnSymb="\[ScriptCapitalE]";
DefConstantSymbol[En,PrintAs->xAct`PSALTer`Private`SymbolBuild@xAct`PSALTer`Private`EnSymb];

xAct`PSALTer`Private`MoSymb="\[ScriptP]";
DefConstantSymbol[Mo,PrintAs->xAct`PSALTer`Private`SymbolBuild@xAct`PSALTer`Private`MoSymb];

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
