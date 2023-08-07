(*========================*)
(*  FieldStrengthTensors  *)
(*========================*)

Section@"Field strength tensors";

Supercomment@"In this section we will restrict our MAG implementation to the zero-torsion case, as detailed in Section 6 of arXiv:1912.01023.";

Comment@"First we write out rules which define the field strength tensors.";

Comment@{"The curvature is defined as in",Cref@{"MetricAffineCurvature","MetricAffineCurvaturePerturbed"},"."};

DefTensor[ZeroTorsionCurvature[-m,-n,r,-s],M4,Antisymmetric[{-m,-n}],PrintAs->"\[ScriptCapitalF]"];
ZeroTorsionCurvatureToPerturbed=MakeRule[{ZeroTorsionCurvature[-m,-n,r,-s],CD[-m]@ZeroTorsionPalatiniConnection[-n,r,-s]-CD[-n]@ZeroTorsionPalatiniConnection[-m,r,-s]+ZeroTorsionPalatiniConnection[-m,r,-t]*ZeroTorsionPalatiniConnection[-n,t,-s]-ZeroTorsionPalatiniConnection[-n,r,-t]*ZeroTorsionPalatiniConnection[-m,t,-s]},MetricOn->All,ContractMetrics->True];

Expr=ZeroTorsionCurvature[-m,-n,r,-s];
DisplayExpression@Expr;
Expr=Expr/.ZeroTorsionCurvatureToPerturbed;
Expr//=ScreenDollarIndices;
DisplayExpression@Expr;

Comment@{"The torsion in",Cref@"MetricAffineTorsion"," is now vanishing of course."};

Comment@{"And finally the non-metricity as in",Cref@{"MetricAffineNonMetricity","MetricAffineNonMetricityPerturbation"},"."};

DefTensor[ZeroTorsionNonMetricity[-l,-m,-n],M4,Symmetric[{-m,-n}],PrintAs->"\[ScriptCapitalQ]"];
ZeroTorsionNonMetricityToPerturbed=MakeRule[{ZeroTorsionNonMetricity[-l,-m,-n],-CD[-l]@ZeroTorsionPalatiniMetricPerturbation[-m,-n]+ZeroTorsionPalatiniConnection[-l,t,-m]*G[-t,-n]+ZeroTorsionPalatiniConnection[-l,t,-n]*G[-m,-t]},MetricOn->All,ContractMetrics->True];

Expr=ZeroTorsionNonMetricity[-l,-m,-n];
DisplayExpression@Expr;
Expr=Expr/.ZeroTorsionNonMetricityToPerturbed;
Expr//=SeparateMetric[G];
Expr//=ScreenDollarIndices;
DisplayExpression@Expr;

Comment@"Now we move on to computing the seven contractions defined in Equation (2.5) on page 5 of arXiv:1912.01023. Most of these contractions only appear in quadratic invariants, so we only need these formulae to be accurate to first order in small quantities.";

Comment@{"The torsion contraction in",Cref@{"MetricAffineTorsionContraction","MetricAffineTorsionContractionPerturbed"}," is vanishing of course."};

Comment@{"Next the (standard) non-metricity contraction as in",Cref@{"MetricAffineNonMetricityContraction","MetricAffineNonMetricityContractionPerturbed"},"."};

DefTensor[ZeroTorsionNonMetricityContraction[-m],M4,PrintAs->"\[ScriptCapitalQ]"];
ZeroTorsionNonMetricityContractionToPerturbed=MakeRule[{ZeroTorsionNonMetricityContraction[-m],ZeroTorsionNonMetricity[-m,-l,l]},MetricOn->All,ContractMetrics->True];

Expr=ZeroTorsionNonMetricityContraction[-m];
DisplayExpression@Expr;
Expr=Expr/.ZeroTorsionNonMetricityContractionToPerturbed;
Expr//=ScreenDollarIndices;
DisplayExpression@Expr;

Comment@{"Next the (tilde) non-metricity contraction as in",Cref@{"MetricAffineNonMetricityContractionTilde","MetricAffineNonMetricityContractionTildePerturbed"},"."};

