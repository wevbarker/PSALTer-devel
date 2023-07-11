(*==================*)
(*  UnmakeSymbolic  *)
(*==================*)

BuildPackage@"ParticleSpectrum/ConstructSaturatedPropagator/UnmakeSymbolicElement.m";

UnmakeSymbolic[InverseSymbolicMatrix_,
	ReduceFirstIntermediateSymbols_,
	FirstIntermediateSymbolsToSecondIntermediateSymbols_,
	SecondIntermediateSymbolsToCouplingConstants_]:=Module[{
		RankOfMatrix,
		InverseMatrix,
		CombinedRules,
		TheInverseSymbolicMatrix,
		DistributedCombinedRules},

	LocalPropagator=" ** UnmakeSymbolic...";

	RankOfMatrix=Length@InverseSymbolicMatrix;

	Quiet@CreateDirectory[FileNameJoin@{NotebookDirectory[],"tmp"}];

	MatrixElementFileNames=Table[0,{i,RankOfMatrix},{j,RankOfMatrix}];
	Table[
		MatrixElement=Evaluate@(InverseSymbolicMatrix[[i,j]]);
		MatrixElementFileName=FileNameJoin@{NotebookDirectory[],
				"tmp",
				"MatrixElement"<>ToString@i<>ToString@j<>".mx"};
		MatrixElementFileNames[[i,j]]=MatrixElementFileName;
		DumpSave[MatrixElementFileName,MatrixElement];
		MatrixElement=0;
		MatrixElementFileName="";,
	{i,RankOfMatrix},{j,RankOfMatrix}];

	(Diagnostic@#)&@MatrixForm@MatrixElementFileNames;

	CombinedRules={ReduceFirstIntermediateSymbols,FirstIntermediateSymbolsToSecondIntermediateSymbols,SecondIntermediateSymbolsToCouplingConstants};

	InverseMatrix=MapThread[(xAct`PSALTer`Private`PSALTerParallelSubmit@(UnmakeSymbolicElement[#1,#2]))&,{Map[(CombinedRules)&,MatrixElementFileNames,{2}],MatrixElementFileNames},2];

	(Diagnostic@#)&@InverseMatrix;
	InverseMatrix=WaitAll@InverseMatrix;
InverseMatrix];
