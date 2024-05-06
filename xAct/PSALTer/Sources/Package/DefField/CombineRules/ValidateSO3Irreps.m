(*=====================*)
(*  ValidateSO3Irreps  *)
(*=====================*)

BuildPackage@"DefField/CombineRules/ValidateSO3Irreps/ValidateTraceless.m";
BuildPackage@"DefField/CombineRules/ValidateSO3Irreps/ValidateSpatial.m";
BuildPackage@"DefField/CombineRules/ValidateSO3Irreps/ValidateInverseField.m";
BuildPackage@"DefField/CombineRules/ValidateSO3Irreps/ValidateSymmetryField.m";
BuildPackage@"DefField/CombineRules/ValidateSO3Irreps/ValidateInverseMode.m";
BuildPackage@"DefField/CombineRules/ValidateSO3Irreps/ValidateSymmetryMode.m";

ValidateSO3Irreps[]:=Catch@Module[{
	Class,
	FieldSpinParityTensorHeadsValue,
	ListOfModes},

	Class=FieldAssociation@Context[];

	DecomposeAndExpandFields[InputExpr_]:=Catch@Module[{
		Fundamental=InputExpr,
		Decomposed,
		Expanded
		},

		Fundamental//=ToIndexFree;
		Fundamental//=FromIndexFree;
		Decomposed=Fundamental//(Class@DecomposeFields);
		Expanded=Decomposed//(Class@ExpandFields);

		ValidateInverseField[InputExpr,Expanded,Fundamental];
		ValidateSymmetryField[InputExpr,Decomposed,Fundamental];
	];

	ExpandAndDecomposeFields[InputExpr_]:=Catch@Module[{
		Reduced=InputExpr,
		Decomposed,
		Expanded
		},

		Reduced//=ToIndexFree;
		Reduced//=FromIndexFree;
		Expanded=Reduced//(Class@ExpandFields);
		Decomposed=Expanded//(Class@DecomposeFields);

		ValidateSpatial[InputExpr,Expanded];
		ValidateTraceless[InputExpr,Expanded];
		ValidateInverseMode[InputExpr,Decomposed,Reduced];
		ValidateSymmetryMode[InputExpr,Expanded,Reduced];
	];

	FieldSpinParityTensorHeadsValue=Class@FieldSpinParityTensorHeads;
	ListOfModes=Flatten/@(Values/@(Values/@FieldSpinParityTensorHeadsValue));

	Off[General::stop];

	(
		DecomposeAndExpandFields@Tensor;
		ExpandAndDecomposeFields/@(ListOfModes@Tensor);
	)~Table~{Tensor,Class@Tensors};

	On[General::stop];
];
