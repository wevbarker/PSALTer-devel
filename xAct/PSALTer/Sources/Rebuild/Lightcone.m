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
(*DEPRECIATED*)
(*
AllComponentValues[Tau[{-a,-cartesian},{-b,-cartesian}]];
AllComponentValues[Evaluate@Dagger@Tau[{-a,-cartesian},{-b,-cartesian}]];

AllComponentValues[Sigma[{-a,-cartesian},{-b,-cartesian},{-c,-cartesian}]];
AllComponentValues[Evaluate@Dagger@Sigma[{-a,-cartesian},{-b,-cartesian},{-c,-cartesian}]];

(AllComponentValues@FreeToBasis[cartesian]@#;)&/@{TauP1p[a,b],SigmaP1p[a,b],SigmaPerp1p[a,b],TauP1m[a],SigmaP1m[a],TauPerp1m[a],SigmaPerp1m[a],TauP2p[a,b],SigmaP2p[a,b],SigmaP2m[a,b,c],TauP1p[-a,-b],SigmaP1p[-a,-b],SigmaPerp1p[-a,-b],TauP1m[-a],SigmaP1m[-a],TauPerp1m[-a],SigmaPerp1m[-a],TauP2p[-a,-b],SigmaP2p[-a,-b],SigmaP2m[-a,-b,-c]};
*)

DefClass["PGT",xAct`PSALTer`Private`FieldSpinParityTensorHeadsPGT,xAct`PSALTer`Private`SourceSpinParityTensorHeadsPGT,xAct`PSALTer`Private`EngineeringDimensionsPGT,xAct`PSALTer`Private`DecomposeFieldsPGT,xAct`PSALTer`Private`FourierDecomposePGT,ExportClass->True];

DefConstantSymbol[
	Symbol["X"<>ToString@#],
	PrintAs->"\!\(\*SubscriptBox[\(\[ScriptCapitalX]\), \("
		<>ColorString[ToString@#,RGBColor[1.,0.,1.]]<>"\)]\)",
	Dagger->Complex
]&/@Table[i,{i,100}];
