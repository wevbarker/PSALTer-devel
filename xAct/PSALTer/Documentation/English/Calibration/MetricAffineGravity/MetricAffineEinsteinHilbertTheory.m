(*=====================================*)
(*  MetricAffineEinsteinHilbertTheory  *)
(*=====================================*)

Section@"Einstein-Hilbert theory";

Comment@"The first theory we will look at is the simple Einstein-Hilbert case.";

LinearLagrangian=Measure*NonlinearLagrangian/.{xAct`PSALTer`MetricAffineGravity`A1->0,xAct`PSALTer`MetricAffineGravity`A2->0,xAct`PSALTer`MetricAffineGravity`A3->0,xAct`PSALTer`MetricAffineGravity`A4->0,xAct`PSALTer`MetricAffineGravity`A5->0,xAct`PSALTer`MetricAffineGravity`A6->0,xAct`PSALTer`MetricAffineGravity`A7->0,xAct`PSALTer`MetricAffineGravity`A8->0,xAct`PSALTer`MetricAffineGravity`A9->0,xAct`PSALTer`MetricAffineGravity`A10->0,xAct`PSALTer`MetricAffineGravity`A11->0,xAct`PSALTer`MetricAffineGravity`C1->0,xAct`PSALTer`MetricAffineGravity`C2->0,xAct`PSALTer`MetricAffineGravity`C3->0,xAct`PSALTer`MetricAffineGravity`C4->0,xAct`PSALTer`MetricAffineGravity`C5->0,xAct`PSALTer`MetricAffineGravity`C6->0,xAct`PSALTer`MetricAffineGravity`C7->0,xAct`PSALTer`MetricAffineGravity`C8->0,xAct`PSALTer`MetricAffineGravity`C9->0,xAct`PSALTer`MetricAffineGravity`C10->0,xAct`PSALTer`MetricAffineGravity`C11->0,xAct`PSALTer`MetricAffineGravity`C12->0,xAct`PSALTer`MetricAffineGravity`C13->0,xAct`PSALTer`MetricAffineGravity`C14->0,xAct`PSALTer`MetricAffineGravity`C15->0,xAct`PSALTer`MetricAffineGravity`C16->0};
DisplayExpression[LinearLagrangian,EqnLabel->"MetricAffineEinsteinHilbertTheory"];
LinearLagrangian//=LineariseLagrangian;
ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"MetricAffineEinsteinHilbertTheory",	
		Method->"Hard",
		MaxLaurentDepth->3];
Comment@{"We find that there are no massive poles, and hence no massive gravitons. There are however two massless degrees of freedom which we take to be the graviton polarisations. The unitarity conditions of these polarisations just make sure that the Einstein--Hilbert coupling carries the right sign, i.e. that the square of the Planck mass is positive. The spectra",Cref@{"MetricAffineEinsteinHilbertTheory","EinsteinCartanTheory","GeneralRelativity"}," are all the same."};

Comment@"Now we want to try this using the second order formalism.";

LinearLagrangian=Measure*NonlinearLagrangian/.{xAct`PSALTer`MetricAffineGravity`A1->0,xAct`PSALTer`MetricAffineGravity`A2->0,xAct`PSALTer`MetricAffineGravity`A3->0,xAct`PSALTer`MetricAffineGravity`A4->0,xAct`PSALTer`MetricAffineGravity`A5->0,xAct`PSALTer`MetricAffineGravity`A6->0,xAct`PSALTer`MetricAffineGravity`A7->0,xAct`PSALTer`MetricAffineGravity`A8->0,xAct`PSALTer`MetricAffineGravity`A9->0,xAct`PSALTer`MetricAffineGravity`A10->0,xAct`PSALTer`MetricAffineGravity`A11->0,xAct`PSALTer`MetricAffineGravity`C1->0,xAct`PSALTer`MetricAffineGravity`C2->0,xAct`PSALTer`MetricAffineGravity`C3->0,xAct`PSALTer`MetricAffineGravity`C4->0,xAct`PSALTer`MetricAffineGravity`C5->0,xAct`PSALTer`MetricAffineGravity`C6->0,xAct`PSALTer`MetricAffineGravity`C7->0,xAct`PSALTer`MetricAffineGravity`C8->0,xAct`PSALTer`MetricAffineGravity`C9->0,xAct`PSALTer`MetricAffineGravity`C10->0,xAct`PSALTer`MetricAffineGravity`C11->0,xAct`PSALTer`MetricAffineGravity`C12->0,xAct`PSALTer`MetricAffineGravity`C13->0,xAct`PSALTer`MetricAffineGravity`C14->0,xAct`PSALTer`MetricAffineGravity`C15->0,xAct`PSALTer`MetricAffineGravity`C16->0};
DisplayExpression[LinearLagrangian,EqnLabel->"MetricAffineEinsteinHilbertTheory"];
LinearLagrangian=LineariseLagrangian[LinearLagrangian,Formulation->SecondOrder];

DisplayExpression[LinearLagrangian,EqnLabel->"MetricAffineEinsteinHilbertTheorySecondOrder"];
ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"MetricAffineEinsteinHilbertTheorySecondOrder",	
		Method->"Hard",
		MaxLaurentDepth->3];
