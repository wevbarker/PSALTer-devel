(*==================*)
(*  AntiWeylTheory  *)
(*==================*)

Subsection@"The anti-Weyl theory";
Comment@"We will study the anti-Weyl symmetry.";
DefiningSystem=And[A4==(-2)A7+Rational[1,2]A8,A11==Rational[4,3]A5+Rational[4,3]A7+Rational[8,3]A8+Rational[-1,3]A9,A10==Rational[-4,3]A5+Rational[-4,3]A7+Rational[-8,3]A8+Rational[1,3]A9,A1==Rational[-1,2]A2+Rational[-3,2]A3-2A5-2A7-4A8,A0==2A5+2A7+4A8,C9==0,C8==0,C7==0,C6==0,C5==0,C4==0,C3==0,C2==0,C16==0,C15==0,C14==0,C12==0,C11==0,C10==0,C1==0];
DefiningSystem//=Quiet@First@Solve[#,AllCouplings]&;
LinearLagrangian=NonlinearLagrangian/.DefiningSystem;
DisplayExpression[LinearLagrangian,EqnLabel->"AntiWeylTheory"];
LinearLagrangian*=Measure;
LinearLagrangian//=MetricAffineLineariseLagrangian;
Comment@{"We study",Cref@"AntiWeylTheory"," in the second-order formulation."};
LinearLagrangian=MetricAffineLineariseLagrangian[LinearLagrangian,Formulation->SecondOrder];
Code[LinearLagrangian,
	ParticleSpectrum[LinearLagrangian,
			TheoryName->"AntiWeylTheorySecondOrder",	
			Method->"Hard",
			MaxLaurentDepth->1];
];
Comment@{"A massive vector accompanies the graviton, and the whole theory may be made to be unitary."};
