(*============*)
(*  DefField  *)
(*============*)

BuildPackage@"DefField/AppendToField.m";
BuildPackage@"DefField/DefFiducialField.m";
BuildPackage@"DefField/DefSO3Irrep.m";
BuildPackage@"DefField/CombineRules.m";
BuildPackage@"DefField/SummariseField.m";

Off[Set::write];
Off[SetDelayed::write];

Options@DefFieldActual={PrintAs->"\[Zeta]",PrintSourceAs->"\[ScriptJ]"};

DefField::UnstudiedKinetics="The SO(3) decomposition of tensors with indices `1` and symmetry `2` has not yet been implemented in PSALTer.";

DefFieldActual[InputField_[Inds___],Opts___?OptionQ]:=DefFieldActual[InputField[Inds],GenSet[],Opts];
DefFieldActual[InputField_[Inds___],SymmExpr_,OptionsPattern[]]:=Module[{
	Rank=Length@{Inds},
	Type=Head@SymmExpr,
	Pair,
	FieldContext="xAct`PSALTer`"<>ToString@InputField<>"`"
	},

	If[Type==GenSet,Pair={},
		Pair=First/@(First/@(Position[{Inds},#]&/@(Identity@@SymmExpr))),
		Pair=First/@(First/@(Position[{Inds},#]&/@(Identity@@SymmExpr)))];
	DefTensor[InputField@Inds,
		M4,SymmExpr,PrintAs->OptionValue@PrintAs];
	DefTensor[(ToExpression@("Source"<>ToString@InputField))@Inds,
		M4,SymmExpr,PrintAs->OptionValue@PrintSourceAs];
	PrintAsValue=OptionValue@PrintAs;
	PrintSourceAsValue=OptionValue@PrintSourceAs;

	Begin[FieldContext];
	Which[
		(Rank===0),
		BuildPackage@"DefField/RegisterFieldRank0.m",
		(Rank===1),
		BuildPackage@"DefField/RegisterFieldRank1.m",
		(Rank===2)&&(Type===GenSet),
		BuildPackage@"DefField/RegisterFieldRank2.m",
		(Rank===2)&&(Type===Antisymmetric),
		BuildPackage@"DefField/RegisterFieldRank2Antisymmetric.m",
		(Rank===2)&&(Type===Symmetric),
		BuildPackage@"DefField/RegisterFieldRank2Symmetric.m",
		(Rank===3)&&(Type===GenSet),
		BuildPackage@"DefField/RegisterFieldRank3.m",
		(Rank===3)&&(Type===Antisymmetric)&&((Pair==={1,2})||(Pair==={2,1})),
		BuildPackage@"DefField/RegisterFieldRank3Antisymmetric.m",
		(Rank===3)&&(Type===Antisymmetric)&&((Pair==={1,3})||(Pair==={3,1})),
		BuildPackage@"DefField/RegisterFieldRank3Antisymmetric.m",
		(Rank===3)&&(Type===Antisymmetric)&&((Pair==={2,3})||(Pair==={3,2})),
		BuildPackage@"DefField/RegisterFieldRank3Antisymmetric.m",
		(Rank===3)&&(Type===Symmetric)&&((Pair==={1,2})||(Pair==={2,1})),
		BuildPackage@"DefField/RegisterFieldRank3Symmetric.m",
		(Rank===3)&&(Type===Symmetric)&&((Pair==={1,3})||(Pair==={3,1})),
		BuildPackage@"DefField/RegisterFieldRank3Symmetric.m",
		(Rank===3)&&(Type===Symmetric)&&((Pair==={2,3})||(Pair==={3,2})),
		BuildPackage@"DefField/RegisterFieldRank3Symmetric.m",
		True,
		Throw@Message[DefField::UnstudiedKinetics,{Inds},SymmExpr]
	];
	SummariseField[];
	End[];
];
On[Set::write];
On[SetDelayed::write];

Unprotect@DefField;
Options@DefField={PrintAs->"\[Zeta]",PrintSourceAs->"\[ScriptJ]"};
DefField[InputField_[Inds___],Opts___?OptionQ]:=DefField[InputField[Inds],GenSet[],Opts];
DefField[InputField_[Inds___],SymmExpr_,Opts:OptionsPattern[]]:=If[$Disabled,
	DefTensor[InputField[Inds],M4,SymmExpr,PrintAs->OptionValue@PrintAs],
	DefFieldActual[InputField[Inds],SymmExpr,Opts]
];
Protect@DefField;
