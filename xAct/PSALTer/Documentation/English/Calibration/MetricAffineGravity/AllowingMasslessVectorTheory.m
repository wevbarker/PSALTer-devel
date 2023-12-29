(*================================*)
(*  AllowingMasslessVectorTheory  *)
(*================================*)

Section@"Ricci-type with massless vector";

Comment@"We will study the Ricci-type theory with the massless vector. The condition in Eq. (32) is a little bit tricky to impose, because it is not linear in the couplings (PSALTer would need some modifications to accommodate for this), so instead we try a more restrictive version as follows.";

LinearLagrangian=Measure*NonlinearLagrangian/.{xAct`PSALTer`MetricAffineGravity`A1->0,xAct`PSALTer`MetricAffineGravity`A2->0,xAct`PSALTer`MetricAffineGravity`A3->0,xAct`PSALTer`MetricAffineGravity`A4->0,xAct`PSALTer`MetricAffineGravity`A5->0,xAct`PSALTer`MetricAffineGravity`A6->0,xAct`PSALTer`MetricAffineGravity`A7->0,xAct`PSALTer`MetricAffineGravity`A8->0,xAct`PSALTer`MetricAffineGravity`A9->0,xAct`PSALTer`MetricAffineGravity`A10->0,xAct`PSALTer`MetricAffineGravity`A11->0,xAct`PSALTer`MetricAffineGravity`C1->0,xAct`PSALTer`MetricAffineGravity`C2->0,xAct`PSALTer`MetricAffineGravity`C3->0,xAct`PSALTer`MetricAffineGravity`C4->0,xAct`PSALTer`MetricAffineGravity`C5->0,xAct`PSALTer`MetricAffineGravity`C6->0,xAct`PSALTer`MetricAffineGravity`C16->0};

AllowingMasslessVectorTheoryConstraint={xAct`PSALTer`MetricAffineGravity`C7->xAct`PSALTer`MetricAffineGravity`C8-xAct`PSALTer`MetricAffineGravity`C9+xAct`PSALTer`MetricAffineGravity`C10-xAct`PSALTer`MetricAffineGravity`C11+xAct`PSALTer`MetricAffineGravity`C12,xAct`PSALTer`MetricAffineGravity`C14->-xAct`PSALTer`MetricAffineGravity`C15};

DisplayExpression[AllowingMasslessVectorTheoryConstraint,EqnLabel->"AllowingMasslessVectorTheoryConstraint"];

Comment@{"So imposing",Cref@"AllowingMasslessVectorTheoryConstraint"," on the theory in",Cref@"MetricAffineRicciTypeTheory"," we obtain the following."};

LinearLagrangian=LinearLagrangian/.AllowingMasslessVectorTheoryConstraint;

DisplayExpression[LinearLagrangian,EqnLabel->"MetricAffineEinsteinHilbertTheory"];
LinearLagrangian//=LineariseLagrangian;
ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"AllowingMasslessVectorTheory",	
		Method->"Hard",
		MaxLaurentDepth->1];
Comment@{"The conclusion we reach from",Cref@"AllowingMasslessVectorTheory"," is that by using",Cref@"AllowingMasslessVectorTheoryConstraint"," we can kill off both the massive poles and keep a unitary massless mode in the spectrum alongside the graviton. This seems to contradict the conclusion of the draft as it stands, so probably this is a worthwhile special-case to consider."};
