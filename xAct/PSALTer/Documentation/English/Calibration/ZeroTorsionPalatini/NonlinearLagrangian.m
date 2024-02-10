(*=======================*)
(*  NonlinearLagrangian  *)
(*=======================*)

Subsection@"The general parity-preserving Lagrangian";

Comment@{"Now we construct the zero-torsion counterpart of",Cref@"MetricAffineNonlinearLagrangian",", which is given in Eq. (6.2) on page 19 of arXiv:1912.01023."};

NonlinearLagrangian=-(1/2)*(
	-xAct`PSALTer`ZeroTorsionPalatini`ZeroTorsionPalatiniA0*ZeroTorsionRicciScalar[]
	+ZeroTorsionCurvature[m,n,r,s]*(
		xAct`PSALTer`ZeroTorsionPalatini`H1*ZeroTorsionCurvature[-m,-n,-r,-s]
		+xAct`PSALTer`ZeroTorsionPalatini`H2*ZeroTorsionCurvature[-m,-n,-s,-r]
		+xAct`PSALTer`ZeroTorsionPalatini`H3*ZeroTorsionCurvature[-r,-s,-m,-n]
		+xAct`PSALTer`ZeroTorsionPalatini`H4*ZeroTorsionCurvature[-m,-r,-n,-s]
	)
	+ZeroTorsionRicciTensor13[m,n]*(
		xAct`PSALTer`ZeroTorsionPalatini`H7*ZeroTorsionRicciTensor13[-m,-n]
		+xAct`PSALTer`ZeroTorsionPalatini`H8*ZeroTorsionRicciTensor13[-n,-m]
	)
	+ZeroTorsionRicciTensor14[m,n]*(
		xAct`PSALTer`ZeroTorsionPalatini`H9*ZeroTorsionRicciTensor14[-m,-n]
		+xAct`PSALTer`ZeroTorsionPalatini`H10*ZeroTorsionRicciTensor14[-n,-m]
	)
	+ZeroTorsionRicciTensor14[m,n]*(
		xAct`PSALTer`ZeroTorsionPalatini`H11*ZeroTorsionRicciTensor13[-m,-n]
		+xAct`PSALTer`ZeroTorsionPalatini`H12*ZeroTorsionRicciTensor13[-n,-m]
	)
	+xAct`PSALTer`ZeroTorsionPalatini`H16*ZeroTorsionRicciScalar[]*ZeroTorsionRicciScalar[]
	+ZeroTorsionNonMetricity[r,m,n]*(
		xAct`PSALTer`ZeroTorsionPalatini`ZeroTorsionPalatiniA4*ZeroTorsionNonMetricity[-r,-m,-n]
		+xAct`PSALTer`ZeroTorsionPalatini`ZeroTorsionPalatiniA5*ZeroTorsionNonMetricity[-n,-m,-r]
	)
	+xAct`PSALTer`ZeroTorsionPalatini`ZeroTorsionPalatiniA6*ZeroTorsionNonMetricityContraction[-m]*ZeroTorsionNonMetricityContraction[m]
	+xAct`PSALTer`ZeroTorsionPalatini`ZeroTorsionPalatiniA7*ZeroTorsionNonMetricityContractionTilde[-m]*ZeroTorsionNonMetricityContractionTilde[m]
	+xAct`PSALTer`ZeroTorsionPalatini`ZeroTorsionPalatiniA8*ZeroTorsionNonMetricityContraction[-m]*ZeroTorsionNonMetricityContractionTilde[m]
);

DisplayExpression[NonlinearLagrangian,EqnLabel->"ZeroTorsionNonlinearLagrangian"];

Comment@{"Again we will need to include the linearised measure as in",Cref@"Measure","."};

Measure=1+(1/2)*ZeroTorsionPalatiniMetricPerturbation[a,-a];
DisplayExpression@Measure;


Off[ValidateSymbol::used];
DefConstantSymbol[PerturbativeParameter,PrintAs->"\[Epsilon]"];
On[ValidateSymbol::used];

ToOrderZeroTorsionPalatiniConnection=MakeRule[{ZeroTorsionPalatiniConnection[-a,-b,-c],PerturbativeParameter*ZeroTorsionPalatiniConnection[-a,-b,-c]},MetricOn->All,ContractMetrics->True];
ToOrderZeroTorsionPalatiniMetricPerturbation=MakeRule[{ZeroTorsionPalatiniMetricPerturbation[-a,-b],PerturbativeParameter*ZeroTorsionPalatiniMetricPerturbation[-a,-b]},MetricOn->All,ContractMetrics->True];
ToOrder=Join[ToOrderZeroTorsionPalatiniConnection,ToOrderZeroTorsionPalatiniMetricPerturbation];


FirstOrderZeroTorsionPalatiniConnectionToSecondOrderZeroTorsionPalatiniConnection=MakeRule[{
		ZeroTorsionPalatiniConnection[-m,r,-n],
ZeroTorsionPalatiniConnection[-m,r,-n]+(1/2)*(G[r,l]-ZeroTorsionPalatiniMetricPerturbation[r,l])*(CD[-m]@ZeroTorsionPalatiniMetricPerturbation[-l,-n]+CD[-n]@ZeroTorsionPalatiniMetricPerturbation[-l,-m]-CD[-l]@ZeroTorsionPalatiniMetricPerturbation[-m,-n])},
		MetricOn->All,ContractMetrics->True];

Options@ZeroTorsionPalatiniLineariseLagrangian={Formulation->FirstOrder};
ZeroTorsionPalatiniLineariseLagrangian[NonlinearLagrangian_,OptionsPattern[]]:=Module[{
	LinearLagrangian=NonlinearLagrangian,
	FirstOrderPart,
	SecondOrderPart	
	},	

	LinearLagrangian=LinearLagrangian/.ZeroTorsionRicciScalarToPerturbed;
	LinearLagrangian//=NoScalar;
	LinearLagrangian//=xAct`PSALTer`Private`ToNewCanonical;
	LinearLagrangian=LinearLagrangian/.ZeroTorsionCurvatureToPerturbed;
	LinearLagrangian//=NoScalar;
	LinearLagrangian//=xAct`PSALTer`Private`ToNewCanonical;
	LinearLagrangian=LinearLagrangian/.ZeroTorsionNonMetricityToPerturbed;
	LinearLagrangian//=NoScalar;
	LinearLagrangian//=xAct`PSALTer`Private`ToNewCanonical;
	LinearLagrangian=LinearLagrangian/.ZeroTorsionRicciScalarToPerturbed;
	LinearLagrangian//=NoScalar;
	LinearLagrangian//=xAct`PSALTer`Private`ToNewCanonical;
	LinearLagrangian=LinearLagrangian/.ZeroTorsionCurvatureToPerturbed;
	LinearLagrangian//=NoScalar;
	LinearLagrangian//=xAct`PSALTer`Private`ToNewCanonical;
	LinearLagrangian=LinearLagrangian/.ZeroTorsionNonMetricityToPerturbed;
	LinearLagrangian//=NoScalar;
	LinearLagrangian//=xAct`PSALTer`Private`ToNewCanonical;
	LinearLagrangian=LinearLagrangian/.ToPerturbed;
	LinearLagrangian//=NoScalar;
	LinearLagrangian//=xAct`PSALTer`Private`ToNewCanonical;
	LinearLagrangian=LinearLagrangian/.ToPerturbed;
	LinearLagrangian//=NoScalar;
	LinearLagrangian//=xAct`PSALTer`Private`ToNewCanonical;
	LinearLagrangian=LinearLagrangian/.ToPerturbed;
	LinearLagrangian//=NoScalar;

	If[OptionValue@Formulation==SecondOrder,
		LinearLagrangian=LinearLagrangian/.FirstOrderZeroTorsionPalatiniConnectionToSecondOrderZeroTorsionPalatiniConnection;
	];
	LinearLagrangian//=NoScalar;
	LinearLagrangian//=xAct`PSALTer`Private`ToNewCanonical;
	LinearLagrangian=LinearLagrangian/.ToOrder;

	SecondOrderPart=LinearLagrangian//Series[#,{PerturbativeParameter,0,2}]&;
	SecondOrderPart//=Normal;
	SecondOrderPart=SecondOrderPart/.PerturbativeParameter->1;
	SecondOrderPart//=xAct`PSALTer`Private`ToNewCanonical;

	FirstOrderPart=LinearLagrangian//Series[#,{PerturbativeParameter,0,1}]&;
	FirstOrderPart//=Normal;
	FirstOrderPart=FirstOrderPart/.PerturbativeParameter->1;
	FirstOrderPart//=xAct`PSALTer`Private`ToNewCanonical;

	LinearLagrangian=SecondOrderPart-FirstOrderPart;
	LinearLagrangian//=xAct`PSALTer`Private`ToNewCanonical;
	LinearLagrangian//=CollectTensors;

LinearLagrangian];

Comment@{"Now we linearize",Cref@"ZeroTorsionNonlinearLagrangian","."};

LinearLagrangian=Measure*NonlinearLagrangian//ZeroTorsionPalatiniLineariseLagrangian;
DisplayExpression[LinearLagrangian,EqnLabel->"ZeroTorsionLinearLagrangian"];

Comment@{"We see that",Cref@"ZeroTorsionLinearLagrangian"," is appreciably shorter than",Cref@"MetricAffineLinearLagrangian",", which is to be expected."};
