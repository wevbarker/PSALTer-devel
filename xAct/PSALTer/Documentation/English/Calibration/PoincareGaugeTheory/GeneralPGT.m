(*==============*)
(*  GeneralPGT  *)
(*==============*)

Section@"Most general PGT";

Comment@{"We first want to study the most general PGT. We will do this using the general coupling coefficients defined in",Cref@"CleanHayashiShirafuji","."};

DisplayExpression@CollectTensors@ToCanonical[HSNonlinearLagrangian];

LinearisedLagrangian=LineariseLagrangian[HSNonlinearLagrangian];

ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"PoincareGaugeTheory",
	TheoryName->"GeneralPGT",	
	Method->"Hard",
	MaxLaurentDepth->3
];

Supercomment@"These results should be compared with the Hayashi and Shirafuji papers, in particular Eqs. (4.11) in Prog. Theor. Phys. 64 (1980) 2222.";
