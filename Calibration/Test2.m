(*=========*)
(*  Test2  *)
(*=========*)

Print/@(MatrixForm/@xAct`PSALTer`Private`AllMatrices);

Print@"The aim here is to try some symbolic equivalent of the matrices";

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

ManualPseudoInverse[TheInputMatrix_List?MatrixQ/;Precision[TheInputMatrix]===Infinity,TheConjecturedNullSpace_]:=Module[{
	CompensatorMatrix=TheConjecturedNullSpace,
	PseudoInverseMatrix},
	CompensatorMatrix=If[CompensatorMatrix==={},{Table[0,{Length[First[TheInputMatrix]]}]},CompensatorMatrix];
	PseudoInverseMatrix=Inverse[(Transpose@TheInputMatrix).TheInputMatrix+(Transpose@CompensatorMatrix).CompensatorMatrix].(Transpose@TheInputMatrix);
PseudoInverseMatrix];

UnmakeSymbolicElement[SymbolicElement_,SymbolicRules_]:=Module[{FullElement=SymbolicElement},
	(*(FullElement=Simplify@(FullElement/.#))&@SymbolicRules;*)
	(FullElement=Simplify@(FullElement/.#))&/@Table[Take[SymbolicRules,i],{i,Length@SymbolicRules}];
	(*(FullElement=FullSimplify@(FullElement/.#))&/@Table[Take[SymbolicRules,i],{i,Length@SymbolicRules}];*)
FullElement];

	ConstraintComponentList=(xAct`PSALTer`Private`PSALTerParallelSubmit@(ConstraintComponentToLightcone[ClassName,#]))&/@ConstraintComponentList;

UnmakeSymbolic[InverseSymbolicMatrix_,SymbolicRules_]:=Module[{InverseMatrix},	
	InverseMatrix=MapThread[
			(xAct`PSALTer`Private`PSALTerParallelSubmit@(UnmakeSymbolicElement[#1,#2]))&,
				{InverseSymbolicMatrix,
				Map[(SymbolicRules)&,InverseSymbolicMatrix,{2}]},
			2];
	Print@InverseMatrix;
	InverseMatrix=WaitAll@InverseMatrix;
InverseMatrix];

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

ConjectureInverse[#,Couplings,CouplingAssumptions]&/@xAct`PSALTer`Private`AllMatrices;
(*ConjectureInverse[#,Couplings,CouplingAssumptions]&/@xAct`PSALTer`Private`AllMatrices[[5;;8]];*)
