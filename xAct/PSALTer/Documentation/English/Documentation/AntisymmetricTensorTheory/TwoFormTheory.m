(*=================*)
(*  TwoFormTheory  *)
(*=================*)

Subsection@"Massless two-form theory";
Comment@"We now examine two-form electrodynamics.";
LinearisedLagrangian=Coupling1*Antisymmetrize[CD[-a]@TwoFormField[-b,-c],{-a,-b,-c}]*CD[a]@TwoFormField[b,c];
DisplayExpression[LinearisedLagrangian,EqnLabel->"TwoFormEectrodynamics"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"TwoFormEectrodynamics",
		Method->"Easy",
		MaxLaurentDepth->1
	];
];
Comment@"This result matches the literature.";
