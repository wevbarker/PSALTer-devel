(*=================================*)
(*  MetricAffineGaussBonnetTheory  *)
(*=================================*)

Section@"Gauss-Bonnet term";

Comment@"The Gauss-Bonnet term is presented in Eq. (2.6) on page 5 of arXiv:1912.01023. This expression appears to match that provided also in Eq. (51) on page 8 of arXiv:2104.10192.";
LinearLagrangian=Measure*A1*(
			MetricAffineCurvature[-m,-n,-r,-s]*MetricAffineCurvature[r,s,m,n]
			-MetricAffineRicciTensor13[-m,-n]*MetricAffineRicciTensor13[n,m]
			-MetricAffineRicciTensor14[-m,-n]*MetricAffineRicciTensor14[n,m]
			+2*MetricAffineRicciTensor13[-m,-n]*MetricAffineRicciTensor14[n,m]
			+MetricAffineRicciScalar[]^2
			);
DisplayExpression@LinearLagrangian;
LinearLagrangian//=LineariseLagrangian;

ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"MetricAffineGaussBonnetTheory",	
		Method->"Easy",
		MaxLaurentDepth->1];
Comment@"Some comment.";
