(* ::Package:: *)

(*================================*)
(*  LagrangianLinWeylCouplings  *)
(*================================*)

(*To first define WGT field strengths R*, T* w.r.t. the PGT counterparts*)

xAct`PSALTer`LagrangianLinWeylCouplings`Private`WeylHSymb="\[ScriptCapitalH]";
DefTensor[WeylH[-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`LagrangianLinWeylCouplings`Private`WeylHSymb],Dagger->Complex];

xAct`PSALTer`LagrangianLinWeylCouplings`Private`WeylCovariantDerivativeOnScalarSymb="\!\(\*SubscriptBox[\(\[ScriptCapitalD]\), \(*\)]\[Phi]\)";
DefTensor[WeylCovariantDerivativeOnScalar[-i],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`LagrangianLinWeylCouplings`Private`WeylCovariantDerivativeOnScalarSymb],Dagger->Complex];

xAct`PSALTer`LagrangianLinWeylCouplings`Private`WeylTSymb="\!\(\*SubscriptBox[\(\[ScriptCapitalT]\), \(*\)]\)";
DefTensor[WeylT[c,-a,-b],M4,Antisymmetric[{-a,-b}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`LagrangianLinWeylCouplings`Private`WeylTSymb],Dagger->Complex];

xAct`PSALTer`LagrangianLinWeylCouplings`Private`WeylQuantitiesExpand=Join[
	MakeRule[{WeylH[-a,-b],Evaluate[WeylTetrad[-a,i]WeylTetrad[-b,j](CD[-i][WeylVector[-j]]-CD[-j][WeylVector[-i]])]},MetricOn->All,ContractMetrics->True],	
	MakeRule[{WeylCovariantDerivativeOnScalar[-i],Evaluate[CD[-i][Compensator[]]-WeylVector[-i]Compensator[]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{WeylT[c,-a,-b],Evaluate[WeylBaseT[c,-a,-b]+WeylVector[-i](WeylTetrad[-a,i]G[c,-b]-WeylTetrad[-b,i]G[c,-a])]},MetricOn->All,ContractMetrics->True]	
];

(*N.B. this is equation 10 of Lin, PHYS. REV. D 104, 024034 (2021)*)
NonlinearLagrangianLinWeyl=(
	-lLambda*(Compensator[]^2)*WeylBaseR[a,b,-a,-b]
	+(1lR1/3+lR2/6)*WeylBaseR[a,b,c,d]*WeylBaseR[-a,-b,-c,-d]
	+(2lR1/3-2lR2/3)*WeylBaseR[a,b,c,d]*WeylBaseR[-a,-c,-b,-d]
	+(1lR1/3+lR2/6-lR3)*WeylBaseR[a,b,c,d]*WeylBaseR[-c,-d,-a,-b]
	+(lR4+lR5)*WeylBaseR[a,c,b,-c]*WeylBaseR[-a,-d,-b,d]
	+(lR4-lR5)*WeylBaseR[a,c,b,-c]*WeylBaseR[-b,-d,-a,d]
	-lC1*WeylBaseR[a,c,b,-c]*WeylH[-a,-b]
	+lXi*WeylH[a,b]*WeylH[-a,-b]
	+lNu/2*WeylCovariantDerivativeOnScalar[-i]WeylCovariantDerivativeOnScalar[i]
	+(lT1/3+lT2/12+lLambda/4)*(Compensator[]^2)*WeylT[a,b,c]*WeylT[-a,-b,-c]
	-(lT1/3-lT2/6+lLambda/2)*(Compensator[]^2)*WeylT[a,b,c]*WeylT[-b,-c,-a]
	-(lT1/3-2lT3/3+lLambda)*(Compensator[]^2)*WeylT[-a,c,a]*WeylT[-b,-c,b]
);

DisplayExpression[NonlinearLagrangianLinWeyl,EqnLabel->"LinWeylUnexpanded"];
Comment@{"In",Cref@"LinWeylUnexpanded"," this is the non-linear Lagrangian as given in eqn 10 of Lin, PHYS. REV. D 104, 024034 (2021)."};

NonlinearLagrangianLinWeyl=NonlinearLagrangianLinWeyl/.xAct`PSALTer`LagrangianLinWeylCouplings`Private`WeylQuantitiesExpand;
NonlinearLagrangianLinWeyl//=xAct`PSALTer`Private`ToNewCanonical;

DisplayExpression[NonlinearLagrangianLinWeyl,EqnLabel->"LinWeylExpandedtoPGT"];
Comment@{"In",Cref@"LinWeylExpandedtoPGT"," the non-linear Lagrangian is expanded to PGT quantities."};
