(*=====================*)
(*  SquareRicciTheory  *)
(*=====================*)

Subsection@"Pure Ricci-square theory";
Comment@{"We build a theory out of the square of the Ricci tensor."};
LinearisedLagrangian=-Coupling1*(
	CD[-a]@CD[-b]@MetricPerturbation[a,b]
	-CD[-a]@CD[a]@MetricPerturbation[-b,b]	
)*(
	CD[-c]@CD[-d]@MetricPerturbation[c,d]
	-CD[-c]@CD[c]@MetricPerturbation[-d,d]	
);
DisplayExpression[LinearisedLagrangian,EqnLabel->"SquareRicciTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"SquareRicciTheory",	
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
Comment@{"The empty spectrum is consistent with the literature."};
