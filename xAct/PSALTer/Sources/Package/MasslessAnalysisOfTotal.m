(*===========================*)
(*  MasslessAnalysisOfTotal  *)
(*===========================*)

MasslessAnalysisOfTotal[LightconePropagator_List,NullSpace_List]:=Module[{
	PrintVariable,
	MasslessPropagaor,
	MasslessPropagaorResidue,
	NullSpaceDimension,
	FreeSourceVariables,
	NummeratorFreeSourceCoefficientMatrix,
	NummeratorFreeSourceEigenvalues},

	MasslessPropagaor=Together@Total@LightconePropagator;
	MasslessPropagaorResidue=2*Mo*Residue[MasslessPropagaor,{En,Mo}]//Simplify;

	NullSpaceDimension=(Dimensions@NullSpace)[[1]];
	FreeSourceVariables=Table[Symbol["X"<>ToString@i],{i,NullSpaceDimension}];

	NummeratorFreeSourceCoefficientMatrix=Last@CoefficientArrays[MasslessPropagaorResidue,FreeSourceVariables~Join~(Evaluate@Dagger[FreeSourceVariables]),"Symmetric"->False];
	NummeratorFreeSourceCoefficientMatrix=NummeratorFreeSourceCoefficientMatrix[[1;;(1/2)Length@#,(1/2)Length@#+1;;Length@#]]&@NummeratorFreeSourceCoefficientMatrix;
	NummeratorFreeSourceEigenvalues=Eigenvalues@NummeratorFreeSourceCoefficientMatrix;

	Print@" ** ParticleSpectrum: residue of the massless propagator at the massless pole (unitarity reflected in the denominator):";
	Print@MasslessPropagaorResidue;
	Print@" ** ParticleSpectrum: current eigenvalues of the massless propagator residues (number of massless polarisations is number of positive-definite eigenvalues):";
	NummeratorFreeSourceEigenvalues//=DeleteCases[#,0,Infinity]&;
	Print@NummeratorFreeSourceEigenvalues;

{MasslessPropagaorResidue,NummeratorFreeSourceEigenvalues}];
