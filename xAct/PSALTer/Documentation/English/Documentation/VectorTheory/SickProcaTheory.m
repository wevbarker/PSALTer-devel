(*===================*)
(*  SickProcaTheory  *)
(*===================*)

Subsection@"Sickly Proca field";
Comment@{"We extend our analysis of",Cref@"SickMaxwellTheory"," to the general massive case."};
LinearisedLagrangian=Coupling1*CD[-a]@VectorField[-b]*CD[a]@VectorField[b]+Coupling2*CD[-a]@VectorField[a]*CD[-b]@VectorField[b]+Coupling3*VectorField[-a]*VectorField[a];
DisplayExpression[LinearisedLagrangian,EqnLabel->"SickProcaTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"SickProcaTheory",	
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
Comment@"Once again, the theory is sick in the helicity-0 sector. In case the massive parity-odd vector is unitary, then the helicity-0 mode must either be a ghost or a tachyon.";
