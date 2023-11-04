(*=========================*)
(*  MarzoZellBarkerModel3  *)
(*=========================*)

Section@"Model 3";

Comment@"We will study Model 3.";
LinearLagrangian=Measure*NonlinearLagrangian/.{xAct`PSALTer`MetricAffineGravity`A1->0,xAct`PSALTer`MetricAffineGravity`A2->0,xAct`PSALTer`MetricAffineGravity`A3->0,xAct`PSALTer`MetricAffineGravity`A4->0,xAct`PSALTer`MetricAffineGravity`A5->0,xAct`PSALTer`MetricAffineGravity`A6->0,xAct`PSALTer`MetricAffineGravity`A7->0,xAct`PSALTer`MetricAffineGravity`A8->0,xAct`PSALTer`MetricAffineGravity`A9->0,xAct`PSALTer`MetricAffineGravity`A10->0,xAct`PSALTer`MetricAffineGravity`A11->0,xAct`PSALTer`MetricAffineGravity`C1->0,xAct`PSALTer`MetricAffineGravity`C2->0,xAct`PSALTer`MetricAffineGravity`C3->0,xAct`PSALTer`MetricAffineGravity`C4->0,xAct`PSALTer`MetricAffineGravity`C5->0,xAct`PSALTer`MetricAffineGravity`C6->0,xAct`PSALTer`MetricAffineGravity`C7->0,xAct`PSALTer`MetricAffineGravity`C8->0,xAct`PSALTer`MetricAffineGravity`C9->0,xAct`PSALTer`MetricAffineGravity`C10->0,xAct`PSALTer`MetricAffineGravity`C11->0,xAct`PSALTer`MetricAffineGravity`C12->0,xAct`PSALTer`MetricAffineGravity`C14->0,xAct`PSALTer`MetricAffineGravity`C15->0,xAct`PSALTer`MetricAffineGravity`C16->0};
DisplayExpression[LinearLagrangian,EqnLabel->"MetricAffineEinsteinHilbertTheory"];
LinearLagrangian//=LineariseLagrangian;
ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"MarzoZellBarkerModel3",	
		Method->"Hard",
		MaxLaurentDepth->3];
Comment@{"Some comments can be made about Model 3."};
