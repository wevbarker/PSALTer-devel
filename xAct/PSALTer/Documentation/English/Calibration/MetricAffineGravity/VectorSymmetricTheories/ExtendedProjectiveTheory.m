(*============================*)
(*  ExtendedProjectiveTheory  *)
(*============================*)

Section@"The extended-projective theory";

Comment@"We will study the extended-projective symmetry.";

DefiningSystem=And[xAct`PSALTer`MetricAffineGravity`A4==-xAct`PSALTer`MetricAffineGravity`A5-4xAct`PSALTer`MetricAffineGravity`A6-xAct`PSALTer`MetricAffineGravity`A7+Rational[-5,2]xAct`PSALTer`MetricAffineGravity`A8,xAct`PSALTer`MetricAffineGravity`A11==Rational[4,3]xAct`PSALTer`MetricAffineGravity`A5+Rational[4,3]xAct`PSALTer`MetricAffineGravity`A7+Rational[8,3]xAct`PSALTer`MetricAffineGravity`A8+Rational[-1,3]xAct`PSALTer`MetricAffineGravity`A9,xAct`PSALTer`MetricAffineGravity`A10==Rational[-4,3]xAct`PSALTer`MetricAffineGravity`A5+Rational[-4,3]xAct`PSALTer`MetricAffineGravity`A7+Rational[-8,3]xAct`PSALTer`MetricAffineGravity`A8+Rational[1,3]xAct`PSALTer`MetricAffineGravity`A9,xAct`PSALTer`MetricAffineGravity`A1==Rational[-1,2]xAct`PSALTer`MetricAffineGravity`A2+Rational[-3,2]xAct`PSALTer`MetricAffineGravity`A3-2xAct`PSALTer`MetricAffineGravity`A5-2xAct`PSALTer`MetricAffineGravity`A7-4xAct`PSALTer`MetricAffineGravity`A8,xAct`PSALTer`MetricAffineGravity`A0==(-8)xAct`PSALTer`MetricAffineGravity`A6+4xAct`PSALTer`MetricAffineGravity`A7-2xAct`PSALTer`MetricAffineGravity`A8,xAct`PSALTer`MetricAffineGravity`C9==0,xAct`PSALTer`MetricAffineGravity`C8==0,xAct`PSALTer`MetricAffineGravity`C7==0,xAct`PSALTer`MetricAffineGravity`C16==0,xAct`PSALTer`MetricAffineGravity`C15==0,xAct`PSALTer`MetricAffineGravity`C14==0,xAct`PSALTer`MetricAffineGravity`C13==0,xAct`PSALTer`MetricAffineGravity`C12==0,xAct`PSALTer`MetricAffineGravity`C11==0,xAct`PSALTer`MetricAffineGravity`C10==0,xAct`PSALTer`MetricAffineGravity`C5==(-2)xAct`PSALTer`MetricAffineGravity`C6,xAct`PSALTer`MetricAffineGravity`C4==xAct`PSALTer`MetricAffineGravity`C6,xAct`PSALTer`MetricAffineGravity`C3==-xAct`PSALTer`MetricAffineGravity`C6,xAct`PSALTer`MetricAffineGravity`C2==Rational[1,2]xAct`PSALTer`MetricAffineGravity`C6,xAct`PSALTer`MetricAffineGravity`C1==Rational[-1,2]xAct`PSALTer`MetricAffineGravity`C6];

DefiningSystem//=Quiet@First@Solve[#,AllCouplings]&;
LinearLagrangian=NonlinearLagrangian/.DefiningSystem;
DisplayExpression[LinearLagrangian,EqnLabel->"ExtendedProjectiveTheory"];

Comment@{"First we study",Cref@"ExtendedProjectiveTheory"," in the first-order formulation."};
LinearLagrangian*=Measure;
LinearLagrangian//=LineariseLagrangian;
ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"ExtendedProjectiveTheory",	
		Method->"Hard",
		MaxLaurentDepth->1];

Comment@{"Next we study",Cref@"ExtendedProjectiveTheory"," in the second-order formulation."};
LinearLagrangian=LineariseLagrangian[LinearLagrangian,Formulation->SecondOrder];
ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"ExtendedProjectiveTheorySecondOrder",	
		Method->"Hard",
		MaxLaurentDepth->1];
Supercomment@{"A massive pseudoscalar accompanies the graviton, and the whole theory may be made to be unitary."};
