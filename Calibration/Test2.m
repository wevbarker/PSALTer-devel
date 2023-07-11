(*=========*)
(*  Test2  *)
(*=========*)

(Print@#)&/@(MatrixForm/@xAct`PSALTer`Private`AllMatrices);

(Print@#)&@"The aim here is to try some symbolic equivalent of the matrices";

(*Couplings2={xAct`PSALTer`MetricAffineGaugeTheory`A4,xAct`PSALTer`MetricAffineGaugeTheory`A5,xAct`PSALTer`MetricAffineGaugeTheory`A9};*)

Couplings={xAct`PSALTer`MetricAffineGaugeTheory`A0,xAct`PSALTer`MetricAffineGaugeTheory`A1,xAct`PSALTer`MetricAffineGaugeTheory`A2,xAct`PSALTer`MetricAffineGaugeTheory`A3,xAct`PSALTer`MetricAffineGaugeTheory`A4,xAct`PSALTer`MetricAffineGaugeTheory`A5,xAct`PSALTer`MetricAffineGaugeTheory`A6,xAct`PSALTer`MetricAffineGaugeTheory`A7,xAct`PSALTer`MetricAffineGaugeTheory`A8,xAct`PSALTer`MetricAffineGaugeTheory`A9,xAct`PSALTer`MetricAffineGaugeTheory`A10,xAct`PSALTer`MetricAffineGaugeTheory`A11,xAct`PSALTer`MetricAffineGaugeTheory`C1,xAct`PSALTer`MetricAffineGaugeTheory`C2,xAct`PSALTer`MetricAffineGaugeTheory`C3,xAct`PSALTer`MetricAffineGaugeTheory`C4,xAct`PSALTer`MetricAffineGaugeTheory`C5,xAct`PSALTer`MetricAffineGaugeTheory`C6,xAct`PSALTer`MetricAffineGaugeTheory`C7,xAct`PSALTer`MetricAffineGaugeTheory`C8,xAct`PSALTer`MetricAffineGaugeTheory`C9,xAct`PSALTer`MetricAffineGaugeTheory`C10,xAct`PSALTer`MetricAffineGaugeTheory`C11,xAct`PSALTer`MetricAffineGaugeTheory`C12,xAct`PSALTer`MetricAffineGaugeTheory`C13,xAct`PSALTer`MetricAffineGaugeTheory`C14,xAct`PSALTer`MetricAffineGaugeTheory`C15,xAct`PSALTer`MetricAffineGaugeTheory`C16};
CouplingAssumptions=(#~Element~Reals)&/@Couplings;
CouplingAssumptions~AppendTo~(xAct`PSALTer`Def~Element~Reals);

IsNullVectorOfSpace[NullVector_,MinimalExampleCaseNullSpace_]:=Module[{LinearIndependence},
	LinearIndependence=ResourceFunction["LinearlyIndependent"]@(MinimalExampleCaseNullSpace~Join~{NullVector});
(!LinearIndependence)];

CommonNullVector[NullVector_,MinimalExampleCaseNullSpaces_]:=Module[{IsNullVectorOfExampleCaseNullSpaces},
	IsNullVectorOfExampleCaseNullSpaces=IsNullVectorOfSpace[NullVector,#]&/@MinimalExampleCaseNullSpaces;
And@@IsNullVectorOfExampleCaseNullSpaces];

ConjectureNullSpace[InputMatrix_,Couplings_,CouplingAssumptions_]:=Module[{	
	MinimalExampleCaseRules,
	MinimalExampleCaseNullSpaces,
	AllNullVectors},

	MinimalExampleCaseRules=Table[(#->0)&/@Drop[Couplings,{i}],{i,Length@Couplings}];
	MinimalExampleCaseNullSpaces=Module[{MinimalExampleCaseNullSpace},
		Assuming[CouplingAssumptions,MinimalExampleCaseNullSpace=NullSpace[InputMatrix/.#]];
		Assuming[CouplingAssumptions,MinimalExampleCaseNullSpace//=Simplify];
	MinimalExampleCaseNullSpace]&/@MinimalExampleCaseRules;
	AllNullVectors=Join@@MinimalExampleCaseNullSpaces;
	AllNullVectors//=DeleteDuplicates;
	ConjecturedNullSpace=AllNullVectors~Select~(CommonNullVector[#,MinimalExampleCaseNullSpaces]&);
ConjecturedNullSpace];

MakeSymbolic[InputMatrix_,CouplingAssumptions_]:=Module[{
	DimensionOfMatrix,
	SymbolicMatrix,
	SymbolicRules
	},

	LocalPropagator=" ** MakeSymbolic...";

	DimensionOfMatrix=Length@InputMatrix;
	SymbolicMatrix=Table[0,{i,DimensionOfMatrix},{j,DimensionOfMatrix}];	
	SymbolicRules={};

	ReplaceReal[i_,j_]:=Module[{RealPart,NewSymbol},	
		Assuming[CouplingAssumptions,RealPart=Simplify@Re@(Evaluate@InputMatrix[[i,j]])];
		NewSymbol=Symbol["r"<>ToString@i<>ToString@j];
		If[PossibleZeroQ@RealPart,Null,
			SymbolicRules~AppendTo~(NewSymbol->RealPart);
			SymbolicMatrix[[i,j]]+=NewSymbol;
			If[i===j,Null,
				SymbolicMatrix[[j,i]]+=NewSymbol;
			];
		];
	];

	ReplaceImaginary[i_,j_]:=Module[{ImaginaryPart,NewSymbol},
		Assuming[CouplingAssumptions,ImaginaryPart=Simplify@Im@(Evaluate@InputMatrix[[i,j]])];
		NewSymbol=Symbol["i"<>ToString@i<>ToString@j];
		If[PossibleZeroQ@ImaginaryPart,Null,
			SymbolicRules~AppendTo~(NewSymbol->ImaginaryPart);
			SymbolicMatrix[[i,j]]+=I*NewSymbol;
			If[i===j,Null,
				SymbolicMatrix[[j,i]]+=-I*NewSymbol;
			];
		];
	];
	
	Table[
		(
			ReplaceReal[i,j];
			ReplaceImaginary[i,j];
		),
		{i,DimensionOfMatrix},{j,i,DimensionOfMatrix}];	

{SymbolicMatrix,SymbolicRules}];

IntermediateRules[FirstIntermediateSymbolsToCouplingConstants_,Couplings_]:=Module[{
	NewIndex,
	FirstIntermediateSymbols,
	FirstIntermediateSymbolsToSecondIntermediateSymbols,
	ReduceFirstIntermediateSymbols,
	SecondIntermediateSymbols,
	SecondIntermediateSymbolsToCouplingConstants,
	ReduceSecondIntermediateSymbols,
	TotalExpr,
	},

	LocalPropagator=" ** IntermediateRules...";
	
	NewIndex=1;
	FirstIntermediateSymbols=First/@FirstIntermediateSymbolsToCouplingConstants;	
	SecondIntermediateSymbolsToCouplingConstants={};
	FirstIntermediateSymbolsToSecondIntermediateSymbols={};
	Table[
		TotalExpr=0;
		Table[
			Module[{Expr},
				Expr=Coefficient[FirstIntermediateSymbol/.FirstIntermediateSymbolsToCouplingConstants,xAct`PSALTer`Def,j];
				If[!(Expr===0),
					SecondIntermediateSymbolsToCouplingConstants=SecondIntermediateSymbolsToCouplingConstants~Join~{Symbol["l"<>ToString@NewIndex]->Expr};
					(*(Print@#)&@SecondIntermediateSymbolsToCouplingConstants;*)
					TotalExpr+=Symbol["l"<>ToString@NewIndex]*xAct`PSALTer`Def^j;
					(*(Print@#)&@TotalExpr;*)
					NewIndex+=1;
				];
			];,
		{j,0,8}];
		FirstIntermediateSymbolsToSecondIntermediateSymbols=FirstIntermediateSymbolsToSecondIntermediateSymbols~Join~{FirstIntermediateSymbol->TotalExpr};,
	{FirstIntermediateSymbol,FirstIntermediateSymbols}];

	ReduceFirstIntermediateSymbols=Eliminate[FirstIntermediateSymbolsToCouplingConstants/.{Rule->Equal},Couplings];
	ReduceFirstIntermediateSymbols=First@Quiet@Solve[ReduceFirstIntermediateSymbols,FirstIntermediateSymbols];

	SecondIntermediateSymbols=First/@SecondIntermediateSymbolsToCouplingConstants;
	ReduceSecondIntermediateSymbols=Eliminate[SecondIntermediateSymbolsToCouplingConstants/.{Rule->Equal},Couplings];
	ReduceSecondIntermediateSymbols=First@Quiet@Solve[ReduceSecondIntermediateSymbols,SecondIntermediateSymbols];

	FirstIntermediateSymbolsToSecondIntermediateSymbols=FirstIntermediateSymbolsToSecondIntermediateSymbols/.ReduceSecondIntermediateSymbols;

{ReduceFirstIntermediateSymbols,FirstIntermediateSymbolsToSecondIntermediateSymbols,SecondIntermediateSymbolsToCouplingConstants}];

ManualPseudoInverse[TheInputMatrix_List?MatrixQ/;Precision[TheInputMatrix]===Infinity,TheConjecturedNullSpace_]:=Module[{
	DimensionsOfMatrix,
	OriginalNullSpace=TheConjecturedNullSpace,
	ColumnNullSpace,
	RowNullSpace,
	CompensatorMatrix,
	Similarity,
	RawInverse,
	PseudoInverseMatrix},
	
	LocalPropagator=" ** ManualPseudoInverse...";

	DimensionsOfMatrix=Length@TheInputMatrix;

	OriginalNullSpace=If[OriginalNullSpace==={},
			{Table[0,{DimensionsOfMatrix}]},OriginalNullSpace];

	Assuming[xAct`PSALTer`Def>0,
		OriginalNullSpace=FullSimplify@Orthogonalize@OriginalNullSpace];

	ColumnNullSpace=Transpose@OriginalNullSpace;
	RowNullSpace=Conjugate@OriginalNullSpace;


	(Print@#)&@"Checking orthonormality";
	(Print@#)&@(MatrixForm@Assuming[xAct`PSALTer`Def>0,
			FullSimplify@(RowNullSpace.ColumnNullSpace)]);

	CompensatorMatrix=ColumnNullSpace.RowNullSpace;
	Assuming[xAct`PSALTer`Def>0,CompensatorMatrix//=FullSimplify];
	(Print@#)&@(MatrixForm@CompensatorMatrix);

	Similarity=(IdentityMatrix@DimensionsOfMatrix)-CompensatorMatrix;

	(Print@#)&@"Checking annihilation";
	(Print@#)&@(MatrixForm@Assuming[xAct`PSALTer`Def>0,
			FullSimplify@(Similarity.ColumnNullSpace)]);

	PseudoInverseMatrix=Inverse[TheInputMatrix+CompensatorMatrix];
	(*Assuming[xAct`PSALTer`Def>0,PseudoInverseMatrix//=FullSimplify];*)

	PseudoInverseMatrix=PseudoInverseMatrix.Similarity;
	(*Assuming[xAct`PSALTer`Def>0,PseudoInverseMatrix//=FullSimplify];*)

	PseudoInverseMatrix=(ConjugateTranspose@Similarity).PseudoInverseMatrix;
	(*Assuming[xAct`PSALTer`Def>0,PseudoInverseMatrix//=FullSimplify];*)

	(*PseudoInverseMatrix=Inverse[(ConjugateTranspose@TheInputMatrix).TheInputMatrix+(ConjugateTranspose@CompensatorMatrix).CompensatorMatrix].(ConjugateTranspose@TheInputMatrix);*)
(*
	PseudoInverseMatrix=Inverse[(ConjugateTranspose@TheInputMatrix).TheInputMatrix+(ConjugateTranspose@CompensatorMatrix).CompensatorMatrix].(ConjugateTranspose@TheInputMatrix);
*)
PseudoInverseMatrix];

GradualExpand[Expr_,SetOfRules_]:=Module[{ExpandedExpr=Expr,PrintVariable},
	(PrintVariable=PrintTemporary["Attempting to substitute and expand with ",#];
	ExpandedExpr=Expand@(ExpandedExpr/.#);
	NotebookDelete@PrintVariable)&/@Table[Take[SetOfRules,i],{i,Length@SetOfRules}];
ExpandedExpr];

UnmakeSymbolicElement[SymbolicRules_,MatrixElementFileName_]:=Module[{
	ReduceFirstIntermediateSymbols,
	FirstIntermediateSymbolsToSecondIntermediateSymbols,
	SecondIntermediateSymbolsToCouplingConstants,
	FullElement,
	ReducedNumerator,
	ReducedDenominator,
	PrintingVariable
	},

	Get@MatrixElementFileName;

	FullElement=ToExpression@"MatrixElement";

	If[!(FullElement===0),
	
	{ReduceFirstIntermediateSymbols,FirstIntermediateSymbolsToSecondIntermediateSymbols,SecondIntermediateSymbolsToCouplingConstants}=SymbolicRules;

	(Print@#)&@"Now attempting to simplify a single element of the inverse...";
	PrintingVariable=PrintTemporary@"Collecting element...";
	FullElement//=Together;
	NotebookDelete@PrintingVariable;
	PrintingVariable=PrintTemporary@"Extracting numerator...";
	ReducedNumerator=Numerator@FullElement;
	NotebookDelete@PrintingVariable;
	PrintingVariable=PrintTemporary@"Expanding numerator...";
	ReducedNumerator//=Expand;
	NotebookDelete@PrintingVariable;
	PrintingVariable=PrintTemporary@"Expanding and refining numerator";
	ReducedNumerator=GradualExpand[ReducedNumerator,ReduceFirstIntermediateSymbols];
	ReducedNumerator=GradualExpand[ReducedNumerator,FirstIntermediateSymbolsToSecondIntermediateSymbols];
	ReducedNumerator=GradualExpand[ReducedNumerator,SecondIntermediateSymbolsToCouplingConstants];
	NotebookDelete@PrintingVariable;
	PrintingVariable=PrintTemporary@"Attempting FullSimplify on numerator...";
	ReducedNumerator//=FullSimplify;
	(Print@#)&@ReducedNumerator;
	NotebookDelete@PrintingVariable;

	PrintingVariable=PrintTemporary@"Extracting denominator...";
	ReducedDenominator=Denominator@FullElement;
	NotebookDelete@PrintingVariable;
	PrintingVariable=PrintTemporary@"Expanding denominator...";
	ReducedDenominator//=Expand;
	NotebookDelete@PrintingVariable;
	PrintingVariable=PrintTemporary@"Expanding and refining denominator";
	ReducedDenominator=GradualExpand[ReducedDenominator,ReduceFirstIntermediateSymbols];
	ReducedDenominator=GradualExpand[ReducedDenominator,FirstIntermediateSymbolsToSecondIntermediateSymbols];
	ReducedDenominator=GradualExpand[ReducedDenominator,SecondIntermediateSymbolsToCouplingConstants];
	NotebookDelete@PrintingVariable;
	PrintingVariable=PrintTemporary@"Attempting FullSimplify on denominator...";
	ReducedDenominator//=FullSimplify;
	(Print@#)&@ReducedDenominator;
	NotebookDelete@PrintingVariable;

	FullElement=ReducedNumerator/ReducedDenominator;
	FullElement//=FullSimplify;
	];
FullElement];
DistributeDefinitions[UnmakeSymbolicElement];

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

	Quiet[
	  CreateDirectory[FileNameJoin@{NotebookDirectory[],"tmp"}]
	, CreateDirectory::filex
	];

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

	(Print@#)&@MatrixForm@MatrixElementFileNames;

	CombinedRules={ReduceFirstIntermediateSymbols,FirstIntermediateSymbolsToSecondIntermediateSymbols,SecondIntermediateSymbolsToCouplingConstants};

	InverseMatrix=MapThread[(xAct`PSALTer`Private`PSALTerParallelSubmit@(UnmakeSymbolicElement[#1,#2]))&,{Map[(CombinedRules)&,MatrixElementFileNames,{2}],MatrixElementFileNames},2];

	(Print@#)&@InverseMatrix;
	InverseMatrix=WaitAll@InverseMatrix;
InverseMatrix];

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

	(Print@#)&@(MatrixForm@InputMatrix);
(**)
	TheInputMatrix=TheInputMatrix/.{xAct`PSALTer`MetricAffineGaugeTheory`A1->0,xAct`PSALTer`MetricAffineGaugeTheory`A2->0,xAct`PSALTer`MetricAffineGaugeTheory`A3->0,xAct`PSALTer`MetricAffineGaugeTheory`A4->0,xAct`PSALTer`MetricAffineGaugeTheory`A5->0,xAct`PSALTer`MetricAffineGaugeTheory`A6->0,xAct`PSALTer`MetricAffineGaugeTheory`A7->0,xAct`PSALTer`MetricAffineGaugeTheory`A8->0,xAct`PSALTer`MetricAffineGaugeTheory`A9->0,xAct`PSALTer`MetricAffineGaugeTheory`A10->0,xAct`PSALTer`MetricAffineGaugeTheory`A11->0};
(**)
(*
	TheInputMatrix=TheInputMatrix/.{xAct`PSALTer`MetricAffineGaugeTheory`A1->0,xAct`PSALTer`MetricAffineGaugeTheory`A2->0,xAct`PSALTer`MetricAffineGaugeTheory`A3->0,xAct`PSALTer`MetricAffineGaugeTheory`A4->0,xAct`PSALTer`MetricAffineGaugeTheory`A5->0,xAct`PSALTer`MetricAffineGaugeTheory`A6->0,xAct`PSALTer`MetricAffineGaugeTheory`A7->0,xAct`PSALTer`MetricAffineGaugeTheory`A8->0,xAct`PSALTer`MetricAffineGaugeTheory`A9->0,xAct`PSALTer`MetricAffineGaugeTheory`A10->0,xAct`PSALTer`MetricAffineGaugeTheory`A11->0,xAct`PSALTer`MetricAffineGaugeTheory`C11->0,xAct`PSALTer`MetricAffineGaugeTheory`C12->0,xAct`PSALTer`MetricAffineGaugeTheory`C13->0,xAct`PSALTer`MetricAffineGaugeTheory`C14->0,xAct`PSALTer`MetricAffineGaugeTheory`C15->0,xAct`PSALTer`MetricAffineGaugeTheory`C16->0};
*)
(*
	TheInputMatrix=TheInputMatrix/.{xAct`PSALTer`MetricAffineGaugeTheory`A1->0,xAct`PSALTer`MetricAffineGaugeTheory`A2->0,xAct`PSALTer`MetricAffineGaugeTheory`A3->0,xAct`PSALTer`MetricAffineGaugeTheory`A4->0,xAct`PSALTer`MetricAffineGaugeTheory`A5->0,xAct`PSALTer`MetricAffineGaugeTheory`A6->0,xAct`PSALTer`MetricAffineGaugeTheory`A7->0,xAct`PSALTer`MetricAffineGaugeTheory`A8->0,xAct`PSALTer`MetricAffineGaugeTheory`A9->0,xAct`PSALTer`MetricAffineGaugeTheory`A10->0,xAct`PSALTer`MetricAffineGaugeTheory`A11->0,xAct`PSALTer`MetricAffineGaugeTheory`C1->0,xAct`PSALTer`MetricAffineGaugeTheory`C2->0,xAct`PSALTer`MetricAffineGaugeTheory`C3->0,xAct`PSALTer`MetricAffineGaugeTheory`C4->0,xAct`PSALTer`MetricAffineGaugeTheory`C5->0,xAct`PSALTer`MetricAffineGaugeTheory`C6->0,xAct`PSALTer`MetricAffineGaugeTheory`C7->0,xAct`PSALTer`MetricAffineGaugeTheory`C8->0,xAct`PSALTer`MetricAffineGaugeTheory`C9->0,xAct`PSALTer`MetricAffineGaugeTheory`C10->0,xAct`PSALTer`MetricAffineGaugeTheory`C11->0,xAct`PSALTer`MetricAffineGaugeTheory`C12->0,xAct`PSALTer`MetricAffineGaugeTheory`C13->0,xAct`PSALTer`MetricAffineGaugeTheory`C14->0,xAct`PSALTer`MetricAffineGaugeTheory`C15->0,xAct`PSALTer`MetricAffineGaugeTheory`C16->0};
*)

	ConjecturedNullSpace=ConjectureNullSpace[TheInputMatrix,Couplings,CouplingAssumptions];
	(Print@#)&@(MatrixForm@ConjecturedNullSpace);
	{SymbolicMatrix,FirstIntermediateSymbolsToCouplingConstants}=MakeSymbolic[TheInputMatrix,CouplingAssumptions];
	(Print@#)&@(MatrixForm@SymbolicMatrix);
	{ReduceFirstIntermediateSymbols,FirstIntermediateSymbolsToSecondIntermediateSymbols,SecondIntermediateSymbolsToCouplingConstants}=IntermediateRules[FirstIntermediateSymbolsToCouplingConstants,Couplings];
	(Print@#)&@ReduceFirstIntermediateSymbols;
	(Print@#)&@FirstIntermediateSymbolsToSecondIntermediateSymbols;
	(Print@#)&@SecondIntermediateSymbolsToCouplingConstants;

	InverseSymbolicMatrix=ManualPseudoInverse[SymbolicMatrix,ConjecturedNullSpace];

	InverseMatrix=UnmakeSymbolic[InverseSymbolicMatrix,ReduceFirstIntermediateSymbols,FirstIntermediateSymbolsToSecondIntermediateSymbols,SecondIntermediateSymbolsToCouplingConstants];	
	InverseMatrix=((#)~FullSimplify~CouplingAssumptions)&@InverseMatrix;
	(Print@#)&@(MatrixForm@InverseMatrix);

InverseMatrix];

InvertedMatrices=ConjectureInverse[#,Couplings,CouplingAssumptions]&/@xAct`PSALTer`Private`AllMatrices[[1;;8]];
DumpSave[FileNameJoin@{NotebookDirectory[],"InvertedMatrices.mx"},InvertedMatrices];
