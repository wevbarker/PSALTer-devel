(*=========================*)
(*  AnnalaRasanenTheories  *)
(*=========================*)

Section@"Annala-Räsänen theories";

Comment@"Now we need to extend to a representative Lagrangian which will cover the whole of the fourth column of Table 1 on page 14 of arXiv:2212.09820.";

ARNonlinearLagrangian=-(1/2)*(
	-xAct`PSALTer`MetricAffineGravity`A0*MetricAffineRicciScalar[]
	+(1/2)*C1*MetricAffineRicciTensor13[m,n]*(
		MetricAffineRicciTensor13[-m,-n]
		+MetricAffineRicciTensor13[-n,-m]
	)
	+(1/2)*C2*MetricAffineRicciTensor13[m,n]*(
		MetricAffineRicciTensor13[-m,-n]
		-MetricAffineRicciTensor13[-n,-m]
	)
	+C3*MetricAffineRicciTensorTri[m,n]*MetricAffineRicciTensorTri[-m,-n]
	+C4*MetricAffineRicciTensorP[m,n]*MetricAffineRicciTensorP[-m,-n]
	+C5*MetricAffineRicciTensor[m,n]*MetricAffineRicciTensor[-m,-n]
);

DisplayExpression[ARNonlinearLagrangian,EqnLabel->"MetricAffineARNonlinearLagrangian"];

Comment@{"Now we linearize",Cref@"MetricAffineARNonlinearLagrangian","."};

ARLinearLagrangian=Measure*ARNonlinearLagrangian//LineariseLagrangian;
DisplayExpression[ARLinearLagrangian,EqnLabel->"MetricAffineARLinearLagrangian"];

Subsection@"Annala-Räsänen column 1 row 1";

Comment@"Here is our `minimal model' Lagrangian.";
Col1Row1=ARNonlinearLagrangian/.{C2->0,C3->0,C4->0,C5->0};
DisplayExpression@Col1Row1;
LinearLagrangian=ARLinearLagrangian/.{C2->0,C3->0,C4->0,C5->0};
ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"AnnalaRasanenRow1",	
		Method->"Easy",
		MaxLaurentDepth->1];
Supercomment@"Looks good, no new d.o.fs.";

Subsection@"Annala-Räsänen column 1 row 2";

Comment@"Here is our `minimal model' Lagrangian.";
Col1Row2=ARNonlinearLagrangian/.{C1->0,C3->0,C4->0,C5->0};
DisplayExpression@Col1Row2;
LinearLagrangian=ARLinearLagrangian/.{C1->0,C3->0,C4->0,C5->0};
ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"AnnalaRasanenRow2",	
		Method->"Easy",
		MaxLaurentDepth->1];
Supercomment@"Looks good, ghosts.";

Subsection@"Annala-Räsänen column 1 row 3";

Comment@"Here is our `minimal model' Lagrangian.";
Col1Row3=ARNonlinearLagrangian/.{C1->0,C2->0,C4->0,C5->0};
DisplayExpression@Col1Row3;
LinearLagrangian=ARLinearLagrangian/.{C1->0,C2->0,C4->0,C5->0};
ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"AnnalaRasanenRow3",	
		Method->"Easy",
		MaxLaurentDepth->1];
Supercomment@"Needs checking, looks like ghosts?";

Subsection@"Annala-Räsänen column 1 row 4";

Comment@"Here is our `minimal model' Lagrangian.";
Col1Row4=ARNonlinearLagrangian/.{C1->0,C2->0,C3->0,C5->0};
DisplayExpression@Col1Row4;
LinearLagrangian=ARLinearLagrangian/.{C1->0,C2->0,C3->0,C5->0};
ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"AnnalaRasanenRow4",	
		Method->"Easy",
		MaxLaurentDepth->1];
Supercomment@"Looks good, no new d.o.fs.";

Subsection@"Annala-Räsänen column 1 row 5";

Comment@"Here is our `minimal model' Lagrangian.";
Col1Row5=ARNonlinearLagrangian/.{C1->0,C2->0,C3->0,C4->0};
DisplayExpression@Col1Row5;
LinearLagrangian=ARLinearLagrangian/.{C1->0,C2->0,C3->0,C4->0};
ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"AnnalaRasanenRow5",	
		Method->"Easy",
		MaxLaurentDepth->1];
Supercomment@"Needs checking, looks like a healthy vector?";
