(*======================*)
(*  AppendToKinematics  *)
(*======================*)

AppendToKinematics[InputKinematics_,AssocKey_,InputValue_]:=Module[{
	KinematicsAssociationValue},

	(!(AssociationQ@Evaluate@KinematicsAssociation@InputKinematics))~If~(KinematicsAssociation@InputKinematics^=<||>);
	KinematicsAssociationValue=Evaluate@KinematicsAssociation@InputKinematics;
	Clear@InputKinematics;
	KinematicsAssociationValue@AssocKey=InputValue;
	KinematicsAssociation@InputKinematics^=KinematicsAssociationValue;
	Quiet@Catch@DistributeDefinitions@InputKinematics;
];
