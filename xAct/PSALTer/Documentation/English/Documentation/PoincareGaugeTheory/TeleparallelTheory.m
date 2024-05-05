(*======================*)
(*  TeleparallelTheory  *)
(*======================*)

Section@"Teleparallel Theory";

Comment@"We would like to check the basic teleparallel theory.";

NonLinearLagrangian=xAct`PSALTer`PoincareGaugeTheory`kT1*(-(1/4)*T[-m, -n, -r]*T[m, n, r]-(1/2)*T[-m, -n, -r]*T[n, m, r]+T[n, -m, -n]*T[r, m, -r]);

DisplayExpression@NonLinearLagrangian;
LinearLagrangian=NonLinearLagrangian;
LinearLagrangian//=LineariseLagrangian;
DisplayExpression@LinearLagrangian;
LinearLagrangian=LinearLagrangian/.{xAct`PSALTer`PoincareGaugeTheory`A->Zero};
DisplayExpression@LinearLagrangian;

      
ParticleSpectrum[
	LinearLagrangian,
	ClassName->"PoincareGaugeTheory",
	TheoryName->"TeleparallelTheory",	
	Method->"Hard",
	MaxLaurentDepth->3
];
