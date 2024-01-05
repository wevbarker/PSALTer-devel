(*============================*)
(*  ExtendedProjectiveTheory  *)
(*============================*)

Section@"The extended-projective theory";

Comment@"We will study extended-projective.";

DefiningSystem=And[xAct`PSALTer`MetricAffineGravity`A4==-xAct`PSALTer`MetricAffineGravity`A5-4xAct`PSALTer`MetricAffineGravity`A6-xAct`PSALTer`MetricAffineGravity`A7+Rational[-5,2]xAct`PSALTer`MetricAffineGravity`A8,xAct`PSALTer`MetricAffineGravity`A11==Rational[4,3]xAct`PSALTer`MetricAffineGravity`A5+Rational[4,3]xAct`PSALTer`MetricAffineGravity`A7+Rational[8,3]xAct`PSALTer`MetricAffineGravity`A8+Rational[-1,3]xAct`PSALTer`MetricAffineGravity`A9,xAct`PSALTer`MetricAffineGravity`A10==Rational[-4,3]xAct`PSALTer`MetricAffineGravity`A5+Rational[-4,3]xAct`PSALTer`MetricAffineGravity`A7+Rational[-8,3]xAct`PSALTer`MetricAffineGravity`A8+Rational[1,3]xAct`PSALTer`MetricAffineGravity`A9,xAct`PSALTer`MetricAffineGravity`A1==Rational[-1,2]xAct`PSALTer`MetricAffineGravity`A2+Rational[-3,2]xAct`PSALTer`MetricAffineGravity`A3-2xAct`PSALTer`MetricAffineGravity`A5-2xAct`PSALTer`MetricAffineGravity`A7-4xAct`PSALTer`MetricAffineGravity`A8,xAct`PSALTer`MetricAffineGravity`A0==(-8)xAct`PSALTer`MetricAffineGravity`A6+4xAct`PSALTer`MetricAffineGravity`A7-2xAct`PSALTer`MetricAffineGravity`A8,xAct`PSALTer`MetricAffineGravity`C9==0,xAct`PSALTer`MetricAffineGravity`C8==0,xAct`PSALTer`MetricAffineGravity`C7==0,xAct`PSALTer`MetricAffineGravity`C16==0,xAct`PSALTer`MetricAffineGravity`C15==0,xAct`PSALTer`MetricAffineGravity`C14==0,xAct`PSALTer`MetricAffineGravity`C13==0,xAct`PSALTer`MetricAffineGravity`C12==0,xAct`PSALTer`MetricAffineGravity`C11==0,xAct`PSALTer`MetricAffineGravity`C10==0,xAct`PSALTer`MetricAffineGravity`C5==(-2)xAct`PSALTer`MetricAffineGravity`C6,xAct`PSALTer`MetricAffineGravity`C4==xAct`PSALTer`MetricAffineGravity`C6,xAct`PSALTer`MetricAffineGravity`C3==-xAct`PSALTer`MetricAffineGravity`C6,xAct`PSALTer`MetricAffineGravity`C2==Rational[1,2]xAct`PSALTer`MetricAffineGravity`C6,xAct`PSALTer`MetricAffineGravity`C1==Rational[-1,2]xAct`PSALTer`MetricAffineGravity`C6];

DefiningSystem//=First@Solve[#,AllCouplings]&;
LinearLagrangian=Measure*NonlinearLagrangian/.DefiningSystem;
DisplayExpression[LinearLagrangian,EqnLabel->"ExtendedProjectiveTheory"];
LinearLagrangian//=LineariseLagrangian;
Comment@"Here is the result from the supercomputer.";
ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"ExtendedProjectiveTheory",	
		Method->"Hard",
		MaxLaurentDepth->3];
Comment@{"Some comments can be made about extended-projective."};
Throw@"Have a look here";
