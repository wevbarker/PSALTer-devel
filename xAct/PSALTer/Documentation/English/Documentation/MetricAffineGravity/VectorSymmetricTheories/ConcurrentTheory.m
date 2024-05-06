(*====================*)
(*  ConcurrentTheory  *)
(*====================*)

Subsection@"The concurrent theory";
Comment@"We will study the concurrent symmetry.";
DefiningSystem=And[A10==Rational[-1,4]A11-A5-A7-2A8+Rational[1,4]A9,A1==Rational[-3,2]A11+Rational[-1,2]A2+Rational[-3,2]A3+Rational[-1,2]A9,A0==Rational[9,8]A11+2A4+Rational[1,2]A5+Rational[9,2]A7+Rational[3,8]A9,C9==0,C8==0,C7==0,C5==(-2)C6,C4==C6,C3==-C6,C2==Rational[1,2]C6,C16==0,C15==0,C14==0,C12==0,C11==0,C10==0,C1==Rational[-1,2]C6];
DefiningSystem//=Quiet@First@Solve[#,AllCouplings]&;
LinearLagrangian=NonlinearLagrangian/.DefiningSystem;
DisplayExpression[LinearLagrangian,EqnLabel->"ConcurrentTheory"];
ReductionRules={A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0,C2->C1,C3->C1,C4->C1,C5->C1,C6->C1,C7->C1,C8->C1,C9->C1,C10->C1,C11->C1,C12->C1,C13->C1,C14->C1,C15->C1,C16->C1};
Comment@{"In the most general form",Cref@"ConcurrentTheory",", the theory has a symmetry which is cumbersome to express in terms of the remaining couplings. We therefore take an arbitrary case of the theory."};
LinearLagrangian=LinearLagrangian/.ReductionRules;
DisplayExpression[LinearLagrangian,EqnLabel->"ConcurrentTheoryReduced"];
Comment@{"First we study",Cref@"ConcurrentTheoryReduced"," in the first-order formulation."};
LinearLagrangian*=Measure;
LinearLagrangian//=MetricAffineLineariseLagrangian;
Code[LinearLagrangian,
	ParticleSpectrum[LinearLagrangian,
			TheoryName->"ConcurrentTheory",	
			Method->"Hard",
			MaxLaurentDepth->1];
];
Comment@{"Next we study",Cref@"ConcurrentTheory"," in the second-order formulation."};
LinearLagrangian=MetricAffineLineariseLagrangian[LinearLagrangian,Formulation->SecondOrder];
Code[LinearLagrangian,
	ParticleSpectrum[LinearLagrangian,
			TheoryName->"ConcurrentTheorySecondOrder",	
			Method->"Hard",
			MaxLaurentDepth->1];
];
Comment@{"We see that the mass spectrum of the theory with concurrent symmetry is simply the union of the anti-Weyl and extended projective cases. As expected, there is a single vector symmetry in this theory. The whole theory may be made to be unitary."};
