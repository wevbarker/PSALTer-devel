(*===============*)
(*  GeneraleWGT  *)
(*===============*)

Section@"Most general eWGT";

Comment@"First we set up the non-linear Lagrangian.";
NewNonlinearLagrangian=(
	-(1/2)*MPl0*R[i,j,-i,-j]+
	T[-m,-n,-s]*(
		Bet1*+T[m,n,s]+
		Bet2*+T[n,m,s]
	)+
	Bet3*T[i,-i,s]*T[j,-j,-s]+
	Alp1*R[i,j,-i,-j]*R[k,l,-k,-l]+
	R[i,-m,-i,-n]*(
		Alp2*R[j,m,-j,n]+
		Alp3*R[j,n,-j,m]
	)+
	+R[-m,-n,-s,-l]*(
		Alp4*R[m,n,s,l]+
		Alp5*R[m,s,n,l]+
		Alp6*R[s,l,m,n]
	)+
	(1/3)*Chi0*R[i,-m,-i,-n]*(1/2)*(CD[m]@T[j,-j,n]-CD[n]@T[j,-j,m])+
	(1/36)*Xi0*(1/2)*(CD[-m]@T[k,-k,-n]-CD[-n]@T[k,-k,-m])*(1/2)*(CD[m]@T[j,-j,n]-CD[n]@T[j,-j,m])
);
DisplayExpression[NewNonlinearLagrangian];

Comment@"We first try the PGT equivalent.";
SpecialNonlinearLagrangian=NewNonlinearLagrangian/.{Chi0->0,Xi->0};
SpecialNonlinearLagrangian//=LineariseLagrangian;
SpecialNonlinearLagrangian//DisplayExpression;
ParticleSpectrum[
	SpecialNonlinearLagrangian,
	ClassName->"PoincareGaugeTheory",
	TheoryName->"PGTeWGT",	
	Method->"Hard",
	MaxLaurentDepth->3
];

Comment@"We next try the discontinuous PGT equivalent.";
SpecialNonlinearLagrangian=NewNonlinearLagrangian/.{Alp5->-(2*Alp2+4*Alp4)};
SpecialNonlinearLagrangian=SpecialNonlinearLagrangian/.{Chi0->0,Xi->0};
SpecialNonlinearLagrangian//=LineariseLagrangian;
SpecialNonlinearLagrangian//DisplayExpression;
ParticleSpectrum[
	SpecialNonlinearLagrangian,
	ClassName->"PoincareGaugeTheory",
	TheoryName->"DiscontinuousPGTeWGT",	
	Method->"Hard",
	MaxLaurentDepth->3
];

Comment@"Now we impose the basic conditions.";
NewNonlinearLagrangian=NewNonlinearLagrangian/.{Alp5->Chi0^2/Xi0-(2*Alp2+4*Alp4)};
NewNonlinearLagrangian=NewNonlinearLagrangian/.{Chi0->kT1*Xi0};
NewNonlinearLagrangian//=CollectTensors;
DisplayExpression[NewNonlinearLagrangian];

Comment@"We first try the root theory.";
SpecialNonlinearLagrangian=NewNonlinearLagrangian;
SpecialNonlinearLagrangian//=LineariseLagrangian;
SpecialNonlinearLagrangian//DisplayExpression;
ParticleSpectrum[
	SpecialNonlinearLagrangian,
	ClassName->"PoincareGaugeTheory",
	TheoryName->"GeneraleWGT",	
	Method->"Hard",
	MaxLaurentDepth->3
];

Comment@"We next try the Maxwell limit.";
SpecialNonlinearLagrangian=NewNonlinearLagrangian/.{kT1->0};
SpecialNonlinearLagrangian//=LineariseLagrangian;
SpecialNonlinearLagrangian//DisplayExpression;
ParticleSpectrum[
	SpecialNonlinearLagrangian,
	ClassName->"PoincareGaugeTheory",
	TheoryName->"NoChieWGT",	
	Method->"Hard",
	MaxLaurentDepth->3
];

Comment@"Now we will try to look for new solutions to the vector system.";
NewTheoryConditions={	
	(2Bet1+Bet2+3Bet3)(6Alp1+2Alp3-2Alp4+2Alp6+Chi0^2/Xi0)==0,
	4Alp2+12Alp4-2Chi0^2/Xi0==0,
	(Alp2-Alp3+4Alp4-4Alp6)(2Bet1-Bet2)==0,
	(2Bet1+Bet2)(3Alp2-Alp3+4Alp4-4Alp6-2Chi0^2/Xi0)==0,
	4Alp2-2Chi0^2/Xi0==0,
	Chi0!=0
};
Comment@"From the general mass parameters, here are the conditions which must be true in order for only the parity-odd vector to propagate.";
DisplayExpression/@NewTheoryConditions;
Comment@"Now we obtain the following solutions.";
NewTheoryRules=Solve@NewTheoryConditions;
NewTheoryRules=NewTheoryRules/.{Chi0->kT1*Xi0};
NewTheoryRules//=FullSimplify;
DisplayExpression/@NewTheoryRules;

TryTheory[TheTheory_]:=Module[{
		NewTheoryName="TrialeWGT"<>ToString@TheTheory,
		NewTheoryRule=NewTheoryRules[[TheTheory]],
		NewestNonlinearLagrangian,
		SuperRules
		},

	Subsection@{"Trying a new theory with name",NewTheoryName," and the following replacement."};
	DisplayExpression@NewTheoryRule;
	Comment@"This leads to the following overall definition.";
	SuperRules=NewTheoryRule/.{kT1->Chi0/Xi0};
	SuperRules={Alp5->Chi0^2/Xi0-(2*Alp2+4*Alp4)}~Join~SuperRules;
	SuperRules=SuperRules/.{Rule->Equal};
	SuperRules//=Reduce;
	DisplayExpression@SuperRules;
	Comment@"This leads to the following non-linear Lagrangian.";
	NewestNonlinearLagrangian=NewNonlinearLagrangian/.NewTheoryRule;
	NewestNonlinearLagrangian//=ToCanonical;
	NewestNonlinearLagrangian//=ContractMetric;
	NewestNonlinearLagrangian//=ScreenDollarIndices;
	NewestNonlinearLagrangian//=CollectTensors;
	NewestNonlinearLagrangian//DisplayExpression;
	Comment@"This leads to the following linear Lagrangian.";
	NewestNonlinearLagrangian//=LineariseLagrangian;
	NewestNonlinearLagrangian//DisplayExpression;
	ParticleSpectrum[
		NewestNonlinearLagrangian,
		ClassName->"PoincareGaugeTheory",
		TheoryName->NewTheoryName,	
		Method->"Hard",
		MaxLaurentDepth->3
	];
	Comment@"Some comments to be made.";
];

TryTheory/@Table[i,{i,1,2}];
