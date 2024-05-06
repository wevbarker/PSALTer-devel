(*================*)
(*  CombineRules  *)
(*================*)

BuildPackage@"DefField/CombineRules/DefSummary.m";
BuildPackage@"DefField/CombineRules/ValidateSO3Irreps.m";
BuildPackage@"DefField/CombineRules/DefAllComponentValues.m";

CombineRules[ExpandFieldsRulesInput_,
		ExpandSourcesRulesInput_,
		DecomposeFieldsRulesInput_]:=Module[{
		ExpandFieldsValue,
		ExpandSourcesValue,
		DecomposeFieldsValue},

	AppendToField[Context[],ExpandFieldsRules,ExpandFieldsRulesInput];
	AppendToField[Context[],ExpandSourcesRules,ExpandSourcesRulesInput];
	AppendToField[Context[],DecomposeFieldsRules,DecomposeFieldsRulesInput];

	ExpandFieldsValue[InputExpr_]:=Module[{Expr=InputExpr},
		Expr=Expr/.ExpandFieldsRulesInput;
		Expr//=xAct`PSALTer`Private`ToNewCanonical;
		Expr//=CollectTensors;
	Expr];

	ExpandSourcesValue[InputExpr_]:=Module[{Expr=InputExpr},
		Expr=Expr/.ExpandSourcesRulesInput;
		Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr];

	DecomposeFieldsValue[InputExpr_]:=Module[{Expr=InputExpr},
		Expr//=xAct`PSALTer`Private`ToNewCanonical;
		Expr=Expr/.DecomposeFieldsRulesInput;
		Expr//=xAct`PSALTer`Private`ToNewCanonical;
		Expr//=CollectTensors;
	Expr];

	AppendToField[Context[],ExpandFields,ExpandFieldsValue];
	AppendToField[Context[],ExpandSources,ExpandSourcesValue];
	AppendToField[Context[],DecomposeFields,DecomposeFieldsValue];

	DefSummary[];
	ValidateSO3Irreps[];
	DefAllComponentValues[];
];
