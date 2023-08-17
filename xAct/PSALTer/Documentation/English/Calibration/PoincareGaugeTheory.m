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

Get@FileNameJoin@{NotebookDirectory[],"Calibration","PoincareGaugeTheory","LagrangianHayashiShirafujiCouplings.m"};

Comment@"We can also use a different set of coupling coefficients, as developed by Karananas.";

Get@FileNameJoin@{NotebookDirectory[],"Calibration","PoincareGaugeTheory","LagrangianKarananasCouplings.m"};
DisplayExpression@NonlinearLagrangian;

Get@FileNameJoin@{NotebookDirectory[],"Calibration","PoincareGaugeTheory","Linearise.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","PoincareGaugeTheory","CriticalCases.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","PoincareGaugeTheory","Unitarity.m"};

(*Get@FileNameJoin@{NotebookDirectory[],"Calibration","PoincareGaugeTheory","GeneralPGT.m"};*)
Get@FileNameJoin@{NotebookDirectory[],"Calibration","PoincareGaugeTheory","MinimalEvenScalar.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","PoincareGaugeTheory","MinimalMassiveOddScalar.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","PoincareGaugeTheory","MinimalMasslessOddScalar.m"};
(*Get@FileNameJoin@{NotebookDirectory[],"Calibration","PoincareGaugeTheory","AnnalaRasanenTheory.m"};*)
(*Get@FileNameJoin@{NotebookDirectory[],"Calibration","PoincareGaugeTheory","MelichevPercacciTheory.m"};*)
(*Get@FileNameJoin@{NotebookDirectory[],"Calibration","PoincareGaugeTheory","EinsteinCartanTheory.m"};*)
(*Get@FileNameJoin@{NotebookDirectory[],"Calibration","PoincareGaugeTheory","GeneralRelativity.m"};*)
(*Get@FileNameJoin@{NotebookDirectory[],"Calibration","PoincareGaugeTheory","LinHobsonLasenbyTheories.m"};*)
