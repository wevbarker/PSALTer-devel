(*=================*)
(*  NevilleTheory  *)
(*=================*)

Subsection@"Neville theory";

Comment@{"We will study the Neville theory."};

NonlinearLagrangian=Alp1*R[m,n,r,s]*(R[-m,-n,-r,-s]+R[-r,-s,-m,-n]-4*R[-m,-r,-n,-s])-(1/2)Alp0 G[a,c]G[b,d]R[-a,-b,-c,-d];
DisplayExpression@CollectTensors@ToCanonical[NonlinearLagrangian];
LinearLagrangian=LineariseLagrangian[NonlinearLagrangian];
Code[LinearLagrangian,
	ParticleSpectrum[
		LinearLagrangian,
		TheoryName->"NevilleTheory",	
		Method->"Hard",
		MaxLaurentDepth->3
	];
];
Comment@"Some comments can be made about Neville theory.";
