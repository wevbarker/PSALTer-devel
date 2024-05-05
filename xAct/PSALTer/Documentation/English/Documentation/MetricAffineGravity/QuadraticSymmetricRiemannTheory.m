(*===================================*)
(*  QuadraticSymmetricRiemannTheory  *)
(*===================================*)

Section@"Square of the symmetric part of the curvature";

Comment@"We take the square of the symmetric part of the curvature tensor, as defined in Eq. (46) on page 7 of arXiv:2104.10192.";
LinearLagrangian=Measure*(A0*MetricAffineRicciScalar[]+A1*(1/2)*(MetricAffineCurvature[-m,-n,-r,-s]+MetricAffineCurvature[-m,-n,-s,-r])*MetricAffineCurvature[m,n,r,s]);
DisplayExpression@LinearLagrangian;
LinearLagrangian//=LineariseLagrangian;

ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"QuadraticSymmetricRiemannTheory",	
		Method->"Hard",
		MaxLaurentDepth->1];
Comment@"Some comment.";
