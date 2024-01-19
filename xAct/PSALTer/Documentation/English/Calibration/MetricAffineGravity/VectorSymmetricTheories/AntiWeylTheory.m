(*==================*)
(*  AntiWeylTheory  *)
(*==================*)

Section@"The anti-Weyl theory";

Comment@"We will study anti-Weyl.";

DefiningSystem=And[xAct`PSALTer`MetricAffineGravity`A4==(-2)xAct`PSALTer`MetricAffineGravity`A7+Rational[1,2]xAct`PSALTer`MetricAffineGravity`A8,xAct`PSALTer`MetricAffineGravity`A11==Rational[4,3]xAct`PSALTer`MetricAffineGravity`A5+Rational[4,3]xAct`PSALTer`MetricAffineGravity`A7+Rational[8,3]xAct`PSALTer`MetricAffineGravity`A8+Rational[-1,3]xAct`PSALTer`MetricAffineGravity`A9,xAct`PSALTer`MetricAffineGravity`A10==Rational[-4,3]xAct`PSALTer`MetricAffineGravity`A5+Rational[-4,3]xAct`PSALTer`MetricAffineGravity`A7+Rational[-8,3]xAct`PSALTer`MetricAffineGravity`A8+Rational[1,3]xAct`PSALTer`MetricAffineGravity`A9,xAct`PSALTer`MetricAffineGravity`A1==Rational[-1,2]xAct`PSALTer`MetricAffineGravity`A2+Rational[-3,2]xAct`PSALTer`MetricAffineGravity`A3-2xAct`PSALTer`MetricAffineGravity`A5-2xAct`PSALTer`MetricAffineGravity`A7-4xAct`PSALTer`MetricAffineGravity`A8,xAct`PSALTer`MetricAffineGravity`A0==2xAct`PSALTer`MetricAffineGravity`A5+2xAct`PSALTer`MetricAffineGravity`A7+4xAct`PSALTer`MetricAffineGravity`A8,xAct`PSALTer`MetricAffineGravity`C9==0,xAct`PSALTer`MetricAffineGravity`C8==0,xAct`PSALTer`MetricAffineGravity`C7==0,xAct`PSALTer`MetricAffineGravity`C6==0,xAct`PSALTer`MetricAffineGravity`C5==0,xAct`PSALTer`MetricAffineGravity`C4==0,xAct`PSALTer`MetricAffineGravity`C3==0,xAct`PSALTer`MetricAffineGravity`C2==0,xAct`PSALTer`MetricAffineGravity`C16==0,xAct`PSALTer`MetricAffineGravity`C15==0,xAct`PSALTer`MetricAffineGravity`C14==0,xAct`PSALTer`MetricAffineGravity`C12==0,xAct`PSALTer`MetricAffineGravity`C11==0,xAct`PSALTer`MetricAffineGravity`C10==0,xAct`PSALTer`MetricAffineGravity`C1==0];

DefiningSystem//=First@Solve[#,AllCouplings]&;
LinearLagrangian=Measure*NonlinearLagrangian/.DefiningSystem;
DisplayExpression[LinearLagrangian,EqnLabel->"AntiWeylTheory"];
LinearLagrangian//=LineariseLagrangian;
Comment@"Here is the result from the supercomputer.";

ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"AntiWeylTheory",	
		Method->"Hard",
		MaxLaurentDepth->1];
Comment@{"Some comments can be made about anti-Weyl."};
