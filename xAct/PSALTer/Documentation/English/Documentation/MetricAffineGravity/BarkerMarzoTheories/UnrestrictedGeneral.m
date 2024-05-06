(*=======================*)
(*  UnrestrictedGeneral  *)
(*=======================*)

Subsection@"General Ricci-type";
Comment@"We will study the general Ricci-type theory in full metric affine geometry.";
LinearLagrangian=Measure*NonlinearLagrangian/.{A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0,C1->0,C2->0,C3->0,C4->0,C5->0,C6->0,C16->0};
DisplayExpression[LinearLagrangian,EqnLabel->"UnrestrictedGeneral"];
LinearLagrangian//=MetricAffineLineariseLagrangian;
Code[LinearLagrangian,
	ParticleSpectrum[LinearLagrangian,
			TheoryName->"UnrestrictedGeneralFirstOrder",	
			Method->"Hard",
			MaxLaurentDepth->1];
];
Comment@{"So generically from",Cref@"UnrestrictedGeneral"," we expect a massless higher-spin particle and also a pair of positive- and negative-parity massive vectors. To my understanding this is perfectly consistent with the claims in Section C1 of Carlo's draft (i.e. I can recover Eq. (28) and Eq. (29) perfectly)."};
LinearLagrangian=MetricAffineLineariseLagrangian[LinearLagrangian,Formulation->SecondOrder];
Code[LinearLagrangian,
	ParticleSpectrum[LinearLagrangian,
			TheoryName->"UnrestrictedGeneralSecondOrder",	
			Method->"Hard",
			MaxLaurentDepth->1];
];
