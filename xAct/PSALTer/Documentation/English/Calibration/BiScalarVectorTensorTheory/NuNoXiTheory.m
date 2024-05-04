(*================*)
(*  NuNoXiTheory  *)
(*================*)

Section@"With Nu and no Xi";

NewLinearisedLagrangian=LinearisedLagrangian/.{CouplingXi->0};
DisplayExpression[NewLinearisedLagrangian,EqnLabel->"NuNoXiTheory"];
Code[
	ParticleSpectrum[
		LinearisedLagrangian,
		TheoryName->"NuNoXiTheory",	
		Method->"Easy",
		MaxLaurentDepth->3
	];
];
Comment@"Some comment can be made.";
