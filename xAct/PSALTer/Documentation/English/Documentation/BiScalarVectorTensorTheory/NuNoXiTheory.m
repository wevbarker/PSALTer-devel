(*================*)
(*  NuNoXiTheory  *)
(*================*)

Subsection@"With Nu and no Xi";
NewLinearisedLagrangian=LinearisedLagrangian/.{CouplingXi->0};
DisplayExpression[NewLinearisedLagrangian,EqnLabel->"NuNoXiTheory"];
Code[LinearisedLagrangian,
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"NuNoXiTheory",	
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
Comment@"This result was used in a manuscript in preparation.";
