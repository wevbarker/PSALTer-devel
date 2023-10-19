(*====================*)
(*  ConvertLightcone  *)
(*====================*)

BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/ExpressInLightcone.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/ConstrainInLightcone.m";

ConvertLightcone[ClassName_?StringQ,ValuesSaturatedPropagator_]:=Module[{	
	SaturatedPropagatorArray,
	},

	LocalMasslessSpectrum=" ** ConvertLightcone...";

	SaturatedPropagatorArray=(If[Head@#===Plus,List@@#,List@#])&/@(ValuesSaturatedPropagator);
	Diagnostic@SaturatedPropagatorArray;

	SaturatedPropagatorArray//=(#~PadRight~{Length@#,First@((Length/@#)~TakeLargest~1)})&;
	Diagnostic@SaturatedPropagatorArray;

	Print@{"ExpressInLightcone",AbsoluteTime[]};

	LightconePropagator=MapThread[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(ExpressInLightcone[ClassName,#1,#2]))&,
		{SaturatedPropagatorArray,
		Map[((SourceComponentsToFreeSourceVariables)&),SaturatedPropagatorArray,{2}]},2];
	LightconePropagator=MonitorParallel@LightconePropagator;
	Diagnostic@LightconePropagator;

	Print@{"ConstrainInLightcone",AbsoluteTime[]};

	LightconePropagator=MapThread[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(ConstrainInLightcone[ClassName,#1,#2]))&,
		{LightconePropagator,
		Map[((SourceComponentsToFreeSourceVariables)&),LightconePropagator,{3}]},3];
	LightconePropagator=MonitorParallel@LightconePropagator;
	Diagnostic@LightconePropagator;

	Print@{"Total",AbsoluteTime[]};

	LightconePropagator=MapThread[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(Total[#1]))&,
		{LightconePropagator,
		Map[((SourceComponentsToFreeSourceVariables)&),LightconePropagator,{2}]},2];
	LightconePropagator=MonitorParallel@LightconePropagator;
	Diagnostic@LightconePropagator;
];
