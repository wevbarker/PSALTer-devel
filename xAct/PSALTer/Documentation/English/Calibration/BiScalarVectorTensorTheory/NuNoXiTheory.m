(*================*)
(*  NuNoXiTheory  *)
(*================*)

Section@"With Nu and no Xi";

NewLinearisedLagrangian=LinearisedLagrangian/.{xAct`PSALTer`BiScalarVectorTensorTheory`CouplingXi->0};
DisplayExpression[NewLinearisedLagrangian,EqnLabel->"NuNoXiTheory"];
ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"BiScalarVectorTensorTheory",
	TheoryName->"NuNoXiTheory",	
	Method->"Easy",
	MaxLaurentDepth->3
];
Comment@"Some comment can be made.";
