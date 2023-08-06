(*===================*)
(*  WeylGaugeTheory  *)
(*===================*)

Title@"Weyl gauge theory (PGT)";

Supercomment@"We will test the WeylGaugeTheory module.";

Supercomment@"This section is still under development by Zhiyuan.";

LinearisedLagrangian=kXi*(CD[-a]@WeylVector[-b]-CD[-b]@WeylVector[-a])*(CD[a]@WeylVector[b]-CD[b]@WeylVector[a]);

Comment@"Let's just try a linearised theory which follows from the Homothetic curvature.";
DisplayExpression@LinearisedLagrangian;

ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"WeylGaugeTheory",
	TheoryName->"SillyExample",	
	Method->"Easy",
	MaxLaurentDepth->3
];
