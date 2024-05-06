(*=========================*)
(*  AnnalaRasanenCol1Row3  *)
(*=========================*)

Subsection@"Annala-Räsänen column 1 row 3";
Comment@"Here is our `minimal model' Lagrangian.";
Col1Row3=ARNonlinearLagrangian/.{C1->0,C2->0,C4->0,C5->0};
DisplayExpression@Col1Row3;
LinearLagrangian=ARLinearLagrangian/.{C1->0,C2->0,C4->0,C5->0};
Code[LinearLagrangian,
	ParticleSpectrum[LinearLagrangian,
			TheoryName->"AnnalaRasanenCol1Row3",	
			Method->"Easy",
			MaxLaurentDepth->1];
];
Comment@"Needs checking, looks like ghosts?";
