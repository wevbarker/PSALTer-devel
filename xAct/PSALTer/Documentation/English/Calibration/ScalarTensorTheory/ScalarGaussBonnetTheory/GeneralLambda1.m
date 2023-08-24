(*==================*)
(*  GeneralLambda1  *)
(*==================*)

LinearisedLagrangian=GeneralLinearisedLagrangian/.{Pw->1};
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
DisplayExpression@LinearisedLagrangian;

ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"ScalarTensorTheory",
	TheoryName->"ScalarGaussBonnetTheory",
	Method->"Easy",
	MaxLaurentDepth->3
];

Comment@"Some comment.";
