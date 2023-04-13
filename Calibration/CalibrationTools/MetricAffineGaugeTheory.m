(*===========================*)
(*  MetricAffineGaugeTheory  *)
(*===========================*)

Section@"Metric affine gauge theory";

Subsection@"Setting up the action";

Comment@"It is finally time to start our analysis of the metric affine gauge theory. First, we will try something extremely simple.";

Comment@"First we write out rules which define the field strength tensors.";

Comment@"We want to define the curvature in Equation (2.1) on page 4 of arXiv:1912.01023.";

DefTensor[MetricAffineCurvature[-m,-n,r,-s],M4,Antisymmetric[{-m,-n}],PrintAs->"\[ScriptCapitalF]"];
MetricAffineCurvatureToConnection=MakeRule[{MetricAffineCurvature[-m,-n,r,-s],CD[-m]@Connection[-n,r,-s]-CD[-n]@Connection[-m,r,-s]+Connection[-m,r,-t]*Connection[-n,t,-s]-Connection[-n,r,-t]*Connection[-m,t,-s]},MetricOn->All,ContractMetrics->True];

Expr=MetricAffineCurvature[-m,-n,r,-s];
DisplayExpression@Expr;
Expr=Expr/.MetricAffineCurvatureToConnection;
Expr//=ScreenDollarIndices;
DisplayExpression@Expr;

Comment@"Next want to define the torsion in Equation (2.2) on page 5 of arXiv:1912.01023.";

DefTensor[MetricAffineTorsion[-m,a,-n],M4,Antisymmetric[{-m,-n}],PrintAs->"\[ScriptCapitalT]"];
MetricAffineTorsionToConnection=MakeRule[{MetricAffineTorsion[-m,a,-n],Connection[-m,a,-n]-Connection[-n,a,-m]},MetricOn->All,ContractMetrics->True];

Expr=MetricAffineTorsion[-m,a,-n];
DisplayExpression@Expr;
Expr=Expr/.MetricAffineTorsionToConnection;
Expr//=ScreenDollarIndices;
DisplayExpression@Expr;

Comment@"And finally the non-metricity in Equation (2.3) on page 5 of arXiv:1912.01023. Watch out for the trivial misprint in the trace valence. Also, since the non-metricity only appears via quadratic invariants we don't need to bother about perturbing the metric here.";

DefTensor[MetricAffineNonMetricity[-l,-m,-n],M4,Symmetric[{-m,-n}],PrintAs->"\[ScriptCapitalQ]"];
MetricAffineNonMetricityToConnection=MakeRule[{MetricAffineNonMetricity[-l,-m,-n],-CD[-l]@LinearMetric[-m,-n]+Connection[-l,t,-m]*G[-t,-n]-Connection[-l,t,-n]*G[-m,-t]},MetricOn->All,ContractMetrics->True];

Expr=MetricAffineNonMetricity[-l,-m,-n];
DisplayExpression@Expr;
Expr=Expr/.MetricAffineNonMetricityToConnection;
Expr//=SeparateMetric[G];
Expr//=ScreenDollarIndices;
DisplayExpression@Expr;

Comment@"Now we move on to computing the (conventional) Ricci scalar in Equation (2.5) on page 5 of arXiv:1912.01023. This time we need to be careful to retain contributions up to second order in smallness, since this is the only invariant which appears on its own.";

DefTensor[MetricAffineRicciScalar[],M4,PrintAs->"\[ScriptCapitalF]"];
MetricAffineRicciScalarToConnection=MakeRule[{MetricAffineRicciScalar[],MetricAffineCurvature[-m,-n,r,-s]*(G[m,-r]-LinearMetric[m,-r])*(G[n,s]-LinearMetric[n,s])},MetricOn->All,ContractMetrics->True];

Expr=MetricAffineRicciScalar[];
DisplayExpression@Expr;
Expr=Expr/.MetricAffineRicciScalarToConnection;
Expr//=ScreenDollarIndices;
DisplayExpression@Expr;

Comment@"Now we want to consider the measure.";

