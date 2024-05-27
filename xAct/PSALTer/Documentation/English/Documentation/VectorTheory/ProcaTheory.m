(*===============*)
(*  ProcaTheory  *)
(*===============*)

Subsection@"Proca field (electroweak bosons)";
Comment@{"Having investigated the massless theory in",Cref@"MaxwellTheory"," we keep the same kinetic term but now add a mass term. This is the Proca theory."};
LinearisedLagrangian=Coupling1*(CD[-a]@VectorField[-b]-CD[-b]@VectorField[-a])*(CD[a]@VectorField[b]-CD[b]@VectorField[a])+Coupling3*VectorField[-a]*VectorField[a];
DisplayExpression[LinearisedLagrangian,EqnLabel->"ProcaTheory"];
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"ProcaTheory",	
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
Comment@"The divergence of the Proca equation of motion restricts the vector to be divergence-free, which is another way of saying that the helicity-0 mode vanishes on-shell. This is not a gauge condition (evidenced by the fact that the wave operator matrices are non-singular), but it does mean that in common with Maxwell's theory, we have the parity-odd vector mode. The theory is now massive, and so there is a massive pole in the propagator. There are now two unitarity conditions: the original no-ghost condition and a new no-tachyon condition which protects the Proca mass from becoming imaginary.";
