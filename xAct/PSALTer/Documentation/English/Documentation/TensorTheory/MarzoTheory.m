(*===============*)
(*  MarzoTheory  *)
(*===============*)

Subsection@"Marzo theory";
Comment@{"There is a specific deformation of",Cref@"FierzPauliTheory",", which also appears to constitute a viable linear model. This model was first proposed by Carlo Marzo in unpublished correspondence."};
LinearisedLagrangian=-Coupling1*(
	2*CD[-c]@LinearMetric[a,b]*CD[-b]@LinearMetric[-a,c]
	-CD[-c]@LinearMetric[a,b]*CD[c]@LinearMetric[-a,-b]
	-CD[-c]@LinearMetric[a,-a]*CD[c]@LinearMetric[b,-b]
);
DisplayExpression[LinearisedLagrangian,EqnLabel->"MarzoTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"MarzoTheory",	
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
Comment@{"This model appears to be viable."};
