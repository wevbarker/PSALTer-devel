(*=========================*)
(*  MarzoZellBarkerModel3  *)
(*=========================*)

Subsection@"Model 3";
Comment@"We will study Model 3.";
LinearLagrangian=Measure*NonlinearLagrangian/.{A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0,C1->0,C2->0,C3->0,C4->0,C5->0,C6->0,C7->0,C8->0,C9->0,C10->0,C11->0,C12->0,C14->0,C15->0,C16->0};
DisplayExpression[LinearLagrangian,EqnLabel->"MetricAffineEinsteinHilbertTheory"];
LinearLagrangian//=MetricAffineLineariseLagrangian;
Code[LinearLagrangian,
ParticleSpectrum[LinearLagrangian,
		TheoryName->"MarzoZellBarkerModel3",	
		Method->"Hard",
		MaxLaurentDepth->3];
];
Comment@{"Some comments can be made about Model 3."};
