(* ::Package:: *)

(*================================*)
(*  LagrangianLinWeylCouplings  *)
(*================================*)

(*To first define WGT field strengths*)
(*R is inherited from PGT definition, does not change*)

xAct`PSALTer`LagrangianLinWeylCouplings`Private`WeylHSymb="\[ScriptCapitalH]";
DefTensor[WeylH[-i,-j],M4,Antisymmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`LagrangianLinWeylCouplings`Private`WeylHSymb],Dagger->Complex];

xAct`PSALTer`LagrangianLinWeylCouplings`Private`WeylCovariantDerivativeOnScalarSymb="\!\(\*SubscriptBox[\(\[ScriptCapitalD]\), \(*\)]\[Phi]\)";
DefTensor[WeylCovariantDerivativeOnScalar[-i],M4,PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`LagrangianLinWeylCouplings`Private`WeylCovariantDerivativeOnScalarSymb],Dagger->Complex];

(*T* and T are antisymmetric in final two indices as per Lin papers*)
(*Not sure do I need to redefine T from WeylGaugeTheory file*)
xAct`PSALTer`LagrangianLinWeylCouplings`Private`WeylTSymb="\!\(\*SubscriptBox[\(\[ScriptCapitalT]\), \(*\)]\)";
DefTensor[WeylT[a,-i,-j],M4,Antisymmetric[{-i,-j}],PrintAs->xAct`PSALTer`Private`SymbolBuild[xAct`PSALTer`LagrangianLinWeylCouplings`Private`WeylTSymb],Dagger->Complex];

$CovDFormat = "Prefix",

xAct`PSALTer`LagrangianLinWeylCouplings`Private`WeylQuantitiesExpand=Join[
(*Not sure do I use k[-i] or cov. derivative CD[-i]*)
	MakeRule[{WeylH[-i,-j],Evaluate[CD[-i]WeylVector[-j]-CD[-j]WeylVector[-i]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylH[-i,-j],Evaluate[Dagger@(CD[-i]WeylVector[-j]-CD[-j]WeylVector[-i])]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{WeylCovariantDerivativeOnScalar[-i],Evaluate[CD[-i]Compensator[]-WeylVector[-i]Compensator[]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylCovariantDerivativeOnScalar[-i],Evaluate[Dagger@(CD[-i]Compensator[]-WeylVector[-i]Compensator[])]},MetricOn->All,ContractMetrics->True],
	
	MakeRule[{WeylT[a,-i,-j],Evaluate[T[a,-i,-j]+WeylVector[-i]delta[-j,a]-WeylVector[-j]delta[-i,a]]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Evaluate@Dagger@WeylT[a,-i,-j],Evaluate[Dagger@(T[a,-i,-j]+WeylVector[-i]delta[-j,a]-WeylVector[-j]delta[-i,a])]},MetricOn->All,ContractMetrics->True]
];

(*N.B. this is equation 10 of Lin, PHYS. REV. D 104, 024034 (2021)*)
NonlinearLagrangianLinWeyl=(
	-lLambda*(Compensator[]^2)*R[i,j,-i,-j]
	+(1/6)*(2lR1+lR2)*R[i,j,k,l]*R[-i,-j,-k,-l]
	+(2/3)*(lR1-lR2)*R[i,j,k,l]*R[-i,-k,-j,-l]
	+(1/6)*(2lR1+lR2-6lR3)*R[i,j,k,l]*R[-k,-l,-i,-j]
	+(lR4+lR5)*R[i,k,j,-k]*R[-i,-l,-j,l]
	+(lR4-lR5)*R[i,k,j,-k]*R[-j,-l,-i,l]
	-lC1*R[i,k,j,-k]*WeylH[-i,-j]
	+lXi*WeylH[i,j]*WeylH[-i,-j]
	+(1/2)*lNu*WeylCovariantDerivativeOnScalar[-i]WeylCovariantDerivativeOnScalar[i]
	+(1/12)*(4lT1+lT2+3lLambda)*(Compensator[]^2)*WeylT[i,j,k]*WeylT[-i,-j,-k]
	-(1/6)*(2lT1-lT2+3lLambda)*(Compensator[]^2)*WeylT[i,j,k]*WeylT[-j,-k,-i]
	-(1/3)*(lT1-2lT3+3lLambda)*(Compensator[]^2)*WeylT[-i,j,i]*WeylT[-k,-j,k]
);

DisplayExpression[NonlinearLagrangianLinWeyl,EqnLabel->"LinWeylUnexpanded"];
Comment@{"In",Cref@"LinWeylUnexpanded"," this is the non-linear Lagrangian as given in eqn 10 of Lin, PHYS. REV. D 104, 024034 (2021)."};

NonlinearLagrangianLinWeyl=NonlinearLagrangianLinWeyl/.xAct`PSALTer`LagrangianLinWeylCouplings`Private`WeylQuantitiesExpand;
NonlinearLagrangianLinWeyl//=xAct`PSALTer`Private`ToNewCanonical;
NonlinearLagrangianLinWeyl//=CollectTensors;
