(*=================*)
(*  MaxwellTheory  *)
(*=================*)

Subsection@"Maxwell field (quantum electrodynamics)";
Comment@"If we contract the square of the Maxwell tensor, we get a viable kinetic term which propagates the two massless photon polarisations.";
LinearisedLagrangian=Coupling1*(CD[-a]@B[-b]-CD[-b]@B[-a])*(CD[a]@B[b]-CD[b]@B[a]);
DisplayExpression[LinearisedLagrangian,EqnLabel->"MaxwellTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"MaxwellTheory",	
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
Comment@{"There are no mass terms in our Lagrangian ",Cref@"MaxwellTheory",", and hence no massive poles in the propagator. Instead, there are two massless eigenvalues which suggest that the vector part of the theory propagates two massless polarisations. The no-ghost condition of this massless vector requires that our kinetic coupling be negative. What about the gauge constraints on the source currents? There is only one such constraint, which tells us that the positive-parity scalar part of the QED current (i.e. the chiral current, or some other four-vector source) must vanish. Reverse-engineering this condition from momentum to position space, we see that the four-divergence of the source must vanish: this is just charge conservation."};
