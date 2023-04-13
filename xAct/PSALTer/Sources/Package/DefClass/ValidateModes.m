(*=================*)
(*  ValidateModes  *)
(*=================*)

ValidateModes[ClassName_?StringQ]:=Catch@Module[{
	Class,
	FieldSpinParityTensorHeadsValue,
	ListOfModes
	},

	Class=Evaluate@Symbol@ClassName;

	DecomposeAndExpandFields[InputExpr_]:=Module[{Expr=InputExpr},
		Print[" ** DefClass: expanding fundamental field "<>(ToString@Expr)<>" into reduced-index modes and decomposing reduced-index modes back into fundamental fields (should return original)."];
		Expr//=ToIndexFree;
		Expr//=FromIndexFree;
		Print@Expr;
		Expr//=(Class@DecomposeFields);
		Print@Expr;
		Expr//=(Class@ExpandFields);
		Print@Expr;
	];

	ExpandAndDecomposeFields[InputExpr_]:=Module[{Expr=InputExpr},
		Print[" ** DefClass: expanding reduced-index mode "<>(ToString@Expr)<>" into fundamental field and decomposing fundamental field back into reduced-index modes (should return original)."];
		Expr//=ToIndexFree;
		Expr//=FromIndexFree;
		Print@Expr;
		Expr//=(Class@ExpandFields);
		Print@Expr;
		Expr//=(Class@DecomposeFields);
		Print@Expr;
	];

	FieldSpinParityTensorHeadsValue=Class@FieldSpinParityTensorHeads;
	ListOfModes=Flatten/@(Values/@(Values/@FieldSpinParityTensorHeadsValue));

	(
		DecomposeAndExpandFields@Tensor;
		ExpandAndDecomposeFields/@(ListOfModes@Tensor);
	)~Table~{Tensor,Class@Tensors};
(*
	SourceSpinParityTensorHeadsValue=Class@SourceSpinParityTensorHeads;
	ListOfModes=Flatten/@(Values/@(Values/@SourceSpinParityTensorHeadsValue));

	(
		DecomposeAndExpandFields@Source;
		ExpandAndDecomposeFields/@(ListOfModes@Source);
	)~Table~{Source,Class@Sources};
*)
];
