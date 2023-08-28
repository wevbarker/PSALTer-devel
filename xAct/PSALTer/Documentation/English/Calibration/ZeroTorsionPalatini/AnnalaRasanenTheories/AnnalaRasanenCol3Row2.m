(*=========================*)
(*  AnnalaRasanenCol3Row2  *)
(*=========================*)

Subsection@"Annala-Räsänen column 3 row 2";

Comment@"Here is our `minimal model' Lagrangian.";
Col3Row2=ARNonlinearLagrangian/.{H1->0,H3->0,H4->0};
DisplayExpression@Col3Row2;
LinearLagrangian=ARLinearLagrangian/.{H1->0,H3->0,H4->0};
ParticleSpectrum[LinearLagrangian,
		ClassName->"ZeroTorsionPalatini",
		TheoryName->"AnnalaRasanenCol3Row2",
		Method->"Easy",
		MaxLaurentDepth->1];
Comment@"Looks good, healthy vector.";
