(*===============*)
(*  GeneraleWGT  *)
(*===============*)

Section@"Most general eWGT";
(*
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

(*NewNonlinearLagrangian=NewNonlinearLagrangian/.{Xi0->Chi0^2/(2*Alp2+4*Alp4+Alp5)};*)

NewNonlinearLagrangian=NewNonlinearLagrangian/.{Alp5->kT3*Chi0-(2*Alp2+4*Alp4)};
NewNonlinearLagrangian=NewNonlinearLagrangian/.{Xi0->Chi0/kT3};
NewNonlinearLagrangian=NewNonlinearLagrangian/.{Chi0->kT3*kT1};

NewNonlinearLagrangian//=ToCanonical;
NewNonlinearLagrangian//=ContractMetric;
NewNonlinearLagrangian//=ScreenDollarIndices;
NewNonlinearLagrangian//=CollectTensors;

DisplayExpression[NewNonlinearLagrangian];

Comment@{"We want to study the most general eWGT."};
DisplayExpression@CollectTensors@ToCanonical[NewNonlinearLagrangian];
LinearLagrangian=LineariseLagrangian[NewNonlinearLagrangian];
DisplayExpression@LinearLagrangian;
ParticleSpectrum[
	LinearLagrangian,
	ClassName->"PoincareGaugeTheory",
	TheoryName->"GeneraleWGT",	
	Method->"Hard",
	MaxLaurentDepth->3
];
Comment@"Some comments to be made.";
*)
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
	(*(1/3)*Chi0*R[i,-m,-i,-n]*(1/2)*(CD[m]@T[j,-j,n]-CD[n]@T[j,-j,m])+*)
	(1/36)*Xi0*(1/2)*(CD[-m]@T[k,-k,-n]-CD[-n]@T[k,-k,-m])*(1/2)*(CD[m]@T[j,-j,n]-CD[n]@T[j,-j,m])
);

DisplayExpression[NewNonlinearLagrangian];

(*NewNonlinearLagrangian=NewNonlinearLagrangian/.{Xi0->Chi0^2/(2*Alp2+4*Alp4+Alp5)};*)
(*
NewNonlinearLagrangian=NewNonlinearLagrangian/.{Xi0->Chi0/kT3};
NewNonlinearLagrangian=NewNonlinearLagrangian/.{Chi0->kT3*kT1};
*)
NewNonlinearLagrangian=NewNonlinearLagrangian/.{Alp5->-(2*Alp2+4*Alp4)};
NewNonlinearLagrangian//=ToCanonical;
NewNonlinearLagrangian//=ContractMetric;
NewNonlinearLagrangian//=ScreenDollarIndices;
NewNonlinearLagrangian//=CollectTensors;

DisplayExpression[NewNonlinearLagrangian];

Comment@{"We want to study the most general eWGT."};
DisplayExpression@CollectTensors@ToCanonical[NewNonlinearLagrangian];
LinearLagrangian=LineariseLagrangian[NewNonlinearLagrangian];
DisplayExpression@LinearLagrangian;
ParticleSpectrum[
	LinearLagrangian,
	ClassName->"PoincareGaugeTheory",
	TheoryName->"NoChieWGT",	
	Method->"Hard",
	MaxLaurentDepth->3
];
Comment@"Some comments to be made.";
