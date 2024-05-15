(*========================*)
(*  MassiveTwoFormTheory  *)
(*========================*)

Subsection@"Massive two-form theory";
Comment@"We now add a mass-term.";
LinearisedLagrangian=Coupling3*Antisymmetrize[CD[-a]@AntisymmTensor[-b,-c],{-a,-b,-c}]*CD[a]@AntisymmTensor[b,c]+Coupling4*AntisymmTensor[-a,-b]*AntisymmTensor[a,b];
(*LinearisedLagrangian+=Coupling1*CD[-a]@Phi[]CD[a]@Phi[]-Coupling2*Phi[]*Phi[];*)
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
