(*==================*)
(*  UnmakeSymbolic  *)
(*==================*)

BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator/UnmakeSymbolicElement.m";

UnmakeSymbolic[InverseSymbolicMatrix_,SymbolicRules_]:=Module[{InverseMatrix},	
	InverseMatrix=MapThread[
			(xAct`PSALTer`Private`PSALTerParallelSubmit@(UnmakeSymbolicElement[#1,#2]))&,
				{InverseSymbolicMatrix,
				Map[(SymbolicRules)&,InverseSymbolicMatrix,{2}]},
			2];
	Print@InverseMatrix;
	InverseMatrix=WaitAll@InverseMatrix;
InverseMatrix];
