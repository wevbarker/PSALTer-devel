(*=========================*)
(*  AnnalaRasanenCol1Row1  *)
(*=========================*)

Subsection@"Annala-Räsänen column 1 row 1";
Comment@"Here is our `minimal model' Lagrangian.";
Col1Row1=ARNonlinearLagrangian/.{C2->0,C3->0,C4->0,C5->0};
DisplayExpression@Col1Row1;
LinearLagrangian=ARLinearLagrangian/.{C2->0,C3->0,C4->0,C5->0};
Code[LinearLagrangian,
	ParticleSpectrum[LinearLagrangian,
			TheoryName->"AnnalaRasanenCol1Row1",
			Method->"Easy",
			MaxLaurentDepth->1];
];
Comment@"Looks good, no new d.o.fs.";