DefTensor[ZeroTorsionNonMetricityContractionTilde[-m],M4,PrintAs->"\!\(\*OverscriptBox[\(\[ScriptCapitalQ]\), \(~\)]\)"];
ZeroTorsionNonMetricityContractionTildeToPerturbed=MakeRule[{ZeroTorsionNonMetricityContractionTilde[-m],ZeroTorsionNonMetricity[-l,l,-m]},MetricOn->All,ContractMetrics->True];

Expr=ZeroTorsionNonMetricityContractionTilde[-m];
DisplayExpression@Expr;
Expr=Expr/.ZeroTorsionNonMetricityContractionTildeToPerturbed;
Expr//=ScreenDollarIndices;
DisplayExpression@Expr;

Comment@{"According to Eq. (6.1) of arXiv:1912.01023, we don't need a separate definition for the conventional Ricci tensor as defined in",Cref@{"MetricAffineRicciTensor","MetricAffineRicciTensorPerturbed"},"."};

Comment@{"Next the first of the pseudo-Ricci tensors as in",Cref@{"MetricAffineRicciTensor14","MetricAffineRicciTensor14Perturbed"},"."};

DefTensor[ZeroTorsionRicciTensor14[-m,-n],M4,PrintAs->"\!\(\*SuperscriptBox[\(\[ScriptCapitalF]\), \((14)\)]\)"];
ZeroTorsionRicciTensor14ToPerturbed=MakeRule[{ZeroTorsionRicciTensor14[-m,-n],ZeroTorsionCurvature[-l,-m,-n,l]},MetricOn->All,ContractMetrics->True];

Expr=ZeroTorsionRicciTensor14[-m,-n];
DisplayExpression@Expr;
Expr=Expr/.ZeroTorsionRicciTensor14ToPerturbed;
Expr//=ScreenDollarIndices;
DisplayExpression@Expr;

Comment@{"Next the second of the pseudo-Ricci tensors as in",Cref@{"MetricAffineRicciTensor13","MetricAffineRicciTensor13Perturbed"},"."};

DefTensor[ZeroTorsionRicciTensor13[-m,-n],M4,PrintAs->"\!\(\*SuperscriptBox[\(\[ScriptCapitalF]\), \((13)\)]\)"];
ZeroTorsionRicciTensor13ToPerturbed=MakeRule[{ZeroTorsionRicciTensor13[-m,-n],ZeroTorsionCurvature[-l,-m,l,-n]},MetricOn->All,ContractMetrics->True];

Expr=ZeroTorsionRicciTensor13[-m,-n];
DisplayExpression@Expr;
Expr=Expr/.ZeroTorsionRicciTensor13ToPerturbed;
Expr//=ScreenDollarIndices;
DisplayExpression@Expr;

Comment@{"Now we move on to computing the (conventional) Ricci scalar as in",Cref@{"MetricAffineRicciScalar","MetricAffineRicciScalarPerturbed"},"."};

DefTensor[ZeroTorsionRicciScalar[],M4,PrintAs->"\[ScriptCapitalF]"];
ZeroTorsionRicciScalarToPerturbed=MakeRule[{ZeroTorsionRicciScalar[],Scalar[ZeroTorsionCurvature[-m,-n,r,-s]*(G[m,-r])*(G[n,s]-ZeroTorsionPalatiniMetricPerturbation[n,s])]},MetricOn->All,ContractMetrics->True];

Expr=ZeroTorsionRicciScalar[];
DisplayExpression@Expr;
Expr=Expr/.ZeroTorsionRicciScalarToPerturbed;
Expr//=ScreenDollarIndices;
DisplayExpression@Expr;


ToPerturbed=Join[
ZeroTorsionCurvatureToPerturbed,
ZeroTorsionTorsionToPerturbed,
ZeroTorsionNonMetricityToPerturbed,
ZeroTorsionTorsionContractionToPerturbed,
ZeroTorsionNonMetricityContractionToPerturbed,
ZeroTorsionNonMetricityContractionTildeToPerturbed,
ZeroTorsionRicciTensorToPerturbed,
ZeroTorsionRicciTensor14ToPerturbed,
ZeroTorsionRicciTensor13ToPerturbed,
ZeroTorsionRicciScalarToPerturbed
];
