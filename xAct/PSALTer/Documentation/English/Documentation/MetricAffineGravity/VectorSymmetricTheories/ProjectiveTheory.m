(*====================*)
(*  ProjectiveTheory  *)
(*====================*)

Subsection@"The projective theory";
Comment@"We will study the projective symmetry.";
DefiningSystem=And[A11==Rational[4,3]A5+Rational[4,3]A7+Rational[8,3]A8+Rational[-1,3]A9,A10==Rational[4,3]A4+Rational[16,3]A6+Rational[2,3]A8+Rational[1,3]A9,A1==Rational[-1,2]A2+Rational[-3,2]A3+Rational[8,3]A4+Rational[2,3]A5+Rational[32,3]A6+Rational[2,3]A7+Rational[8,3]A8,C11==C12+4C14-C5-2C6-2C7+2C8,C10==2C14-2C15+C4-C6-C7+C8+C9,C1==(-4)C13+Rational[1,2]C14+Rational[1,2]C15-C2];
DefiningSystem//=Quiet@First@Solve[#,AllCouplings]&;
LinearLagrangian=NonlinearLagrangian/.DefiningSystem;
DisplayExpression[LinearLagrangian,EqnLabel->"ProjectiveTheory"];
ReductionRules={A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0,C2->C1,C3->C1,C4->C1,C5->C1,C6->C1,C7->C1,C8->C1,C9->C1,C10->C1,C11->C1,C12->C1,C13->C1,C14->C1,C15->C1,C16->C1};
Comment@{"In the most general form",Cref@"ProjectiveTheory",", the theory has a symmetry which is cumbersome to express in terms of the remaining couplings. We therefore take an arbitrary case of the theory."};
LinearLagrangian=LinearLagrangian/.ReductionRules;
DisplayExpression[LinearLagrangian,EqnLabel->"ProjectiveTheoryReduced"];
Comment@{"First we study",Cref@"ProjectiveTheoryReduced"," in the first-order formulation."};
LinearLagrangian*=Measure;
LinearLagrangian//=MetricAffineLineariseLagrangian;
Code[LinearLagrangian,
	ParticleSpectrum[LinearLagrangian,
			TheoryName->"ProjectiveTheory",	
			Method->"Hard",
			MaxLaurentDepth->1];
];
Comment@{"Next we study",Cref@"ProjectiveTheory"," in the second-order formulation."};
LinearLagrangian=MetricAffineLineariseLagrangian[LinearLagrangian,Formulation->SecondOrder];
Code[LinearLagrangian,
	ParticleSpectrum[LinearLagrangian,
			TheoryName->"ProjectiveTheorySecondOrder",	
			Method->"Hard",
			MaxLaurentDepth->1];
];
Comment@{"Unlike the theory with concurrent symmetry, we see that the massive spectrum of the projective-symmetric theory is quite rich. In particular, the spin-three mode is active."};
