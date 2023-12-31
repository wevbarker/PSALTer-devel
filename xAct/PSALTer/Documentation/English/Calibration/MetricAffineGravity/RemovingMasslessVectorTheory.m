(*==========================*)
(*  RemovingMasslessVector  *)
(*==========================*)

Section@"Ricci-type without massless vector";

Comment@"We will now study the Ricci-type theory without the massless vector. To do this, we impose Carlo's conditions as presented in Eq. (33) of the draft.";

LinearLagrangian=Measure*NonlinearLagrangian/.{xAct`PSALTer`MetricAffineGravity`A1->0,xAct`PSALTer`MetricAffineGravity`A2->0,xAct`PSALTer`MetricAffineGravity`A3->0,xAct`PSALTer`MetricAffineGravity`A4->0,xAct`PSALTer`MetricAffineGravity`A5->0,xAct`PSALTer`MetricAffineGravity`A6->0,xAct`PSALTer`MetricAffineGravity`A7->0,xAct`PSALTer`MetricAffineGravity`A8->0,xAct`PSALTer`MetricAffineGravity`A9->0,xAct`PSALTer`MetricAffineGravity`A10->0,xAct`PSALTer`MetricAffineGravity`A11->0,xAct`PSALTer`MetricAffineGravity`C1->0,xAct`PSALTer`MetricAffineGravity`C2->0,xAct`PSALTer`MetricAffineGravity`C3->0,xAct`PSALTer`MetricAffineGravity`C4->0,xAct`PSALTer`MetricAffineGravity`C5->0,xAct`PSALTer`MetricAffineGravity`C6->0,xAct`PSALTer`MetricAffineGravity`C16->0};

RemovingMasslessVectorConstraint={xAct`PSALTer`MetricAffineGravity`C9->xAct`PSALTer`MetricAffineGravity`C10-xAct`PSALTer`MetricAffineGravity`C11+xAct`PSALTer`MetricAffineGravity`C12+16xAct`PSALTer`MetricAffineGravity`C13-xAct`PSALTer`MetricAffineGravity`C7+xAct`PSALTer`MetricAffineGravity`C8,xAct`PSALTer`MetricAffineGravity`C15->8xAct`PSALTer`MetricAffineGravity`C13-xAct`PSALTer`MetricAffineGravity`C14};

DisplayExpression[RemovingMasslessVectorConstraint,EqnLabel->"RemovingMasslessVectorConstraint"];

Comment@{"So imposing",Cref@"RemovingMasslessVectorConstraint"," on the theory in",Cref@"MetricAffineRicciTypeTheory"," we obtain the following."};

LinearLagrangian=LinearLagrangian/.RemovingMasslessVectorConstraint;

DisplayExpression[LinearLagrangian,EqnLabel->"MetricAffineEinsteinHilbertTheory"];
LinearLagrangian//=LineariseLagrangian;
ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"RemovingMasslessVector",	
		Method->"Hard",
		MaxLaurentDepth->1];
Comment@{"So it seems in this case that",Cref@"RemovingMasslessVectorConstraint"," did not yet kill off the extra massless particle. Despite this, I believe we can confirm both the residue and the mass of the parity-even vector in Eq. (34) and Eq. (36). There is a clear problem with the mass (and perhaps the residue, even after reduction) of the parity-odd vector."};
