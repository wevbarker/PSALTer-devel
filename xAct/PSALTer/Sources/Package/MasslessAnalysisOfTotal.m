(*===========================*)
(*  MasslessAnalysisOfTotal  *)
(*===========================*)

MasslessAnalysisOfTotal[LightconePropagator_List,NullSpace_List]:=Catch@Module[{printer,MasslessPropagaor,MasslessPropagaorResidue,NullSpaceDimension,FreeSourceVariables,NummeratorFreeSourceCoefficientMatrix,NummeratorFreeSourceEigenvalues},
MasslessPropagaor=Together@Total@LightconePropagator;
MasslessPropagaorResidue=Residue[MasslessPropagaor (En-Mo)^0,{En,Mo}]//Simplify;

NullSpaceDimension=(Dimensions@NullSpace)[[1]];
FreeSourceVariables=Table[Symbol["X"<>ToString@i],{i,NullSpaceDimension}];
NummeratorFreeSourceCoefficientMatrix=Last@CoefficientArrays[Numerator@MasslessPropagaorResidue,FreeSourceVariables~Join~(Evaluate@Dagger[FreeSourceVariables]),"Symmetric"->False];
NummeratorFreeSourceCoefficientMatrix=NummeratorFreeSourceCoefficientMatrix[[1;;(1/2)Length@#,(1/2)Length@#+1;;Length@#]]&@NummeratorFreeSourceCoefficientMatrix;
NummeratorFreeSourceEigenvalues=Eigenvalues@NummeratorFreeSourceCoefficientMatrix;

Print@" ** YunCherngLin: residue of the massless propagator at the massless pole (unitarity reflected in the denominator):";
Print@MasslessPropagaorResidue;
Print@" ** YunCherngLin: current eigenvalues of the massless propagator residues (number of massless polarisations is number of positive-definite eigenvalues):";
Print@NummeratorFreeSourceEigenvalues;

{MasslessPropagaorResidue,NummeratorFreeSourceEigenvalues}];
