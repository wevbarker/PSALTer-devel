(*===============*)
(*  MarzoTheory  *)
(*===============*)

Section@"Marzo theory";

Comment@"On the 21st of August, Carlo emailed to me, the following gravity. (This nearly rhymes)";

LinearisedLagrangian=-xAct`PSALTer`TensorTheory`Coupling1*(
	2*CD[-c]@LinearMetric[a,b]*CD[-b]@LinearMetric[-a,c]
	-CD[-c]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-b]
	-CD[-c]@LinearMetric[a,-a]*CD[c]@LinearMetric[b,-b]
);

DisplayExpression@LinearisedLagrangian;

LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;

ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"TensorTheory",
	TheoryName->"MarzoTheory",	
	Method->"Easy",
	MaxLaurentDepth->3
];

Comment@"What do we see?";
