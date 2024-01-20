(*=======================*)
(*  NonlinearLagrangian  *)
(*=======================*)

Subsection@"The general parity-preserving Lagrangian";

Comment@"Now all the generally-covariant contractions of the field strength tensors have been defined, so we construct the general, parity-preserving Lagrangian proposed in Equation (2.4) on page 5 of arXiv:1912.01023.";

NonlinearLagrangian=-(1/2)*(
	-xAct`PSALTer`MetricAffineGravity`A0*MetricAffineRicciScalar[]
	+MetricAffineCurvature[m,n,r,s]*(
		xAct`PSALTer`MetricAffineGravity`C1*MetricAffineCurvature[-m,-n,-r,-s]
		+xAct`PSALTer`MetricAffineGravity`C2*MetricAffineCurvature[-m,-n,-s,-r]
		+xAct`PSALTer`MetricAffineGravity`C3*MetricAffineCurvature[-r,-s,-m,-n]
		+xAct`PSALTer`MetricAffineGravity`C4*MetricAffineCurvature[-m,-r,-n,-s]
		+xAct`PSALTer`MetricAffineGravity`C5*MetricAffineCurvature[-m,-s,-n,-r]
		+xAct`PSALTer`MetricAffineGravity`C6*MetricAffineCurvature[-m,-s,-r,-n]
	)
	+MetricAffineRicciTensor13[m,n]*(
		xAct`PSALTer`MetricAffineGravity`C7*MetricAffineRicciTensor13[-m,-n]
		+xAct`PSALTer`MetricAffineGravity`C8*MetricAffineRicciTensor13[-n,-m]
	)
	+MetricAffineRicciTensor14[m,n]*(
		xAct`PSALTer`MetricAffineGravity`C9*MetricAffineRicciTensor14[-m,-n]
		+xAct`PSALTer`MetricAffineGravity`C10*MetricAffineRicciTensor14[-n,-m]
	)
	+MetricAffineRicciTensor14[m,n]*(
		xAct`PSALTer`MetricAffineGravity`C11*MetricAffineRicciTensor13[-m,-n]
		+xAct`PSALTer`MetricAffineGravity`C12*MetricAffineRicciTensor13[-n,-m]
	)
	+MetricAffineRicciTensor[m,n]*(
		xAct`PSALTer`MetricAffineGravity`C13*MetricAffineRicciTensor[-m,-n]
		+xAct`PSALTer`MetricAffineGravity`C14*MetricAffineRicciTensor13[-m,-n]
		+xAct`PSALTer`MetricAffineGravity`C15*MetricAffineRicciTensor14[-m,-n]
	)
	+xAct`PSALTer`MetricAffineGravity`C16*MetricAffineRicciScalar[]*MetricAffineRicciScalar[]
	+MetricAffineTorsion[m,r,n]*(
		xAct`PSALTer`MetricAffineGravity`A1*MetricAffineTorsion[-m,-r,-n]
		+xAct`PSALTer`MetricAffineGravity`A2*MetricAffineTorsion[-m,-n,-r]
	)
	+xAct`PSALTer`MetricAffineGravity`A3*MetricAffineTorsionContraction[m]*MetricAffineTorsionContraction[-m]
	+MetricAffineNonMetricity[r,m,n]*(
		xAct`PSALTer`MetricAffineGravity`A4*MetricAffineNonMetricity[-r,-m,-n]
		+xAct`PSALTer`MetricAffineGravity`A5*MetricAffineNonMetricity[-n,-m,-r]
	)
	+xAct`PSALTer`MetricAffineGravity`A6*MetricAffineNonMetricityContraction[-m]*MetricAffineNonMetricityContraction[m]
	+xAct`PSALTer`MetricAffineGravity`A7*MetricAffineNonMetricityContractionTilde[-m]*MetricAffineNonMetricityContractionTilde[m]
	+xAct`PSALTer`MetricAffineGravity`A8*MetricAffineNonMetricityContraction[-m]*MetricAffineNonMetricityContractionTilde[m]
	+xAct`PSALTer`MetricAffineGravity`A9*MetricAffineTorsion[m,r,n]*MetricAffineNonMetricity[-m,-r,-n]
	+MetricAffineTorsionContraction[m]*(
		xAct`PSALTer`MetricAffineGravity`A10*MetricAffineNonMetricityContraction[-m]
		+xAct`PSALTer`MetricAffineGravity`A11*MetricAffineNonMetricityContractionTilde[-m]
	)
);

DisplayExpression[NonlinearLagrangian,EqnLabel->"MetricAffineNonlinearLagrangian"];

