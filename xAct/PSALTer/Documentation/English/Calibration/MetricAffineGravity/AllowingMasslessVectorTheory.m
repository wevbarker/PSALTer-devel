(*================================*)
(*  AllowingMasslessVectorTheory  *)
(*================================*)

Section@"Ricci-type with massless vector";

Comment@"We will study the Ricci-type theory with the massless vector and a corresponding constraint on the massive sector.";

LinearLagrangian=Measure*NonlinearLagrangian/.{xAct`PSALTer`MetricAffineGravity`A1->0,xAct`PSALTer`MetricAffineGravity`A2->0,xAct`PSALTer`MetricAffineGravity`A3->0,xAct`PSALTer`MetricAffineGravity`A4->0,xAct`PSALTer`MetricAffineGravity`A5->0,xAct`PSALTer`MetricAffineGravity`A6->0,xAct`PSALTer`MetricAffineGravity`A7->0,xAct`PSALTer`MetricAffineGravity`A8->0,xAct`PSALTer`MetricAffineGravity`A9->0,xAct`PSALTer`MetricAffineGravity`A10->0,xAct`PSALTer`MetricAffineGravity`A11->0,xAct`PSALTer`MetricAffineGravity`C1->0,xAct`PSALTer`MetricAffineGravity`C2->0,xAct`PSALTer`MetricAffineGravity`C3->0,xAct`PSALTer`MetricAffineGravity`C4->0,xAct`PSALTer`MetricAffineGravity`C5->0,xAct`PSALTer`MetricAffineGravity`C6->0,xAct`PSALTer`MetricAffineGravity`C16->0};

LinearLagrangian=LinearLagrangian=/.{xAct`PSALTer`MetricAffineGravity`C7->xAct`PSALTer`MetricAffineGravity`C8-xAct`PSALTer`MetricAffineGravity`C9+xAct`PSALTer`MetricAffineGravity`C10-xAct`PSALTer`MetricAffineGravity`C11+xAct`PSALTer`MetricAffineGravity`C12+(xAct`PSALTer`MetricAffineGravity`C14+xAct`PSALTer`MetricAffineGravity`C15)^2/(4xAct`PSALTer`MetricAffineGravity`C13)};

DisplayExpression[LinearLagrangian,EqnLabel->"MetricAffineEinsteinHilbertTheory"];
LinearLagrangian//=LineariseLagrangian;
ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"AllowingMasslessVectorTheory",	
		Method->"Hard",
		MaxLaurentDepth->1];
Comment@{"Some comments can be made about Ricci-type."};
