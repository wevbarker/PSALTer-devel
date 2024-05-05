(*=============*)
(*  Foliation  *)
(*=============*)

$DefInfoQ=False;
$CVVerbose=False;
DefTensor[V[-a],M4,PrintAs->"\[ScriptN]"];
AutomaticRules[V,MakeRule[{V[-a]V[a],1}],Verbose->False];
DefConstantSymbol[Def,PrintAs->"\[ScriptK]"];
DefConstantSymbol[xAct`PSALTer`Private`DefSquared,PrintAs->"\[ScriptX]"];
DefConstantSymbol[Action,PrintAs->"\[ScriptCapitalS]"];
DefConstantSymbol[xAct`PSALTer`Private`TCoordinate,PrintAs->"\[ScriptT]"];
DefConstantSymbol[xAct`PSALTer`Private`XCoordinate,PrintAs->"\[ScriptX]"];
DefConstantSymbol[xAct`PSALTer`Private`YCoordinate,PrintAs->"\[ScriptY]"];
DefConstantSymbol[xAct`PSALTer`Private`ZCoordinate,PrintAs->"\[ScriptZ]"];
DefTensor[P[i],M4,PrintAs->"\[ScriptK]"];
AutomaticRules[P,MakeRule[{CD[-a][P[-b]],0},MetricOn->All,ContractMetrics->True],Verbose->False];
xAct`PSALTer`Private`ToV=MakeRule[{P[-i],Def V[-i]},MetricOn->All,ContractMetrics->True];
xAct`PSALTer`Private`ToP=MakeRule[{V[-i],P[-i]/Def},MetricOn->All,ContractMetrics->True];
$CVVerbose=True;
$DefInfoQ=True;
