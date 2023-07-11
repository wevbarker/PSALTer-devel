(*=============================*)
(*  ConstructMasslessAnalysis  *)
(*=============================*)

BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConstructLightcone.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/NullResidue.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/MasslessAnalysisOfTotal.m";

ConstructMasslessAnalysis[ClassName_?StringQ,ValuesOfSourceConstraints_,ValuesSaturatedPropagator_]:=Module[{	
	MasslessPropagatorResidue,
	MasslessAnalysis
	},

	LocalSpectrum=" ** ConstructMasslessAnalysis...";

	ConstructLightcone[ClassName,ValuesOfSourceConstraints];
	ConvertLightcone[ClassName,ValuesSaturatedPropagator];

	MasslessPropagatorResidue=Map[(xAct`PSALTer`Private`PSALTerParallelSubmit@(NullResidue@#))&,LightconePropagator,{2}];
	MasslessPropagatorResidue=WaitAll@MasslessPropagatorResidue;
	Diagnostic@MasslessPropagatorResidue;

	MasslessAnalysis=MasslessAnalysisOfTotal[MasslessPropagatorResidue,UnscaledNullSpace];
	Diagnostic@MasslessAnalysis;
	MasslessAnalysisValue=MasslessAnalysis[[2]];	

	LocalSpectrum=PrintSpectrum[MassiveAnalysis,MassiveGhostAnalysis,MasslessAnalysisValue];
];
