(*=========================*)
(*  ReparameteriseSources  *)
(*=========================*)

IncludeHeader@"ExtractDenominator";
IncludeHeader@"ExtractReparameterisationMatrix";

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
	(*Print@MatrixForm@ReparameterisationMatrix;*)

	ReparameterisedMatrix=ReparameterisationMatrix.ReparameterisedMatrix.ReparameterisationMatrix;
	ReparameterisedMatrix//=Simplify;	
{ReparameterisedMatrix,OverallDenominator}];
