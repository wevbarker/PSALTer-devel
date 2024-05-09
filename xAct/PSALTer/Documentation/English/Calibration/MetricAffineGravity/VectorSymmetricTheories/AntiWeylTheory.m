(*==================*)
(*  AntiWeylTheory  *)
(*==================*)

Section@"The anti-Weyl theory";

Comment@"We will study the anti-Weyl symmetry.";

DefiningSystem=And[xAct`PSALTer`MetricAffineGravity`A4==(-2)xAct`PSALTer`MetricAffineGravity`A7+Rational[1,2]xAct`PSALTer`MetricAffineGravity`A8,xAct`PSALTer`MetricAffineGravity`A11==Rational[4,3]xAct`PSALTer`MetricAffineGravity`A5+Rational[4,3]xAct`PSALTer`MetricAffineGravity`A7+Rational[8,3]xAct`PSALTer`MetricAffineGravity`A8+Rational[-1,3]xAct`PSALTer`MetricAffineGravity`A9,xAct`PSALTer`MetricAffineGravity`A10==Rational[-4,3]xAct`PSALTer`MetricAffineGravity`A5+Rational[-4,3]xAct`PSALTer`MetricAffineGravity`A7+Rational[-8,3]xAct`PSALTer`MetricAffineGravity`A8+Rational[1,3]xAct`PSALTer`MetricAffineGravity`A9,xAct`PSALTer`MetricAffineGravity`A1==Rational[-1,2]xAct`PSALTer`MetricAffineGravity`A2+Rational[-3,2]xAct`PSALTer`MetricAffineGravity`A3-2xAct`PSALTer`MetricAffineGravity`A5-2xAct`PSALTer`MetricAffineGravity`A7-4xAct`PSALTer`MetricAffineGravity`A8,xAct`PSALTer`MetricAffineGravity`A0==2xAct`PSALTer`MetricAffineGravity`A5+2xAct`PSALTer`MetricAffineGravity`A7+4xAct`PSALTer`MetricAffineGravity`A8,xAct`PSALTer`MetricAffineGravity`C9==0,xAct`PSALTer`MetricAffineGravity`C8==0,xAct`PSALTer`MetricAffineGravity`C7==0,xAct`PSALTer`MetricAffineGravity`C6==0,xAct`PSALTer`MetricAffineGravity`C5==0,xAct`PSALTer`MetricAffineGravity`C4==0,xAct`PSALTer`MetricAffineGravity`C3==0,xAct`PSALTer`MetricAffineGravity`C2==0,xAct`PSALTer`MetricAffineGravity`C16==0,xAct`PSALTer`MetricAffineGravity`C15==0,xAct`PSALTer`MetricAffineGravity`C14==0,xAct`PSALTer`MetricAffineGravity`C12==0,xAct`PSALTer`MetricAffineGravity`C11==0,xAct`PSALTer`MetricAffineGravity`C10==0,xAct`PSALTer`MetricAffineGravity`C1==0];

DefiningSystem//=Quiet@First@Solve[#,AllCouplings]&;
LinearLagrangian=NonlinearLagrangian/.DefiningSystem;
DisplayExpression[LinearLagrangian,EqnLabel->"AntiWeylTheory"];

(*Comment@{"First we study",Cref@"AntiWeylTheory"," in the first-order formulation."};*)
LinearLagrangian*=Measure;
LinearLagrangian//=MetricAffineLineariseLagrangian;
(*
ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"AntiWeylTheory",	
		Method->"Hard",
		MaxLaurentDepth->1];
*)
Comment@{"We study",Cref@"AntiWeylTheory"," in the second-order formulation."};
LinearLagrangian=MetricAffineLineariseLagrangian[LinearLagrangian,Formulation->SecondOrder];
ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"AntiWeylTheorySecondOrder",	
		Method->"Hard",
		MaxLaurentDepth->1];
Supercomment@{"A massive vector accompanies the graviton, and the whole theory may be made to be unitary."};
