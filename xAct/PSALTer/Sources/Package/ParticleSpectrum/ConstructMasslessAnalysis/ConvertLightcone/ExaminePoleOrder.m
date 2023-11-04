(*====================*)
(*  ExaminePoleOrder  *)
(*====================*)

BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/ExaminePoleOrder/NullResidue.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/ExaminePoleOrder/MasslessAnalysisOfTotal.m";

ExaminePoleOrder[LightconePropagator_,LaurentDepth_]:=Module[{
	LightconePropagatorValue=LightconePropagator},

	LocalMasslessSpectrum=" ** NullResidue...";
	LightconePropagatorValue=Map[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(NullResidue[#,LaurentDepth]))&,
		LightconePropagatorValue,{2}];
	LightconePropagatorValue=MonitorParallel@LightconePropagatorValue;
	Diagnostic@LightconePropagatorValue;

	LocalMasslessSpectrum=" ** MasslessAnalysisOfTotal...";
	LightconePropagatorValue//=MasslessAnalysisOfTotal;
	Diagnostic@LightconePropagatorValue;

LightconePropagatorValue];
