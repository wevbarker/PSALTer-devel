(*=================*)
(*  TwoFormTheory  *)
(*=================*)

Subsection@"Massless two-form theory";
Comment@"We now examine two-form electrodynamics.";
LinearisedLagrangian=KineticCoupling*Antisymmetrize[CD[-a]@AntisymmTensor[-b,-c],{-a,-b,-c}]*CD[a]@AntisymmTensor[b,c];
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
