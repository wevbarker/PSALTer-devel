(*=========================*)
(*  AnnalaRasanenCol1Row4  *)
(*=========================*)

Subsection@"Annala-Räsänen column 1 row 4";

Comment@"Here is our `minimal model' Lagrangian.";
Col1Row4=ARNonlinearLagrangian/.{C1->0,C2->0,C3->0,C5->0};
DisplayExpression@Col1Row4;
LinearLagrangian=ARLinearLagrangian/.{C1->0,C2->0,C3->0,C5->0};
ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"AnnalaRasanenCol1Row4",
		Method->"Easy",
		MaxLaurentDepth->1];
Comment@"Looks good, no new d.o.fs.";
