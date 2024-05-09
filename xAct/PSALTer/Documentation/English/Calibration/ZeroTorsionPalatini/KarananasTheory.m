(*===================*)
(*  KarananasTheory  *)
(*===================*)

Subsection@"Karananas' theory";

Comment@{"We will study the square of the Ricci in Weyl gauge theory."};

Comment@"Unfortunately, the theory Giorgos is looking at is not quite kinematically zero-torsion Palatini, because we also need to kill off all the other pieces of nonmetricity. To make this work, we write a nasty, non-covariant Lagrangian density which will be the same as Giorgos' theory to quadratic order. Then, the parts of zero-torsion Palatini which were kinematically distinct from Giorgos' setup (i.e. the co-Weyl vector and the tensor non-metricity) will not be allowed to mix in at quadratic order, so they fall out of the theory. This will make the gauge symmetries look a lot bigger than they really are (because of drop-out sectors), but the spectrum should be correct.";

NonlinearKarananasTheory=xAct`PSALTer`ZeroTorsionPalatini`H1*(ZeroTorsionRicciScalar[]-CD[-r]@ZeroTorsionNonMetricityContractionTilde[r])*(ZeroTorsionRicciScalar[]-CD[-s]@ZeroTorsionNonMetricityContractionTilde[s]);
DisplayExpression[NonlinearKarananasTheory,EqnLabel->"NonlinearKarananasTheory"];
Comment@{"Okay, so now we take",Cref@"NonlinearKarananasTheory"," and we linearise it."};
LinearLagrangian=Measure*NonlinearKarananasTheory//ZeroTorsionPalatiniLineariseLagrangian;
DisplayExpression[LinearLagrangian,EqnLabel->"LinearKarananasTheory"];
Comment@{"Okay, so now we take",Cref@"LinearKarananasTheory"," and we try it in PSALTer."};

ParticleSpectrum[LinearLagrangian,
		ClassName->"ZeroTorsionPalatini",
		TheoryName->"KarananasTheory",	
		Method->"Hard",
		MaxLaurentDepth->3];

Comment@"Some comments can be made about Karananas' theory...";
