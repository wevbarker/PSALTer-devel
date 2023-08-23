(*=======================*)
(*  LongitudinalMassive  *)
(*=======================*)

Section@"Pure longitudinal massive";

Comment@"Add a mass term, this makes the theory identical to that studied by Sebastian in his email of last week.";

LinearisedLagrangian=Coupling2*CD[-a]@xAct`PSALTer`VectorTheory`B[a]*CD[-b]@xAct`PSALTer`VectorTheory`B[b]+Coupling3*xAct`PSALTer`VectorTheory`B[-a]*xAct`PSALTer`VectorTheory`B[a];
DisplayExpression@LinearisedLagrangian;

LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;

ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"VectorTheory",
	TheoryName->"LongitudinalMassive",	
	Method->"Easy",
	MaxLaurentDepth->3
];

Comment@"The theory propagates a single, healthy massive scalar.";
