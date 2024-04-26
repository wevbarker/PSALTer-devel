(*=================*)
(*  AppendToField  *)
(*=================*)

AppendToField[InputField_,AssocKey_,InputValue_]:=Module[{
	FieldAssociationValue},

	(!(AssociationQ@Evaluate@FieldAssociation@InputField))~If~(FieldAssociation@InputField^=<||>);
	FieldAssociationValue=Evaluate@FieldAssociation@InputField;
	Clear@InputField;
	FieldAssociationValue@AssocKey=InputValue;
	FieldAssociation@InputField^=FieldAssociationValue;
	Quiet@Catch@DistributeDefinitions@InputField;
];
