(*================================*)
(*  LagrangianKarananasCouplings  *)
(*================================*)

NonlinearLagrangian=(
	-kLambda*R[i,j,-i,-j]
	+(kR4+kR5)*R[i,k,j,-k]*R[-i,l,-j,-l]
	+(kR4-kR5)*R[i,k,j,-k]*R[-j,l,-i,-l]
	+(kR1/3+kR2/6)*R[i,j,k,l]*R[-i,-j,-k,-l]
	+(2*kR1/3-2*kR2/3)*R[i,j,k,l]*R[-i,-k,-j,-l]
	+(kR1/3+kR2/6-kR3)*R[i,j,k,l]*R[-k,-l,-i,-j]
	+(kLambda/4+kT1/3+kT2/12)*T[i,j,k]*T[-i,-j,-k]
	+(-kLambda/2-kT1/3+kT2/6)*T[i,j,k]*T[-j,-k,-i]
	+(-kLambda-kT1/3+2*kT3/3)*T[i,j,k]*T[-j,-k,-i]
);
