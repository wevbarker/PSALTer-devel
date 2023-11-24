(*=====================*)
(*  SquareRicciTheory  *)
(*=====================*)

Section@"Zell's square Ricci theory";

Comment@{"We need to see what happens when we try the square of the Ricci tensor."};
LinearisedLagrangian=-xAct`PSALTer`TensorTheory`Coupling1*(
	CD[-a]@CD[-b]@LinearMetric[a,b]
	-CD[-a]@CD[a]@LinearMetric[-b,b]	
)*(
	CD[-c]@CD[-d]@LinearMetric[c,d]
	-CD[-c]@CD[c]@LinearMetric[-d,d]	
);
DisplayExpression[LinearisedLagrangian,EqnLabel->"SquareRicciTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"TensorTheory",
	TheoryName->"SquareRicciTheory",	
	Method->"Easy",
	MaxLaurentDepth->3
];
Comment@{"Some comment can be made."};
