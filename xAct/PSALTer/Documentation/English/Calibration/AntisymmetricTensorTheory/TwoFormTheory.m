(*=================*)
(*  TwoFormTheory  *)
(*=================*)

Section@"Two-form theory";

Comment@"We now examine two-form electrodynamics.";
Code[
	LinearisedLagrangian=KineticCoupling*Antisymmetrize[CD[-a]@AntisymmTensor[-b,-c],{-a,-b,-c}]*CD[a]@AntisymmTensor[b,c];
];
DisplayExpression[LinearisedLagrangian,EqnLabel->"TwoFormEectrodynamics"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Code[
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"TwoFormEectrodynamics",
		Method->"Easy",
		MaxLaurentDepth->1
	];
];
Comment@"We now add a mass-term.";
Code[
	LinearisedLagrangian=KineticCoupling*Antisymmetrize[CD[-a]@AntisymmTensor[-b,-c],{-a,-b,-c}]*CD[a]@AntisymmTensor[b,c]+TwoFormMass*AntisymmTensor[-a,-b]*AntisymmTensor[a,b];
];
DisplayExpression[LinearisedLagrangian,EqnLabel->"TwoFormEectrodynamicsMassive"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Code[
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"TwoFormEectrodynamicsMassive",
		Method->"Easy",
		MaxLaurentDepth->1
	];
];
