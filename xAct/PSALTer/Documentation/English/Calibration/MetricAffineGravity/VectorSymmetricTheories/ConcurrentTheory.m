(*====================*)
(*  ConcurrentTheory  *)
(*====================*)

Section@"The concurrent theory";

Comment@"We will study the concurrent symmetry.";

DefiningSystem=And[xAct`PSALTer`MetricAffineGravity`A10==Rational[-1,4]xAct`PSALTer`MetricAffineGravity`A11-xAct`PSALTer`MetricAffineGravity`A5-xAct`PSALTer`MetricAffineGravity`A7-2xAct`PSALTer`MetricAffineGravity`A8+Rational[1,4]xAct`PSALTer`MetricAffineGravity`A9,xAct`PSALTer`MetricAffineGravity`A1==Rational[-3,2]xAct`PSALTer`MetricAffineGravity`A11+Rational[-1,2]xAct`PSALTer`MetricAffineGravity`A2+Rational[-3,2]xAct`PSALTer`MetricAffineGravity`A3+Rational[-1,2]xAct`PSALTer`MetricAffineGravity`A9,xAct`PSALTer`MetricAffineGravity`A0==Rational[9,8]xAct`PSALTer`MetricAffineGravity`A11+2xAct`PSALTer`MetricAffineGravity`A4+Rational[1,2]xAct`PSALTer`MetricAffineGravity`A5+Rational[9,2]xAct`PSALTer`MetricAffineGravity`A7+Rational[3,8]xAct`PSALTer`MetricAffineGravity`A9,xAct`PSALTer`MetricAffineGravity`C9==0,xAct`PSALTer`MetricAffineGravity`C8==0,xAct`PSALTer`MetricAffineGravity`C7==0,xAct`PSALTer`MetricAffineGravity`C5==(-2)xAct`PSALTer`MetricAffineGravity`C6,xAct`PSALTer`MetricAffineGravity`C4==xAct`PSALTer`MetricAffineGravity`C6,xAct`PSALTer`MetricAffineGravity`C3==-xAct`PSALTer`MetricAffineGravity`C6,xAct`PSALTer`MetricAffineGravity`C2==Rational[1,2]xAct`PSALTer`MetricAffineGravity`C6,xAct`PSALTer`MetricAffineGravity`C16==0,xAct`PSALTer`MetricAffineGravity`C15==0,xAct`PSALTer`MetricAffineGravity`C14==0,xAct`PSALTer`MetricAffineGravity`C12==0,xAct`PSALTer`MetricAffineGravity`C11==0,xAct`PSALTer`MetricAffineGravity`C10==0,xAct`PSALTer`MetricAffineGravity`C1==Rational[-1,2]xAct`PSALTer`MetricAffineGravity`C6];

DefiningSystem//=Quiet@First@Solve[#,AllCouplings]&;
LinearLagrangian=NonlinearLagrangian/.DefiningSystem;
DisplayExpression[LinearLagrangian,EqnLabel->"ConcurrentTheory"];

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
Comment@{"In the most general form",Cref@"ConcurrentTheory",", the theory has a symmetry which is cumbersome to express in terms of the remaining couplings. We therefore take an arbitrary case of the theory."};
LinearLagrangian=LinearLagrangian/.ReductionRules;
DisplayExpression[LinearLagrangian,EqnLabel->"ConcurrentTheoryReduced"];

Comment@{"First we study",Cref@"ConcurrentTheoryReduced"," in the first-order formulation."};
LinearLagrangian*=Measure;
LinearLagrangian//=MetricAffineLineariseLagrangian;
(**)
ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"ConcurrentTheory",	
		Method->"Hard",
		MaxLaurentDepth->1];
(**)
Comment@{"Next we study",Cref@"ConcurrentTheory"," in the second-order formulation."};
LinearLagrangian=MetricAffineLineariseLagrangian[LinearLagrangian,Formulation->SecondOrder];
ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"ConcurrentTheorySecondOrder",	
		Method->"Hard",
		MaxLaurentDepth->1];
Supercomment@{"We see that the mass spectrum of the theory with concurrent symmetry is simply the union of the anti-Weyl and extended projective cases. As expected, there is a single vector symmetry in this theory. The whole theory may be made to be unitary."};
