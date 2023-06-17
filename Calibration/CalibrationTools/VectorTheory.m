(*================*)
(*  VectorTheory  *)
(*================*)

(*===========================================*)
(*  Maxwell field (quantum electrodynamics)  *)
(*===========================================*)

Title@"Maxwell field (quantum electrodynamics)";

Comment@"The first pure 1-form theory we might think to try is due to Maxwell. We know from kindergarten that if we contract the square of the Maxwell tensor, we get a viable kinetic term which propagates the two massless photon polarisations. Let's try this out.";

LinearisedLagrangian=Coupling1*(CD[-a]@xAct`PSALTer`VectorTheory`B[-b]-CD[-b]@xAct`PSALTer`VectorTheory`B[-a])*(CD[a]@xAct`PSALTer`VectorTheory`B[b]-CD[b]@xAct`PSALTer`VectorTheory`B[a]);
Print@LinearisedLagrangian;

Comment@"We need to expand the brackets before passing to PSALTer.";

LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Print@LinearisedLagrangian;

Comment@"Now we shove the Lagrangian into PSALTer.";

ParticleSpectrum[
	"VectorTheory",
	"Maxwell",
	LinearisedLagrangian,
	TensorFields->{xAct`PSALTer`VectorTheory`B},
	CouplingConstants->{Coupling1},
	ExportTheory->True
];

Comment@"The output above makes sense. There are no mass terms in our Lagrangian, and hence no massive poles in the propagator. Instead, there are two massless eigenvalues which suggest that the vector part of the theory propagates two massless polarisations. The no-ghost condition of this massless vector simply demands that our kinetic coupling be negative: this is why in school we are told to put a -1/4 factor in front of the QED Lagrangian. What about the gauge constraints on the source currents? There is only one such constraint, which tells us that the positive-parity scalar part of the QED current (think the chiral current, or some such four-vector source) must vanish. Reverse-engineering this condition from momentum to position space, we see that the four-divergence of the source must vanish. Of course it must: this is just charge conservation. The conservation law is intimately connected to the gauge symmetries of the theory, according to Noether: these symmetries are manifest as singularities (zeroes) in the matrix form of the Lagrangian operator, though there are no spin-parity degeneracies in the 1-form and so all these matrices are just single elements.";

(*===========================================*)
(*  VectorTheory field (electroweak bosons)  *)
(*===========================================*)

Title@"VectorTheory field (electroweak bosons)";

Comment@"Having investigated the massless theory, we keep the same kinetic setup but just add a mass term. This is of course the VectorTheory theory, which finds a place higher up in the standard model.";

LinearisedLagrangian=Coupling1*(CD[-a]@xAct`PSALTer`VectorTheory`B[-b]-CD[-b]@xAct`PSALTer`VectorTheory`B[-a])*(CD[a]@xAct`PSALTer`VectorTheory`B[b]-CD[b]@xAct`PSALTer`VectorTheory`B[a])+Coupling3*xAct`PSALTer`VectorTheory`B[-a]*xAct`PSALTer`VectorTheory`B[a];
Print@LinearisedLagrangian;

Comment@"Again we just need to expand those brackets before passing to PSALTer.";

LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Print@LinearisedLagrangian;

Comment@"Now we shove the Lagrangian into PSALTer.";

ParticleSpectrum[
	"VectorTheory",
	"BasicVectorTheory",
	LinearisedLagrangian,
	TensorFields->{xAct`PSALTer`VectorTheory`B},
	CouplingConstants->{Coupling1,Coupling3},
	ExportTheory->True
];

Comment@"Once again, the result makes sense. If you write out the VectorTheory equation of motion and take the divergence, you see that the presence of the mass term restricts the 1-form to be divergence-free, which is another way of saying that the helicity-0 mode vanishes on shell. This is not a gauge condition (evidenced by the fact that the Lagrangian operator matrices are non-singular), but it does mean that in common with Maxwell's theory, we are stuck with the parity-odd vector mode. What is this mode doing? The theory is now massive, and so there is a massive pole in the propagator. There are now two unitarity conditions: the original no-ghost condition of QED and a new no-tachyon condition which protects the VectorTheory mass from becoming imaginary.";

