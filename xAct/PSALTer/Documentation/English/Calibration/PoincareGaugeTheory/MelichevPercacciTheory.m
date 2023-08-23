(*==========================*)
(*  MelichevPercacciTheory  *)
(*==========================*)

Section@"Melichev-Percacci gravity";

Comment@{"Next we want to study the new theory put forward in Eq. (2.17) of 2307.02336. We will recycle some coupling symbols for convenience (i.e. these won't have the same interpretation as those in",Cref@"CleanHayashiShirafuji",")."};

Comment@"The nonlinear Lagrangian is as follows.";

HSNonlinearLagrangian2=Alp1*R[a,b,c,d]*R[-a,-b,-c,-d]+Bet1*T[a,b,c]*T[-a,-b,-c];

DisplayExpression[CollectTensors@ToCanonical[HSNonlinearLagrangian2],EqnLabel->"MelichevPercacci"];

Comment@{"At first glance,",Cref@"MelichevPercacci"," is already an appealing theory to study, since it has quite an odd structure. The two terms are respectively the Kretschmann scalar and the `totally cross-contracted' square of the torsion (not a typical combination), meanwhile the Einstein-Hilbert term is entirely missing. We will now feed",Cref@"MelichevPercacci"," into the PSALTer software."};

LinearisedLagrangian=LineariseLagrangian[HSNonlinearLagrangian2];

ParticleSpectrum[
	LinearisedLagrangian,
	ClassName->"PoincareGaugeTheory",
	TheoryName->"MelichevPercacciTheory",	
	Method->"Hard",
	MaxLaurentDepth->3
];

Supercomment@"There are quite a few comments to unpack here. Firstly, due the vanishing of the Einstein-Hilbert term, it is possible that this model falls into the category of unstudied PGT spectra, since it features vanishing tordion (not a typo: a tordion being a torsion particle) masses. In many papers, the authors explicitly refuse to consider such scenarios, due to their complexity and the emergence of extra symmetries. However PSALTer can handle vanishing masses, and we do indeed get a spectrum, which in turn has some features worth further comment.";

Supercomment@{"Let's start with the massive sector. We see scalar, vector and tensor species all propagating. By inspection of",Cref@"MelichevPercacci",", it makes dimensional sense that all the square masses are proportional to",Inline@(Bet1/Alp1),". Now consider the first two particles: a pseudoscalar and a parity-even vector. For the pseudoscalar to be neither a ghost nor a tachyon, we need",Inline@(Alp1<0)," and",Inline@(Bet1>0),". These conditions stop the parity-even vector mode from being a tachyon, but they then force it to be a ghost."};

Supercomment@{"Continuing with the massive sector, we notice that the parity-odd vector and the parity-odd tensor are both unitary under the conditions just discussed. That sounds promising, but there is a caveat here because PSALTer is telling us that they share the square mass",Inline@(-Bet1/(2Alp1)),". So what? Well actually this is possibly dangerous, because in such cases the mode does not have a definite spin, and properly one should take the joint residue of both spin sectors when evaluating the unitarity. The joint residue is simple to compute, but it happens not to be implemented in PSALTer yet (it would just require a few lines of code to make the system robust against such contingencies)."};

Supercomment@{"Finally, let's discuss the massless sector. The condition",Inline@(Alp1<0)," from earlier would seem to imply that the first two polarisations are `ghosts in both the soft and hard limits', if such things are even well defined."};

Supercomment@{"Next, we have a complex structure of three plus three polarisations, evidently associated with a quadratic secular equation at some hiden level in the computation. When the massless spectrum is this rich, it is often because there is a non-simple null pole. This is heuristically understood as follows: the massless propagator structure is the saturated eigenspace of the",Inline@(Def^2)," residue. But in general the saturated propagator is a Laurent series, with each successive term becoming more complicated in the natural course of things. If there is only a",Inline@(Def^2)," pole, then this pole is the first term and likely carries an algebraically compact residue with correspondingly simple unitarity conditions. But this reasoning works in reverse, so if you have complicated conditions and many eigenvectors, it is probably because the",Inline@(Def^2)," residue was not the first term, i.e. you have a",Inline@(Def^4)," residue or worse. Heisenberg tells us that such higher-order poles are always ghosts under a limit of partial fractions, and indeed, PSALTer finds such higher-order poles here."};

Supercomment@"In total, if all the massive spin multiplicities and massless polarisations (not counting the higher-order poles, which are duplicates by construction) are added together, one obtains 20 propagating degrees of freedom. Since the number of a priori degrees of freedom in the tetrad an spin connection is 40, and the Poincaré gauge symmetry has 10 generators, this means that the theory is essentially propagating `everything' (recall the gauge always hits twice). This is confirmed by a simple Hamiltonian analysis, which can be done even without writing anything down: by inspection there are no primary `if-constraints' at all, and since the primaries corresponding to the Poincaré symmetry (the so-called super-currents) are first-class according to a well-known constraint algebra, there must be 20 degrees of freedom propagating.";
