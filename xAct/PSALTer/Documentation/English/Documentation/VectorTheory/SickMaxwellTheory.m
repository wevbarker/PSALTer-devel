(*=====================*)
(*  SickMaxwellTheory  *)
(*=====================*)

Subsection@"Sickly quantum electrodynamics";
Comment@"Up to surface terms, there are two kinetic terms which are consistent with the basic requirement of Lorentz invariance in a vector theory.";
LinearisedLagrangian=Coupling1*CD[-a]@B[-b]*CD[a]@B[b]+Coupling2*CD[-a]@B[a]*CD[-b]@B[b];
DisplayExpression[LinearisedLagrangian,EqnLabel->"SickMaxwellTheory"];
Commen@{"The two couplings we've used to parameteise",Cref@"SickMaxwellTheory"," must be equal in magnitude and opposite in sign in order for QED to emerge. When they are not assumed to be so, the theory is usually sick:"};
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"SickMaxwellTheory",	
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
Comment@{"Notice the appearance of two extra massless eigenvalues, alongside the familiar photon polarisations. These carry different signs, and thus cannot be positive-definite: the theory is immutably sick. What has happened here is a result of the Ostrogradsky theorem. Our kinetic structure in",Cref@"SickMaxwellTheory"," has destroyed the gauge invariance of the theory, and so the helicity-0 part of the field (the divergence of some scalar superpotential) has begun to move. Because the helicity-0 part contains an implicit divergence, that part of the theory now contains four implicit derivatives, and is a sickly higher-derivative model."};
