(*=========*)
(*  Test2  *)
(*=========*)

Print/@(MatrixForm/@xAct`PSALTer`Private`AllMatrices);

Print@"The aim here is to try some symbolic equivalent of the matrices";
(*
NewMatrices=Map[(If[PossibleZeroQ@#,0,a])&,#,{2}]&/@xAct`PSALTer`Private`AllMatrices;
*)

MakeSymbolic[InputMatrix_]:=Module[{
	DimensionOfMatrix,
	SymbolicMatrix,
	CouplingAssumptions,
	Couplings,
	SymbolicRules,
myPseudoInverse
	},

	Couplings={xAct`PSALTer`MetricAffineGaugeTheory`A0,xAct`PSALTer`MetricAffineGaugeTheory`A1,xAct`PSALTer`MetricAffineGaugeTheory`A2,xAct`PSALTer`MetricAffineGaugeTheory`A3,xAct`PSALTer`MetricAffineGaugeTheory`A4,xAct`PSALTer`MetricAffineGaugeTheory`A5,xAct`PSALTer`MetricAffineGaugeTheory`A6,xAct`PSALTer`MetricAffineGaugeTheory`A7,xAct`PSALTer`MetricAffineGaugeTheory`A8,xAct`PSALTer`MetricAffineGaugeTheory`A9,xAct`PSALTer`MetricAffineGaugeTheory`A10,xAct`PSALTer`MetricAffineGaugeTheory`A11,xAct`PSALTer`MetricAffineGaugeTheory`C1,xAct`PSALTer`MetricAffineGaugeTheory`C2,xAct`PSALTer`MetricAffineGaugeTheory`C3,xAct`PSALTer`MetricAffineGaugeTheory`C4,xAct`PSALTer`MetricAffineGaugeTheory`C5,xAct`PSALTer`MetricAffineGaugeTheory`C6,xAct`PSALTer`MetricAffineGaugeTheory`C7,xAct`PSALTer`MetricAffineGaugeTheory`C8,xAct`PSALTer`MetricAffineGaugeTheory`C9,xAct`PSALTer`MetricAffineGaugeTheory`C10,xAct`PSALTer`MetricAffineGaugeTheory`C11,xAct`PSALTer`MetricAffineGaugeTheory`C12,xAct`PSALTer`MetricAffineGaugeTheory`C13,xAct`PSALTer`MetricAffineGaugeTheory`C14,xAct`PSALTer`MetricAffineGaugeTheory`C15,xAct`PSALTer`MetricAffineGaugeTheory`C16};
	CouplingAssumptions=(#~Element~Reals)&/@Couplings;
	CouplingAssumptions~AppendTo~(xAct`PSALTer`Def~Element~Reals);

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
	(*SymbolicMatrix=SymbolicMatrix/.{I->1};*)
	Print@MatrixForm@SymbolicMatrix;

	Print@MatrixForm@InputMatrix;

(*
	Couplings2={xAct`PSALTer`MetricAffineGaugeTheory`A4,xAct`PSALTer`MetricAffineGaugeTheory`A5,xAct`PSALTer`MetricAffineGaugeTheory`A9};
*)

(*
MinimalExampleCaseRules,
MinimalExampleCaseNullSpaces,
AllNullVectors,
*)

	MinimalExampleCaseRules=Table[(#->0)&/@Drop[Couplings,{i}],{i,Length@Couplings}];
	MinimalExampleCaseNullSpaces=Module[{MinimalExampleCaseNullSpace},
		Assuming[CouplingAssumptions,MinimalExampleCaseNullSpace=NullSpace[InputMatrix/.#]];
		Assuming[CouplingAssumptions,MinimalExampleCaseNullSpace//=Simplify];
	MinimalExampleCaseNullSpace]&/@MinimalExampleCaseRules;
	(*MinimalExampleCaseNullSpaces=MinimalExampleCaseNullSpaces/.{xAct`PSALTer`Def->Pi};*)
	AllNullVectors=Join@@MinimalExampleCaseNullSpaces;
	AllNullVectors//=DeleteDuplicates;
	Print@"All null vectors";
	Print@MatrixForm@AllNullVectors;
	
	IsNullVectorOfSpace[NullVector_,MinimalExampleCaseNullSpace_]:=Module[{LinearIndependence},
		LinearIndependence=ResourceFunction["LinearlyIndependent"]@(MinimalExampleCaseNullSpace~Join~{NullVector});
	(!LinearIndependence)];

	CommonNullVector[NullVector_]:=Module[{IsNullVectorOfExampleCaseNullSpaces},
		IsNullVectorOfExampleCaseNullSpaces=IsNullVectorOfSpace[NullVector,#]&/@MinimalExampleCaseNullSpaces;
	And@@IsNullVectorOfExampleCaseNullSpaces];
		
	ConjecturedNullSpace=Select[AllNullVectors,CommonNullVector];

	Print@"Conjectured null space";
	Print@MatrixForm@ConjecturedNullSpace;

(*
	Assuming[CouplingAssumptions,sample=NullSpace[InputMatrix/.ShrinkRules,Method->"DivisionFreeRowReduction"]];
	Print@"obtained space";
*)
(*
	sample=Module[{nexpr},Assuming[CouplingAssumptions,nexpr=#;
		Print@nexpr;
		nexpr=List@@nexpr;
		(Print@"new term";Print@#;Print@"resolved";Print@Simplify@#)&/@nexpr;
		]]&/@Flatten@sample;
	Print@sample;
	Print@Simplify@sample;
*)

	Print@"Now moving on to inverseion procedure...";

	ManualPseudoInverse[TheInputMatrix_List?MatrixQ/;Precision[TheInputMatrix]===Infinity,TheConjecturedNullSpace_]:=Module[{CompensatorMatrix=ConjecturedNullSpace,PseudoInverseMatrix},
	CompensatorMatrix=If[CompensatorMatrix==={},{Table[0,{Length[First[TheInputMatrix]]}]},CompensatorMatrix];
	PseudoInverseMatrix=Inverse[(Transpose@TheInputMatrix).TheInputMatrix+(Transpose@CompensatorMatrix).CompensatorMatrix].(Transpose@TheInputMatrix);
	PseudoInverseMatrix];
(*
	Print@MatrixForm@SymbolicMatrix;
	ClippedMatrix=Drop[Drop[#,3]&/@SymbolicMatrix,3];
	Print@MatrixForm@ClippedMatrix;
	ClippedNullSpace={Drop[First@ConjecturedNullSpace,3]};
*)
(**)
	Print@ManualPseudoInverse[InputMatrix,ConjecturedNullSpace];
(**)
	SymbolicMatrix];

NewMatrices=MakeSymbolic/@xAct`PSALTer`Private`AllMatrices;
(*NewMatrices=MakeSymbolic@xAct`PSALTer`Private`AllMatrices[[4]];*)


