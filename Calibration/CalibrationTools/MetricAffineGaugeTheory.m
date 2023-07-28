(*===========================*)
(*  MetricAffineGaugeTheory  *)
(*===========================*)

Section@"Metric affine gauge theory";

Subsection@"Field strength tensors";

PartIIIProject@"In this section we will try our analysis of the metric affine gauge theory (MAGT). Our attempt closely follows the very wonderful paper arXiv:1912.01023 which was first brought to my attention by Claire Rigouzzo. The current MAGT implementation in PSALTer follows (to the letter) the conventions established in this paper. We will attempt to recover some key results in this paper, but we will also later look at arXiv:2110.14788, which was brought to my attention by Sebastian Zell.";

Comment@"First we write out rules which define the field strength tensors.";

Comment@"We want to define the curvature in Equation (2.1) on page 4 of arXiv:1912.01023.";

DefTensor[MetricAffineCurvature[-m,-n,r,-s],M4,Antisymmetric[{-m,-n}],PrintAs->"\[ScriptCapitalF]"];
MetricAffineCurvatureToPerturbed=MakeRule[{MetricAffineCurvature[-m,-n,r,-s],CD[-m]@Connection[-n,r,-s]-CD[-n]@Connection[-m,r,-s]+Connection[-m,r,-t]*Connection[-n,t,-s]-Connection[-n,r,-t]*Connection[-m,t,-s]},MetricOn->All,ContractMetrics->True];

Expr=MetricAffineCurvature[-m,-n,r,-s];
DisplayExpression@Expr;
Expr=Expr/.MetricAffineCurvatureToPerturbed;
Expr//=ScreenDollarIndices;
DisplayExpression@Expr;

Comment@"Next want to define the torsion in Equation (2.2) on page 5 of arXiv:1912.01023.";

DefTensor[MetricAffineTorsion[-m,a,-n],M4,Antisymmetric[{-m,-n}],PrintAs->"\[ScriptCapitalT]"];
MetricAffineTorsionToPerturbed=MakeRule[{MetricAffineTorsion[-m,a,-n],Connection[-m,a,-n]-Connection[-n,a,-m]},MetricOn->All,ContractMetrics->True];

Expr=MetricAffineTorsion[-m,a,-n];
DisplayExpression@Expr;
Expr=Expr/.MetricAffineTorsionToPerturbed;
Expr//=ScreenDollarIndices;
DisplayExpression@Expr;

Comment@"And finally the non-metricity in Equation (2.3) on page 5 of arXiv:1912.01023. Watch out for the trivial misprint in the trace valence. Also, since the non-metricity only appears via quadratic invariants we don't need to bother about perturbing the metric here.";

DefTensor[MetricAffineNonMetricity[-l,-m,-n],M4,Symmetric[{-m,-n}],PrintAs->"\[ScriptCapitalQ]"];
MetricAffineNonMetricityToPerturbed=MakeRule[{MetricAffineNonMetricity[-l,-m,-n],-CD[-l]@MetricPerturbation[-m,-n]+Connection[-l,t,-m]*G[-t,-n]+Connection[-l,t,-n]*G[-m,-t]},MetricOn->All,ContractMetrics->True];

Expr=MetricAffineNonMetricity[-l,-m,-n];
DisplayExpression@Expr;
Expr=Expr/.MetricAffineNonMetricityToPerturbed;
Expr//=SeparateMetric[G];
Expr//=ScreenDollarIndices;
DisplayExpression@Expr;

Comment@"Now we move on to computing the seven contractions defined in Equation (2.5) on page 5 of arXiv:1912.01023. Most of these contractions only appear in quadratic invariants, so we only need these formulae to be accurate to first order in small quantities.";

Comment@"First comes the torsion contraction.";

DefTensor[MetricAffineTorsionContraction[-m],M4,PrintAs->"\[ScriptCapitalT]"];
MetricAffineTorsionContractionToPerturbed=MakeRule[{MetricAffineTorsionContraction[-m],MetricAffineTorsion[-l,l,-m]},MetricOn->All,ContractMetrics->True];

Expr=MetricAffineTorsionContraction[-m];
DisplayExpression@Expr;
Expr=Expr/.MetricAffineTorsionContractionToPerturbed;
Expr//=ScreenDollarIndices;
DisplayExpression@Expr;

Comment@"Next the (standard) non-metricity contraction.";

