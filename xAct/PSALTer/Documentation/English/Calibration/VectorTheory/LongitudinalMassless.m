(*========================*)
(*  LongitudinalMassless  *)
(*========================*)

Section@"Pure longutudinal massless";

Comment@"Now we try working purely with the longitudinal theory.";

LinearisedLagrangian=Coupling2*CD[-a]@xAct`PSALTer`VectorTheory`B[a]*CD[-b]@xAct`PSALTer`VectorTheory`B[b];
DisplayExpression@LinearisedLagrangian;

LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;

ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"VectorTheory",
	TheoryName->"LongitudinalMassless",	
	Method->"Easy",
	MaxLaurentDepth->3
];

Comment@"Comment.";
