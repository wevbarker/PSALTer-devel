(*=========================*)
(*  AnnalaRasanenCol3Row1  *)
(*=========================*)

Subsection@"Annala-Räsänen column 3 row 1";

Comment@"Here is our `minimal model' Lagrangian.";
Col3Row1=ARNonlinearLagrangian/.{H2->0,H3->0,H4->0};
DisplayExpression@Col3Row1;
LinearLagrangian=ARLinearLagrangian/.{H2->0,H3->0,H4->0};
ParticleSpectrum[LinearLagrangian,
		ClassName->"ZeroTorsionPalatini",
		TheoryName->"AnnalaRasanenCol3Row1",	
		Method->"Easy",
		MaxLaurentDepth->1];
Comment@"Looks good, no new d.o.fs.";
