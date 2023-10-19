(*=============================*)
(*  ConstructMasslessAnalysis  *)
(*=============================*)

BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConstructLightcone.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/NullResidue.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/MasslessAnalysisOfTotal.m";

Options@ConstructMasslessAnalysis={
	MaxLaurentDepth->1
	};

ConstructMasslessAnalysis[ClassName_?StringQ,ValuesOfSourceConstraints_,ValuesSaturatedPropagator_,OptionsPattern[]]:=Module[{	
	MasslessPropagatorResidue,
	MasslessAnalysis
	},

	LocalMasslessSpectrum=" ** ConstructMasslessAnalysis...";

	ConstructLightconeTime=Timing@ConstructLightcone[ClassName,ValuesOfSourceConstraints];
	Print@{"ConstructLightconeTime",First@ConstructLightconeTime};
	ConvertLightconeTime=Timing@ConvertLightcone[ClassName,ValuesSaturatedPropagator];
	Print@{"ConvertLightconeTime",First@ConvertLightconeTime};

	MasslessPropagatorResidue=MapThread[(xAct`PSALTer`Private`PSALTerParallelSubmit@(NullResidue[#1,#2]))&,
	{LightconePropagator,
	Map[(1)&,LightconePropagator,{2}]},
	2];
	MasslessPropagatorResidue=MonitorParallel@MasslessPropagatorResidue;
	Diagnostic@MasslessPropagatorResidue;
	MasslessAnalysis=MasslessAnalysisOfTotal[MasslessPropagatorResidue,UnscaledNullSpace];
	Diagnostic@MasslessAnalysis;
	MasslessAnalysisValue=MasslessAnalysis[[2]];	

	If[(OptionValue@MaxLaurentDepth)>1,
	MasslessPropagatorResidue=MapThread[(xAct`PSALTer`Private`PSALTerParallelSubmit@(NullResidue[#1,#2]))&,
	{LightconePropagator,
	Map[(2)&,LightconePropagator,{2}]},
	2];
	MasslessPropagatorResidue=MonitorParallel@MasslessPropagatorResidue;
	Diagnostic@MasslessPropagatorResidue;
	MasslessAnalysis=MasslessAnalysisOfTotal[MasslessPropagatorResidue,UnscaledNullSpace];
	Diagnostic@MasslessAnalysis;
	QuarticAnalysisValue=MasslessAnalysis[[2]];,
	QuarticAnalysisValue={};
	];

	If[(OptionValue@MaxLaurentDepth)>2,
	MasslessPropagatorResidue=MapThread[(xAct`PSALTer`Private`PSALTerParallelSubmit@(NullResidue[#1,#2]))&,
	{LightconePropagator,
	Map[(3)&,LightconePropagator,{2}]},
	2];
	MasslessPropagatorResidue=MonitorParallel@MasslessPropagatorResidue;
	Diagnostic@MasslessPropagatorResidue;
	MasslessAnalysis=MasslessAnalysisOfTotal[MasslessPropagatorResidue,UnscaledNullSpace];
	Diagnostic@MasslessAnalysis;
	HexicAnalysisValue=MasslessAnalysis[[2]];,
	HexicAnalysisValue={};
	];

	LocalMasslessSpectrum={{},{},MasslessAnalysisValue,QuarticAnalysisValue,HexicAnalysisValue};
];
