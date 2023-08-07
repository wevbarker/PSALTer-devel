(*========================*)
(*  FieldStrengthTensors  *)
(*========================*)

Section@"Field strength tensors";

Supercomment@"In this section we will try our analysis of the metric affine gravity (MAG). Our attempt closely follows the very wonderful paper arXiv:1912.01023 which was first brought to my attention by Claire Rigouzzo. The current MAG implementation in PSALTer follows (to the letter) the conventions established in this paper. We will attempt to recover some key results in this paper, but we will also later look at arXiv:2110.14788, which was brought to my attention by Sebastian Zell.";

Comment@"First we write out rules which define the field strength tensors.";

Comment@"We want to define the curvature in Equation (2.1) on page 4 of arXiv:1912.01023.";

DefTensor[MetricAffineCurvature[-m,-n,r,-s],M4,Antisymmetric[{-m,-n}],PrintAs->"\[ScriptCapitalF]"];
MetricAffineCurvatureToPerturbed=MakeRule[{MetricAffineCurvature[-m,-n,r,-s],CD[-m]@Connection[-n,r,-s]-CD[-n]@Connection[-m,r,-s]+Connection[-m,r,-t]*Connection[-n,t,-s]-Connection[-n,r,-t]*Connection[-m,t,-s]},MetricOn->All,ContractMetrics->True];

Expr=MetricAffineCurvature[-m,-n,r,-s];
DisplayExpression[Expr,EqnLabel->"MetricAffineCurvature"];
Expr=Expr/.MetricAffineCurvatureToPerturbed;
Expr//=ScreenDollarIndices;
DisplayExpression[Expr,EqnLabel->"MetricAffineCurvaturePerturbed"];

Comment@"Next want to define the torsion in Equation (2.2) on page 5 of arXiv:1912.01023.";

DefTensor[MetricAffineTorsion[-m,a,-n],M4,Antisymmetric[{-m,-n}],PrintAs->"\[ScriptCapitalT]"];
MetricAffineTorsionToPerturbed=MakeRule[{MetricAffineTorsion[-m,a,-n],Connection[-m,a,-n]-Connection[-n,a,-m]},MetricOn->All,ContractMetrics->True];

Expr=MetricAffineTorsion[-m,a,-n];
DisplayExpression[Expr,EqnLabel->"MetricAffineTorsion"];
Expr=Expr/.MetricAffineTorsionToPerturbed;
Expr//=ScreenDollarIndices;
DisplayExpression@Expr;

Comment@"And finally the non-metricity in Equation (2.3) on page 5 of arXiv:1912.01023. Watch out for the trivial misprint in the trace valence. Also, since the non-metricity only appears via quadratic invariants we don't need to bother about perturbing the metric here.";

DefTensor[MetricAffineNonMetricity[-l,-m,-n],M4,Symmetric[{-m,-n}],PrintAs->"\[ScriptCapitalQ]"];
MetricAffineNonMetricityToPerturbed=MakeRule[{MetricAffineNonMetricity[-l,-m,-n],-CD[-l]@MetricPerturbation[-m,-n]+Connection[-l,t,-m]*G[-t,-n]+Connection[-l,t,-n]*G[-m,-t]},MetricOn->All,ContractMetrics->True];

Expr=MetricAffineNonMetricity[-l,-m,-n];
DisplayExpression[Expr,EqnLabel->"MetricAffineNonMetricity"];
Expr=Expr/.MetricAffineNonMetricityToPerturbed;
Expr//=SeparateMetric[G];
Expr//=ScreenDollarIndices;
DisplayExpression[Expr,EqnLabel->"MetricAffineNonMetricityPerturbation"];

Comment@"Now we move on to computing the seven contractions defined in Equation (2.5) on page 5 of arXiv:1912.01023. Most of these contractions only appear in quadratic invariants, so we only need these formulae to be accurate to first order in small quantities.";

Comment@"First comes the torsion contraction.";

DefTensor[MetricAffineTorsionContraction[-m],M4,PrintAs->"\[ScriptCapitalT]"];
MetricAffineTorsionContractionToPerturbed=MakeRule[{MetricAffineTorsionContraction[-m],MetricAffineTorsion[-l,l,-m]},MetricOn->All,ContractMetrics->True];

Expr=MetricAffineTorsionContraction[-m];
DisplayExpression[Expr,EqnLabel->"MetricAffineTorsionContraction"];
Expr=Expr/.MetricAffineTorsionContractionToPerturbed;
Expr//=ScreenDollarIndices;
DisplayExpression[Expr,EqnLabel->"MetricAffineTorsionContractionPerturbed"];

Comment@"Next the (standard) non-metricity contraction.";

DefTensor[MetricAffineNonMetricityContraction[-m],M4,PrintAs->"\[ScriptCapitalQ]"];
MetricAffineNonMetricityContractionToPerturbed=MakeRule[{MetricAffineNonMetricityContraction[-m],MetricAffineNonMetricity[-m,-l,l]},MetricOn->All,ContractMetrics->True];

