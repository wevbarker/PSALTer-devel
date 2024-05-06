(*==========================*)
(*  MelichevPercacciTheory  *)
(*==========================*)

Subsection@"Melichev-Percacci gravity";

Comment@{"We want to study the new theory put forward in Eq. (2.17) of 2307.02336. We will recycle some coupling symbols for convenience (i.e. these won't have the same interpretation as those in",Cref@"CleanHayashiShirafuji",")."};
NonlinearLagrangian=Alp1*R[a,b,c,d]*R[-a,-b,-c,-d]+Bet1*T[a,b,c]*T[-a,-b,-c];
DisplayExpression[CollectTensors@ToCanonical[NonlinearLagrangian],EqnLabel->"MelichevPercacci"];
Comment@{"At first glance,",Cref@"MelichevPercacci"," is already an appealing theory to study, since it has quite an odd structure. The two terms are respectively the Kretschmann scalar and the `totally cross-contracted' square of the torsion (not a typical combination), meanwhile the Einstein-Hilbert term is entirely missing."};
LinearLagrangian=LineariseLagrangian[NonlinearLagrangian];
Code[LinearLagrangian,
	ParticleSpectrum[
		LinearLagrangian,
		TheoryName->"MelichevPercacciTheory",	
		Method->"Hard",
		MaxLaurentDepth->3
	];
];
Comment@"In total, if all the massive spin multiplicities and massless polarisations (not counting the higher-order poles, which are duplicates by construction) are added together, one obtains 20 propagating degrees of freedom. Since the number of a priori degrees of freedom in the tetrad an spin connection is 40, and the Poincaré gauge symmetry has 10 generators, this means that the theory is essentially propagating `everything' (recall the gauge always hits twice). This is confirmed by a simple Hamiltonian analysis, which can be done even without writing anything down: by inspection there are no primary `if-constraints' at all, and since the primaries corresponding to the Poincaré symmetry (the so-called super-currents) are first-class according to a well-known constraint algebra, there must be 20 degrees of freedom propagating.";
