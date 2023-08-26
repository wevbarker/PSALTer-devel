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

Get@FileNameJoin@{NotebookDirectory[],"Calibration","MetricAffineGravity","AnnalaRasanenTheories",
					"AnnalaRasanenCol1Row1.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","MetricAffineGravity","AnnalaRasanenTheories",
					"AnnalaRasanenCol1Row2.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","MetricAffineGravity","AnnalaRasanenTheories",
					"AnnalaRasanenCol1Row3.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","MetricAffineGravity","AnnalaRasanenTheories",
					"AnnalaRasanenCol1Row4.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","MetricAffineGravity","AnnalaRasanenTheories",
					"AnnalaRasanenCol1Row5.m"};

Title@"Summary of results.";

Comment@"Now it is time to summarise all our results.";

NewTable1=Grid[{
	{
	TextCell@"Tensor",
	SpanFromLeft,
	TextCell@"General case",
	SpanFromLeft,
	TextCell@"Zero torsion",
	TextCell@"Zero non-metricity",
	TextCell@"Lagrangia probed so far",
	SpanFromLeft},
	{
	TextCell@"[MetricAffineGravity] and [ZeroTorsionPalatini] PSALTer modules",
	TextCell@"[PoincareGaugeTheory] PSALTer module",
	TextCell@"Minkowski",
	TextCell@"FLRW",
	TextCell@"Minkowski",
	TextCell@"Minkowski",
	TextCell@"[MetricAffineGravity] and [ZeroTorsionPalatini] PSALTer modules (note coupling notation shown only for [MetricAffineGravity])",
	TextCell@"[PoincareGaugeTheory] PSALTer module"
	},
	{
	HoldForm[(1/2)*(MetricAffineRicciTensor13[-a,-b]+MetricAffineRicciTensor13[-b,-a])],
	HoldForm[(1/2)*(R[m,-a,-m,-b]+R[m,-b,-m,-a])],
	TextCell["no new dofs",FontColor->Blue],
	TextCell@"beyond PSALTer",
	TextCell["no new dofs",FontColor->Blue],
	TextCell["no new dofs",FontColor->Blue],
	Col1Row1,
	HSNonlinearLagrangian2
	},
	{
	HoldForm[(1/2)*(MetricAffineRicciTensor13[-a,-b]-MetricAffineRicciTensor13[-b,-a])],
	HoldForm[(1/2)*(R[m,-a,-m,-b]-R[m,-b,-m,-a])],
	TextCell["ghosts",FontColor->Blue],
	SpanFromAbove,
	TextCell["healthy vector",FontColor->Blue],
	TextCell["no new dofs",FontColor->Red],
	Col1Row2,
	SpanFromAbove	
	},
	{
	MetricAffineRicciTensorTri[-a,-b],
	TextCell["0",FontColor->Black],
	TextCell["ghosts",FontColor->Red],
	SpanFromAbove,
	TextCell["ghosts",FontColor->Blue],
	TextCell["0",FontColor->Black],
	Col1Row3,
	TextCell["0",Fontcolor->Black]
	},
	{
	MetricAffineRicciTensorP[-a,-b],
	TextCell["not independent",FontColor->Black],
	TextCell["no new dofs",FontColor->Blue],
	SpanFromAbove,
	TextCell["ghosts",FontColor->Blue],
	TextCell["not independent",FontColor->Black],
	Col1Row4,
	TextCell["not independent",FontColor->Black]
	},
	{
	MetricAffineRicciTensor[-a,-b],
	TextCell["0",FontColor->Black],
	TextCell["healthy vector",FontColor->Red],
	SpanFromAbove,
	TextCell["not independent",FontColor->Black],
	TextCell["0",FontColor->Black],
	Col1Row5,
	TextCell["0",Fontcolor->Black]
	}
	},Frame->All,Alignment->{Center,Center}];

DisplayExpression[NewTable1,EqnLabel->"NewTable1"];

Supercomment@{"The current status of the PSALTer calibration against arXiv:2212.09820 is represented in",Cref@"NewTable1",", candidate discrepancies with Table 1 on page 14 of that paper are marked in red, and agreement is marked in blue."};
