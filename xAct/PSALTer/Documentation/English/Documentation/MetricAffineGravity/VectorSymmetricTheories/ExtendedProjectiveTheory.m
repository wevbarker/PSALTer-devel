(*============================*)
(*  ExtendedProjectiveTheory  *)
(*============================*)

Subsection@"The extended-projective theory";
Comment@"We will study the extended-projective symmetry.";
DefiningSystem=And[A4==-A5-4A6-A7+Rational[-5,2]A8,A11==Rational[4,3]A5+Rational[4,3]A7+Rational[8,3]A8+Rational[-1,3]A9,A10==Rational[-4,3]A5+Rational[-4,3]A7+Rational[-8,3]A8+Rational[1,3]A9,A1==Rational[-1,2]A2+Rational[-3,2]A3-2A5-2A7-4A8,A0==(-8)A6+4A7-2A8,C9==0,C8==0,C7==0,C16==0,C15==0,C14==0,C13==0,C12==0,C11==0,C10==0,C5==(-2)C6,C4==C6,C3==-C6,C2==Rational[1,2]C6,C1==Rational[-1,2]C6];
DefiningSystem//=Quiet@First@Solve[#,AllCouplings]&;
LinearLagrangian=NonlinearLagrangian/.DefiningSystem;
DisplayExpression[LinearLagrangian,EqnLabel->"ExtendedProjectiveTheory"];
LinearLagrangian*=Measure;
LinearLagrangian//=MetricAffineLineariseLagrangian;
Comment@{"We study",Cref@"ExtendedProjectiveTheory"," in the second-order formulation:"};
LinearLagrangian=MetricAffineLineariseLagrangian[LinearLagrangian,Formulation->SecondOrder];
Code[LinearLagrangian,
	ParticleSpectrum[LinearLagrangian,
			TheoryName->"ExtendedProjectiveTheorySecondOrder",	
			Method->"Hard",
			MaxLaurentDepth->1];
];
Comment@{"A massive pseudoscalar accompanies the graviton, and the whole theory may be made to be unitary."};
