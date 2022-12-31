(*===========================*)
(*  MasslessAnalysisOfTotal  *)
(*===========================*)

MasslessAnalysisOfTotalList[RawMasslessPropagaorResidue_List,NullSpace_List]:=Module[{
	PrintVariable,
	MasslessPropagaorResidue=RawMasslessPropagaorResidue,
	NullSpaceDimension,
	FreeSourceVariables,
	NumeratorFreeSourceCoefficientMatrix,
	NumeratorFreeSourceEigenvalues},

	PrintVariable={};
	PrintVariable=PrintVariable~Append~PrintTemporary@" ** MasslessAnalysisOfTotalList...";

	MasslessPropagaorResidue//=Flatten;
	MasslessPropagaorResidue//=Total;
	MasslessPropagaorResidue//=Simplify;

	If[!(MasslessPropagaorResidue===0),
		NullSpaceDimension=(Dimensions@NullSpace)[[1]];
		FreeSourceVariables=Table[Symbol["X"<>ToString@i],{i,NullSpaceDimension}];

		NumeratorFreeSourceCoefficientMatrix=Last@CoefficientArrays[MasslessPropagaorResidue,FreeSourceVariables~Join~(Evaluate@Dagger[FreeSourceVariables]),"Symmetric"->False];
		NumeratorFreeSourceCoefficientMatrix=NumeratorFreeSourceCoefficientMatrix[[1;;(1/2)Length@#,(1/2)Length@#+1;;Length@#]]&@NumeratorFreeSourceCoefficientMatrix;
		NumeratorFreeSourceEigenvalues=Eigenvalues@NumeratorFreeSourceCoefficientMatrix;
		NumeratorFreeSourceEigenvalues//=DeleteCases[#,0,Infinity]&;
		Print@NumeratorFreeSourceEigenvalues;,

		NumeratorFreeSourceEigenvalues={};
		Print@NumeratorFreeSourceEigenvalues;
	];

	NotebookDelete@PrintVariable;
{MasslessPropagaorResidue,NumeratorFreeSourceEigenvalues}];
