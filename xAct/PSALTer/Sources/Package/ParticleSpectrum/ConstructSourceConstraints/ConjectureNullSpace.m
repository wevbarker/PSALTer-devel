(*=======================*)
(*  ConjectureNullSpace  *)
(*=======================*)

BuildPackage@"ParticleSpectrum/ConstructSourceConstraints/ConjectureNullSpace/CommonNullVector.m";

ConjectureNullSpace[InputMatrix_,Couplings_,CouplingAssumptions_]:=Module[{	
	ProcessedMatrix=InputMatrix,
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

(*
ClearAll[CreateList];
SetAttributes[CreateList,HoldAll];
CreateList[Plus[a__]]:={a};
CreateList[a_?AtomQ]:={a};
CreateList[a_]:=a;

RemoveReferencesToMomentum[InputMatrix_,Couplings_]:=Module[{
	FieldRescaledMatrix=InputMatrix,
	ConstantRescalingPowers,
	ConstantRescalingRules,
	ConstantDescalingRules,
	FieldRescalingPowers,
	FieldRescalingMatrix,
	FieldDescalingMatrix,
	ScalingSolutions,
	UnsolvedScalingSolutions
	},

	ConstantRescalingPowers=Table[ToExpression@("ConstantRescalingPower"<>ToString@ii),{ii,Length@Couplings}];
	ConstantRescalingRules=MapThread[(#1->#1*xAct`PSALTer`Def^#2)&,{Couplings,ConstantRescalingPowers}];
	ConstantDescalingRules=MapThread[(#1->#1*xAct`PSALTer`Def^-#2)&,{Couplings,ConstantRescalingPowers}];

	FieldRescalingPowers=Table[ToExpression@("FieldRescalingPower"<>ToString@ii),{ii,Length@InputMatrix}];
	FieldRescalingMatrix=DiagonalMatrix@((xAct`PSALTer`Def^#)&/@FieldRescalingPowers);
	FieldDescalingMatrix=DiagonalMatrix@((xAct`PSALTer`Def^-#)&/@FieldRescalingPowers);

	FieldRescaledMatrix=FieldRescalingMatrix.FieldRescaledMatrix.FieldRescalingMatrix/.ConstantRescalingRules;

	ScalingSolutions=Flatten@FieldRescaledMatrix;
	ScalingSolutions//=(PowerExpand/@#)&;
	ScalingSolutions//=(Expand[#,xAct`PSALTer`Def]&/@#)&;
	ScalingSolutions//=(CreateList/@#)&;
	ScalingSolutions//=Flatten;
	ScalingSolutions//=(((PowerExpand@Log@#)~Coefficient~Log@xAct`PSALTer`Def)&/@#)&;
	ScalingSolutions//=Flatten;
	ScalingSolutions//=((#==0)&/@#)&;
	ScalingSolutions//=DeleteDuplicates;
	ScalingSolutions//=(#~DeleteElements~True)&;
	ScalingSolutions//=(First@Quiet@Solve[#,ConstantRescalingPowers~Join~FieldRescalingPowers])&;

	UnsolvedScalingSolutions=DeleteDuplicates@Flatten@(Variables/@((ConstantRescalingPowers~Join~FieldRescalingPowers)/.ScalingSolutions));
	UnsolvedScalingSolutions//=((#->-(2*3*5*7*11)^10)&/@#)&;
	ScalingSolutions//=(#/.UnsolvedScalingSolutions)&;
	ScalingSolutions//=FullSimplify;
	ScalingSolutions//=(#~Join~UnsolvedScalingSolutions)&;

	FieldRescaledMatrix=FieldRescaledMatrix/.ScalingSolutions;
	FieldRescaledMatrix//=PowerExpand;
	FieldRescaledMatrix//=FullSimplify;

{FieldRescaledMatrix,ConstantDescalingRules,FieldRescalingMatrix,ScalingSolutions}];

CleanNullVector[NullVector_,CouplingAssumptions_]:=Module[{
	Expr=NullVector,
	SimpleNorm},
	
	SimpleNorm=Assuming[CouplingAssumptions,FullSimplify@Sqrt@PowerExpand@((Norm@NullVector)^2)];
	HighestPower=CouplingAssumptions~Assuming~Exponent[SimpleNorm,xAct`PSALTer`Def,Max];
	LowestPower=CouplingAssumptions~Assuming~Exponent[SimpleNorm,xAct`PSALTer`Def,Min];
	If[Abs@HighestPower>=Abs@LowestPower,
		CouplingAssumptions~Assuming~(Expr/=xAct`PSALTer`Def^HighestPower);
	,
		CouplingAssumptions~Assuming~(Expr/=xAct`PSALTer`Def^LowestPower);
	];
	CouplingAssumptions~Assuming~(Expr//=FullSimplify);
Expr];

ConjectureNullSpace[InputMatrix_,Couplings_,CouplingAssumptions_]:=Module[{	
	(*ProcessedMatrix=InputMatrix,
	MinimalExampleCaseRules,
	MinimalExampleCaseNullSpaces,
	AllNullVectors*)
	FieldRescaledMatrix,
	ConstantDescalingRules,
	FieldRescalingMatrix,
	ScalingSolutions,
	RescaledNullSpace,
	DescaledNullSpace
	},

	{FieldRescaledMatrix,
	ConstantDescalingRules,
	FieldRescalingMatrix,
	ScalingSolutions}=RemoveReferencesToMomentum[InputMatrix,Couplings];

	RescaledNullSpace=NullSpace@FieldRescaledMatrix;

	Print@"Show it works when simplified";
	Print@MatrixForm@FieldRescaledMatrix;
	(Print@MatrixForm@#)&/@RescaledNullSpace;
	If[!(RescaledNullSpace=={}),
		(Print@MatrixForm@((FieldRescaledMatrix).(#)))&/@RescaledNullSpace;
	];

	DescaledNullSpace=((FieldRescalingMatrix.#)/.ConstantDescalingRules/.ScalingSolutions)&/@RescaledNullSpace;
	CouplingAssumptions~Assuming~(DescaledNullSpace//=FullSimplify);
	DescaledNullSpace//=(CleanNullVector[#,CouplingAssumptions]&/@#)&;
	
	Print@"Show it works fully";
	Print@MatrixForm@InputMatrix;
	(Print@MatrixForm@#)&/@DescaledNullSpace;
	If[!(DescaledNullSpace=={}),
		(Print@MatrixForm@((InputMatrix).(#)))&/@DescaledNullSpace;
	];

(*
	MinimalExampleCaseRules=Table[(#->0)&/@Drop[Couplings,{i}],{i,Length@Couplings}];
	MinimalExampleCaseNullSpaces=Module[{MinimalExampleCaseNullSpace},
		Assuming[CouplingAssumptions,MinimalExampleCaseNullSpace=NullSpace[InputMatrix/.#]];
		Assuming[CouplingAssumptions,MinimalExampleCaseNullSpace//=Simplify];
	MinimalExampleCaseNullSpace]&/@MinimalExampleCaseRules;
	AllNullVectors=Join@@MinimalExampleCaseNullSpaces;
	AllNullVectors//=DeleteDuplicates;
	ConjecturedNullSpace=AllNullVectors~Select~(CommonNullVector[#,MinimalExampleCaseNullSpaces]&);
*)
DescaledNullSpace];
*)
