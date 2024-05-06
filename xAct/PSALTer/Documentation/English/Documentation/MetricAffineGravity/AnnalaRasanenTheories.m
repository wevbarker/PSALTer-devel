(*=========================*)
(*  AnnalaRasanenTheories  *)
(*=========================*)

Comment@"We construct a representative Lagrangian which will cover the whole of the fourth column of Table 1 on page 14 of arXiv:2212.09820.";
ARNonlinearLagrangian=-(1/2)*(
	-A0*MetricAffineRicciScalar[]
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
ARLinearLagrangian=Measure*ARNonlinearLagrangian//MetricAffineLineariseLagrangian;
DisplayExpression[ARLinearLagrangian,EqnLabel->"MetricAffineARLinearLagrangian"];
Get@FileNameJoin@{$ThisDirectory,"Documentation","MetricAffineGravity","AnnalaRasanenTheories",
					"AnnalaRasanenCol1Row1.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","MetricAffineGravity","AnnalaRasanenTheories",
					"AnnalaRasanenCol1Row2.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","MetricAffineGravity","AnnalaRasanenTheories",
					"AnnalaRasanenCol1Row3.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","MetricAffineGravity","AnnalaRasanenTheories",
					"AnnalaRasanenCol1Row4.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","MetricAffineGravity","AnnalaRasanenTheories",
					"AnnalaRasanenCol1Row5.m"};
