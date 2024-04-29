(*=======================*)
(*  CombineAssociations  *)
(*=======================*)

BuildPackage@"ParticleSpectrum/CombineAssociations/GenerateAnsatz.m";
BuildPackage@"ParticleSpectrum/CombineAssociations/NormaliseRescalings.m";
BuildPackage@"ParticleSpectrum/CombineAssociations/CacheContexts.m";

CombineAssociations[Lagrangian_,TheoryContext_]:=Module[{
		Expr=Lagrangian,
		LagrangianCouplingsValue,
		FieldSpinParityTensorHeadsValue,
		SourceSpinParityTensorHeadsValue,
		FieldToFiducialFieldValue,
		ExpandFieldsRulesValue,
		ExpandSourcesRulesValue
		},

	Expr=Expr/.{Plus->List};
	(!(ListQ@Expr))~If~(Expr//=List);
	Expr//=ToIndexFree;
	Expr=Expr/.{CD->Identity,IndexFree->Identity};
	Expr=Expr.Table[0.1*ii,{ii,Length@Expr}];
	Expr//=Variables;	
	Expr//=DeleteDuplicates;

	LagrangianCouplingsValue=DeleteCases[Expr,_?xTensorQ];
	AppendToField[TheoryContext,LagrangianCouplings,LagrangianCouplingsValue];

	Expr=Expr~DeleteElements~LagrangianCouplingsValue;
	Expr=ToString/@Expr;
	Expr=("xAct`PSALTer`"<>#<>"`")&/@Expr;

	$AllFieldContexts=Expr;

	Expr=FieldAssociation/@Expr;
	
	FieldSpinParityTensorHeadsValue=(#@FieldSpinParityTensorHeads)&/@Expr;
	FieldSpinParityTensorHeadsValue=FieldSpinParityTensorHeadsValue~Merge~Total;
	AppendToField[TheoryContext,FieldSpinParityTensorHeads,FieldSpinParityTensorHeadsValue];

	SourceSpinParityTensorHeadsValue=(#@SourceSpinParityTensorHeads)&/@Expr;
	SourceSpinParityTensorHeadsValue=SourceSpinParityTensorHeadsValue~Merge~Total;
	AppendToField[TheoryContext,SourceSpinParityTensorHeads,SourceSpinParityTensorHeadsValue];

	FieldToFiducialFieldValue=(#@FieldToFiducialField)&/@Expr;
	FieldToFiducialFieldValue//=Flatten;
	AppendToField[TheoryContext,FieldToFiducialField,FieldToFiducialFieldValue];

	ExpandFieldsRulesValue=(#@ExpandFieldsRules)&/@Expr;
	ExpandFieldsRulesValue//=Flatten;
	AppendToField[TheoryContext,ExpandFieldsRules,ExpandFieldsRulesValue];

	ExpandSourcesRulesValue=(#@ExpandSourcesRules)&/@Expr;
	ExpandSourcesRulesValue//=Flatten;
	AppendToField[TheoryContext,ExpandSourcesRules,ExpandSourcesRulesValue];

	DecomposeFieldsRulesValue=(#@DecomposeFieldsRules)&/@Expr;
	DecomposeFieldsRulesValue//=Flatten;
	AppendToField[TheoryContext,DecomposeFieldsRules,DecomposeFieldsRulesValue];

	TensorsValue=(#@Tensors)&/@Expr;
	TensorsValue//=Flatten;
	AppendToField[TheoryContext,Tensors,TensorsValue];

	SourcesValue=(#@Sources)&/@Expr;
	SourcesValue//=Flatten;
	AppendToField[TheoryContext,Sources,SourcesValue];

	SpinsValue=(#@Spins)&/@Expr;
	SpinsValue//=Flatten;
	SpinsValue//=DeleteDuplicates;
	SpinsValue//=Sort;
	AppendToField[TheoryContext,Spins,SpinsValue];

	ExpandFieldsValue[InputExpr_]:=Module[{Expr=InputExpr},
		Expr=Expr/.ExpandFieldsRulesValue;
		Expr//=xAct`PSALTer`Private`ToNewCanonical;
		Expr//=CollectTensors;
	Expr];

	ExpandSourcesValue[InputExpr_]:=Module[{Expr=InputExpr},
		Expr=Expr/.ExpandSourcesRulesValue;
		Expr//=xAct`PSALTer`Private`ToNewCanonical;
	Expr];

	DecomposeFieldsValue[InputExpr_]:=Module[{Expr=InputExpr},
		Expr//=xAct`PSALTer`Private`ToNewCanonical;
		Expr=Expr/.DecomposeFieldsRulesValue;
		Expr//=xAct`PSALTer`Private`ToNewCanonical;
		Expr//=CollectTensors;
	Expr];

	AppendToField[TheoryContext,ExpandFields,ExpandFieldsValue];
	AppendToField[TheoryContext,ExpandSources,ExpandSourcesValue];
	AppendToField[TheoryContext,DecomposeFields,DecomposeFieldsValue];

	GenerateAnsatz@TheoryContext;
	NormaliseRescalings@TheoryContext;

	ClassName=FieldAssociation@TheoryContext;	

	CacheContexts[];
];
