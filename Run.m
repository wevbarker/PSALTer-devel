(*=======*)
(*  Run  *)
(*=======*)

Print@"First we load the PSALTer package:";

<<xAct`PSALTer`;

Print@"Set up the theory under investigation:";

Lagrangian=(
	T[i,g,h](
		Bet1 PT1[-i,-g,-h,a,c,d]+
		Bet2 PT2[-i,-g,-h,a,c,d]+
		Bet3 PT3[-i,-g,-h,a,c,d]
	)T[-a,-c,-d]
	+R[i,j,g,h](
		Alp1 PR1[-i,-j,-g,-h,a,b,c,d]+
		Alp2 PR2[-i,-j,-g,-h,a,b,c,d]+
		Alp3 PR3[-i,-j,-g,-h,a,b,c,d]+
		Alp4 PR4[-i,-j,-g,-h,a,b,c,d]+
		Alp5 PR5[-i,-j,-g,-h,a,b,c,d]+
		Alp6 PR6[-i,-j,-g,-h,a,b,c,d]
	)R[-a,-b,-c,-d]
	-(1/2)Alp0 G[a,c]G[b,d]R[-a,-b,-c,-d]
	+AlpGB(
		R[a,b,-a,-b]R[i,j,-i,-j]-
		4R[q,-i,-q,-j]R[p,j,-p,i]+
		R[-i,-j,-k,-l]R[k,l,i,j]
	)
);


Lagrangian=Lagrangian/.{Bet1->0,Alp1->-2Alp6,Alp2->2Alp6,Alp3->0,Alp4->-Alp6,Alp0->0};
Lagrangian=Lagrangian/.PActivate;
Lagrangian//=ToNewCanonical;

Print@Lagrangian;

Print@"Linearise this theory on a flat background:";

DefConstantSymbol[Prt];
ToOrderA = MakeRule[{A[-a, -b, -c], Prt A[-a, -b, -c]}, 
	MetricOn -> All, ContractMetrics -> True];
ToOrderF = MakeRule[{F[-a, -b], Prt F[-a, -b]}, 
	MetricOn -> All, ContractMetrics -> True];
ToOrder = Join[ToOrderA, ToOrderF];

Lagrangian=Lagrangian/.ExpandStrengths/.ToF;
Lagrangian=Lagrangian/.ToOrder;
Lagrangian=Series[Lagrangian,{Prt,0,2}]//Normal;
Lagrangian=Lagrangian/.Prt->1;
Lagrangian=Lagrangian/.PActivate;
Lagrangian//=ToNewCanonical;
SecondOrderLagrangian=Lagrangian//ToNewCanonical;

Print@SecondOrderLagrangian;

Print@"Now attempt to find the particle spectrum:";

ParticleSpectrum["Case16New",SecondOrderLagrangian,F,A,ExportTheory->True];

r1,r3/2-r4,t1,t3,l-1
r1,r3/2-r4,t1,l-2
r1,r3,r4,t1+t2,t3,l-3
r2,r1-r3,r4,t1+t2,t3,l-4
r2,r1-r3,r4,t2,t1+t3,l-5
r1,2r3-r4,t1+t2,t3,l-6
r2,2r1-2r3+r4,t1+t2,t3,l-7
r2,r1-r3,r4,t1,t2,l-8
r2,r1-r3,r4,t1,t2,t3,l-9
r1,r2,r3/2-r4,t1,t2,t3,l-10
r1,r3/2-r4,t1,t2,t3,l-11
r1,r2,r3/2-r4,t1,t3,l-12
r2,2r1-2r3+r4,t1,t2,t3,l-13
r1,r2,r3/2-r4,t1,t2,l-14
r1,r2,r3/2-r4,t1,l-15
r1,r3/2-r4,t1,t2,l-16
r1,r2,r3,r4,t1+t2,t3,l-17
r1,r2,r3,r4,t2,t1+t3,l-18
r1,r2,2r3-r4,t1+t2,t3,l-19
r1,r3,r4,r5,l-20
r1,r3,r4,r5,t1+t2,l-21
r1,r3,r4,r5,t1+t3,l-22
r1,r3,r4,r5,t1+r2,t1+t3,l-23
r1,r3,r4,t1,l-24
r1,r3,r4,r5,t1,l-25
r1,r3,r4,r5,t1,t3,l-26
r1,r3/2-r4,r3/2+r5,t1,t3,l-27
r1,r3,r4,t1,t3,l-28
r1-r3,r4,2r1+r5,t1,l-29
r1-r3,r4,2r1+r5,t1,t3,l-30
r1,2r3-r4,2r3+r5,t1,t3,l-31
r1,r3,r4,r5,t3,l-32
r1,r3,r4,r5,t1+t2,t3,l-33
r1,2r3-r4,r3+r5,t1,t3,l-34
r1,r3/2-r4,2r3+r5,t1,t3,l-35
2r1-2r3+r4,2r3+r5,t1,t3,l-36
r1,r3/2-r4,2r3+r5,t1,l-37
r1,2r3-r4,2r3+r5,t3,l-38
r1,2r3-r4,2r3+r5,t1+t2,t3,l-39
r1,r4+r5,t1,t3,l-40
r1,r3/2-r4,r3/2+r5,t1,l-41
r1,r3,r4,t1+t2,l-42
r1,r3,r4,t1+t3,l-43
r2,r1-r3,r4,t1+t2,l-44
r2,r1-r3,t4,t1+t3,l-45
r1-r3,r4,2r1+r5,t1+t3,l-46
r1,r2,r3,r4,t1+t2,l-47
r1,r2,r3,r4,t1+t3,l-48
r1,r3,r4,t1+t2,t1+t3,l-49
r2,r1-r3,r4,r1+r5,t1+t2,l-50
r2,r1-r3,r4,2r1+r5,t1+t3,l-51
r2,r1-r3,r4,t1+t2,t1+t3,l-52
r2,r1-r3,r4,r1+r5,t1+t2,t1+t3,l-53
r2,r1-r3,r4,2r1+r5,t1+t2,t1+t3,l-54
r2,r1-r3,r4,r1+r5,t1+t2,t3,l-55
r2,r1-r3,r4,2r1+r5,t2,t1+t3,l-56
r1-r3,r4,2r1+r5,t2,t1+t3,l-57
r2,2r1-2r3+r4,r1-2r3-r5,t1+t2,t3,l-58









Quit[];