Expr=MetricAffineNonMetricityContraction[-m];
DisplayExpression[Expr,EqnLabel->"MetricAffineNonMetricityContraction"];
Expr=Expr/.MetricAffineNonMetricityContractionToPerturbed;
Expr//=ScreenDollarIndices;
DisplayExpression[Expr,EqnLabel->"MetricAffineNonMetricityContractionPerturbed"];

Comment@"Next the (tilde) non-metricity contraction.";

DefTensor[MetricAffineNonMetricityContractionTilde[-m],M4,PrintAs->"\!\(\*OverscriptBox[\(\[ScriptCapitalQ]\), \(~\)]\)"];
MetricAffineNonMetricityContractionTildeToPerturbed=MakeRule[{MetricAffineNonMetricityContractionTilde[-m],MetricAffineNonMetricity[-l,l,-m]},MetricOn->All,ContractMetrics->True];

Expr=MetricAffineNonMetricityContractionTilde[-m];
DisplayExpression[Expr,EqnLabel->"MetricAffineNonMetricityContractionTilde"];
Expr=Expr/.MetricAffineNonMetricityContractionTildeToPerturbed;
Expr//=ScreenDollarIndices;
DisplayExpression[Expr,EqnLabel->"MetricAffineNonMetricityContractionTildePerturbed"];

Comment@"Next the (conventional) Ricci tensor.";

DefTensor[MetricAffineRicciTensor[-m,-n],M4,PrintAs->"\[ScriptCapitalF]"];
MetricAffineRicciTensorToPerturbed=MakeRule[{MetricAffineRicciTensor[-m,-n],MetricAffineCurvature[-m,-n,-l,l]},MetricOn->All,ContractMetrics->True];

Expr=MetricAffineRicciTensor[-m,-n];
DisplayExpression[Expr,EqnLabel->"MetricAffineRicciTensor"];
Expr=Expr/.MetricAffineRicciTensorToPerturbed;
Expr//=ScreenDollarIndices;
DisplayExpression[Expr,EqnLabel->"MetricAffineRicciTensorPerturbed"];

Comment@"Next the first of the pseudo-Ricci tensors.";

DefTensor[MetricAffineRicciTensor14[-m,-n],M4,PrintAs->"\!\(\*SuperscriptBox[\(\[ScriptCapitalF]\), \((14)\)]\)"];
MetricAffineRicciTensor14ToPerturbed=MakeRule[{MetricAffineRicciTensor14[-m,-n],MetricAffineCurvature[-l,-m,-n,l]},MetricOn->All,ContractMetrics->True];

Expr=MetricAffineRicciTensor14[-m,-n];
DisplayExpression[Expr,EqnLabel->"MetricAffineRicciTensor14"];
Expr=Expr/.MetricAffineRicciTensor14ToPerturbed;
Expr//=ScreenDollarIndices;
DisplayExpression[Expr,EqnLabel->"MetricAffineRicciTensor14Perturbed"];

Comment@"Next the second of the pseudo-Ricci tensors.";

DefTensor[MetricAffineRicciTensor13[-m,-n],M4,PrintAs->"\!\(\*SuperscriptBox[\(\[ScriptCapitalF]\), \((13)\)]\)"];
MetricAffineRicciTensor13ToPerturbed=MakeRule[{MetricAffineRicciTensor13[-m,-n],MetricAffineCurvature[-l,-m,l,-n]},MetricOn->All,ContractMetrics->True];

Expr=MetricAffineRicciTensor13[-m,-n];
DisplayExpression[Expr,EqnLabel->"MetricAffineRicciTensor13"];
Expr=Expr/.MetricAffineRicciTensor13ToPerturbed;
Expr//=ScreenDollarIndices;
DisplayExpression[Expr,EqnLabel->"MetricAffineRicciTensor13Perturbed"];

Comment@"Now we move on to computing the (conventional) Ricci scalar. This time we need to be careful to retain contributions up to second order in smallness, since this is the only invariant which appears on its own.";

DefTensor[MetricAffineRicciScalar[],M4,PrintAs->"\[ScriptCapitalF]"];
MetricAffineRicciScalarToPerturbed=MakeRule[{MetricAffineRicciScalar[],Scalar[MetricAffineCurvature[-m,-n,r,-s]*(G[m,-r])*(G[n,s]-MetricPerturbation[n,s])]},MetricOn->All,ContractMetrics->True];

Expr=MetricAffineRicciScalar[];
DisplayExpression[Expr,EqnLabel->"MetricAffineRicciScalar"];
Expr=Expr/.MetricAffineRicciScalarToPerturbed;
Expr//=ScreenDollarIndices;
DisplayExpression[Expr,EqnLabel->"MetricAffineRicciScalarPerturbed"];


ToPerturbed=Join[
MetricAffineCurvatureToPerturbed,
MetricAffineTorsionToPerturbed,
MetricAffineNonMetricityToPerturbed,
MetricAffineTorsionContractionToPerturbed,
MetricAffineNonMetricityContractionToPerturbed,
MetricAffineNonMetricityContractionTildeToPerturbed,
MetricAffineRicciTensorToPerturbed,
MetricAffineRicciTensor14ToPerturbed,
MetricAffineRicciTensor13ToPerturbed,
MetricAffineRicciScalarToPerturbed
];
