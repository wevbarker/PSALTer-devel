(*====================*)
(*  CurvedFierzPauli  *)
(*====================*)

<<VimFormat`;

SetOptions[$FrontEndSession,EvaluationCompletionAction->"ScrollToOutput"];

Title@"Expanding Fierz-Pauli around de Sitter";

<<xAct`xTensor`;
<<xAct`xPert`;
<<xAct`xTras`;

Comment@"Define a manifold and curved metric.";

DefManifold[M4,4,IndexRange[{a,z}]];
DefMetric[-1,G[-a,-c],CD,{";","\[Del]"},PrintAs->"\[ScriptG]",WeightedWithBasis->AIndex];

StandardIndices=ToExpression/@Alphabet[];
StandardIndicesSymb=ToString@ToExpression@("\\[Gothic"<>ToUpperCase@ToString@#<>"]")&/@Alphabet[];
(PrintAs@Evaluate@#1^=Evaluate@#2)&~MapThread~{StandardIndices,StandardIndicesSymb};

Comment@"Define the Einstein constant.";

DefConstantSymbol[EinsteinConstant,PrintAs->"\[Kappa]"];

Comment@"Define a scale factor, (constant) Hubble number and a vector which will be unit-timelike in the flat spacetime to which de Sitter is conformal. Note that the unit-timelike vector will have downstairs valence, so that it naturally inherits the tensor character of derivative operators later on without the need for a metric.";

DefConstantSymbol[CosmologicalConstant,PrintAs->"\[CapitalLambda]"];
DefConstantSymbol[HubbleScale,PrintAs->"\[ScriptCapitalH]"];

Comment@"Define a tensor which acts as the linear metric.";

DefTensor[LinearMetric[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->"\[ScriptH]",Dagger->Complex];

Comment@"Define the trace-reversed metric.";

DefTensor[TraceReversedLinearMetric[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->"\!\(\*OverscriptBox[\(\[ScriptH]\),\(-\)]\)",Dagger->Complex];
DefTensor[TraceLinearMetric[],M4,PrintAs->"\[ScriptH]",Dagger->Complex];

LinearMetricToTraceReversedLinearMetric=MakeRule[{LinearMetric[-a,-b],TraceReversedLinearMetric[-a,-b]+(1/2)*TraceLinearMetric[]*G[-a,-b]},MetricOn->All,ContractMetrics->True];
AutomaticRules[TraceReversedLinearMetric,MakeRule[{TraceReversedLinearMetric[-a,a],-TraceLinearMetric[]},MetricOn->All,ContractMetrics->True]];


Expr=TraceReversedLinearMetric[-a,-b];
DisplayExpression@Expr;

MakeReadable[InputExpr_]:=Module[{Expr=InputExpr},	
	Expr//=RicciToEinstein;
	Expr//=ToCanonical;
	Expr//=ContractMetric;
	Expr//=ScreenDollarIndices;
	Expr=Expr/.LinearMetricToTraceReversedLinearMetric;
	Expr//=ToCanonical;
	Expr//=ContractMetric;
	Expr//=ScreenDollarIndices;
	Expr//=ToCanonical;
	Expr//=ContractMetric;
	Expr//=ScreenDollarIndices;
	Expr//=Simplify;
Expr];

Comment@"Define the Einstein-Hilbert action.";

Subsection@"Background terms";

Comment@"First term, the Hilbert term.";
Fields0=Sqrt[-DetG[]]((-1/2)*RicciScalarCD[])/EinsteinConstant;
DisplayExpression@MakeReadable@Fields0;

Comment@"Second term, the source.";
Source0=Sqrt[-DetG[]](-CosmologicalConstant)/EinsteinConstant;
DisplayExpression@MakeReadable@Source0;

Subsection@"First order terms";

Fields1=VarD[G[-a,-b],CD][Fields0]*LinearMetric[-a,-b];
Fields1//=ToCanonical;
Fields1//=ContractMetric;
Fields1//=ScreenDollarIndices;
Fields1//=Simplify;
DisplayExpression@MakeReadable@Fields1;

Source1=VarD[G[-a,-b],CD][Source0]*LinearMetric[-a,-b];
Source1//=ToCanonical;
Source1//=ContractMetric;
Source1//=ScreenDollarIndices;
Source1//=Simplify;
DisplayExpression@MakeReadable@Source1;

Subsection@"Second order terms";

Fields2=VarD[G[-a,-b],CD][Fields1]*LinearMetric[-a,-b];
Fields2//=ToCanonical;
Fields2//=ContractMetric;
Fields2//=ScreenDollarIndices;
DisplayExpression@MakeReadable@Fields2;

Source2=VarD[G[-a,-b],CD][Source1]*LinearMetric[-a,-b];
Source2//=ToCanonical;
Source2//=ContractMetric;
Source2//=ScreenDollarIndices;
Source2//=Simplify;
DisplayExpression@MakeReadable@Source2;

Comment@"Now define a generating vector for diffeomorphisms of the background.";
DefTensor[Gen[a],M4,PrintAs->"\[ScriptCapitalV]"];
Expr=Gen[a];
DisplayExpression@Expr;

Variation1=CD[-a]@Gen[-b]+CD[-b]@Gen[-a];
DisplayExpression@Variation1;

Variation2=Gen[c]*CD[-c]@LinearMetric[-a,-b]+LinearMetric[c,-b]*CD[-a]@Gen[-c]+LinearMetric[c,-a]*CD[-b]@Gen[-c];
DisplayExpression@Variation2;

ExtractGeneratingVector[InputExpr_,Perturbation_]:=Module[{Expr=InputExpr},
	Expr=VarD[LinearMetric[-a,-b],CD][Expr]*Perturbation;
	Expr//=ToCanonical;
	Expr//=ContractMetric;
	Expr//=ScreenDollarIndices;
	Expr=VarD[Gen[a],CD][Expr]*Gen[a];
	Expr//=ToCanonical;
	Expr//=ContractMetric;
	Expr//=ScreenDollarIndices;
	Expr//=SortCovDs;
	Expr//=ToCanonical;
	Expr//=ContractMetric;
	Expr//=ScreenDollarIndices;
	Expr=Expr/.CurvatureRelationsBianchi[CD];
	Expr//=ToCanonical;
	Expr//=ContractMetric;
	Expr//=ScreenDollarIndices;
	DisplayExpression@MakeReadable@Expr;	
MakeReadable@Expr];

Subsection@"First order terms";

ExtractGeneratingVector[Fields1,Variation1];
ExtractGeneratingVector[Fields1,Variation2];

ExtractGeneratingVector[Source1,Variation1];
ExtractGeneratingVector[Source1,Variation2];

Subsection@"Second order terms";

ToShell=MakeRule[{EinsteinCD[-a,-b],CosmologicalConstant*G[-a,-b]},MetricOn->All,ContractMetrics->True];
DisplayExpression@MakeReadable@ToShell;

Expr=ExtractGeneratingVector[Fields2,Variation1];
Expr=Expr/.ToShell;
DisplayExpression@MakeReadable@Expr;

Expr=ExtractGeneratingVector[Source2,Variation1];
Expr=Expr/.ToShell;
DisplayExpression@MakeReadable@Expr;

Comment@"So we see that there is cancellation across orders due to Bianchi and also within each order due to the shell.";

Subsection@"Weyl transformation";

Comment@"Define the scale factor, Hubble number (constant), and unit timelike vector.";
DefTensor[ScaleFactor[],M4,PrintAs->"\[ScriptA]"];
DefConstantSymbol[HubbleNumber,PrintAs->"H"];
VSymb="\[ScriptN]";
DefTensor[V[-a],M4,PrintAs->VSymb];
AutomaticRules[V,MakeRule[{V[-a]V[a],1}]];
AutomaticRules[V,MakeRule[{CD[-a]@V[b],0},MetricOn->All,ContractMetrics->True]];
AutomaticRules[ScaleFactor,MakeRule[{CD[-a]@ScaleFactor[],HubbleNumber*ScaleFactor[]^2*V[-a]},MetricOn->All,ContractMetrics->True]];

DisplayExpression/@{ScaleFactor[],HubbleNumber,V[a]};

Comment@"Define some rules which convert the curved metric to the flat metric.";

RescaleH=MakeRule[{LinearMetric[c,d],LinearMetric[c,d]*ScaleFactor[]},MetricOn->All,ContractMetrics->True];
GToG=MakeRule[{G[-c,-d],G[-c,-d]*ScaleFactor[]^2},MetricOn->None,ContractMetrics->False];
GInvToGInv=MakeRule[{G[c,d],G[c,d]/ScaleFactor[]^2},MetricOn->None,ContractMetrics->False];

ToWeyl[InputExpr_]:=Module[{Expr=InputExpr},

	Expr//=RiemannToChristoffel;
	Expr=ChangeCovD[Expr,CD,PD];
	Expr//=ToCanonical;
	Expr//=ScreenDollarIndices;
	Expr//=ChristoffelToMetric;
	Expr//=ScreenDollarIndices;
	Expr//=SeparateMetric[];
	Expr//=ScreenDollarIndices;
	(*DisplayExpression@Expr;*)

	Expr//=NoScalar;
	Expr=Expr/.GToG;
	Expr//=NoScalar;
	Expr=Expr/.GInvToGInv;
	Expr//=NoScalar;
	Expr=Expr/.{PD->CD,Sqrt[-DetG[]]->ScaleFactor[]^4};
	Expr//=NoScalar;
	(*Expr=Expr/.BackgroundStressEnergy;*)
	Expr//=ToCanonical;
	Expr//=ContractMetric;
	Expr//=ScreenDollarIndices;

	(*Expr=Expr/.ToKinetic;*)
	Expr//=ToCanonical;
	Expr//=ContractMetric;
	Expr//=ScreenDollarIndices;

	Expr=Expr/.RescaleH;
(*	Expr=Expr/.RescaleStressEnergy;*)
	Expr//=ToCanonical;
	Expr//=ContractMetric;
	Expr//=ScreenDollarIndices;
Expr];

Comment@"Let's check that the Weyl-transformed first-order operator is satisfying the background field equations.";

Expr=Fields1+Source1;
DisplayExpression@Expr;
Expr//=ToWeyl;
Expr//=CollectTensors;
DisplayEquation@Expr;

Comment@"So, this is looking pretty good. The cosmological constant should be three times the square of the Hubble number.";

Comment@"Just as a reminder, here is what we believe to be the total wave operator when expressed in terms of the perturbed field and the curvature (i.e. not trace-reverse or Einstein tensor).";

Expr=Fields2+Source2;
DisplayExpression@Expr;

Comment@"Now we will try to look at the Weyl-transformed version.";

Expr//=ToWeyl;
Expr//=CollectTensors;
DisplayEquation@Expr;
WaveOperator=Expr;

Comment@"We can see that the power of the scale factor in the transformation is appropriate, since we will recover the (unscaled) Fierz-Pauli operator among the second-order terms.";

Comment@"Now we look at the part of the variation that we keep in the second-order operator, recalling that this will now be the variation of the rescaled perturbation (hence we need to divide by the scale factor).";

Expr=Variation1/ScaleFactor[];
DisplayExpression@Expr;
Expr//=ToWeyl;
Expr//=CollectTensors;
DisplayExpression@Expr;
FlatVariation1=Expr;

Comment@"Now we wish to impose this variation on the wave operator.";

ExtractFlatGeneratingVector[InputExpr_,Perturbation_]:=Module[{Expr=InputExpr},
	Expr=VarD[LinearMetric[-a,-b],CD][Expr]*Perturbation;
	Expr//=ToCanonical;
	Expr//=ContractMetric;
	Expr//=ScreenDollarIndices;
	Expr=VarD[Gen[a],CD][Expr]*Gen[a];
	Expr//=ToCanonical;
	Expr//=ContractMetric;
	Expr//=ScreenDollarIndices;
	Expr//=SortCovDs;
	Expr//=ToCanonical;
	Expr//=ContractMetric;
	Expr//=ScreenDollarIndices;
	Expr=Expr/.{RiemannCD->Zero,RicciCD->Zero,RicciScalarCD->Zero};
	Expr//=ToCanonical;
	Expr//=ContractMetric;
	Expr//=ScreenDollarIndices;
	Expr//=CollectTensors;
	DisplayExpression@Expr;	
Expr];

ExtractFlatGeneratingVector[WaveOperator,FlatVariation1];

Comment@"Okay, brilliant!";

Comment@"Can we check that this does not work if we simply use the unit timelike vector to emulate the derivative?";

DefConstantSymbol[Nn]

Expr=Variation1/ScaleFactor[]^Nn;
DisplayExpression@Expr;
Expr//=ToWeyl;
Expr//=CollectTensors;
DisplayExpression@Expr;
FlatVariation2=Expr;

ExtractFlatGeneratingVector[WaveOperator,FlatVariation2];

Comment@"Here is the version of the Lagrangian which we will export to be used by PSALTer in the calibration script.";

ExportLagrangian=WaveOperator/.{CosmologicalConstant->3*HubbleNumber^2,ScaleFactor[]->HubbleScale/HubbleNumber};
ExportLagrangian=WaveOperator/.{CosmologicalConstant->3*HubbleNumber^2,ScaleFactor[]->HubbleScale/HubbleNumber};
ExportLagrangian//=ToCanonical;
ExportLagrangian//=ScreenDollarIndices;
ExportLagrangian//=CollectTensors;
DisplayExpression@ExportLagrangian;

ExportLagrangian//=InputForm;
ExportLagrangian//=ToString;

ExportLagrangian=ToString@ExportLagrangian;
DisplayExpression@ExportLagrangian;

DumpSave[FileNameJoin@{NotebookDirectory[],"CurvedFierzPauli.mx"},{ExportLagrangian}];

Quit[];

Comment@"Define the perturbation to the metric.";

DefMetricPerturbation[G, H, \[Epsilon],Dagger->Complex];
PrintAs@H^="\[ScriptH]";

Comment@"Color the indices of the perturbed fields.";

Unprotect[IndexForm]; 
IndexForm[LI[x_]] := ColorString[ToString[x], RGBColor[0, 0, 1]]; 
Protect[IndexForm];

Comment@"Perturbation of the metric.";

Expr=G[-a,-b]~Perturbation~1;
DisplayExpression@Expr;

Comment@"Perturbation of the inverse metric.";

Expr=G[a,b]~Perturbation~2;
Expr//=ExpandPerturbation;
Expr//=ScreenDollarIndices;
DisplayExpression@Expr;

Comment@"Define the stress-energy tensor, and make sure that it has (downstairs) valence such that it is the correct tensor given by variations with respect to the inverse metric.";

DefTensor[NonlinearStressEnergy[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->"\[ScriptCapitalT]"];
DefTensorPerturbation[NonlinearStressEnergyPert[LI[order],-a,-b],NonlinearStressEnergy[-a,-b],M4,Symmetric[{-a,-b}],WeightOfTensor->AIndex];
PrintAs@NonlinearStressEnergyPert^="\[ScriptCapitalT]";

Expr=NonlinearStressEnergy[a,b];
DisplayExpression@Expr;
Expr=Expr~Perturbation~2;
DisplayExpression@Expr;
Expr//=ExpandPerturbation;
Expr//=ToCanonical;
Expr//=ScreenDollarIndices;
DisplayExpression@Expr;

Comment@"Make a rule which switches off the background stress-energy tensor.";

BackgroundStressEnergy=Join[
	MakeRule[{NonlinearStressEnergyPert[LI[2],-a,-b],0},MetricOn->All,ContractMetrics->True],
	MakeRule[{NonlinearStressEnergy[-a,-b],0},MetricOn->All,ContractMetrics->True]
];

Comment@"Define the full nonlinear free theory. The cosmological constant is included, and expressed in terms of the constant Hubble number.";

NonlinearLagrangian=Sqrt[-DetG[]]((-1/2)*RicciScalarCD[]-3*HubbleNumber^2)/EinsteinConstant;
NonlinearLagrangian//=ToCanonical;
DisplayExpression@NonlinearLagrangian;

ToKinetic=MakeRule[{H[LI[1],-a,-b]CD[-c]@CD[-d]@H[LI[1],-e,-f],-CD[-c]@H[LI[1],-a,-b]CD[-d]@H[LI[1],-e,-f]},MetricOn->All,ContractMetrics->True];
FromKinetic=MakeRule[{CD[-c]@H[LI[1],-a,-b]CD[-d]@H[LI[1],-e,-f],-H[LI[1],-a,-b]CD[-c]@CD[-d]@H[LI[1],-e,-f]},MetricOn->All,ContractMetrics->True];
RescaleStressEnergy=MakeRule[{NonlinearStressEnergyPert[LI[1],c,d],NonlinearStressEnergyPert[LI[1],c,d]/ScaleFactor[]},MetricOn->All,ContractMetrics->True];

ToLinear[InputExpr_,Order_]:=Module[{Expr=InputExpr},

	Expr=(Expr~Perturbation~Order);
	Expr//=ExpandPerturbation;
	Expr=Expr/.{H[LI[2],Inds___]->0};
	Expr//=ToCanonical;
	Expr//=ScreenDollarIndices;
	Expr//=RiemannToChristoffel;
	Expr=ChangeCovD[Expr,CD,PD];
	Expr//=ToCanonical;
	Expr//=ScreenDollarIndices;
	Expr//=ChristoffelToMetric;
	Expr//=ScreenDollarIndices;
	Expr//=SeparateMetric[];
	Expr//=ScreenDollarIndices;
	(*DisplayExpression@Expr;*)

	Expr//=NoScalar;
	Expr=Expr/.GToG;
	Expr//=NoScalar;
	Expr=Expr/.GInvToGInv;
	Expr//=NoScalar;
	Expr=Expr/.{PD->CD,Sqrt[-DetG[]]->ScaleFactor[]^4};
	Expr//=NoScalar;
	Expr=Expr/.BackgroundStressEnergy;
	Expr//=ToCanonical;
	Expr//=ContractMetric;
	Expr//=ScreenDollarIndices;

	Expr=Expr/.ToKinetic;
	Expr//=ToCanonical;
	Expr//=ContractMetric;
	Expr//=ScreenDollarIndices;

	Expr=Expr/.RescaleH;
(*	Expr=Expr/.RescaleStressEnergy;*)
	Expr//=ToCanonical;
	Expr//=ContractMetric;
	Expr//=ScreenDollarIndices;

Expr];

Comment@"Here is the linear part of the free Lagrangian, and you can see that it is a pure surface term. This suggests that the cosmological constant was added in correctly.";

LinearLagrangian=ToLinear[NonlinearLagrangian,1];
DisplayExpression@LinearLagrangian;

Comment@"Here is the quadratic part of the free Lagrangian, expressed with first derivatives. We can read off the Fierz-Pauli part, which is also reassuring. The rest will smoothly vanish with the Hubble number. Note that we chose the Weyl rescaling of the perturbation to give no extra factors of the scale factor in the kinetic term. All these factors combine with the Hubble number to make powers of the reciprocal comoving horizon, which is as expected.";

QuadraticLagrangian=ToLinear[NonlinearLagrangian,2];
DisplayExpression@QuadraticLagrangian;

Comment@"Here is the linear part of the nonlinear conservation law of the stress-energy tensor. Of course, it has now a correction in the Hubble number.";

LinearConservation=ToLinear[V[b]*CD[a]@(NonlinearStressEnergy[-a,-b]/ScaleFactor[]),1];
DisplayExpression@LinearConservation;

Comment@"We define the positive norm of the four-momentum, and make a rule to convert the action of the derivative.";


DefConstantSymbol[Def,PrintAs->"\[ScriptK]"];
ToFourier=Join[
MakeRule[{CD[-c]@LinearMetric[-d,-e],-I*Def*V[-c]*LinearMetric[-d,-e]},MetricOn->All,ContractMetrics->True],
MakeRule[{H[LI[1],-a,-b]*CD[-c]@H[LI[1],-d,-e],-I*Def*V[-c]*Dagger@LinearMetric[-a,-b]*LinearMetric[-d,-e]},MetricOn->All,ContractMetrics->True],
MakeRule[{H[LI[1],-a,-b]*CD[-f]@CD[-c]@H[LI[1],-d,-e],-Def^2*V[-c]*V[-f]*Dagger@LinearMetric[-a,-b]*LinearMetric[-d,-e]},MetricOn->All,ContractMetrics->True],
MakeRule[{H[LI[1],-a,-b]*H[LI[1],-d,-e],Dagger@LinearMetric[-a,-b]*LinearMetric[-d,-e]},MetricOn->All,ContractMetrics->True]
];
DisplayExpression@ToFourier;

Comment@"Now we move the linear part of the conservation law into Fourier space.";

LinearConservation=LinearConservation/.ToFourier;
LinearConservation//=ToCanonical;
LinearConservation//=ScreenDollarIndices;
LinearConservation=LinearConservation/.ToFourier;
LinearConservation//=ToCanonical;
LinearConservation//=ScreenDollarIndices;
DisplayExpression@LinearConservation;

Comment@"Now we take the quadratic Lagrangian and we use some surface terms.";

QuadraticLagrangian=QuadraticLagrangian/.FromKinetic;
QuadraticLagrangian//=ToCanonical;
QuadraticLagrangian//=ScreenDollarIndices;
DisplayExpression@QuadraticLagrangian;

Comment@"Here is the version of the Lagrangian which we will export to be used by PSALTer in the calibration script.";

ExportLagrangian=QuadraticLagrangian/.{ScaleFactor[]->HubbleScale/HubbleNumber,H[LI[1],Inds__]->LinearMetric[Inds]};
ExportLagrangian//=ToCanonical;
ExportLagrangian//=ScreenDollarIndices;
DisplayExpression@ExportLagrangian;

Comment@"Next we construct a rule to shift the perturbed field in the direction of a gauge transformation.";

DefTensor[GaugeShift[-a,-b],M4,Symmetric[{-a,-b}],PrintAs->"\[Delta]\[ScriptH]",Dagger->Complex];
DisplayExpression@GaugeShift[-a,b];
DefConstantSymbol[PerturbativeParam,PrintAs->"\[Epsilon]"];

GaugeShiftRule=MakeRule[{H[LI[1],-a,-b],LinearMetric[-a,-b]+PerturbativeParam*GaugeShift[-a,-b]},MetricOn->All,ContractMetrics->True];
DisplayExpression@GaugeShift;

Comment@"Now we impose this shift, and keep only first-order transformed quantities.";

QuadraticLagrangian=QuadraticLagrangian/.GaugeShiftRule;
QuadraticLagrangian=Coefficient[QuadraticLagrangian,PerturbativeParam,1];
QuadraticLagrangian//=ToCanonical;
QuadraticLagrangian//=ScreenDollarIndices;
DisplayExpression@QuadraticLagrangian;

Comment@"Now impose some additional rules to get rid of the surface terms acting on the gauge-shifted field.";

GaugeRight=Join[
	MakeRule[{LinearMetric[-a,-b]*CD[-c]@CD[-d]@GaugeShift[-e,-f],CD[-c]@CD[-d]@LinearMetric[-a,-b]*GaugeShift[-e,-f]},MetricOn->All,ContractMetrics->True],
	MakeRule[{ScaleFactor[]*LinearMetric[-a,-b]*CD[-d]@GaugeShift[-e,-f],-CD[-d]@(ScaleFactor[]*LinearMetric[-a,-b])*GaugeShift[-e,-f]},MetricOn->All,ContractMetrics->True]
];

QuadraticLagrangian=QuadraticLagrangian/.GaugeRight;
QuadraticLagrangian//=ToCanonical;
QuadraticLagrangian//=ScreenDollarIndices;
DisplayExpression@QuadraticLagrangian;

Comment@"Now we consider a vector field which lies in the time direction as being the generator of a diffeomorphism. We believe that the change in the metric will be given by the Lie derivative.";

DefTensor[Phi[],M4,PrintAs->"\[Phi]"];
DefTensorPerturbation[PhiPert[LI[order]],Phi[],M4,WeightOfTensor->AIndex];
PrintAs@PhiPert^="\[Phi]";

DefConstantSymbol[Mn];
MetricShift=ToLinear[G[-b,-c]*CD[-a]@(ScaleFactor[]^Mn*Phi[]V[b])+G[-b,-a]*CD[-c]@(ScaleFactor[]^Mn*Phi[]V[b]),1];
DefConstantSymbol[Pn];
DefConstantSymbol[Qn];
DefConstantSymbol[Jn];
	MetricShift=(MetricShift+Pn*HubbleNumber*ScaleFactor[]^(Mn+1)*Phi[]*G[-a,-c]+Qn*HubbleNumber*ScaleFactor[]^(Mn+1)*Phi[]*V[-a]*V[-c])/.{Perturbation->Zero,PhiPert[LI[1]]->Phi[]};
	(*MetricShift=(MetricShift)/.{Perturbation->Zero,PhiPert[LI[1]]->Phi[]};*)
DisplayExpression@MetricShift;

Comment@"Now make a rule to switch out that perturbation.";

DefConstantSymbol[Nn];
ForShift=MakeRule[{GaugeShift[-a,-c],(1/ScaleFactor[]^Nn)*Evaluate@MetricShift},MetricOn->All,ContractMetrics->True];

Comment@"Now we substitute for our field";

(*
QuadraticLagrangian=(
	V[-a]*CD[-b]@((1/ScaleFactor[]^Nn)*VarD[GaugeShift[-a,-b],CD][QuadraticLagrangian])
	+V[-b]*CD[-a]@((1/ScaleFactor[]^Nn)*VarD[GaugeShift[-a,-b],CD][QuadraticLagrangian])
);
*)

QuadraticLagrangian=QuadraticLagrangian/.ForShift;
QuadraticLagrangian//=ToCanonical;
QuadraticLagrangian//=ScreenDollarIndices;
DisplayExpression@QuadraticLagrangian;

Comment@"Now we pull out the field itself.";

QuadraticLagrangian=VarD[Phi[],CD][QuadraticLagrangian];
QuadraticLagrangian//=ToCanonical;
QuadraticLagrangian//=ScreenDollarIndices;
DisplayExpression@QuadraticLagrangian;

Comment@"Now we can transition to Fourier space.";

QuadraticLagrangian=QuadraticLagrangian/.ToFourier;
QuadraticLagrangian//=ToCanonical;
QuadraticLagrangian//=ScreenDollarIndices;
QuadraticLagrangian=QuadraticLagrangian/.ToFourier;
QuadraticLagrangian//=ToCanonical;
QuadraticLagrangian//=ScreenDollarIndices;
QuadraticLagrangian=QuadraticLagrangian/.ToFourier;
QuadraticLagrangian//=ToCanonical;
QuadraticLagrangian//=ScreenDollarIndices;
QuadraticLagrangian=QuadraticLagrangian/.ToFourier;
QuadraticLagrangian//=ToCanonical;
QuadraticLagrangian//=ScreenDollarIndices;
QuadraticLagrangian=QuadraticLagrangian/.{ScaleFactor[]->HubbleScale/HubbleNumber};
QuadraticLagrangian//=ToCanonical;
QuadraticLagrangian//=CollectTensors;
QuadraticLagrangian//=ScreenDollarIndices;
DisplayExpression@QuadraticLagrangian;

Comment@"Make this agree with the expression which follows.";

QuadraticLagrangian=QuadraticLagrangian/.{Mn->Nn+1,Pn->0};
QuadraticLagrangian//=ToCanonical;
QuadraticLagrangian//=CollectTensors;
QuadraticLagrangian//=ScreenDollarIndices;
DisplayExpression@QuadraticLagrangian;

Comment@"Now we'd like to check that the lowest order contribution doesn't cause any damage.";

DisplayExpression@LinearLagrangian;

QuadraticLagrangian=LinearLagrangian/.{ScaleFactor[]->(ScaleFactor[]+PerturbativeParam*HubbleNumber*ScaleFactor[]^(1+1)*Phi[])};
QuadraticLagrangian=Coefficient[QuadraticLagrangian,PerturbativeParam,1];
QuadraticLagrangian//=ToCanonical;
QuadraticLagrangian//=ScreenDollarIndices;
QuadraticLagrangian=QuadraticLagrangian/.{H[LI[1],Inds__]->LinearMetric[Inds]};
QuadraticLagrangian//=ToCanonical;
QuadraticLagrangian//=ScreenDollarIndices;
DisplayExpression@QuadraticLagrangian;

QuadraticLagrangian=QuadraticLagrangian/.ToFourier;
QuadraticLagrangian//=ToCanonical;
QuadraticLagrangian//=ScreenDollarIndices;
QuadraticLagrangian=QuadraticLagrangian/.ToFourier;
QuadraticLagrangian//=ToCanonical;
QuadraticLagrangian//=ScreenDollarIndices;
QuadraticLagrangian=QuadraticLagrangian/.ToFourier;
QuadraticLagrangian//=ToCanonical;
QuadraticLagrangian//=ScreenDollarIndices;
QuadraticLagrangian=QuadraticLagrangian/.ToFourier;
QuadraticLagrangian//=ToCanonical;
QuadraticLagrangian//=ScreenDollarIndices;
QuadraticLagrangian=QuadraticLagrangian/.{ScaleFactor[]->HubbleScale/HubbleNumber};
QuadraticLagrangian//=ToCanonical;
QuadraticLagrangian//=CollectTensors;
QuadraticLagrangian//=ScreenDollarIndices;
DisplayExpression@QuadraticLagrangian;

Quit[];

DisplayExpression@QuadraticLagrangian;
(*
Comment@"Now we try an ansatz for the gauge transformation."; 

DefConstantSymbol[Alp1,PrintAs->"\[Alpha]1"];
DefConstantSymbol[Alp2,PrintAs->"\[Alpha]2"];
DefConstantSymbol[Alp3,PrintAs->"\[Alpha]3"];
DefConstantSymbol[Alp4,PrintAs->"\[Alpha]4"];

LeftNull=MakeRule[{Evaluate[GaugeShift[-a,-b]],Evaluate[
	Alp1*G[-a,-b]+Alp2*V[-a]*V[-b]
	]},MetricOn->All,ContractMetrics->True];
DisplayExpression@LeftNull;

Comment@"And now we attempt the ansatz itself.";

QuadraticLagrangian=QuadraticLagrangian/.LeftNull;
*)
QuadraticLagrangian//=ToCanonical;
QuadraticLagrangian//=ScreenDollarIndices;
QuadraticLagrangian//=CollectTensors;
DisplayExpression@QuadraticLagrangian;

Quit[];

Comment@"We then move over into Fourier space as we did with the conservation law.";

QuadraticLagrangian=QuadraticLagrangian/.ToFourier;
QuadraticLagrangian//=ToCanonical;
QuadraticLagrangian//=ScreenDollarIndices;
QuadraticLagrangian=QuadraticLagrangian/.ToFourier;
QuadraticLagrangian//=ToCanonical;
QuadraticLagrangian//=ScreenDollarIndices;
DisplayExpression@QuadraticLagrangian;

Comment@"Now we need a transformation law which displaces the conjugate perturbation by some factor of the left null eigenvector.";

DefConstantSymbol[Alp1,PrintAs->"\[Alpha]1"];
DefConstantSymbol[Alp2,PrintAs->"\[Alpha]2"];
DefConstantSymbol[Alp3,PrintAs->"\[Alpha]3"];
DefConstantSymbol[Alp4,PrintAs->"\[Alpha]4"];

LeftNull=MakeRule[{Evaluate[Dagger@LinearMetric[-a,-b]],Evaluate[
	Alp1*G[-a,-b]+Alp2*V[-a]*V[-b]
	]},MetricOn->All,ContractMetrics->True];
DisplayExpression@LeftNull;

QuadraticLagrangian=QuadraticLagrangian/.LeftNull;
QuadraticLagrangian=QuadraticLagrangian/.{ScaleFactor[]->1};
QuadraticLagrangian//=ToCanonical;
QuadraticLagrangian//=ContractMetric;
QuadraticLagrangian//=CollectTensors;
QuadraticLagrangian//=ScreenDollarIndices;
DisplayExpression@QuadraticLagrangian;

Throw@"Hold my mead";


Quit[];
Throw@"hold my wine";
