(*===================*)
(*  SickProcaTheory  *)
(*===================*)

Section@"Sickly Proca field";

Comment@"For completeness, it behoves us to look at the general massive case.";

LinearisedLagrangian=Coupling1*CD[-a]@xAct`PSALTer`VectorTheory`B[-b]*CD[a]@xAct`PSALTer`VectorTheory`B[b]+Coupling2*CD[-a]@xAct`PSALTer`VectorTheory`B[a]*CD[-b]@xAct`PSALTer`VectorTheory`B[b]+Coupling3*xAct`PSALTer`VectorTheory`B[-a]*xAct`PSALTer`VectorTheory`B[a];
DisplayExpression@LinearisedLagrangian;

LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;

ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"VectorTheory",
	TheoryName->"SickProcaTheory",	
	Method->"Easy",
	MaxLaurentDepth->3
];

Comment@"Once again, the theory is sick in the helicity-0 sector. In case the massive parity-odd vector is unitary, then the helicity-0 mode must either be a ghost or a tachyon.";
