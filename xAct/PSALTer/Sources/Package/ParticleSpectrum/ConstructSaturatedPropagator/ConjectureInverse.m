(*=====================*)
(*  ConjectureInverse  *)
(*=====================*)

BuildPackage@"ParticleSpectrum/ConstructSourceConstraints/ConjectureNullSpace.m";
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
	SecondIntermediateSymbolsToCouplingConstants
	},

	LocalPropagator=" ** ConjectureInverse...";

	(Diagnostic@#)&@(MatrixForm@InputMatrix);

	ConjecturedNullSpace=ConjectureNullSpace[TheInputMatrix,Couplings,CouplingAssumptions];
	(Diagnostic@#)&@(MatrixForm@ConjecturedNullSpace);
	{SymbolicMatrix,FirstIntermediateSymbolsToCouplingConstants}=MakeSymbolic[TheInputMatrix,CouplingAssumptions];
	(Diagnostic@#)&@(MatrixForm@SymbolicMatrix);
	{ReduceFirstIntermediateSymbols,FirstIntermediateSymbolsToSecondIntermediateSymbols,SecondIntermediateSymbolsToCouplingConstants}=IntermediateRules[FirstIntermediateSymbolsToCouplingConstants,Couplings];
	(Diagnostic@#)&@ReduceFirstIntermediateSymbols;
	(Diagnostic@#)&@FirstIntermediateSymbolsToSecondIntermediateSymbols;
	(Diagnostic@#)&@SecondIntermediateSymbolsToCouplingConstants;

	InverseSymbolicMatrix=ManualPseudoInverse[SymbolicMatrix,ConjecturedNullSpace];

	InverseMatrix=UnmakeSymbolic[InverseSymbolicMatrix,ReduceFirstIntermediateSymbols,FirstIntermediateSymbolsToSecondIntermediateSymbols,SecondIntermediateSymbolsToCouplingConstants];	
	InverseMatrix=((#)~FullSimplify~CouplingAssumptions)&@InverseMatrix;
	(Diagnostic@#)&@(MatrixForm@InverseMatrix);

InverseMatrix];
