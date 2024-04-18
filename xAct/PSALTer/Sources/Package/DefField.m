(*============*)
(*  DefField  *)
(*============*)

DefField::UnstudiedKinetics="The SO(3) decomposition of tensors with indices `1` and symmetry `2` has not yet been implemented in PSALTer.";

Options@DefField={PrintAs->"\[Zeta]",PrintSourceAs->"\[ScriptJ]"};

DefField[InputField_[Inds___],InputKinematics_,Opts___?OptionQ]:=DefField[InputField[Inds],InputKinematics,GenSet[],Opts];

DefField[InputField_[Inds___],InputKinematics_,SymmExpr_,OptionsPattern[]]:=Module[{
	Rank=Length@{Inds},
	Type=Head@SymmExpr,
	Pair=First/@(First/@(Position[{Inds},#]&/@(Identity@@SymmExpr)))
	},
	Print@Rank;
	Print@Type;
	Print@Pair;

	DefTensor[InputField@Inds,M4,SymmExpr,PrintAs->OptionValue@PrintAs];
	DefTensor[(ToExpression@("ConjugateSource"<>ToString@InputField))@Inds,M4,SymmExpr,PrintAs->OptionValue@PrintSourceAs];

	Which[
		(Rank==0),
		InputField[]~RegisterFieldRank0~InputKinematics,
		(Rank==1),
		InputField[-a]~RegisterFieldRank1~InputKinematics,
		(Rank==2)&&(Type==GenSet),
		InputField[-a,-b]~RegisterFieldRank2~InputKinematics,
		(Rank==2)&&(Type==Antisymmetric),
		InputField[-a,-b]~RegisterFieldRank2Antisymmetric~InputKinematics,
		(Rank==2)&&(Type==Symmetric),
		InputField[-a,-b]~RegisterFieldRank2Symmetric~InputKinematics,
		(Rank==3)&&(Type==GenSet),
		InputField[-a,-b,-c]~RegisterFieldRank3~InputKinematics,
		(Rank==3)&&(Type==Antisymmetric)&&((Pair=={1,2})||(Pair=={2,1})),
		InputField[-a,-b,-c]~RegisterFieldRank3Antisymmetric~InputKinematics,
		(Rank==3)&&(Type==Antisymmetric)&&((Pair=={1,3})||(Pair=={3,1})),
		InputField[-a,-c,-b]~RegisterFieldRank3Antisymmetric~InputKinematics,
		(Rank==3)&&(Type==Antisymmetric)&&((Pair=={2,3})||(Pair=={3,2})),
		InputField[-c,-a,-b]~RegisterFieldRank3Antisymmetric~InputKinematics,
		(Rank==3)&&(Type==Symmetric)&&((Pair=={1,2})||(Pair=={2,1})),
		InputField[-a,-b,-c]~RegisterFieldRank3Symmetric~InputKinematics,
		(Rank==3)&&(Type==Symmetric)&&((Pair=={1,3})||(Pair=={3,1})),
		InputField[-a,-c,-b]~RegisterFieldRank3Symmetric~InputKinematics,
		(Rank==3)&&(Type==Symmetric)&&((Pair=={2,3})||(Pair=={3,2})),
		InputField[-c,-a,-b]~RegisterFieldRank3Symmetric~InputKinematics,
		True,
		Throw@Message[DefField::UnstudiedKinetics,{Inds},SymmExpr]
	];
];
