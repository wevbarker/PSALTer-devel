(*====================*)
(*  ExaminePoleOrder  *)
(*====================*)

BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/ExaminePoleOrder/NullResidue.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/ExaminePoleOrder/MasslessAnalysisOfTotal.m";

ExaminePoleOrder[LightconePropagator_,LaurentDepth_]:=Module[{
	LightconePropagatorValue=LightconePropagator},

	LocalMasslessSpectrum=" ** NullResidue...";

	Print@{"NullResidue start",AbsoluteTime[]};
	LightconePropagatorValue=Map[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(NullResidue[#,LaurentDepth]))&,
		LightconePropagatorValue,{2}];
	LightconePropagatorValue=MonitorParallel@LightconePropagatorValue;
	Diagnostic@LightconePropagatorValue;
	Print@{"NullResidue end",AbsoluteTime[]};

	LocalMasslessSpectrum=" ** MasslessAnalysisOfTotal...";

	Print@{"MasslessAnalysisOfTotal start",AbsoluteTime[]};
	LightconePropagatorValue//=MasslessAnalysisOfTotal;
	Diagnostic@LightconePropagatorValue;
	Print@{"MasslessAnalysisOfTotal end",AbsoluteTime[]};
LightconePropagatorValue];
