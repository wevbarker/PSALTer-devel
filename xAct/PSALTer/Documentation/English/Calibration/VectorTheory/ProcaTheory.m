(*===============*)
(*  ProcaTheory  *)
(*===============*)

Section@"Proca field (electroweak bosons)";

Comment@"Having investigated the massless theory, we keep the same kinetic setup but just add a mass term. This is of course the Proca theory, which finds a place higher up in the standard model.";

LinearisedLagrangian=Coupling1*(CD[-a]@xAct`PSALTer`VectorTheory`B[-b]-CD[-b]@xAct`PSALTer`VectorTheory`B[-a])*(CD[a]@xAct`PSALTer`VectorTheory`B[b]-CD[b]@xAct`PSALTer`VectorTheory`B[a])+Coupling3*xAct`PSALTer`VectorTheory`B[-a]*xAct`PSALTer`VectorTheory`B[a];
DisplayExpression@LinearisedLagrangian;

LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;

ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"VectorTheory",
	TheoryName->"ProcaTheory",	
	Method->"Easy",
	MaxLaurentDepth->3
];

Comment@"Once again, the result makes sense. If you write out the Proca equation of motion and take the divergence, you see that the presence of the mass term restricts the 1-form to be divergence-free, which is another way of saying that the helicity-0 mode vanishes on shell. This is not a gauge condition (evidenced by the fact that the Lagrangian operator matrices are non-singular), but it does mean that in common with Maxwell's theory, we are stuck with the parity-odd vector mode. What is this mode doing? The theory is now massive, and so there is a massive pole in the propagator. There are now two unitarity conditions: the original no-ghost condition of QED and a new no-tachyon condition which protects the Proca mass from becoming imaginary.";
