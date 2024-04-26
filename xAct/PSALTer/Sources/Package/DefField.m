(*============*)
(*  DefField  *)
(*============*)

BuildPackage@"DefField/AppendToField.m";
BuildPackage@"DefField/DefSO3Irrep.m";
BuildPackage@"DefField/RegisterFieldRank0.m";
BuildPackage@"DefField/RegisterFieldRank1.m";
BuildPackage@"DefField/RegisterFieldRank2Antisymmetric.m";
BuildPackage@"DefField/RegisterFieldRank2Symmetric.m";
BuildPackage@"DefField/RegisterFieldRank3.m";
BuildPackage@"DefField/RegisterFieldRank3Antisymmetric.m";
BuildPackage@"DefField/RegisterFieldRank3Symmetric.m";

DefField::UnstudiedKinetics="The SO(3) decomposition of tensors with indices `1` and symmetry `2` has not yet been implemented in PSALTer.";

Options@DefField={PrintAs->"\[Zeta]",PrintSourceAs->"\[ScriptJ]"};

DefField[InputField_[Inds___],Opts___?OptionQ]:=DefField[InputField[Inds],GenSet[],Opts];

DefField[InputField_[Inds___],SymmExpr_,OptionsPattern[]]:=Module[{
	Rank=Length@{Inds},
	Type=Head@SymmExpr,
	Pair,
	FieldContext="xAct`PSALTer`"<>ToString@InputField<>"`"
	},

(*BeginPackage[FieldContext,{"xAct`PSALTer`","xAct`xPerm`","xAct`xCore`","xAct`xTras`","xAct`xCoba`","xAct`PSALTer`"}];*)

	If[Type==GenSet,Pair={},
		Pair=First/@(First/@(Position[{Inds},#]&/@(Identity@@SymmExpr))),
		Pair=First/@(First/@(Position[{Inds},#]&/@(Identity@@SymmExpr)))];

	DefTensor[InputField@Inds,M4,SymmExpr,PrintAs->OptionValue@PrintAs];
	DefTensor[(ToExpression@("Source"<>ToString@InputField))@Inds,M4,SymmExpr,PrintAs->OptionValue@PrintSourceAs];

	Begin[FieldContext<>"Private`"];
	Which[
		(Rank==0),
		RegisterFieldRank0[InputField[],
			PrintAs->OptionValue@PrintAs,
			PrintSourceAs->OptionValue@PrintSourceAs],
		(Rank==1),
		RegisterFieldRank1[InputField[-a],
			PrintAs->OptionValue@PrintAs,
			PrintSourceAs->OptionValue@PrintSourceAs],
		(Rank==2)&&(Type==GenSet),
		RegisterFieldRank2[InputField[-a,-b],
			PrintAs->OptionValue@PrintAs,
			PrintSourceAs->OptionValue@PrintSourceAs],
		(Rank==2)&&(Type==Antisymmetric),
		RegisterFieldRank2Antisymmetric[InputField[-a,-b],
			PrintAs->OptionValue@PrintAs,
			PrintSourceAs->OptionValue@PrintSourceAs],
		(Rank==2)&&(Type==Symmetric),
		RegisterFieldRank2Symmetric[InputField[-a,-b],
			PrintAs->OptionValue@PrintAs,
			PrintSourceAs->OptionValue@PrintSourceAs],
		(Rank==3)&&(Type==GenSet),
		RegisterFieldRank3[InputField[-a,-b,-c],
			PrintAs->OptionValue@PrintAs,
			PrintSourceAs->OptionValue@PrintSourceAs],
		(Rank==3)&&(Type==Antisymmetric)&&((Pair=={1,2})||(Pair=={2,1})),
		RegisterFieldRank3Antisymmetric[InputField[-a,-b,-c],
			PrintAs->OptionValue@PrintAs,
			PrintSourceAs->OptionValue@PrintSourceAs],
		(Rank==3)&&(Type==Antisymmetric)&&((Pair=={1,3})||(Pair=={3,1})),
		RegisterFieldRank3Antisymmetric[InputField[-a,-c,-b],
			PrintAs->OptionValue@PrintAs,
			PrintSourceAs->OptionValue@PrintSourceAs],
		(Rank==3)&&(Type==Antisymmetric)&&((Pair=={2,3})||(Pair=={3,2})),
		RegisterFieldRank3Antisymmetric[InputField[-c,-a,-b],
			PrintAs->OptionValue@PrintAs,
			PrintSourceAs->OptionValue@PrintSourceAs],
		(Rank==3)&&(Type==Symmetric)&&((Pair=={1,2})||(Pair=={2,1})),
		RegisterFieldRank3Symmetric[InputField[-a,-b,-c],
			PrintAs->OptionValue@PrintAs,
			PrintSourceAs->OptionValue@PrintSourceAs],
		(Rank==3)&&(Type==Symmetric)&&((Pair=={1,3})||(Pair=={3,1})),
		RegisterFieldRank3Symmetric[InputField[-a,-c,-b],
			PrintAs->OptionValue@PrintAs,
			PrintSourceAs->OptionValue@PrintSourceAs],
		(Rank==3)&&(Type==Symmetric)&&((Pair=={2,3})||(Pair=={3,2})),
		RegisterFieldRank3Symmetric[InputField[-c,-a,-b],
			PrintAs->OptionValue@PrintAs,
			PrintSourceAs->OptionValue@PrintSourceAs],
		True,
		Throw@Message[DefField::UnstudiedKinetics,{Inds},SymmExpr]
	];
(*
	End[];
	EndPackage[];
*)
];