DefTensor[MetricAffineNonMetricityContraction[-m],M4,PrintAs->"\[ScriptCapitalQ]"];
MetricAffineNonMetricityContractionToPerturbed=MakeRule[{MetricAffineNonMetricityContraction[-m],MetricAffineNonMetricity[-m,-l,l]},MetricOn->All,ContractMetrics->True];

Expr=MetricAffineNonMetricityContraction[-m];
DisplayExpression@Expr;
Expr=Expr/.MetricAffineNonMetricityContractionToPerturbed;
Expr//=ScreenDollarIndices;
DisplayExpression@Expr;

Comment@"Next the (tilde) non-metricity contraction.";

DefTensor[MetricAffineNonMetricityContractionTilde[-m],M4,PrintAs->"\!\(\*OverscriptBox[\(\[ScriptCapitalQ]\), \(~\)]\)"];
MetricAffineNonMetricityContractionTildeToPerturbed=MakeRule[{MetricAffineNonMetricityContractionTilde[-m],MetricAffineNonMetricity[-l,l,-m]},MetricOn->All,ContractMetrics->True];

Expr=MetricAffineNonMetricityContractionTilde[-m];
DisplayExpression@Expr;
Expr=Expr/.MetricAffineNonMetricityContractionTildeToPerturbed;
Expr//=ScreenDollarIndices;
DisplayExpression@Expr;

Comment@"Next the (conventional) Ricci tensor.";

DefTensor[MetricAffineRicciTensor[-m,-n],M4,PrintAs->"\[ScriptCapitalF]"];
MetricAffineRicciTensorToPerturbed=MakeRule[{MetricAffineRicciTensor[-m,-n],MetricAffineCurvature[-m,-n,-l,l]},MetricOn->All,ContractMetrics->True];

Expr=MetricAffineRicciTensor[-m,-n];
DisplayExpression@Expr;
Expr=Expr/.MetricAffineRicciTensorToPerturbed;
Expr//=ScreenDollarIndices;
DisplayExpression@Expr;

Comment@"Next the first of the pseudo-Ricci tensors.";

DefTensor[MetricAffineRicciTensor14[-m,-n],M4,PrintAs->"\!\(\*SuperscriptBox[\(\[ScriptCapitalF]\), \((14)\)]\)"];
MetricAffineRicciTensor14ToPerturbed=MakeRule[{MetricAffineRicciTensor14[-m,-n],MetricAffineCurvature[-l,-m,-n,l]},MetricOn->All,ContractMetrics->True];

Expr=MetricAffineRicciTensor14[-m,-n];
DisplayExpression@Expr;
Expr=Expr/.MetricAffineRicciTensor14ToPerturbed;
Expr//=ScreenDollarIndices;
DisplayExpression@Expr;

Comment@"Next the second of the pseudo-Ricci tensors.";

DefTensor[MetricAffineRicciTensor13[-m,-n],M4,PrintAs->"\!\(\*SuperscriptBox[\(\[ScriptCapitalF]\), \((13)\)]\)"];
MetricAffineRicciTensor13ToPerturbed=MakeRule[{MetricAffineRicciTensor13[-m,-n],MetricAffineCurvature[-l,-m,l,-n]},MetricOn->All,ContractMetrics->True];

Expr=MetricAffineRicciTensor13[-m,-n];
DisplayExpression@Expr;
Expr=Expr/.MetricAffineRicciTensor13ToPerturbed;
Expr//=ScreenDollarIndices;
DisplayExpression@Expr;

Comment@"Now we move on to computing the (conventional) Ricci scalar. This time we need to be careful to retain contributions up to second order in smallness, since this is the only invariant which appears on its own.";

DefTensor[MetricAffineRicciScalar[],M4,PrintAs->"\[ScriptCapitalF]"];
MetricAffineRicciScalarToPerturbed=MakeRule[{MetricAffineRicciScalar[],Scalar[MetricAffineCurvature[-m,-n,r,-s]*(G[m,-r])*(G[n,s]-MetricPerturbation[n,s])]},MetricOn->All,ContractMetrics->True];

Expr=MetricAffineRicciScalar[];
DisplayExpression@Expr;
Expr=Expr/.MetricAffineRicciScalarToPerturbed;
Expr//=ScreenDollarIndices;
DisplayExpression@Expr;


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


Subsection@"The general parity-preserving Lagrangian";

Comment@"Now all the generally-covariant contractions of the field strength tensors have been defined, so we construct the general, parity-preserving Lagrangian proposed in Equation (2.4) on page 5 of arXiv:1912.01023. This is just an exercise in data entry.";

