(*==========================*)
(*  UnrestrictedNoVector  *)
(*==========================*)

Subsection@"Ricci-type without massless vector";
Comment@"We will now study the Ricci-type theory without the massless vector. To do this, we impose Carlo's conditions as presented in Eq. (33) of the draft.";
LinearLagrangian=Measure*NonlinearLagrangian/.{A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0,C1->0,C2->0,C3->0,C4->0,C5->0,C6->0,C16->0};
UnrestrictedNoVectorConstraint={C9->C10-C11+C12+16C13-C7+C8,C15->8C13-C14};
DisplayExpression[UnrestrictedNoVectorConstraint,EqnLabel->"UnrestrictedNoVectorConstraint"];
Comment@{"So imposing",Cref@"UnrestrictedNoVectorConstraint"," on the theory in",Cref@"MetricAffineRicciTypeTheory"," we obtain the following."};
LinearLagrangian=LinearLagrangian/.UnrestrictedNoVectorConstraint;
DisplayExpression[LinearLagrangian,EqnLabel->"MetricAffineEinsteinHilbertTheory"];
LinearLagrangian//=MetricAffineLineariseLagrangian;
Code[LinearLagrangian,
	ParticleSpectrum[LinearLagrangian,
			TheoryName->"UnrestrictedNoVectorFirstOrder",	
			Method->"Hard",
			MaxLaurentDepth->3];
];
Comment@{"So it seems in this case that",Cref@"UnrestrictedNoVectorConstraint"," did not yet kill off the extra massless particle. Despite this, I believe we can confirm both the residue and the mass of the parity-even vector in Eq. (34) and Eq. (36). There is a clear problem with the mass (and perhaps the residue, even after reduction) of the parity-odd vector."};
LinearLagrangian=MetricAffineLineariseLagrangian[LinearLagrangian,Formulation->SecondOrder];
Code[LinearLagrangian,
	ParticleSpectrum[LinearLagrangian,
			TheoryName->"UnrestrictedNoVectorSecondOrder",	
			Method->"Hard",
			MaxLaurentDepth->3];
];
