(*========================*)
(*  MassiveTwoFormTheory  *)
(*========================*)

Subsection@"Massive two-form theory";
Comment@"We now add a mass-term.";
LinearisedLagrangian=KineticCoupling*Antisymmetrize[CD[-a]@AntisymmTensor[-b,-c],{-a,-b,-c}]*CD[a]@AntisymmTensor[b,c]+TwoFormMass*AntisymmTensor[-a,-b]*AntisymmTensor[a,b];
DisplayExpression[LinearisedLagrangian,EqnLabel->"TwoFormEectrodynamicsMassive"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"TwoFormEectrodynamicsMassive",
		Method->"Easy",
		MaxLaurentDepth->1
	];
];
Comment@"This result matches the literature.";