NonlinearLagrangian=-(1/2)*(
	-A0*MetricAffineRicciScalar[]
	+MetricAffineCurvature[m,n,r,s]*(
		C1*MetricAffineCurvature[-m,-n,-r,-s]
		+C2*MetricAffineCurvature[-m,-n,-s,-r]
		+C3*MetricAffineCurvature[-r,-s,-m,-n]
		+C4*MetricAffineCurvature[-m,-r,-n,-s]
		+C5*MetricAffineCurvature[-m,-s,-n,-r]
		+C6*MetricAffineCurvature[-m,-s,-r,-n]
	)
	+MetricAffineRicciTensor13[m,n]*(
		C7*MetricAffineRicciTensor13[-m,-n]
		+C8*MetricAffineRicciTensor13[-n,-m]
	)
	+MetricAffineRicciTensor14[m,n]*(
		C9*MetricAffineRicciTensor14[-m,-n]
		+C10*MetricAffineRicciTensor14[-n,-m]
	)
	+MetricAffineRicciTensor14[m,n]*(
		C11*MetricAffineRicciTensor13[-m,-n]
		+C12*MetricAffineRicciTensor13[-n,-m]
	)
	+MetricAffineRicciTensor[m,n]*(
		C13*MetricAffineRicciTensor[-m,-n]
		+C14*MetricAffineRicciTensor13[-m,-n]
		+C15*MetricAffineRicciTensor14[-m,-n]
	)
	+C16*MetricAffineRicciScalar[]*MetricAffineRicciScalar[]
	+MetricAffineTorsion[m,r,n]*(
		A1*MetricAffineTorsion[-m,-r,-n]
		+A2*MetricAffineTorsion[-m,-n,-r]
	)
	+A3*MetricAffineTorsionContraction[m]*MetricAffineTorsionContraction[-m]
	+MetricAffineNonMetricity[r,m,n]*(
		A4*MetricAffineNonMetricity[-r,-m,-n]
		+A5*MetricAffineNonMetricity[-n,-m,-r]
	)
	+A6*MetricAffineNonMetricityContraction[-m]*MetricAffineNonMetricityContraction[m]
	+A7*MetricAffineNonMetricityContractionTilde[-m]*MetricAffineNonMetricityContractionTilde[m]
	+A8*MetricAffineNonMetricityContraction[-m]*MetricAffineNonMetricityContractionTilde[m]
	+A9*MetricAffineTorsion[m,r,n]*MetricAffineNonMetricity[-m,-r,-n]
	+MetricAffineTorsionContraction[m]*(
		A10*MetricAffineNonMetricityContraction[-m]
		+A11*MetricAffineNonMetricityContractionTilde[-m]
	)
);

DisplayExpression@NonlinearLagrangian;

Comment@"This general Lagrangian is something that we must linearize. First, we need the linearized measure, otherwise the Einstein--Hilbert term (which has first-order perturbed contributions) won't have the right linearization.";

Measure=1+(1/2)*MetricPerturbation[a,-a];
DisplayExpression@Measure;


Off[ValidateSymbol::used];
DefConstantSymbol[PerturbativeParameter,PrintAs->"\[Epsilon]"];
On[ValidateSymbol::used];

ToOrderConnection=MakeRule[{Connection[-a,-b,-c],PerturbativeParameter*Connection[-a,-b,-c]},MetricOn->All,ContractMetrics->True];
ToOrderMetricPerturbation=MakeRule[{MetricPerturbation[-a,-b],PerturbativeParameter*MetricPerturbation[-a,-b]},MetricOn->All,ContractMetrics->True];
ToOrder=Join[ToOrderConnection,ToOrderMetricPerturbation];

