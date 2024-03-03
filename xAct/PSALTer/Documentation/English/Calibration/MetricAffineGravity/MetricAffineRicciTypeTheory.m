(*===============================*)
(*  MetricAffineRicciTypeTheory  *)
(*===============================*)

Section@"Ricci-type";

Comment@"We will study the general Ricci-type theory in full metric affine geometry.";

LinearLagrangian=Measure*NonlinearLagrangian/.{xAct`PSALTer`MetricAffineGravity`A1->0,xAct`PSALTer`MetricAffineGravity`A2->0,xAct`PSALTer`MetricAffineGravity`A3->0,xAct`PSALTer`MetricAffineGravity`A4->0,xAct`PSALTer`MetricAffineGravity`A5->0,xAct`PSALTer`MetricAffineGravity`A6->0,xAct`PSALTer`MetricAffineGravity`A7->0,xAct`PSALTer`MetricAffineGravity`A8->0,xAct`PSALTer`MetricAffineGravity`A9->0,xAct`PSALTer`MetricAffineGravity`A10->0,xAct`PSALTer`MetricAffineGravity`A11->0,xAct`PSALTer`MetricAffineGravity`C1->0,xAct`PSALTer`MetricAffineGravity`C2->0,xAct`PSALTer`MetricAffineGravity`C3->0,xAct`PSALTer`MetricAffineGravity`C4->0,xAct`PSALTer`MetricAffineGravity`C5->0,xAct`PSALTer`MetricAffineGravity`C6->0,xAct`PSALTer`MetricAffineGravity`C16->0};

DisplayExpression[LinearLagrangian,EqnLabel->"MetricAffineRicciTypeTheory"];
LinearLagrangian//=LineariseLagrangian;
ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"MetricAffineRicciTypeTheory",	
		Method->"Hard",
		MaxLaurentDepth->1];
Comment@{"So generically from",Cref@"MetricAffineRicciTypeTheory"," we expect a massless higher-spin particle and also a pair of positive- and negative-parity massive vectors. To my understanding this is perfectly consistent with the claims in Section C1 of Carlo's draft (i.e. I can recover Eq. (28) and Eq. (29) perfectly)."};
