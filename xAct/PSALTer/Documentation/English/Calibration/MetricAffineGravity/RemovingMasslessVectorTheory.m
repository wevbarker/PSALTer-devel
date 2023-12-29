(*==========================*)
(*  RemovingMasslessVector  *)
(*==========================*)

Section@"Ricci-type without massless vector";

Comment@"We will study the Ricci-type theory without the massless vector and a corresponding constraint on the massless sector.";

LinearLagrangian=Measure*NonlinearLagrangian/.{xAct`PSALTer`MetricAffineGravity`A1->0,xAct`PSALTer`MetricAffineGravity`A2->0,xAct`PSALTer`MetricAffineGravity`A3->0,xAct`PSALTer`MetricAffineGravity`A4->0,xAct`PSALTer`MetricAffineGravity`A5->0,xAct`PSALTer`MetricAffineGravity`A6->0,xAct`PSALTer`MetricAffineGravity`A7->0,xAct`PSALTer`MetricAffineGravity`A8->0,xAct`PSALTer`MetricAffineGravity`A9->0,xAct`PSALTer`MetricAffineGravity`A10->0,xAct`PSALTer`MetricAffineGravity`A11->0,xAct`PSALTer`MetricAffineGravity`C1->0,xAct`PSALTer`MetricAffineGravity`C2->0,xAct`PSALTer`MetricAffineGravity`C3->0,xAct`PSALTer`MetricAffineGravity`C4->0,xAct`PSALTer`MetricAffineGravity`C5->0,xAct`PSALTer`MetricAffineGravity`C6->0,xAct`PSALTer`MetricAffineGravity`C16->0};

LinearLagrangian=LinearLagrangian/.{xAct`PSALTer`MetricAffineGravity`C9->xAct`PSALTer`MetricAffineGravity`C10-xAct`PSALTer`MetricAffineGravity`C11+xAct`PSALTer`MetricAffineGravity`C12+16xAct`PSALTer`MetricAffineGravity`C13-xAct`PSALTer`MetricAffineGravity`C7+xAct`PSALTer`MetricAffineGravity`C8,xAct`PSALTer`MetricAffineGravity`C15->(8xAct`PSALTer`MetricAffineGravity`C13-xAct`PSALTer`MetricAffineGravity`C14)/8};

DisplayExpression[LinearLagrangian,EqnLabel->"MetricAffineEinsteinHilbertTheory"];
LinearLagrangian//=LineariseLagrangian;
ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"RemovingMasslessVector",	
		Method->"Hard",
		MaxLaurentDepth->1];
Comment@{"Some comments can be made about Ricci-type."};
