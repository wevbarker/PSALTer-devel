(*=========================*)
(*  AnnalaRasanenCol1Row2  *)
(*=========================*)

Subsection@"Annala-Räsänen column 1 row 2";

Comment@"Here is our `minimal model' Lagrangian.";
Col1Row2=ARNonlinearLagrangian/.{C1->0,C3->0,C4->0,C5->0};
DisplayExpression@Col1Row2;
LinearLagrangian=ARLinearLagrangian/.{C1->0,C3->0,C4->0,C5->0};
Code[
	ParticleSpectrum[LinearLagrangian,
			TheoryName->"AnnalaRasanenCol1Row2",
			Method->"Easy",
			MaxLaurentDepth->1];
];
Comment@"Looks good, ghosts.";
