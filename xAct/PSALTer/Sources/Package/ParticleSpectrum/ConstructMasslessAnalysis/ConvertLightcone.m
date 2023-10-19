(*====================*)
(*  ConvertLightcone  *)
(*====================*)

BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/ExpressInLightcone.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/MakeResidue.m";

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

	Print@{"Flatten, Total, Expand",AbsoluteTime[]};
	LightconePropagator//=Flatten;
	LightconePropagator//=Total;
	LightconePropagator//=Expand;
	LightconePropagator=(If[Head@#===Plus,List@@#,List@#])&@(LightconePropagator);
	Print["Length of the component form is:",Length@LightconePropagator];
	LightconePropagator//=Partition[#,UpTo@100]&;
	LightconePropagator//=(Total/@#)&;

	Print@{"MakeResidue",AbsoluteTime[]};
	LightconePropagator=MapThread[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(MakeResidue[ClassName,#1,#2]))&,
		{LightconePropagator,
		Map[((SourceComponentsToFreeSourceVariables)&),LightconePropagator]}];
	LightconePropagator=MonitorParallel@LightconePropagator;
	Diagnostic@LightconePropagator;

	Print@{"Total",AbsoluteTime[]};
	LightconePropagator//=Total;
	LightconePropagator//=Expand;
];
