(*====================*)
(*  ProjectiveTheory  *)
(*====================*)

Section@"The projective theory";

Comment@"We will study projective.";

DefiningSystem=And[xAct`PSALTer`MetricAffineGravity`A11==Rational[4,3]xAct`PSALTer`MetricAffineGravity`A5+Rational[4,3]xAct`PSALTer`MetricAffineGravity`A7+Rational[8,3]xAct`PSALTer`MetricAffineGravity`A8+Rational[-1,3]xAct`PSALTer`MetricAffineGravity`A9,xAct`PSALTer`MetricAffineGravity`A10==Rational[4,3]xAct`PSALTer`MetricAffineGravity`A4+Rational[16,3]xAct`PSALTer`MetricAffineGravity`A6+Rational[2,3]xAct`PSALTer`MetricAffineGravity`A8+Rational[1,3]xAct`PSALTer`MetricAffineGravity`A9,xAct`PSALTer`MetricAffineGravity`A1==Rational[-1,2]xAct`PSALTer`MetricAffineGravity`A2+Rational[-3,2]xAct`PSALTer`MetricAffineGravity`A3+Rational[8,3]xAct`PSALTer`MetricAffineGravity`A4+Rational[2,3]xAct`PSALTer`MetricAffineGravity`A5+Rational[32,3]xAct`PSALTer`MetricAffineGravity`A6+Rational[2,3]xAct`PSALTer`MetricAffineGravity`A7+Rational[8,3]xAct`PSALTer`MetricAffineGravity`A8,xAct`PSALTer`MetricAffineGravity`C11==xAct`PSALTer`MetricAffineGravity`C12+4xAct`PSALTer`MetricAffineGravity`C14-xAct`PSALTer`MetricAffineGravity`C5-2xAct`PSALTer`MetricAffineGravity`C6-2xAct`PSALTer`MetricAffineGravity`C7+2xAct`PSALTer`MetricAffineGravity`C8,xAct`PSALTer`MetricAffineGravity`C10==2xAct`PSALTer`MetricAffineGravity`C14-2xAct`PSALTer`MetricAffineGravity`C15+xAct`PSALTer`MetricAffineGravity`C4-xAct`PSALTer`MetricAffineGravity`C6-xAct`PSALTer`MetricAffineGravity`C7+xAct`PSALTer`MetricAffineGravity`C8+xAct`PSALTer`MetricAffineGravity`C9,xAct`PSALTer`MetricAffineGravity`C1==(-4)xAct`PSALTer`MetricAffineGravity`C13+Rational[1,2]xAct`PSALTer`MetricAffineGravity`C14+Rational[1,2]xAct`PSALTer`MetricAffineGravity`C15-xAct`PSALTer`MetricAffineGravity`C2];

DefiningSystem//=First@Solve[#,AllCouplings]&;
LinearLagrangian=Measure*NonlinearLagrangian/.DefiningSystem;
DisplayExpression[LinearLagrangian,EqnLabel->"ProjectiveTheory"];
LinearLagrangian//=LineariseLagrangian;
Comment@"Here is the result from the supercomputer.";
ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"ProjectiveTheory",	
		Method->"Hard",
		MaxLaurentDepth->1];
Comment@{"Some comments can be made about projective."};