LineariseLagrangian[NonlinearLagrangian_]:=Module[{
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
DisplayExpression@LinearLagrangian;

Comment@"We see that there is not a great degree of degeneracy among the coupling constants, but bear in mind that we may only see such patterns when surface terms are used to extract the wave operator.";

Subsection@"Einstein-Hilbert theory";

Comment@"The first theory we will look at is the simple Einstein-Hilbert case.";
(*
EinsteinHilbertLagrangian=Measure*NonlinearLagrangian/.{A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0,C1->0,C2->0,C3->0,C4->0,C5->0,C6->0,C7->0,C8->0,C9->0,C10->0,C11->0,C12->0,C13->0,C14->0,C15->0,C16->0};
*)
(*
EinsteinHilbertLagrangian=Measure*NonlinearLagrangian/.{A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0};
*)
(*so far the in-vitro test for this works quite well*)
(*
EinsteinHilbertLagrangian=Measure*NonlinearLagrangian/.{A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0,C11->0,C12->0,C13->0,C14->0,C15->0,C16->0};
*)
(**)
EinsteinHilbertLagrangian=Measure*NonlinearLagrangian;
(**)
DisplayExpression@EinsteinHilbertLagrangian;

Comment@"Now we linearize it.";

LinearLagrangian=EinsteinHilbertLagrangian//LineariseLagrangian;
DisplayExpression@LinearLagrangian;

ACouplings={A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11};
CCouplings={C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,C15,C16};

ProbeNumbers=Table[0,{i,(Length@(CCouplings)+1)},{j,(Length@(ACouplings)+1)}];
Print@MatrixForm@ProbeNumbers;
TimingData=Table[0,{i,(Length@(CCouplings)+1)},{j,(Length@(ACouplings)+1)}];
Print@MatrixForm@TimingData;



(**)
(*SpecRules={A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0,C6->0,C8->0,C9->0,C10->0};*)
SpecRules={A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0};
(*SpecRules={A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0,C6->0,C8->0,C9->0,C10->0,C11->0,C12->0};*)

(*SpecRules={A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0,C1->0,C2->0,C3->0,C4->0,C5->0,C6->0,C7->0,C8->0,C9->0,C10->0,C11->0,C12->0,C13->0,C14->0,C15->0,C16->0};*)
NewLinearLagrangian=LinearLagrangian/.SpecRules;
ParticleSpectrum[NewLinearLagrangian,
		ClassName->"MetricAffineGaugeTheory",
		TheoryName->"JustHavingALook",	
		Method->"Careless",
		MaxLaurentDepth->1];
(**)

Throw@"stop here please.";

TimingData=Table[0,{i,(Length@(CCouplings)+1)}];
ACouplings={A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11};
ProbeNumber=1;
ProbeSpectrum[iii_]:=Module[{
		CaseRules,
		TimingDatum,
		NewLinearLagrangian,
		NewNonlinearLagrangian},
	CaseRules=(#->0)&/@(ACouplings~Join~Drop[CCouplings,(iii-1)]);
	ProbeNumber+=1;
	NewLinearLagrangian=LinearLagrangian/.CaseRules;
	NewNonlinearLagrangian=NonlinearLagrangian/.CaseRules;
	DisplayExpression@NewNonlinearLagrangian;
	TimingDatum=AbsoluteTiming@ParticleSpectrum[NewLinearLagrangian,
				ClassName->"MetricAffineGaugeTheory",
				TheoryName->"MetricAffine"<>ToString@ProbeNumber,
				Method->"Careless",
				MaxLaurentDepth->1];
	TimingData[[iii]]=TimingDatum;
	Print@TimingData;
];

Table[ProbeSpectrum[iii],{iii,8,50}];

Throw@"end of survey";

Table[Table[ProbeSpectrum[kkk,iii],{iii,kkk}],{kkk,2,50}];


ProbeNumber=1;
ProbeSpectrum[kkk_,iii_]:=Module[{CaseRules,TimingDatum,NewLinearLagrangian},
	If[iii<=(Length@(CCouplings)+1)&&(kkk-iii+1)<=(Length@(ACouplings)+1),
		CaseRules=(#->0)&/@(Drop[ACouplings,(kkk-iii+1-1)]~Join~Drop[CCouplings,(iii-1)]);
		ProbeNumbers[[iii,kkk-iii+1]]=ProbeNumber;
		ProbeNumber+=1;
		NewLinearLagrangian=LinearLagrangian/.CaseRules;
		DisplayExpression@NewLinearLagrangian;
		TimingDatum=AbsoluteTiming@ParticleSpectrum[NewLinearLagrangian,
					ClassName->"MetricAffineGaugeTheory",
					TheoryName->"MetricAffine",	
					Method->"Careless",
					MaxLaurentDepth->1];
		TimingData[[iii,kkk-iii+1]]=TimingDatum;
		Print@Row@{MatrixForm@ProbeNumbers,MatrixForm@TimingData};
	]
];

Table[Table[ProbeSpectrum[kkk,iii],{iii,kkk}],{kkk,2,50}];

Print@MatrixForm@ProbeNumbers;
Print@MatrixForm@TimingData;



Comment@"Now we feed the linearized Lagrangian into PSALTer. This is done with a single call to the ParticleSpectrum function where the linearized Lagrangian above is passed as the input, and it takes 10-15 minutes on my Dutch machine. As usual, the computation of the wave operator matrices and their inverses is basically instantaneous, and almost all of this time is spent in component-value calculations, computing pole residues in the limit of the lightcone.";

(*Throw@"Pause calculation please!";*)
(**)
ParticleSpectrum[
	"MetricAffineGaugeTheory",
	"EinsteinHilbertTheory",
	LinearLagrangian,
	TensorFields->{MetricPerturbation,Connection},
	CouplingConstants->{A0,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,C15,C16},
	ExportTheory->True
];
(**)

Comment@"This completes the spectral analysis. We find that there are no massive poles, and hence no massive gravitons. There are however two massless degrees of freedom which we take to be the graviton polarisations. The unitarity conditions of these polarisations just make sure that the Einstein--Hilbert coupling carries the right sign, i.e. that the square of the Planck mass is positive. As usual with the PSALTer output, the unitarity conditions also stipulate that the energy (p) of the graviton be a real number, i.e. that its square be positive. This trivial condition typically accompanies the (non-trivial) unitarity condition(s) on the Lagrangian parameters, and is quite natural.";

PartIIIProject@"What about the source constraints? Stephanie wanted an in-depth discussion of where these came from. These constraints can be decoded as a consequence of the diffeomorphism and projective gauge symmetries of the theory, though it takes a bit of manipulation to see this because in their current form they are expressed in terms of the `cryptic' reduced-index spin-parity modes.";

Get@FileNameJoin@{NotebookDirectory[],"EinsteinHilbertTheory.thr.mx"};

DecomposedSourceConstraints=EinsteinHilbertTheory@SourceConstraints;
DisplayEquation/@DecomposedSourceConstraints;

Comment@"Let's expand these in terms of the original source currents which are conjugate to the metric (Einstein stress-energy tensor) and the asymmetric connection (a nameless three-index source which is a combination of the matter spin tensor and the matter dilaton current), both contracted with the momentum in various places.";

DecomposedSourceConstraints=(MetricAffineGaugeTheory@xAct`PSALTer`Private`ExpandSources)/@DecomposedSourceConstraints;
DecomposedSourceConstraints=DecomposedSourceConstraints/.xAct`PSALTer`Private`ToP;
DecomposedSourceConstraints=(ToCanonical)/@DecomposedSourceConstraints;
DecomposedSourceConstraints=(ScreenDollarIndices)/@DecomposedSourceConstraints;
DisplayEquation/@DecomposedSourceConstraints;

Comment@"That is somewhat clearer. Now add the first and last pairs of constraints.";

ProjectiveSourceConstraints={
	DecomposedSourceConstraints[[1]]+3*DecomposedSourceConstraints[[2]],
	DecomposedSourceConstraints[[3]]+2*DecomposedSourceConstraints[[4]]
};
ProjectiveSourceConstraints=(ToCanonical)/@ProjectiveSourceConstraints;
ProjectiveSourceConstraints=(ScreenDollarIndices)/@ProjectiveSourceConstraints;
DisplayEquation/@ProjectiveSourceConstraints;

Comment@"This leads to a simple covariant expression in the rank-three source alone, which we notice immediately is generated by none other than the projective symmetry in Equation (2.16) on page 7 of arXiv:1912.01023.";

ProjectiveSourceConstraints=(1/(3*Def^2))*{ReplaceDummies@(ProjectiveSourceConstraints[[1]])*P[a]+Def*ProjectiveSourceConstraints[[2]]};

ProjectiveSourceConstraints=(ToCanonical)/@ProjectiveSourceConstraints;
ProjectiveSourceConstraints=(ScreenDollarIndices)/@ProjectiveSourceConstraints;
DisplayEquation/@ProjectiveSourceConstraints;

Comment@"This projective symmetry is to be expected, if we examine the parameter conditions in Equation (2.18) on page 7 of arXiv:1912.01023";

Comment@"Now we add the first and last pairs of constraints. Up to the projective symmetry above, this is a joint constraint on the connection source and the stress-energy tensor. It looks to be generated by precisely the diffeomorphism gauge symmetry Equation (2.14) on page 6 of arXiv:1912.01023, and in fact the constraint itself is written out for us in Equation (4.10) on page 14 of arXiv:1912.01023.";

ProjectiveSourceConstraints=(-1/3)*{
	ReplaceDummies@(DecomposedSourceConstraints[[1]])*P[a]+Def*DecomposedSourceConstraints[[4]]
};
ProjectiveSourceConstraints=(ToCanonical)/@ProjectiveSourceConstraints;
ProjectiveSourceConstraints=(ScreenDollarIndices)/@ProjectiveSourceConstraints;
DisplayEquation/@ProjectiveSourceConstraints;

Comment@"Note that the diffeomorphism gauge symmetry is always present in MAGT, so we don't need to carefully check parameter conditions.";

Comment@"Now, we've recovered these (expected) symmetries through their constraints on the conjugate source currents. It would be satisfying if we could go back and show that the linearized Lagrangian itself is symmetric under the relevant transformations.";

Comment@"First we will try the projective symmetry. Here are the infinitesimal transformations suggested by Equation (3.4) on page 8 of arXiv:1912.01023.";

DefTensor[DiffPhi[-a],M4,PrintAs->"\[Xi]"];
DefConstantSymbol[Pert,PrintAs->"\[Epsilon]"];

ToPerturb=Join[
	MakeRule[{MetricPerturbation[-a,-b],MetricPerturbation[-a,-b]+Pert*CD[-a]@DiffPhi[-b]+Pert*CD[-b]@DiffPhi[-a]},MetricOn->All,ContractMetrics->True],
	MakeRule[{Connection[-a,-b,-c],Connection[-a,-b,-c]+Pert*CD[-a]@CD[-c]@DiffPhi[-b]},MetricOn->All,ContractMetrics->True]
];

Expr={MetricPerturbation[-a,-b],Connection[-a,-b,-c]};
DisplayExpression@Expr;
Expr=Expr/.ToPerturb;
Expr=ToCanonical/@Expr;
DisplayExpression@Expr;

Comment@"Now let's see how the linearized Lagrangian transforms at first order.";

PertLagrangian=LinearLagrangian/.ToPerturb;
PertLagrangian=Coefficient[PertLagrangian,Pert,1];
DisplayExpression@PertLagrangian;

Comment@"This looks non-trivial, but if we take the variational derivative with respect to the vector field which generates the diffeomorphism, we see that the whole thing vanishes.";

PertLagrangian=VarD[DiffPhi[a],CD]@PertLagrangian;
PertLagrangian//=ToCanonical;
PertLagrangian//=SortCovDs;
PertLagrangian//=ContractMetric;
PertLagrangian//=CollectTensors;
PertLagrangian//=ScreenDollarIndices;
DisplayExpression@PertLagrangian;

Comment@"Now we would like to try the same thing with the projective symmetry. Again we set up the infinitesimal transformation, this time as suggested by Equation (2.16) on page 7 of arXiv:1912.01023.";

DefTensor[ProjPhi[-a],M4,PrintAs->"\[Lambda]"];

ToPerturb=MakeRule[{Connection[-m,r,-n],Connection[-m,r,-n]+Pert*ProjPhi[-m]*G[r,-n]},MetricOn->All,ContractMetrics->True];

Expr={MetricPerturbation[-a,-b],Connection[-a,-b,-c]};
DisplayExpression@Expr;
Expr=Expr/.ToPerturb;
Expr=ToCanonical/@Expr;
DisplayExpression@Expr;

Comment@"Now let's see how the linearized Lagrangian transforms at first order.";

LinearLagrangian=LinearLagrangian/.ToPerturb;
LinearLagrangian=Coefficient[LinearLagrangian,Pert,1];
DisplayExpression@LinearLagrangian;

Comment@"Again this looks non-trivial, but if we take the variational derivative with respect to the vector field which generates the projective transformation, we see that the whole thing vanishes.";

LinearLagrangian=VarD[ProjPhi[a],CD]@LinearLagrangian;
LinearLagrangian//=ToCanonical;
LinearLagrangian//=SortCovDs;
LinearLagrangian//=ContractMetric;
LinearLagrangian//=CollectTensors;
LinearLagrangian//=ScreenDollarIndices;
DisplayExpression@LinearLagrangian;

Comment@"These results are quite satisfying, and hopefully illustrate how easy it is to `probe' the Lagrangian for extra symmetries using computer algebra.";

Comment@"Let's pause the calculations here.";

Throw@"Pause calculation please!";
