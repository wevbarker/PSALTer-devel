(*========================*)
(*  PercacciSezginTheory  *)
(*========================*)

Section@"Percacci-Sezgin theory";

Comment@"We define the three constants which are set out in Eq. (6.16) on page 23 of arXiv:1912.01023.";

PercacciRules={};
DefConstantSymbol[PercacciA,PrintAs->"\[ScriptCapitalA]"];
PercacciRules=PercacciRules~Join~{PercacciA->7*A0-40*A6-28*A7-34*A8}
Expr=PercacciA;
DisplayExpression[Expr,EqnLabel->"PercacciRule1"];
Expr=Expr/.PercacciRules;
DisplayExpression[Expr,EqnLabel->"PercacciRule2"];

DefConstantSymbol[PercacciB,PrintAs->"\[ScriptCapitalB]"];
PercacciRules=PercacciRules~Join~{PercacciB->4*A0+20*A6-7*A7+2*A8}
Expr=PercacciB;
DisplayExpression[Expr,EqnLabel->"PercacciRule3"];
Expr=Expr/.PercacciRules;
DisplayExpression[Expr,EqnLabel->"PercacciRule4"];

DefConstantSymbol[PercacciC,PrintAs->"\[ScriptCapitalC]"];
PercacciRules=PercacciRules~Join~{PercacciC->A0+8*A6-4*A7+2*A8}
Expr=PercacciC;
DisplayExpression[Expr,EqnLabel->"PercacciRule5"];
Expr=Expr/.PercacciRules;
DisplayExpression[Expr,EqnLabel->"PercacciRule6"];

Comment@"Next we define the Lagrangian set out in Eq. (6.15) on page 22 of arXiv:1912.01023.";
PercacciNonlinearLagrangian=-(1/2)*(
	-xAct`PSALTer`ZeroTorsionPalatini`A0*ZeroTorsionRicciScalar[]
	+(1/2)*H1*ZeroTorsionRicciTensor13[m,n]*(
		ZeroTorsionRicciTensor13[-m,-n]
		+ZeroTorsionRicciTensor13[-n,-m]
	)
	+(1/2)*H2*ZeroTorsionRicciTensor13[m,n]*(
		ZeroTorsionRicciTensor13[-m,-n]
		-ZeroTorsionRicciTensor13[-n,-m]
	)
	+H3*ZeroTorsionRicciTensorTri[m,n]*ZeroTorsionRicciTensorTri[-m,-n]
	+H4*ZeroTorsionRicciTensorP[m,n]*ZeroTorsionRicciTensorP[-m,-n]
);

PercacciNonlinearLagrangian=-(1/2)*(
	-xAct`PSALTer`ZeroTorsionPalatini`A0*ZeroTorsionRicciScalar[]
	-(1/4)*(10*xAct`PSALTer`ZeroTorsionPalatini`H7+3*xAct`PSALTer`ZeroTorsionPalatini`H11)ZeroTorsionCurvature[m,n,r,s]*(
		ZeroTorsionCurvature[-m,-n,-r,-s]
		-2*ZeroTorsionCurvature[-m,-r,-n,-s]
	)
	+2*(1/2)*(ZeroTorsionRicciTensor13[m,n]-ZeroTorsionRicciTensor13[n,m])*(
		xAct`PSALTer`ZeroTorsionPalatini`H7*ZeroTorsionRicciTensor13[-m,-n]
		+xAct`PSALTer`ZeroTorsionPalatini`H11*ZeroTorsionRicciTensor14[-n,-m]
	)
	-(2/3)*(5*xAct`PSALTer`ZeroTorsionPalatini`H7+4*xAct`PSALTer`ZeroTorsionPalatini`H11)*(1/2)*(ZeroTorsionRicciTensor14[m,n]-ZeroTorsionRicciTensor14[n,m])*(
		ZeroTorsionRicciTensor14[-m,-n]
	)
	+(1/48)*(12*xAct`PSALTer`ZeroTorsionPalatini`A0+PercacciA-16*PercacciB)*ZeroTorsionNonMetricity[r,m,n]*ZeroTorsionNonMetricity[-r,-m,-n]
	-(1/24)*(12*xAct`PSALTer`ZeroTorsionPalatini`A0-PercacciA-8*PercacciB)*ZeroTorsionNonMetricity[r,m,n]*ZeroTorsionNonMetricity[-n,-m,-r]
	-(1/288)*(72*xAct`PSALTer`ZeroTorsionPalatini`A0+PercacciA-32*PercacciB+49*PercacciC)*ZeroTorsionNonMetricityContraction[-m]*ZeroTorsionNonMetricityContraction[m]
	-(1/72)*(PercacciA-8*PercacciB+25*PercacciC)*ZeroTorsionNonMetricityContractionTilde[-m]*ZeroTorsionNonMetricityContractionTilde[m]
	+(1/72)*(36*xAct`PSALTer`ZeroTorsionPalatini`A0-PercacciA-16*PercacciB+35*PercacciC)*ZeroTorsionNonMetricityContraction[-m]*ZeroTorsionNonMetricityContractionTilde[m]
);
DisplayExpression[PercacciNonlinearLagrangian,EqnLabel->"ZeroTorsionPercacciLinearLagrangian"];

Comment@"This is next linearised.";
PercacciLinearLagrangian=Measure*PercacciNonlinearLagrangian//LineariseLagrangian;
DisplayExpression[PercacciLinearLagrangian,EqnLabel->"ZeroTorsionPercacciLinearLagrangian"];

Comment@{"Now we use",Cref@{"PercacciRule1","PercacciRule2","PercacciRule3","PercacciRule4","PercacciRule5","PercacciRule6"},"."};
PercacciLinearLagrangian=PercacciLinearLagrangian/.PercacciRules;
PercacciLinearLagrangian//=ToCanonical;
PercacciLinearLagrangian//=CollectTensors;
PercacciLinearLagrangian//=ScreenDollarIndices;
DisplayExpression[PercacciLinearLagrangian,EqnLabel->"ZeroTorsionPercacciLinearLagrangian"];

ParticleSpectrum[PercacciLinearLagrangian,
		ClassName->"ZeroTorsionPalatini",
		TheoryName->"PercacciSezginTheory",	
		Method->"Easy",
		MaxLaurentDepth->1];
Comment@"Some comment.";
