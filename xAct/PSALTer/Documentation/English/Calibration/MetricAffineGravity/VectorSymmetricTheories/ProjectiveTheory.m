(*====================*)
(*  ProjectiveTheory  *)
(*====================*)

Section@"The projective theory";

Comment@"We will study the projective symmetry.";

DefiningSystem=And[xAct`PSALTer`MetricAffineGravity`A11==Rational[4,3]xAct`PSALTer`MetricAffineGravity`A5+Rational[4,3]xAct`PSALTer`MetricAffineGravity`A7+Rational[8,3]xAct`PSALTer`MetricAffineGravity`A8+Rational[-1,3]xAct`PSALTer`MetricAffineGravity`A9,xAct`PSALTer`MetricAffineGravity`A10==Rational[4,3]xAct`PSALTer`MetricAffineGravity`A4+Rational[16,3]xAct`PSALTer`MetricAffineGravity`A6+Rational[2,3]xAct`PSALTer`MetricAffineGravity`A8+Rational[1,3]xAct`PSALTer`MetricAffineGravity`A9,xAct`PSALTer`MetricAffineGravity`A1==Rational[-1,2]xAct`PSALTer`MetricAffineGravity`A2+Rational[-3,2]xAct`PSALTer`MetricAffineGravity`A3+Rational[8,3]xAct`PSALTer`MetricAffineGravity`A4+Rational[2,3]xAct`PSALTer`MetricAffineGravity`A5+Rational[32,3]xAct`PSALTer`MetricAffineGravity`A6+Rational[2,3]xAct`PSALTer`MetricAffineGravity`A7+Rational[8,3]xAct`PSALTer`MetricAffineGravity`A8,xAct`PSALTer`MetricAffineGravity`C11==xAct`PSALTer`MetricAffineGravity`C12+4xAct`PSALTer`MetricAffineGravity`C14-xAct`PSALTer`MetricAffineGravity`C5-2xAct`PSALTer`MetricAffineGravity`C6-2xAct`PSALTer`MetricAffineGravity`C7+2xAct`PSALTer`MetricAffineGravity`C8,xAct`PSALTer`MetricAffineGravity`C10==2xAct`PSALTer`MetricAffineGravity`C14-2xAct`PSALTer`MetricAffineGravity`C15+xAct`PSALTer`MetricAffineGravity`C4-xAct`PSALTer`MetricAffineGravity`C6-xAct`PSALTer`MetricAffineGravity`C7+xAct`PSALTer`MetricAffineGravity`C8+xAct`PSALTer`MetricAffineGravity`C9,xAct`PSALTer`MetricAffineGravity`C1==(-4)xAct`PSALTer`MetricAffineGravity`C13+Rational[1,2]xAct`PSALTer`MetricAffineGravity`C14+Rational[1,2]xAct`PSALTer`MetricAffineGravity`C15-xAct`PSALTer`MetricAffineGravity`C2];

DefiningSystem//=Quiet@First@Solve[#,AllCouplings]&;
LinearLagrangian=NonlinearLagrangian/.DefiningSystem;
DisplayExpression[LinearLagrangian,EqnLabel->"ProjectiveTheory"];

ReductionRules={
xAct`PSALTer`MetricAffineGravity`A1->0,
xAct`PSALTer`MetricAffineGravity`A2->0,
xAct`PSALTer`MetricAffineGravity`A3->0,
xAct`PSALTer`MetricAffineGravity`A4->0,
xAct`PSALTer`MetricAffineGravity`A5->0,
xAct`PSALTer`MetricAffineGravity`A6->0,
xAct`PSALTer`MetricAffineGravity`A7->0,
xAct`PSALTer`MetricAffineGravity`A8->0,
xAct`PSALTer`MetricAffineGravity`A9->0,
xAct`PSALTer`MetricAffineGravity`A10->0,
xAct`PSALTer`MetricAffineGravity`A11->0,
xAct`PSALTer`MetricAffineGravity`C2->xAct`PSALTer`MetricAffineGravity`C1,
xAct`PSALTer`MetricAffineGravity`C3->xAct`PSALTer`MetricAffineGravity`C1,
xAct`PSALTer`MetricAffineGravity`C4->xAct`PSALTer`MetricAffineGravity`C1,
xAct`PSALTer`MetricAffineGravity`C5->xAct`PSALTer`MetricAffineGravity`C1,
xAct`PSALTer`MetricAffineGravity`C6->xAct`PSALTer`MetricAffineGravity`C1,
xAct`PSALTer`MetricAffineGravity`C7->xAct`PSALTer`MetricAffineGravity`C1,
xAct`PSALTer`MetricAffineGravity`C8->xAct`PSALTer`MetricAffineGravity`C1,
xAct`PSALTer`MetricAffineGravity`C9->xAct`PSALTer`MetricAffineGravity`C1,
xAct`PSALTer`MetricAffineGravity`C10->xAct`PSALTer`MetricAffineGravity`C1,
xAct`PSALTer`MetricAffineGravity`C11->xAct`PSALTer`MetricAffineGravity`C1,
xAct`PSALTer`MetricAffineGravity`C12->xAct`PSALTer`MetricAffineGravity`C1,
xAct`PSALTer`MetricAffineGravity`C13->xAct`PSALTer`MetricAffineGravity`C1,
xAct`PSALTer`MetricAffineGravity`C14->xAct`PSALTer`MetricAffineGravity`C1,
xAct`PSALTer`MetricAffineGravity`C15->xAct`PSALTer`MetricAffineGravity`C1,
xAct`PSALTer`MetricAffineGravity`C16->xAct`PSALTer`MetricAffineGravity`C1
};
Comment@{"In the most general form",Cref@"ProjectiveTheory",", the theory has a symmetry which is cumbersome to express in terms of the remaining couplings. We therefore take an arbitrary case of the theory."};
LinearLagrangian=LinearLagrangian/.ReductionRules;
DisplayExpression[LinearLagrangian,EqnLabel->"ProjectiveTheoryReduced"];

Comment@{"First we study",Cref@"ProjectiveTheoryReduced"," in the first-order formulation."};
LinearLagrangian*=Measure;
LinearLagrangian//=MetricAffineLineariseLagrangian;
(**)
ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"ProjectiveTheory",	
		Method->"Hard",
		MaxLaurentDepth->1];
(**)
Comment@{"Next we study",Cref@"ProjectiveTheory"," in the second-order formulation."};
LinearLagrangian=MetricAffineLineariseLagrangian[LinearLagrangian,Formulation->SecondOrder];
ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"ProjectiveTheorySecondOrder",	
		Method->"Hard",
		MaxLaurentDepth->1];
Supercomment@{"Unlike the theory with concurrent symmetry, we see that the massive spectrum of the projective-symmetric theory is quite rich. In particular, the spin-three mode is active."};
