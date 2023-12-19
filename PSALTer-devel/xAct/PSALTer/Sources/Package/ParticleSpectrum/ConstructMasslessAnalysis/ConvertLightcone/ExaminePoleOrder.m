(*====================*)
(*  ExaminePoleOrder  *)
(*====================*)

BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/ExaminePoleOrder/NullResidue.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/ExaminePoleOrder/ExtractSecularEquation.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/ExaminePoleOrder/MasslessAnalysisOfTotal.m";

ExaminePoleOrder[LightconePropagator_,LaurentDepth_]:=Module[{
	LightconePropagatorValue=LightconePropagator,
	SymbolicLightconePropagator,
	TheUniqueMatrixElements,
	NumeratorFreeSourceEigenvalues,
	SecularEquation
	},

	LocalMasslessSpectrum=" ** NullResidue...";
	SymbolicLightconePropagator=LightconePropagatorValue//MatrixToSymbolic;
	Diagnostic@SymbolicLightconePropagator;
	TheUniqueMatrixElements=Map[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(NullResidue[#,LaurentDepth]))&,
	({#})&/@(SymbolicLightconePropagator@UniqueMatrixElements),{2}];
	TheUniqueMatrixElements=MonitorParallel@TheUniqueMatrixElements;
	Diagnostic@TheUniqueMatrixElements;
	TheUniqueMatrixElements=First/@TheUniqueMatrixElements;
	Diagnostic@TheUniqueMatrixElements;
	LightconePropagatorValue=MatrixFromSymbolic[
			SymbolicLightconePropagator@SymbolicMatrix,
			SymbolicLightconePropagator@SymbolicMatrixElements,
			TheUniqueMatrixElements];

(*
	LightconePropagatorValue=Map[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(NullResidue[#,LaurentDepth]))&,
		LightconePropagatorValue,{2}];
	LightconePropagatorValue=MonitorParallel@LightconePropagatorValue;
	Diagnostic@LightconePropagatorValue;
*)

	LocalMasslessSpectrum=" ** ExtractSecularEquation...";
	SecularEquation=LightconePropagatorValue//ExtractSecularEquation;
	Diagnostic@SecularEquation;

	LocalMasslessSpectrum=" ** MasslessAnalysisOfTotal...";
	NumeratorFreeSourceEigenvalues=LightconePropagatorValue//MasslessAnalysisOfTotal;
	Diagnostic@NumeratorFreeSourceEigenvalues;

(*
	LocalMasslessSpectrum=" ** MasslessAnalysisOfTotal...";
	LightconePropagatorValue//=MasslessAnalysisOfTotal;
	Diagnostic@LightconePropagatorValue;
*)
{NumeratorFreeSourceEigenvalues,SecularEquation}];
