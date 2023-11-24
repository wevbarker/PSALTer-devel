(*==========*)
(*  TypeII  *)
(*==========*)

Section@"Type II";

Comment@"We will study Type II.";

DefiningSystem=(-xAct`PSALTer`MetricAffineGravity`A11==xAct`PSALTer`MetricAffineGravity`A10&&1/2(-2xAct`PSALTer`MetricAffineGravity`A5-8xAct`PSALTer`MetricAffineGravity`A6-2xAct`PSALTer`MetricAffineGravity`A7-5xAct`PSALTer`MetricAffineGravity`A8)==xAct`PSALTer`MetricAffineGravity`A4&&-2(4xAct`PSALTer`MetricAffineGravity`A6-2xAct`PSALTer`MetricAffineGravity`A7+xAct`PSALTer`MetricAffineGravity`A8)==xAct`PSALTer`MetricAffineGravity`A0&&xAct`PSALTer`MetricAffineGravity`C10==0&&xAct`PSALTer`MetricAffineGravity`C11==0&&xAct`PSALTer`MetricAffineGravity`C12==0&&xAct`PSALTer`MetricAffineGravity`C13==0&&xAct`PSALTer`MetricAffineGravity`C14==0&&xAct`PSALTer`MetricAffineGravity`C15==0&&xAct`PSALTer`MetricAffineGravity`C16==0&&-2xAct`PSALTer`MetricAffineGravity`C6==xAct`PSALTer`MetricAffineGravity`C5&&-xAct`PSALTer`MetricAffineGravity`C6==xAct`PSALTer`MetricAffineGravity`C3&&-(xAct`PSALTer`MetricAffineGravity`C6/2)==xAct`PSALTer`MetricAffineGravity`C1&&xAct`PSALTer`MetricAffineGravity`C6/2==xAct`PSALTer`MetricAffineGravity`C2&&xAct`PSALTer`MetricAffineGravity`C6==xAct`PSALTer`MetricAffineGravity`C4&&xAct`PSALTer`MetricAffineGravity`C7==0&&xAct`PSALTer`MetricAffineGravity`C8==0&&xAct`PSALTer`MetricAffineGravity`C9==0);
DefiningSystem=First@Solve[DefiningSystem,{xAct`PSALTer`MetricAffineGravity`A0,xAct`PSALTer`MetricAffineGravity`A1,xAct`PSALTer`MetricAffineGravity`A2,xAct`PSALTer`MetricAffineGravity`A3,xAct`PSALTer`MetricAffineGravity`A4,xAct`PSALTer`MetricAffineGravity`A5,xAct`PSALTer`MetricAffineGravity`A6,xAct`PSALTer`MetricAffineGravity`A7,xAct`PSALTer`MetricAffineGravity`A9,xAct`PSALTer`MetricAffineGravity`A9,xAct`PSALTer`MetricAffineGravity`A10,xAct`PSALTer`MetricAffineGravity`A11,xAct`PSALTer`MetricAffineGravity`C1,xAct`PSALTer`MetricAffineGravity`C2,xAct`PSALTer`MetricAffineGravity`C3,xAct`PSALTer`MetricAffineGravity`C4,xAct`PSALTer`MetricAffineGravity`C5,xAct`PSALTer`MetricAffineGravity`C6,xAct`PSALTer`MetricAffineGravity`C7,xAct`PSALTer`MetricAffineGravity`C8,xAct`PSALTer`MetricAffineGravity`C9,xAct`PSALTer`MetricAffineGravity`C10,xAct`PSALTer`MetricAffineGravity`C11,xAct`PSALTer`MetricAffineGravity`C12,xAct`PSALTer`MetricAffineGravity`C13,xAct`PSALTer`MetricAffineGravity`C14,xAct`PSALTer`MetricAffineGravity`C15,xAct`PSALTer`MetricAffineGravity`C16}];

LinearLagrangian=Measure*NonlinearLagrangian/.DefiningSystem;
DisplayExpression[LinearLagrangian,EqnLabel->"MetricAffineEinsteinHilbertTheory"];
LinearLagrangian//=LineariseLagrangian;
ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"TypeII",	
		Method->"Hard",
		MaxLaurentDepth->1];
Comment@{"Some comments can be made about Type II."};
