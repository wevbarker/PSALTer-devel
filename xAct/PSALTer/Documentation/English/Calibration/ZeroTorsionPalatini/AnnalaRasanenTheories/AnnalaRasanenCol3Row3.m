(*=========================*)
(*  AnnalaRasanenCol3Row3  *)
(*=========================*)

Subsection@"Annala-Räsänen column 3 row 3";

Comment@"Here is our `minimal model' Lagrangian.";
Col3Row3=ARNonlinearLagrangian/.{H1->0,H2->0,H4->0};
DisplayExpression@Col3Row3;
LinearLagrangian=ARLinearLagrangian/.{H1->0,H2->0,H4->0};
ParticleSpectrum[LinearLagrangian,
		ClassName->"ZeroTorsionPalatini",
		TheoryName->"AnnalaRasanenCol3Row3",	
		Method->"Easy",
		MaxLaurentDepth->1];
Supercomment@"Looks good, ghosts.";
