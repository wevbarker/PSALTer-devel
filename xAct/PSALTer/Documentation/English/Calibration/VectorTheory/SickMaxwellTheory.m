(*=====================*)
(*  SickMaxwellTheory  *)
(*=====================*)

Section@"Sickly quantum electrodynamics";

Comment@"Now let's try something a bit more ambitious. What if we didn't have the QED Lagrangian as inspiration, but we wanted to construct a general (and not necessarily gauge-invariant) 1-form theory? In the first instance, we'll take the case without any masses. Up to surface terms, there are two kinetic terms we could try which are consistent with the basic requirement of Lorentz invariance.";

LinearisedLagrangian=Coupling1*CD[-a]@xAct`PSALTer`VectorTheory`B[-b]*CD[a]@xAct`PSALTer`VectorTheory`B[b]+Coupling2*CD[-a]@xAct`PSALTer`VectorTheory`B[a]*CD[-b]@xAct`PSALTer`VectorTheory`B[b];
DisplayExpression@LinearisedLagrangian;

Commen@"We know that the two couplings we've used to parameteise this model must be equal in magnitude and opposite in sign in order for QED to emerge. When they are not assumed to be so, it is well known tha t we will generically get a sick theory. Let's try.";

LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;

ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"VectorTheory",
	TheoryName->"SickMaxwellTheory",	
	Method->"Easy",
	MaxLaurentDepth->3
];

Comment@"Notice the suspicious appearance of two extra massless eigenvalues, alongside the familiar photon polarisations. These carry different signs, and thus cannot be positive-definite: the theory is immutably sick, and the no-ghost condition is simply `False'. What has happened here is a result of the Ostrogradsky theorem. Our kinetic structure has destroyed the gauge-invariance of the theory, and so the helicity-0 part of the field (the divergence of some scalar superpotential) has begun to move. Because the helicity-0 part contains an implicit divergence, that part of the theory now contains four implicit derivatives, and is a sickly higher-derivative model. The Ostrogradsky theorem says that derivative decoupling will bifurcate the helicity-0 mode into two modes, one of which is always a ghost. How to get rid of the ghost? We clearly can't do it at the level of the eigenvalues, so we look a few lines above to the Lagrangian matrix structure. The Scalar sector can be killed off entirely, spawning a singular one-element matrix and thus a new gauge symmetry, only by imposing the QED condition. This is of course just what we expect to find.";
