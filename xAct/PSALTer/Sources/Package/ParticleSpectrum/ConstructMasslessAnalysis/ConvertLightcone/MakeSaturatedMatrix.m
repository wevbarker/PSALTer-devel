(*=======================*)
(*  MakeSaturatedMatrix  *)
(*=======================*)

MakeSaturatedMatrix[RawMasslessPropagatorResidue_,NullSpace_List]:=Module[{
	MasslessPropagatorResidue=RawMasslessPropagatorResidue,
	NullSpaceDimension,
	FreeSourceVariables,
	NumeratorFreeSourceCoefficientMatrix},

	LocalMasslessSpectrum=" ** MakeSaturatedMatrix...";

	Diagnostic@MasslessPropagatorResidue;
	MasslessPropagatorResidue//=Expand;
	Diagnostic@MasslessPropagatorResidue;

	NullSpaceDimension=(Dimensions@NullSpace)[[1]];
	FreeSourceVariables=Table[Symbol["X"<>ToString@i],{i,NullSpaceDimension}];

	NumeratorFreeSourceCoefficientMatrix=Last@CoefficientArrays[MasslessPropagatorResidue,FreeSourceVariables~Join~(Evaluate@Dagger[FreeSourceVariables]),"Symmetric"->False];
	NumeratorFreeSourceCoefficientMatrix=NumeratorFreeSourceCoefficientMatrix[[1;;(1/2)Length@#,(1/2)Length@#+1;;Length@#]]&@NumeratorFreeSourceCoefficientMatrix;
	NumeratorFreeSourceCoefficientMatrix//=Normal;
	$DiagnosticMode=True;
	Diagnostic@(MatrixForm@NumeratorFreeSourceCoefficientMatrix);
	SliceOfMatrix=NumeratorFreeSourceCoefficientMatrix[[1;;5,1;;5]];
	Diagnostic@(MatrixForm@SliceOfMatrix);
	SliceOfMatrix=Map[(Residue[#*((En-Mo)^(1-1)),{En,Mo}]//Simplify)&,SliceOfMatrix,{2}];
	Diagnostic@(MatrixForm@SliceOfMatrix);
	$DiagnosticMode=False;

NumeratorFreeSourceCoefficientMatrix];
