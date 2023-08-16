(*=================*)
(*  MaxwellTheory  *)
(*=================*)

Section@"Maxwell field (quantum electrodynamics)";

Comment@"The first pure 1-form theory we might think to try is due to Maxwell. We know from kindergarten that if we contract the square of the Maxwell tensor, we get a viable kinetic term which propagates the two massless photon polarisations. Let's try this out.";

LinearisedLagrangian=Coupling1*(CD[-a]@xAct`PSALTer`VectorTheory`B[-b]-CD[-b]@xAct`PSALTer`VectorTheory`B[-a])*(CD[a]@xAct`PSALTer`VectorTheory`B[b]-CD[b]@xAct`PSALTer`VectorTheory`B[a]);
DisplayExpression@LinearisedLagrangian;

LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;

ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"VectorTheory",
	TheoryName->"MaxwellTheory",	
	Method->"Easy",
	MaxLaurentDepth->3
];

Comment@"The output above makes sense. There are no mass terms in our Lagrangian, and hence no massive poles in the propagator. Instead, there are two massless eigenvalues which suggest that the vector part of the theory propagates two massless polarisations. The no-ghost condition of this massless vector simply demands that our kinetic coupling be negative: this is why in school we are told to put a -1/4 factor in front of the QED Lagrangian. What about the gauge constraints on the source currents? There is only one such constraint, which tells us that the positive-parity scalar part of the QED current (think the chiral current, or some such four-vector source) must vanish. Reverse-engineering this condition from momentum to position space, we see that the four-divergence of the source must vanish. Of course it must: this is just charge conservation. The conservation law is intimately connected to the gauge symmetries of the theory, according to Noether: these symmetries are manifest as singularities (zeroes) in the matrix form of the Lagrangian operator, though there are no spin-parity degeneracies in the 1-form and so all these matrices are just single elements.";
