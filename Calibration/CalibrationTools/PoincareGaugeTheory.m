(*=======================*)
(*  PoincareGaugeTheory  *)
(*=======================*)

Title@"Poincaré gauge theory (PGT)";

Supercomment@"We will test the PoincareGaugeTheory module.";

Comment@"Here is the inverse translational gauge field, or tetrad.";
DefTensor[H[-a,c],M4,PrintAs->"\[ScriptH]"];
DisplayExpression[H[-a,c]];
Comment@"Here is the translational gauge field, or inverse tetrad.";
DefTensor[BField[a,-c],M4,PrintAs->"\[ScriptB]"];
DisplayExpression[BField[a,-c]];
HBFieldToGF=Join[
	MakeRule[{H[-i,-j],G[-i,-j]+F[-i,-j]},MetricOn->All,ContractMetrics->True],
	MakeRule[{BField[-i,-j],G[-i,-j]-F[-j,-i]+F[-i,-m]F[m,-j]},MetricOn->All,ContractMetrics->True]
];
AutomaticRules[H,MakeRule[{H[-a,i]BField[a,-j],G[i,-j]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[H,MakeRule[{H[-a,i]BField[c,-i],G[-a,c]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[H,MakeRule[{CD[-a][H[-j,n]],Evaluate[-H[-i,n]H[-j,m]CD[-a][BField[i,-m]]]},MetricOn->All,ContractMetrics->True]];

DefTensor[R[a, b, -d, -e], M4, {Antisymmetric[{a, b}], Antisymmetric[{-d, -e}]},PrintAs->"\[ScriptCapitalR]"]; 
DefTensor[T[a, -b, -c], M4, Antisymmetric[{-b, -c}],PrintAs->"\[ScriptCapitalT]"]; 
RTToHBFieldACDBFieldCDA=Join[	
	MakeRule[{R[a,b,-d,-e],H[-d,i]H[-e,j](CD[-i][A[a,b,-j]]-CD[-j][A[a,b,-i]]+A[a,-k,-i]A[k,b,-j]-A[a,-k,-j]A[k,b,-i])},MetricOn->All,ContractMetrics->True],
	MakeRule[{T[a,-b,-c],H[-b,i]H[-c,j](CD[-i][BField[a,-j]]-CD[-j][BField[a,-i]]+A[a,-k,-i]BField[k,-j]-A[a,-k,-j]BField[k,-i])},MetricOn->All,ContractMetrics->True]
];

Comment@"Here is the Riemann-Cartan tensor.";
Expr=R[a, b, -d, -e];
DisplayExpression[Expr];
Expr=Expr/.RTToHBFieldACDBFieldCDA;
Expr//=ToCanonical;
Expr//=ScreenDollarIndices;
DisplayExpression[Expr];

Comment@"Here is the torsion tensor.";
Expr=T[a, -b, -c];
DisplayExpression[Expr];
Expr=Expr/.RTToHBFieldACDBFieldCDA;
Expr//=ToCanonical;
Expr//=ScreenDollarIndices;
DisplayExpression[Expr];

Comment@"Now we set up the general Lagrangian. In the first instance we will do this with some coupling constants which are proportional to those used by Hayashi and Shirafuji in Prog. Theor. Phys. 64 (1980) 2222. The normalisations are not absolutely identical, but this should not be a problem.";

Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","PoincareGaugeTheory","LagrangianHayashiShirafujiCouplings.m"};

Comment@"We can also use a different set of coupling coefficients, as developed by Karananas.";

Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","PoincareGaugeTheory","LagrangianKarananasCouplings.m"};
DisplayExpression@NonlinearLagrangian;

Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","PoincareGaugeTheory","Linearise.m"};
Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","PoincareGaugeTheory","CriticalCases.m"};
Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","PoincareGaugeTheory","Unitarity.m"};

(*==========================*)
(*  Einstein-Cartan theory  *)
(*==========================*)
(*
Section@"Most general PGT";

Comment@{"We first want to study the most general PGT. We will do this using the general coupling coefficients defined in",Cref@"CleanHayashiShirafuji","."};

DisplayExpression@CollectTensors@ToCanonical[HSNonlinearLagrangian];

LinearisedLagrangian=LineariseLagrangian[HSNonlinearLagrangian];

ParticleSpectrum[
	"PoincareGaugeTheory",
	"GeneralPGT",
	LinearisedLagrangian,
	TensorFields->{F,A},
	CouplingConstants->{Alp0,Alp1,Alp2,Alp3,Alp4,Alp5,Alp6,Bet1,Bet2,Bet3},
	ExportTheory->True,
	Method->"Careless"
];

Supercomment@"These results should be compared with the Hayashi and Shirafuji papers, in particular Eqs. (4.11) in Prog. Theor. Phys. 64 (1980) 2222.";
*)
(*
Section@"The case Carlo was asking about";

Comment@{"Let's target the case Carlo is talking about, which is `the metric case, which for me is eq. 5.2 of 1912.01023. To study the Ricci models, g1,g3,g4,b1,b2,b3 are set to zero'. Okay, so recycling some coupling symbols for ease (i.e. these won't have the same interpretation as those in",Cref@"CleanHayashiShirafuji","), we think this is the following nonlinear Lagrangian."};

HSNonlinearLagrangian2=-(1/2)*Alp0*R[a,b,-a,-b]+R[a,c,b,-c]*(Alp1*R[-a,d,-b,-d]+Alp2*R[-b,d,-a,-d])+Alp3*R[a,b,-a,-b]*R[c,d,-c,-d];

DisplayExpression[CollectTensors@ToCanonical[HSNonlinearLagrangian2],EqnLabel->"Carlo"];

Comment@{"Okay, so let's see what PSALTer has to say about",Cref@"Carlo","."};

LinearisedLagrangian=LineariseLagrangian[HSNonlinearLagrangian2];

ParticleSpectrum[
	"PoincareGaugeTheory",
	"GeneralPGT",
	LinearisedLagrangian,
	TensorFields->{F,A},
	CouplingConstants->{Alp0,Alp1,Alp2,Alp3,Alp4,Alp5,Alp6,Bet1,Bet2,Bet3},
	ExportTheory->True,
	Method->"Careless"
];

Supercomment@"Cool okay so, the claim is `What I found, in a general survey with all the other operators allowed,is that...nothing but the graviton propagates.' -- clearly this matches the above output. So I think we are good here.";
*)
Section@"Melichev-Percacci gravity";

Comment@{"Next we want to study the new theory put forward in Eq. (2.17) of 2307.02336. Okay, so recycling some coupling symbols for ease (i.e. these won't have the same interpretation as those in",Cref@"CleanHayashiShirafuji","), we think this is the following nonlinear Lagrangian."};

HSNonlinearLagrangian2=Alp1*R[a,b,c,d]*R[-a,-b,-c,-d]+Bet1*T[a,b,c]*T[-a,-b,-c];

DisplayExpression[CollectTensors@ToCanonical[HSNonlinearLagrangian2],EqnLabel->"MelichevPercacci"];

Comment@{"At first glance,",Cref@"MelichevPercacci"," is really an appealing theory to study, since it looks like it looks `maximally contracted' (whatever that means), and the Einstein--Hilbert term is missing. I don't think I've ever come across this model before, so it will be exciting to see what happens... Okay, so let's see what PSALTer has to say about",Cref@"MelichevPercacci","."};

LinearisedLagrangian=LineariseLagrangian[HSNonlinearLagrangian2];
(**)
ParticleSpectrum[
	"PoincareGaugeTheory",
	"MelichevPercacci",
	LinearisedLagrangian,
	TensorFields->{F,A},
	CouplingConstants->{Alp0,Alp1,Alp2,Alp3,Alp4,Alp5,Alp6,Bet1,Bet2,Bet3},
	ExportTheory->True,
	Method->"Careless"
];
(**)

Supercomment@{"Okay, quite a bit to unpack here. Firstly, due the vanishing of the EH term, I think this model falls into the category of unstudied PGT spectra, since it has vanishing tordion (not a typo: tordion is a torsion particle) masses. To check that, we'd have to look at Hayashi and Shirafuji again, but I think it is true. There are lots of papers where the authors explicitly refuse to consider such scenarios, due to their complexity. However PSALTer can handle vanishing masses, and we do indeed get a spectrum. This spectrum has some features that actually point towards parts of PSALTer that need improvement, so this is a really cool theory to talk about. Let's start with the massive sector. We see scalar, vector and tensor species all running around. It makes dimensional sense that all the square masses are proportional to",Inline@(Bet1/Alp1)," of course. Think about the first two particles: a pseudoscalar and a parity-even vector. For the pseudoscalar to be neither a ghost nor a tachyon, we need",Inline@(Alp1<0)," and",Inline@(Bet1>0),". These conditions stop the parity-even vector mode from being a tachyon, but they then absolutely force it to be a ghost. I believe that these are grounds enough to say that the Melichev-Percacci theory must be thrown out. However we continue... Next, to finish off the massive sector, notice that the parity-odd vector and the parity-odd tensor are both unitary under the conditions just discussed. That sounds great, but I have to caution here that PSALTer is telling us that they share the square mass",Inline@(-Bet1/(2Alp1)),". So what? Well actually this is quite dangerous, because in such cases the mode does not really have a definite spin, and properly one should take the joint residue of both spin sectors when evaluating the unitarity. That is trivial to go and do, but it isn't implemented in PSALTer yet (it would just be a few lines of code to make the system robust against such contingencies, but followed but a bunch of careful tests) -- thus I'm not 100% confident in the validity of this part of the spectrum. Finally, let's discuss the massless sector. This is obviously a train wreck, for starters the condition",Inline@(Alp1<0)," from earlier would seem to imply that the first two polarisations are `ghosts in both the soft and hard limits', if that notion is even well defined. Next, we have some complex structure of three plus three polarisations, evidently associated with a quadratic secular equation, which are difficult to untangle. I am very uncomfortable about such scenarios, I don't know where a group of three polarisations could come from (help? Sebastian, do you know of such things?). Anyway, the final point to say about the massless sector, is that things look bad but they might be even worse under the hood. When the massless spectrum is this rich, it is often because there is a non-simple null pole. You can intuitively understand this as follows: the massless propagator structure is the saturated eigenspace of the",Inline@(Def^2)," residue. But in general the saturated propagator is a Laurent series, with each successive term naturally becoming more and more complicated. If there is only a",Inline@(Def^2)," pole, then this is the first term and you expect a small little residue with simple unitarity conditions. But that reasoning works in reverse, so if you have complicated conditions and many eigenvectors, it is probably because the",Inline@(Def^2)," residue was not the first term, i.e. you have a ",Inline@(Def^4),"residue or worse... Heisenberg tells us that such higher-order poles are always ghosts under a limit of partial fractions. Now, PSALTer won't check for such higher-order ghosts (again, super easy to implement), but I just want to observe that we might suspect their presence here."};

(*
Section@"Einstein-Cartan theory (ECT)";

Comment@"Now we would like to check the basic Einstein-Cartan theory. Here is the full nonlinear Lagrangian:";

Off[Solve::svars];
CaseRules=(First/@(Solve[#,{kR1,kR2,kR3,kR4,kR5,kT1,kT2,kT3,kLambda}]&/@BasicCriticalCases))[[1]];
On[Solve::svars];

DisplayExpression@CollectTensors@ToCanonical[NonlinearLagrangian/.CaseRules];

LinearisedLagrangian=LineariseLagrangian[NonlinearLagrangian/.CaseRules];

ParticleSpectrum[
	"PoincareGaugeTheory",
	"EinsteinCartanTheory",
	LinearisedLagrangian,
	TensorFields->{F,A},
	CouplingConstants->{kR1,kR2,kR3,kR4,kR5,kT1,kT2,kT3,kLambda},
	ExportTheory->True
];

Comment@"Okay, so that is the end of the PSALTer output for Einstein-Cartan gravity. What we find are no propagating massive modes, but instead two degrees of freedom in the massive sector. The no-ghost conditions on these massless d.o.f restrict the sign in front of the Einstein-Hilbert term to be negative (which is what we expect for our conventions).";

(*Throw@"Hold more of my beer!";*)

(*======================*)
(*  General relativity  *)
(*======================*)

Section@"General relativity (GR)";

Comment@"Using Karananas' coefficients, it is particularly easy to also look at GR, instead of Einstein-Cartan theory. The difference here is that the quadratic torsion coefficients are manually removed. Here is the nonlinear Lagrangian:";

Off[Solve::svars];
CaseRules=(First/@(Solve[#,{kR1,kR2,kR3,kR4,kR5,kT1,kT2,kT3,kLambda}]&/@BasicCriticalCases))[[2]];
On[Solve::svars];

DisplayExpression@CollectTensors@ToCanonical[NonlinearLagrangian/.CaseRules];

LinearisedLagrangian=LineariseLagrangian[NonlinearLagrangian/.CaseRules];

ParticleSpectrum[
	"PoincareGaugeTheory",
	"GeneralRelativity",
	LinearisedLagrangian,
	TensorFields->{F,A},
	CouplingConstants->{kR1,kR2,kR3,kR4,kR5,kT1,kT2,kT3,kLambda},
	ExportTheory->True
];

Comment@"Thus, the conclusions are the same, as expected.";
*)
(*=============================*)
(*  Yun Cherng Lin's 58 cases  *)
(*=============================*)
(*
Section@"Performing the grand PGT survey";

Off[Solve::svars];
CriticalCasesSolutions=First/@(Solve[#,{kR1,kR2,kR3,kR4,kR5,kT1,kT2,kT3,kLambda}]&/@CriticalCases);
On[Solve::svars];

Comment@"We are now ready to check that PSALTer is getting the physics right by running it on the 58 theories in arXiv:1910.14197.";

Get@FileNameJoin@{NotebookDirectory[],"CalibrationTools","PoincareGaugeTheory","CalibrateCase.m"};

CalibrationTimingData=MapThread[
		AbsoluteTiming@CalibrateCase[#1,#2,#3]&,
		{
			Table[i,{i,1,58}],
			CriticalCasesSolutions[[1;;58]],(*formerly 1--58*)
			Unitarity[[1;;58]]
		}];

Section@"How long did this take?";

Comment@"Okay, that's all the cases. You can see from the timing below (in seconds) that each theory takes about a minute to process:";

DisplayExpression@CalibrationTimingData;

DumpSave[FileNameJoin@{NotebookDirectory[],"CalibrationTimingData.mx"},{CalibrationTimingData}];
*)
