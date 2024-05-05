(*=========================*)
(*  AnnalaRasanenCol3Row4  *)
(*=========================*)

Subsection@"Annala-Räsänen column 3 row 4";

Comment@"Here is our `minimal model' Lagrangian.";
Col3Row4=ARNonlinearLagrangian/.{H1->0,H2->0,H3->0};
DisplayExpression@Col3Row4;
LinearLagrangian=ARLinearLagrangian/.{H1->0,H2->0,H3->0};
ParticleSpectrum[LinearLagrangian,
		ClassName->"ZeroTorsionPalatini",
		TheoryName->"AnnalaRasanenCol3Row4",
		Method->"Easy",
		MaxLaurentDepth->1];
Comment@"Looks good, ghosts.";
