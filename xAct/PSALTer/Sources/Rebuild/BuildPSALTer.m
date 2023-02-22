(*================*)
(*  BuildPSALTer  *)
(*================*)

xAct`PSALTer`Private`PSymb="\[ScriptK]";
DefConstantSymbol[Def,PrintAs->xAct`PSALTer`Private`PSymb];

DefTensor[P[i],M4,PrintAs->xAct`PSALTer`Private`PSymb];
AutomaticRules[P,MakeRule[{CD[-a][P[-b]],0},MetricOn->All,ContractMetrics->True]];
ToV=MakeRule[{P[-i],Def V[-i]},MetricOn->All,ContractMetrics->True];
ToP=MakeRule[{V[-i],P[-i]/Def},MetricOn->All,ContractMetrics->True];

xAct`PSALTer`Private`BuildRebuild@"Lightcone.m";

(*=========================*)
(*  Import theory classes  *)
(*=========================*)

xAct`PSALTer`Private`BuildRebuild@"PGT.m";

DefClass[
	"PGT",
	xAct`PSALTer`Private`FieldSpinParityTensorHeadsPGT,
	xAct`PSALTer`Private`SourceSpinParityTensorHeadsPGT,
	xAct`PSALTer`Private`EngineeringDimensionsPGT,
	xAct`PSALTer`Private`DecomposeFieldsPGT,
	xAct`PSALTer`Private`FourierDecomposePGT,
	xAct`PSALTer`Private`FirstSpeciousFunctionPGT,
	xAct`PSALTer`Private`SecondSpeciousFunctionPGT,
	xAct`PSALTer`Private`ThirdSpeciousFunctionPGT,
ExportClass->True];
