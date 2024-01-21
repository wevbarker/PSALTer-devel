(*=======================*)
(*  ConjectureNullSpace  *)
(*=======================*)

BuildPackage@"ParticleSpectrum/ConstructSourceConstraints/ConjectureNullSpace/CommonNullVector.m";

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
	ScalingSolutions//=(#~DeleteElements~{True})&;
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
	MinimumPower},

	MinimumPower=NullVector;
	MinimumPower//=Assuming[CouplingAssumptions,(Exponent[#,xAct`PSALTer`Def,Min])&/@#]&;
	MinimumPower//=Assuming[CouplingAssumptions,Cases[#,_?NumericQ]]&;
	MinimumPower//=Assuming[CouplingAssumptions,Min@#]&;
	Expr/=xAct`PSALTer`Def^MinimumPower;
	CouplingAssumptions~Assuming~(Expr//=FullSimplify);
Expr];

EnsureLinearInCouplings[NullVector_]:=Module[{
	Expr=NullVector,
	LinearNullVector=NullVector},

	Expr=Together/@Expr;	
	Expr=Denominator/@Expr;
	Expr=Times@@Expr;	
	LinearNullVector*=Expr;
	LinearNullVector//=FullSimplify;
LinearNullVector];

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

	DescaledNullSpace=((FieldRescalingMatrix.#)/.ConstantDescalingRules/.ScalingSolutions)&/@RescaledNullSpace;
	CouplingAssumptions~Assuming~(DescaledNullSpace//=FullSimplify);
	DescaledNullSpace//=(CleanNullVector[#,CouplingAssumptions]&/@#)&;
	DescaledNullSpace=EnsureLinearInCouplings/@DescaledNullSpace;

DescaledNullSpace];
