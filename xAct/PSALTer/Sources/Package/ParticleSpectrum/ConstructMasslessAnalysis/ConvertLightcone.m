(*====================*)
(*  ConvertLightcone  *)
(*====================*)

BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/Repartition.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/FullyExpandSources.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/FullyCanonicalise.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/ExpressInLightcone.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/ConstrainInLightcone.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/MakeSaturatedMatrix.m";
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

	Print@{"Repartition start",AbsoluteTime[]};
	LightconePropagator//=Repartition[#,1]&;
	Print@{"Repartition end",AbsoluteTime[]};

	LocalMasslessSpectrum=" ** FullyExpandSources...";

	Print@{"FullyExpandSources start",AbsoluteTime[]};
	LightconePropagator=Map[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(FullyExpandSources[ClassName,#]))&,
		LightconePropagator];
	LightconePropagator=MonitorParallel@LightconePropagator;
	Diagnostic@LightconePropagator;
	Print@{"FullyExpandSources end",AbsoluteTime[]};

	LocalMasslessSpectrum=" ** Repartition...";

	Print@{"Repartition start",AbsoluteTime[]};
	LightconePropagator//=Repartition[#,10,ExpandAll->False]&;
	Print@{"Repartition end",AbsoluteTime[]};

	LocalMasslessSpectrum=" ** FullyCanonicalise...";

	Print@{"FullyCanonicalise start",AbsoluteTime[]};
	LightconePropagator=Map[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(FullyCanonicalise[#]))&,
		LightconePropagator];
	LightconePropagator=MonitorParallel@LightconePropagator;
	Diagnostic@LightconePropagator;
	Print@{"FullyCanonicalise end",AbsoluteTime[]};

	LocalMasslessSpectrum=" ** Repartition...";

	Print@{"Repartition start",AbsoluteTime[]};
	LightconePropagator//=Repartition[#,10,ExpandAll->False]&;
	Print@{"Repartition end",AbsoluteTime[]};

	LocalMasslessSpectrum=" ** ExpressInLightcone...";

	Print@{"ExpressInLightcone start",AbsoluteTime[]};
	LightconePropagator=Map[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(ExpressInLightcone[ClassName,#]))&,
		LightconePropagator];
	LightconePropagator=MonitorParallel@LightconePropagator;
	Diagnostic@LightconePropagator;
	Print@{"ExpressInLightcone end",AbsoluteTime[]};

	LocalMasslessSpectrum=" ** Repartition...";

	Print@{"Repartition start",AbsoluteTime[]};
	LightconePropagator//=Repartition[#,200]&;
	Print@{"Repartition end",AbsoluteTime[]};

	LocalMasslessSpectrum=" ** ConstrainInLightcone...";

	Print@{"ConstrainInLightcone start",AbsoluteTime[]};
	LightconePropagator=MapThread[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(ConstrainInLightcone[#1,#2]))&,
		{LightconePropagator,
		Map[((SourceComponentsToFreeSourceVariables)&),LightconePropagator]}];
	LightconePropagator=MonitorParallel@LightconePropagator;
	Diagnostic@LightconePropagator;
	Print@{"ConstrainInLightcone end",AbsoluteTime[]};

	Print@{"Total start",AbsoluteTime[]};
	LightconePropagator//=Total;
	LightconePropagator//=Expand;
	Print@{"Total end",AbsoluteTime[]};

	LocalMasslessSpectrum=" ** MakeSaturatedMatrix...";

	Print@{"MakeSaturatedMatrix start",AbsoluteTime[]};
	LightconePropagator//=MakeSaturatedMatrix[#,UnscaledNullSpace]&;
	Diagnostic@LightconePropagator;
	Print@{"MakeSaturatedMatrix end",AbsoluteTime[]};

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
