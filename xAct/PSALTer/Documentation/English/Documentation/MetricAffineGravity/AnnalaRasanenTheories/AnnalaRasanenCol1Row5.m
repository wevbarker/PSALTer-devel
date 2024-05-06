(*=========================*)
(*  AnnalaRasanenCol1Row5  *)
(*=========================*)

Subsection@"Annala-Räsänen column 1 row 5";
Comment@"Here is our `minimal model' Lagrangian.";
Col1Row5=ARNonlinearLagrangian/.{C1->0,C2->0,C3->0,C4->0};
DisplayExpression@Col1Row5;
LinearLagrangian=ARLinearLagrangian/.{C1->0,C2->0,C3->0,C4->0};
Code[LinearLagrangian,
	ParticleSpectrum[LinearLagrangian,
			TheoryName->"AnnalaRasanenCol1Row5",
			Method->"Easy",
			MaxLaurentDepth->1];
];
Comment@"Needs checking, looks like a healthy vector?";
