(*====================*)
(*  ConvertLightcone  *)
(*====================*)

BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/Repartition.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/FullyExpandSources.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/FullyCanonicalise.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/ExpressInLightcone.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/ConstrainInLightcone.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/MakeSaturatedMatrix.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/MatrixToSymbolic.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/MatrixFromSymbolic.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/ExaminePoleOrder.m";

Options@ConvertLightcone={
	MaxLaurentDepth->1
	};

ConvertLightcone[ClassName_?StringQ,
		ValuesSaturatedPropagator_,
		ValuesUnscaledNullSpace_,
		OptionsPattern[]]:=Module[{	
	SaturatedPropagatorArray
	},

	LocalMasslessSpectrum=" ** ConvertLightcone...";
	LightconePropagator=ValuesSaturatedPropagator;

	LocalMasslessSpectrum=" ** Repartition...";
	LightconePropagator//=Repartition[#,1]&;

	LocalMasslessSpectrum=" ** FullyExpandSources...";
	LightconePropagator=Map[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(FullyExpandSources[ClassName,#]))&,
		LightconePropagator];
	LightconePropagator=MonitorParallel@LightconePropagator;
	Diagnostic@LightconePropagator;

	LocalMasslessSpectrum=" ** Repartition...";
	LightconePropagator//=Repartition[#,10,ExpandAll->False]&;

	LocalMasslessSpectrum=" ** FullyCanonicalise...";
	LightconePropagator=Map[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(FullyCanonicalise[#]))&,
		LightconePropagator];
	LightconePropagator=MonitorParallel@LightconePropagator;
	Diagnostic@LightconePropagator;

	LocalMasslessSpectrum=" ** Repartition...";
	LightconePropagator//=Repartition[#,10,ExpandAll->False]&;

	LocalMasslessSpectrum=" ** ExpressInLightcone...";
	LightconePropagator=Map[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(ExpressInLightcone[ClassName,#]))&,
		LightconePropagator];
	LightconePropagator=MonitorParallel@LightconePropagator;
	Diagnostic@LightconePropagator;

	LocalMasslessSpectrum=" ** Repartition...";
	LightconePropagator//=Repartition[#,200]&;

	LocalMasslessSpectrum=" ** ConstrainInLightcone...";
	LightconePropagator=MapThread[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(ConstrainInLightcone[#1,#2]))&,
		{LightconePropagator,
		Map[((SourceComponentsToFreeSourceVariables)&),LightconePropagator]}];
	LightconePropagator=MonitorParallel@LightconePropagator;
	Diagnostic@LightconePropagator;

	LightconePropagator//=Total;
	LightconePropagator//=Expand;

	LocalMasslessSpectrum=" ** MakeSaturatedMatrix...";

	LightconePropagator//=MakeSaturatedMatrix[#,UnscaledNullSpace]&;
	Diagnostic@LightconePropagator;

	{MasslessAnalysisValue,SecularEquationValue}=ExaminePoleOrder[LightconePropagator,1];
	QuarticAnalysisValue={};
	HexicAnalysisValue={};

	LocalMasslessSpectrum={{},{},
		MasslessAnalysisValue,
		QuarticAnalysisValue,
		HexicAnalysisValue,
		{SecularEquationValue}};

	If[(OptionValue@MaxLaurentDepth)>1,
		QuarticAnalysisValue=First@ExaminePoleOrder[LightconePropagator,2];

		LocalMasslessSpectrum={{},{},
			MasslessAnalysisValue,
			QuarticAnalysisValue,
			HexicAnalysisValue,
			{SecularEquationValue}};
	];

	If[(OptionValue@MaxLaurentDepth)>2,
		HexicAnalysisValue=First@ExaminePoleOrder[LightconePropagator,3];

		LocalMasslessSpectrum={{},{},
			MasslessAnalysisValue,
			QuarticAnalysisValue,
			HexicAnalysisValue,
			{SecularEquationValue}};
	];
];
