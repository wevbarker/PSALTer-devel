(*====================*)
(*  ConcurrentTheory  *)
(*====================*)

Section@"The concurrent theory";

Comment@"We will study concurrent.";

DefiningSystem=And[xAct`PSALTer`MetricAffineGravity`A10==Rational[-1,4]xAct`PSALTer`MetricAffineGravity`A11-xAct`PSALTer`MetricAffineGravity`A5-xAct`PSALTer`MetricAffineGravity`A7-2xAct`PSALTer`MetricAffineGravity`A8+Rational[1,4]xAct`PSALTer`MetricAffineGravity`A9,xAct`PSALTer`MetricAffineGravity`A1==Rational[-3,2]xAct`PSALTer`MetricAffineGravity`A11+Rational[-1,2]xAct`PSALTer`MetricAffineGravity`A2+Rational[-3,2]xAct`PSALTer`MetricAffineGravity`A3+Rational[-1,2]xAct`PSALTer`MetricAffineGravity`A9,xAct`PSALTer`MetricAffineGravity`A0==Rational[9,8]xAct`PSALTer`MetricAffineGravity`A11+2xAct`PSALTer`MetricAffineGravity`A4+Rational[1,2]xAct`PSALTer`MetricAffineGravity`A5+Rational[9,2]xAct`PSALTer`MetricAffineGravity`A7+Rational[3,8]xAct`PSALTer`MetricAffineGravity`A9,xAct`PSALTer`MetricAffineGravity`C9==0,xAct`PSALTer`MetricAffineGravity`C8==0,xAct`PSALTer`MetricAffineGravity`C7==0,xAct`PSALTer`MetricAffineGravity`C5==(-2)xAct`PSALTer`MetricAffineGravity`C6,xAct`PSALTer`MetricAffineGravity`C4==xAct`PSALTer`MetricAffineGravity`C6,xAct`PSALTer`MetricAffineGravity`C3==-xAct`PSALTer`MetricAffineGravity`C6,xAct`PSALTer`MetricAffineGravity`C2==Rational[1,2]xAct`PSALTer`MetricAffineGravity`C6,xAct`PSALTer`MetricAffineGravity`C16==0,xAct`PSALTer`MetricAffineGravity`C15==0,xAct`PSALTer`MetricAffineGravity`C14==0,xAct`PSALTer`MetricAffineGravity`C12==0,xAct`PSALTer`MetricAffineGravity`C11==0,xAct`PSALTer`MetricAffineGravity`C10==0,xAct`PSALTer`MetricAffineGravity`C1==Rational[-1,2]xAct`PSALTer`MetricAffineGravity`C6];

DefiningSystem//=First@Solve[#,AllCouplings]&;
LinearLagrangian=Measure*NonlinearLagrangian/.DefiningSystem;
DisplayExpression[LinearLagrangian,EqnLabel->"ConcurrentTheory"];
LinearLagrangian//=LineariseLagrangian;
Comment@"Now we want to try this using the second order formalism.";
LinearLagrangian=LineariseLagrangian[LinearLagrangian,Formulation->SecondOrder];
ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"ConcurrentTheory",	
		Method->"Hard",
		MaxLaurentDepth->1];
Comment@{"Some comments can be made about concurrent."};
