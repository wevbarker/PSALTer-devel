(*=====================*)
(*  ConjectureInverse  *)
(*=====================*)

BuildPackage@"ParticleSpectrum/ConstructSourceConstraints/ConjectureNullSpace.m";
BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator/MakeSymbolic.m";
BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator/ManualPseudoInverse.m";
BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator/UnmakeSymbolic.m";

ConjectureInverse[InputMatrix_,Couplings_,CouplingAssumptions_]:=Module[{	
ConjecturedNullSpace,
SymbolicMatrix,
SymbolicRules
},
	Print@MatrixForm@InputMatrix;
	ConjecturedNullSpace=ConjectureNullSpace[InputMatrix,Couplings,CouplingAssumptions];
	Print@MatrixForm@ConjecturedNullSpace;
	{SymbolicMatrix,SymbolicRules}=MakeSymbolic[InputMatrix,CouplingAssumptions];
	Print@MatrixForm@SymbolicMatrix;
	InverseSymbolicMatrix=ManualPseudoInverse[SymbolicMatrix,ConjecturedNullSpace];
	Print@MatrixForm@InverseSymbolicMatrix;
	InverseMatrix=UnmakeSymbolic[InverseSymbolicMatrix,SymbolicRules];	
	Print@MatrixForm@InverseMatrix;
InverseMatrix];