Comment@"This general Lagrangian is something that we must linearize. First, we need the linearized measure, otherwise the Einstein--Hilbert term (which has first-order perturbed contributions) won't have the right linearization.";

Measure=1+(1/2)*MetricPerturbation[a,-a];
DisplayExpression[Measure,EqnLabel->"Measure"];


Off[ValidateSymbol::used];
DefConstantSymbol[PerturbativeParameter,PrintAs->"\[Epsilon]"];
On[ValidateSymbol::used];

ToOrderConnection=MakeRule[{Connection[-a,-b,-c],PerturbativeParameter*Connection[-a,-b,-c]},MetricOn->All,ContractMetrics->True];
ToOrderMetricPerturbation=MakeRule[{MetricPerturbation[-a,-b],PerturbativeParameter*MetricPerturbation[-a,-b]},MetricOn->All,ContractMetrics->True];
ToOrder=Join[ToOrderConnection,ToOrderMetricPerturbation];


FirstOrderConnectionToSecondOrderConnection=MakeRule[{
		Connection[-m,r,-n],
		Connection[-m,r,-n]+(1/2)*(G[r,l]-MetricPerturbation[r,l])*(CD[-m]@MetricPerturbation[-l,-n]+CD[-n]@MetricPerturbation[-l,-m]-CD[-l]@MetricPerturbation[-m,-n])},
		MetricOn->All,ContractMetrics->True];

LinearFirstOrderToLinearSecondOrder[LinearFirstOrder_]:=Module[{LinearSecondOrder=LinearFirstOrder},
	LinearSecondOrder=LinearSecondOrder/.FirstOrderConnectionToSecondOrderConnection;
	LinearSecondOrder//=LineariseLagrangian;
LinearSecondOrder];


Options@LineariseLagrangian={Formulation->FirstOrder};
LineariseLagrangian[NonlinearLagrangian_,OptionsPattern[]]:=Module[{
	LinearLagrangian=NonlinearLagrangian,
	FirstOrderPart,
	SecondOrderPart	
	},	

	LinearLagrangian=LinearLagrangian/.MetricAffineRicciScalarToPerturbed;
	LinearLagrangian//=NoScalar;
	LinearLagrangian//=xAct`PSALTer`Private`ToNewCanonical;
	LinearLagrangian=LinearLagrangian/.MetricAffineCurvatureToPerturbed;
	LinearLagrangian//=NoScalar;
	LinearLagrangian//=xAct`PSALTer`Private`ToNewCanonical;
	LinearLagrangian=LinearLagrangian/.MetricAffineTorsionToPerturbed;
	LinearLagrangian//=NoScalar;
	LinearLagrangian//=xAct`PSALTer`Private`ToNewCanonical;
	LinearLagrangian=LinearLagrangian/.MetricAffineNonMetricityToPerturbed;
	LinearLagrangian//=NoScalar;
	LinearLagrangian//=xAct`PSALTer`Private`ToNewCanonical;
	LinearLagrangian=LinearLagrangian/.MetricAffineRicciScalarToPerturbed;
	LinearLagrangian//=NoScalar;
	LinearLagrangian//=xAct`PSALTer`Private`ToNewCanonical;
	LinearLagrangian=LinearLagrangian/.MetricAffineCurvatureToPerturbed;
	LinearLagrangian//=NoScalar;
	LinearLagrangian//=xAct`PSALTer`Private`ToNewCanonical;
	LinearLagrangian=LinearLagrangian/.MetricAffineTorsionToPerturbed;
	LinearLagrangian//=NoScalar;
	LinearLagrangian//=xAct`PSALTer`Private`ToNewCanonical;
	LinearLagrangian=LinearLagrangian/.MetricAffineNonMetricityToPerturbed;
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
	Comment@"interim";
	DisplayExpression@LinearLagrangian;
	If[OptionValue@Formulation==SecondOrder,
		LinearLagrangian=LinearLagrangian/.FirstOrderConnectionToSecondOrderConnection;
	];
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

Comment@"Now we attempt the linearization.";

LinearLagrangian=Measure*NonlinearLagrangian//LineariseLagrangian;
DisplayExpression[LinearLagrangian,EqnLabel->"MetricAffineLinearLagrangian"];

Comment@{"We see that",Cref@"MetricAffineLinearLagrangian"," is generically quite a heavy expression, and there is not a very high degree of degeneracy among the coupling constants."};

Comment@"Now we try the second order formulation.";

LinearLagrangianSecondOrder=LinearLagrangian[Measure*NonlinearLagrangian,Formulation->SecondOrder];
DisplayExpression[LinearLagrangianSecondOrder,EqnLabel->"MetricAffineLinearLagrangianSecondOrder"];
