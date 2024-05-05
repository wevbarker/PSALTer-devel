(*==========================*)
(*  UnrestrictedWithVector  *)
(*==========================*)

Subsection@"Ricci-type with massless vector";

Comment@"We will study the Ricci-type theory with the massless vector. The condition in Eq. (32) is a little bit tricky to impose, because it is not linear in the couplings (PSALTer would need some modifications to accommodate for this), so instead we try a more restrictive version as follows.";

LinearLagrangian=Measure*NonlinearLagrangian/.{A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0,C1->0,C2->0,C3->0,C4->0,C5->0,C6->0,C16->0};

UnrestrictedWithVectorConstraint={C7->C8-C9+C10-C11+C12,C14->-C15};

DisplayExpression[UnrestrictedWithVectorConstraint,EqnLabel->"UnrestrictedWithVectorConstraint"];

Comment@{"So imposing",Cref@"UnrestrictedWithVectorConstraint"," on the theory in",Cref@"MetricAffineRicciTypeTheory"," we obtain the following."};

LinearLagrangian=MetricAffineLineariseLagrangian/.UnrestrictedWithVectorConstraint;

DisplayExpression[LinearLagrangian,EqnLabel->"MetricAffineEinsteinHilbertTheory"];
LinearLagrangian//=MetricAffineLineariseLagrangian;
Code[
	ParticleSpectrum[LinearLagrangian,
			TheoryName->"UnrestrictedWithVectorFirstOrder",	
			Method->"Hard",
			MaxLaurentDepth->3];
];
Comment@{"The conclusion we reach from",Cref@"UnrestrictedWithVectorConstraint"," is that by using",Cref@"UnrestrictedWithVectorConstraint"," we can kill off both the massive poles and keep a unitary massless mode in the spectrum alongside the graviton. This seems to contradict the conclusion of the draft as it stands, so probably this is a worthwhile special-case to consider."};

LinearLagrangian=MetricAffineLineariseLagrangian[LinearLagrangian,Formulation->SecondOrder];
Code[
	ParticleSpectrum[LinearLagrangian,
			TheoryName->"UnrestrictedWithVectorSecondOrder",	
			Method->"Hard",
			MaxLaurentDepth->3];
];
