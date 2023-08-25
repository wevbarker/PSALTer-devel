(*=====================================*)
(*  MetricAffineEinsteinHilbertTheory  *)
(*=====================================*)

Section@"Einstein-Hilbert theory";

Comment@"The first theory we will look at is the simple Einstein-Hilbert case.";

LinearLagrangian=Measure*NonlinearLagrangian/.{A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0,C1->0,C2->0,C3->0,C4->0,C5->0,C6->0,C7->0,C8->0,C9->0,C10->0,C11->0,C12->0,C13->0,C14->0,C15->0,C16->0};

DisplayExpression@LinearLagrangian;

LinearLagrangian//=LineariseLagrangian;
DisplayExpression@LinearLagrangian;

ParticleSpectrum[NewLinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"MetricAffineEinsteinHilbertTheory",	
		Method->"Easy",
		MaxLaurentDepth->1];

Comment@"This completes the spectral analysis. We find that there are no massive poles, and hence no massive gravitons. There are however two massless degrees of freedom which we take to be the graviton polarisations. The unitarity conditions of these polarisations just make sure that the Einstein--Hilbert coupling carries the right sign, i.e. that the square of the Planck mass is positive. As usual with the PSALTer output, the unitarity conditions also stipulate that the energy (p) of the graviton be a real number, i.e. that its square be positive. This trivial condition typically accompanies the (non-trivial) unitarity condition(s) on the Lagrangian parameters, and is quite natural.";
