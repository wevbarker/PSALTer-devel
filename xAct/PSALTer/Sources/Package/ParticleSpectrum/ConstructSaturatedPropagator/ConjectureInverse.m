(*=====================*)
(*  ConjectureInverse  *)
(*=====================*)

BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator/ConjectureInverse/MakeSymbolic.m";
BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator/ConjectureInverse/IntermediateRules.m";
BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator/ConjectureInverse/ManualPseudoInverse.m";
BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator/ConjectureInverse/UnmakeSymbolic.m";

ConjectureInverse[InputMatrix_,Couplings_,CouplingAssumptions_]:=Module[{	
	TheInputMatrix=InputMatrix,
	ConjecturedNullSpace,
	SymbolicMatrix,
	FirstIntermediateSymbolsToCouplingConstants,
	ReduceFirstIntermediateSymbols,
	FirstIntermediateSymbolsToSecondIntermediateSymbols,
	SecondIntermediateSymbolsToCouplingConstants,
	InverseSymbolicMatrix,
	DeterminantSymbolic,
	SymbolicCouplingAssumptions
	},


	LocalPropagator=" ** ConjectureInverse...";
	ConjecturedNullSpace=ConjectureNullSpace[TheInputMatrix,Couplings,CouplingAssumptions];
	Diagnostic@(MatrixForm@ConjecturedNullSpace);

	LocalPropagator=" ** MakeSymbolic...";
	{SymbolicMatrix,FirstIntermediateSymbolsToCouplingConstants}=MakeSymbolic[TheInputMatrix,CouplingAssumptions];
	Diagnostic@(MatrixForm@SymbolicMatrix);

	LocalPropagator=" ** IntermediateRules...";
	{ReduceFirstIntermediateSymbols,FirstIntermediateSymbolsToSecondIntermediateSymbols,SecondIntermediateSymbolsToCouplingConstants}=IntermediateRules[FirstIntermediateSymbolsToCouplingConstants,Couplings];
	Diagnostic@ReduceFirstIntermediateSymbols;
	Diagnostic@FirstIntermediateSymbolsToSecondIntermediateSymbols;
	Diagnostic@SecondIntermediateSymbolsToCouplingConstants;

	LocalPropagator=" ** ManualPseudoInverse...";
	{InverseSymbolicMatrix,DeterminantSymbolic}=ManualPseudoInverse[SymbolicMatrix,ConjecturedNullSpace];

	LocalPropagator=" ** IntegrategetAllVariables...";

	SymbolicCouplingAssumptions=CouplingAssumptions;
	Diagnostic@SymbolicCouplingAssumptions;

	LocalPropagator=" ** DistributeConjugate...";
	InverseSymbolicMatrix//=DistributeConjugate[#,SymbolicCouplingAssumptions]&;
	Diagnostic@InverseSymbolicMatrix;
	DeterminantSymbolic//=DistributeConjugate[#,SymbolicCouplingAssumptions]&;
	Diagnostic@DeterminantSymbolic;

	LocalPropagator=" ** UnmakeSymbolic...";
	InverseMatrix=UnmakeSymbolic[InverseSymbolicMatrix,DeterminantSymbolic,ReduceFirstIntermediateSymbols,FirstIntermediateSymbolsToSecondIntermediateSymbols,SecondIntermediateSymbolsToCouplingConstants,CouplingAssumptions];
	Diagnostic@InverseMatrix;

	LocalPropagator=" ** DistributeConjugate...";
	InverseMatrix//=DistributeConjugate[#,CouplingAssumptions]&;
	Diagnostic@InverseMatrix;

InverseMatrix];
