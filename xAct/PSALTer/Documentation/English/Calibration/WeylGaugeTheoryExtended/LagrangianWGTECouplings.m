(* ::Package:: *)

(*===========================*)
(*  LagrangianWGTECouplings  *)
(*===========================*)

(*N.B. this is equation 13 of Lin's draft eWGT paper.*)
NonlinearLagrangianWGTE=(
	+lLambda*(Compensator[]^2)*WeylDaggerR[a,b,-a,-b](*Different sign to WGT*)
	+(1lR1/3+lR2/6)*WeylDaggerR[a,b,c,d]*WeylDaggerR[-a,-b,-c,-d]
	+(2lR1/3-2lR2/3)*WeylDaggerR[a,b,c,d]*WeylDaggerR[-a,-c,-b,-d]
	+(1lR1/3+lR2/6-lR3)*WeylDaggerR[a,b,c,d]*WeylDaggerR[-c,-d,-a,-b]
	+(lR4+lR5)*WeylDaggerR[a,c,b,-c]*WeylDaggerR[-a,-d,-b,d]
	+(lR4-lR5)*WeylDaggerR[a,c,b,-c]*WeylDaggerR[-b,-d,-a,d]	
	-lC1*WeylDaggerR[a,c,b,-c]*WeylDaggerH[-a,-b](*Different sign to WGT*)	
	+lXi*WeylDaggerH[a,b]*WeylDaggerH[-a,-b]
	+lNu/2*WeylCovDerivDaggerOnScalar[-i]*WeylCovDerivDaggerOnScalar[i]
	+(lT1/3+lT2/12+lLambda/4)*(Compensator[]^2)*WeylDaggerT[a,b,c]*WeylDaggerT[-a,-b,-c]
	-(lT1/3-lT2/6+lLambda/2)*(Compensator[]^2)*WeylDaggerT[a,b,c]*WeylDaggerT[-c,-a,-b](*Checked, this contraction should be same from WGT*)
	-(lT1/3-2lT3/3+lLambda)*(Compensator[]^2)*WeylDaggerT[-a,c,a]*WeylDaggerT[-b,-c,b]	
);

(*Check Eqn 15*)
Comment@"In eqn 15 of Lin's draft, we check that the T+ contraction = 0. Here we expand T+ to PGT T.";
TDaggerContractionExpression=WeylDaggerT[a,-b,-a];
TDaggerContractionExpression=TDaggerContractionExpression/.WeyDaggerTHCovDtoBaseTWeylVectorHBAndDaggerRtoDaggerA;
TDaggerContractionExpression//=xAct`PSALTer`Private`ToNewCanonical;
DisplayExpression@CollectTensors@ToCanonical[TDaggerContractionExpression];

(*Expand non-linear Lagrangian*)
Comment@{"In",Cref@"WGTEUnexpanded"," this is the non-linear Lagrangian as given in eqn 13 of Lin's draft paper."};
DisplayExpression[NonlinearLagrangianWGTE,EqnLabel->"WGTEUnexpanded"];

NonlinearLagrangianWGTE=NonlinearLagrangianWGTE/.WeyDaggerTHCovDtoBaseTWeylVectorHBAndDaggerRtoDaggerA;
NonlinearLagrangianWGTE//=xAct`PSALTer`Private`ToNewCanonical;
NonlinearLagrangianWGTE=NonlinearLagrangianWGTE/.WeylDaggerABaseTtoAHBWeylVector;
NonlinearLagrangianWGTE//=xAct`PSALTer`Private`ToNewCanonical;
NonlinearLagrangianWGTE//=CollectTensors;

Comment@{"Diagnostic: Now the non-linear Lagrangian has been expanded to PGT quantities. This is now stored for linearisation."};
