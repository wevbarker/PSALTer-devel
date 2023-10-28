(*====================*)
(*  ExaminePoleOrder  *)
(*====================*)

BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/ExaminePoleOrder/NullResidue.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/ExaminePoleOrder/MasslessAnalysisOfTotal.m";

Options@ExaminePoleOrder={
	MaxLaurentDepth->1
	};

ExaminePoleOrder[LightconePropagator_,OptionsPattern[]]:=Module[{
	LightconePropagatorValue=LightconePropagator},

	LocalMasslessSpectrum=" ** NullResidue...";

	Print@{"NullResidue start",AbsoluteTime[]};
	LightconePropagatorValue=Map[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(NullResidue[#,
								OptionValue@MaxLaurentDepth]))&,
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
