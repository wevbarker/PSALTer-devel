(*=======================================*)
(*  LagrangianHayashiShirafujiCouplings  *)
(*=======================================*)

NonlinearLagrangian=(
	T[i,g,h](
		kT1 PT1[-i,-g,-h,a,c,d]+
		kT2 PT2[-i,-g,-h,a,c,d]+
		kT3 PT3[-i,-g,-h,a,c,d]
	)T[-a,-c,-d]
	+R[i,j,g,h](
		kR1 PR1[-i,-j,-g,-h,a,b,c,d]+
		kR2 PR2[-i,-j,-g,-h,a,b,c,d]+
		kR3 PR3[-i,-j,-g,-h,a,b,c,d]+
		kR4 PR4[-i,-j,-g,-h,a,b,c,d]+
		kR5 PR5[-i,-j,-g,-h,a,b,c,d]+
		kR6 PR6[-i,-j,-g,-h,a,b,c,d]
	)R[-a,-b,-c,-d]
	-(1/2)Alp0 G[a,c]G[b,d]R[-a,-b,-c,-d]
(*
	+AlpGB(
		R[a,b,-a,-b]R[i,j,-i,-j]-
		4R[q,-i,-q,-j]R[p,j,-p,i]+
		R[-i,-j,-k,-l]R[k,l,i,j]
	)
*)
);

(*Lagrangian=Lagrangian/.{Bet1->0,Alp1->-2Alp6,Alp2->2Alp6,Alp3->0,Alp4->-Alp6,Alp0->0};*)

NonlinearLagrangian=NonlinearLagrangian/.PActivate;
NonlinearLagrangian//=ToNewCanonical;