Measure=1+(1/2)*LinearMetric[a,-a];
DisplayExpression@Measure;

Comment@"Now we proceed to compute the particle spectrum of the Einstein-Hilbert case.";

Off[ValidateSymbol::used];
DefConstantSymbol[PerturbativeParameter,PrintAs->"\[Epsilon]"];
On[ValidateSymbol::used];

ToOrderConnection=MakeRule[{Connection[-a,-b,-c],PerturbativeParameter*Connection[-a,-b,-c]},MetricOn->All,ContractMetrics->True];
ToOrderLinearMetric=MakeRule[{LinearMetric[-a,-b],PerturbativeParameter*LinearMetric[-a,-b]},MetricOn->All,ContractMetrics->True];
ToOrder=Join[ToOrderConnection,ToOrderLinearMetric];

LineariseLagrangian[NonlinearLagrangian_]:=Module[{LinearLagrangian=NonlinearLagrangian},	
	LinearLagrangian=LinearLagrangian/.MetricAffineRicciScalarToConnection;
	LinearLagrangian=LinearLagrangian/.MetricAffineCurvatureToConnection;
	LinearLagrangian=LinearLagrangian/.MetricAffineTorsionToConnection;
	LinearLagrangian=LinearLagrangian/.MetricAffineNonMetricityToConnection;
	LinearLagrangian=LinearLagrangian/.MetricAffineRicciScalarToConnection;
	LinearLagrangian=LinearLagrangian/.MetricAffineCurvatureToConnection;
	LinearLagrangian=LinearLagrangian/.MetricAffineTorsionToConnection;
	LinearLagrangian=LinearLagrangian/.MetricAffineNonMetricityToConnection;
	LinearLagrangian=LinearLagrangian/.ToOrder;
	LinearLagrangian//=Series[#,{PerturbativeParameter,0,2}]&;
	LinearLagrangian//=Normal;
	LinearLagrangian=LinearLagrangian/.PerturbativeParameter->1;
	LinearLagrangian//=xAct`PSALTer`Private`ToNewCanonical;
LinearLagrangian];

Comment@"Looking into theory.";

LinearLagrangian=-(1/2)*A0*Measure*MetricAffineRicciScalar[];
DisplayExpression@LinearLagrangian;
LinearLagrangian//=LineariseLagrangian;
DisplayExpression@LinearLagrangian;


DecomposeAndExpandFields[InputExpr_]:=Module[{Expr=InputExpr},
	DisplayExpression@Expr;
	Expr//=xAct`PSALTer`MetricAffineGaugeTheory`Private`DecomposeFields;
	DisplayExpression@Expr;
	Expr//=xAct`PSALTer`MetricAffineGaugeTheory`Private`ExpandFields;
	DisplayExpression@Expr;
];

ExpandAndDecomposeFields[InputExpr_]:=Module[{Expr=InputExpr},
	Print[" ** DefClass: expanding reduced-index mode into fundamental field and decomposing fundamental field back into reduced-index modes (should return original)."];
	DisplayExpression@Expr;
	Expr//=xAct`PSALTer`MetricAffineGaugeTheory`Private`ExpandFields;
	DisplayExpression@Expr;
	Expr//=xAct`PSALTer`MetricAffineGaugeTheory`Private`DecomposeFields;
	DisplayExpression@Expr;
];

Expr=MetricAffineGaugeTheory@xAct`PSALTer`Private`FieldSpinParityTensorHeads;
Expr=Values@(Values/@(Values/@Expr));
Expr//=Flatten;
Expr=ToIndexFree/@Expr;
Expr=FromIndexFree/@Expr;
DisplayExpression@Expr;

ExpandAndDecomposeFields/@Expr;


Throw@"Hold my sherry.";


Expr=Connection[-a,-b,-c];
DecomposeAndExpandFields

(*Throw@"Hold my ale";*)

ParticleSpectrum[
	"MetricAffineGaugeTheory",
	"EinsteinHilbertTheory",
	LinearLagrangian,
	TensorFields->{LinearMetric,Connection},
	CouplingConstants->{A0},
	ExportTheory->True
];

