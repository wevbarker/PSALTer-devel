(*=========================*)
(*  ReparameteriseSources  *)
(*=========================*)

BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/ExaminePoleOrder/ReparameteriseSources/ExtractDenominator.m";
BuildPackage@"ParticleSpectrum/ConstructMasslessAnalysis/ConvertLightcone/ExaminePoleOrder/ReparameteriseSources/ExtractReparameterisationMatrix.m";

ReparameteriseSources[InputMatrix_]:=Module[{
	ReparameterisedMatrix=InputMatrix,
	OverallDenominator,
	ReparameterisationMatrix	
	},

	OverallDenominator=ExtractDenominator@ReparameterisedMatrix;
	Diagnostic@ReparameterisedMatrix;

	ReparameterisedMatrix*=OverallDenominator;
	ReparameterisedMatrix//=Simplify;

	ReparameterisationMatrix=ExtractReparameterisationMatrix@ReparameterisedMatrix;
	Print@MatrixForm@ReparameterisationMatrix;

	(*ReparameterisedMatrix=ReparameterisationMatrix.ReparameterisedMatrix.ReparameterisationMatrix;*)
	ReparameterisedMatrix//=Simplify;	
{ReparameterisedMatrix,OverallDenominator}];