(*==================================*)
(*  Sickly quantum electrodynamics  *)
(*==================================*)

Title@"Sickly quantum electrodynamics";

Comment@"Now let's try something a bit more ambitious. What if we didn't have the QED Lagrangian as inspiration, but we wanted to construct a general (and not necessarily gauge-invariant) 1-form theory? In the first instance, we'll take the case without any masses. Up to surface terms, there are two kinetic terms we could try which are consistent with the basic requirement of Lorentz invariance.";

LinearisedLagrangian=Coupling1*CD[-a]@xAct`PSALTer`VectorTheory`B[-b]*CD[a]@xAct`PSALTer`VectorTheory`B[b]+Coupling2*CD[-a]@xAct`PSALTer`VectorTheory`B[a]*CD[-b]@xAct`PSALTer`VectorTheory`B[b];
Print@LinearisedLagrangian;

Commen@"We know that the two couplings we've used to parameteise this model must be equal in magnitude and opposite in sign in order for QED to emerge. When they are not assumed to be so, it is well known tha t we will generically get a sick theory. Let's try.";

LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;

ParticleSpectrum[
	"VectorTheory",
	"SickMaxwell",
	LinearisedLagrangian,
	TensorFields->{xAct`PSALTer`VectorTheory`B},
	CouplingConstants->{Coupling1,Coupling2},
	ExportTheory->True
];

Comment@"Notice the suspicious appearance of two extra massless eigenvalues, alongside the familiar photon polarisations. These carry different signs, and thus cannot be positive-definite: the theory is immutably sick, and the no-ghost condition is simply `False'. What has happened here is a result of the Ostrogradsky theorem. Our kinetic structure has destroyed the gauge-invariance of the theory, and so the helicity-0 part of the field (the divergence of some scalar superpotential) has begun to move. Because the helicity-0 part contains an implicit divergence, that part of the theory now contains four implicit derivatives, and is a sickly higher-derivative model. The Ostrogradsky theorem says that derivative decoupling will bifurcate the helicity-0 mode into two modes, one of which is always a ghost. How to get rid of the ghost? We clearly can't do it at the level of the eigenvalues, so we look a few lines above to the Lagrangian matrix structure. The Scalar sector can be killed off entirely, spawning a singular one-element matrix and thus a new gauge symmetry, only by imposing the QED condition. This is of course just what we expect to find.";

(*======================*)
(*  Sickly Proca field  *)
(*======================*)

Title@"Sickly Proca field";

Comment@"For completeness, it behoves us to look at the general massive case.";

LinearisedLagrangian=Coupling1*CD[-a]@xAct`PSALTer`VectorTheory`B[-b]*CD[a]@xAct`PSALTer`VectorTheory`B[b]+Coupling2*CD[-a]@xAct`PSALTer`VectorTheory`B[a]*CD[-b]@xAct`PSALTer`VectorTheory`B[b]+Coupling3*xAct`PSALTer`VectorTheory`B[-a]*xAct`PSALTer`VectorTheory`B[a];
Print@LinearisedLagrangian;

Comment@"We enter this into PSALTer.";

LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;

ParticleSpectrum[
	"VectorTheory",
	"SickBasicVectorTheory",
	LinearisedLagrangian,
	TensorFields->{xAct`PSALTer`VectorTheory`B},
	CouplingConstants->{Coupling1,Coupling2,Coupling3},
	ExportTheory->True
];

Comment@"Once again, the theory is sick in the helicity-0 sector. In case the massive parity-odd vector is unitary, then the helicity-0 mode must either be a ghost or a tachyon.";
