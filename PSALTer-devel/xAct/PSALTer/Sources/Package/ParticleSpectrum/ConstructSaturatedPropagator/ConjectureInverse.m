(*=====================*)
(*  ConjectureInverse  *)
(*=====================*)

BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator/MakeSymbolic.m";
BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator/IntermediateRules.m";
BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator/ManualPseudoInverse.m";
BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator/UnmakeSymbolic.m";

ConjectureInverse[InputMatrix_,Couplings_,CouplingAssumptions_]:=Module[{	
	TheInputMatrix=InputMatrix,
	ConjecturedNullSpace,
	SymbolicMatrix,
	FirstIntermediateSymbolsToCouplingConstants,
	ReduceFirstIntermediateSymbols,
	FirstIntermediateSymbolsToSecondIntermediateSymbols,
	SecondIntermediateSymbolsToCouplingConstants,
	InverseSymbolicMatrix,
	DeterminantSymbolic
	},

	LocalPropagator=" ** ConjectureInverse...";

	ConjecturedNullSpace=ConjectureNullSpace[TheInputMatrix,Couplings,CouplingAssumptions];
	Diagnostic@ConjecturedNullSpace;
	{SymbolicMatrix,FirstIntermediateSymbolsToCouplingConstants}=MakeSymbolic[TheInputMatrix,CouplingAssumptions];
	Diagnostic@SymbolicMatrix;
	{ReduceFirstIntermediateSymbols,FirstIntermediateSymbolsToSecondIntermediateSymbols,SecondIntermediateSymbolsToCouplingConstants}=IntermediateRules[FirstIntermediateSymbolsToCouplingConstants,Couplings];
	Diagnostic@ReduceFirstIntermediateSymbols;
	Diagnostic@FirstIntermediateSymbolsToSecondIntermediateSymbols;
	Diagnostic@SecondIntermediateSymbolsToCouplingConstants;

	{InverseSymbolicMatrix,DeterminantSymbolic}=ManualPseudoInverse[SymbolicMatrix,ConjecturedNullSpace];

	InverseMatrix=UnmakeSymbolic[InverseSymbolicMatrix,DeterminantSymbolic,ReduceFirstIntermediateSymbols,FirstIntermediateSymbolsToSecondIntermediateSymbols,SecondIntermediateSymbolsToCouplingConstants,CouplingAssumptions];

	Diagnostic@InverseMatrix;

InverseMatrix];
