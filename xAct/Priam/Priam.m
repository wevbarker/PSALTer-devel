(*============*)
(*  GeoHiGGS  *)
(*============*)

(*------------------------------*)
(*  Change version number here  *)
(*------------------------------*)

(*
xAct`PSALTer`$Version={"1.0.0",{2022,11,4}};
*)
xAct`PSALTer`$Version={"1.0.0-developer",DateList@FileDate@$InputFileName~Drop~(-3)};

If[Unevaluated[xAct`xCore`Private`$LastPackage]===xAct`xCore`Private`$LastPackage,xAct`xCore`Private`$LastPackage="xAct`PSALTer`"];

(* here is an error-killing line, I can't quite remember why we needed it! *)
Off@(Solve::fulldim);

(*=================*)
(*  xAct`PSALTer`  *)
(*=================*)

BeginPackage["xAct`PSALTer`",{"xAct`xTensor`","xAct`xPerm`","xAct`xCore`","xAct`xTras`","xAct`HiGGS`","xAct`FieldsX`"}];

$PSALTerInstallDirectory=Select[FileNameJoin[{#,"xAct/PSALTer"}]&/@$Path,DirectoryQ][[1]];

(*--------------*)
(*  Disclaimer  *)
(*--------------*)

If[xAct`xCore`Private`$LastPackage==="xAct`PSALTer`",
Unset[xAct`xCore`Private`$LastPackage];
Print[xAct`xCore`Private`bars];
Print["These packages come with ABSOLUTELY NO WARRANTY; for details type Disclaimer[]. This is free software, and you are welcome to redistribute it under certain conditions. See the General Public License for details."];
Print[xAct`xCore`Private`bars]];

(*--------------------------------------------------------------*)
(*  Declaration of provided functions and symbols for PSALTer   *)
(*--------------------------------------------------------------*)

BuildPriam::usage="BuildPriam[] introduces a few new definitions.";
FourierLagrangian::usage="FourierLagrangian[Expr,Tensor1,Tensor2,...] transfers a scalar expression Expr which is quadratic in the given perturbed fields whose xTensor heads are Tensor1 and Tensor2 into its Fourier form. 
Both Expr and at least one field must be provided. Do not include indices in the fields, just list the xTensor heads (i.e. the tensor names).";
SaturateMe::usage="SaturateMe[Expr] produces the saturated propagator from the Lagrangian Expr, which must be a scalar of the form output by FourierLagrangian[].";
YunCherngLin::usage="YunCherngLin[Expr,Tensor1,Tensor2,...] performs the whole propagator analysis on a scalar Lagrangian Expr, which is quadratic in the given perturbed fields whose xTensor heads are Tensor1 and Tensor2 into its Fourier form. 
Both Expr and at least one field must be provided. Do not include indices in the fields, just list the xTensor heads (i.e. the tensor names). If these names do not correspond to gauge field perturbations that are already known to Priam, an error will be thrown."


BuildLightcone::usage="BuildLightcone is a boolean option for BuildPriam, which determines whether the lightcone coordinates are constructed using xCoba. Default is True.";
Even::usage="Even is an association key which refers to even-parity spin states.";
Odd::usage="Odd is an association key which refers to odd-parity spin states.";


(* ::Code::Initialization:: *)
$PriamBuilt::usage="$PriamBuilt is a global variable which tells us whether the Priam package environment is ready to use.";


(* ::Code::Initialization:: *)
Begin["xAct`Priam`Private`"];


$PriamBuilt=False;
BuildPriam::unbuilt="The HiGGS environment has not been built: you can build it by running BuildHiGGS[].";
Options@BuildPriam={BuildLightcone->True};
BuildPriam::built="The Priam environment has already been built.";
BuildPriam[OptionsPattern[]]:=Catch@Module[{PriorMemory,UsedMemory},
(*A message*)
xAct`xTensor`Private`MakeDefInfo[BuildPriam,$KernelID,{"Priam environment for kernel",""}];
(*Check for pre-existing build*)
If[xAct`HiGGS`Private`$HiGGSBuilt,Null,Throw@Message[BuildPriam::unbuilt],Throw@Message[BuildPriam::unbuilt]];
If[$PriamBuilt,Throw@Message[BuildPriam::built]];
(*List of all print cells in front end before this notebook starts to run*)
$PrintCellsBeforeStartBuildPriam=Flatten@Cells[SelectedNotebook[],CellStyle->{"Print"}];
Print[" ** BuildPriam: Building session from ",FileNameJoin@{$PriamInstallDirectory,"Priam_sources.nb"}];
Get[FileNameJoin@{$PriamInstallDirectory,"Priam_sources.m"}];
If[OptionValue@BuildLightcone,
Get[FileNameJoin@{$PriamInstallDirectory,"Priam_lightcone.m"}];
];
(*Purge all cells created during build process*)
Pause[2];
NotebookDelete@(Flatten@Cells[SelectedNotebook[],CellStyle->{"Print"}]~Complement~$PrintCellsBeforeStartBuildPriam);
Print[" ** BuildPriam: If build was successful, the Priam environment is now ready to use."];
$PriamBuilt=True;
];


FourierLagrangian[Expr_,Tensors__]:=Catch@Module[{CrossingRules,ToMomentumExpr,Tensors1,Tensors2,printer},
printer={};
printer=printer~Append~PrintTemporary@" ** FourierLagrangian...";
Tensors1=(#@@(ToExpression/@Alphabet[][[1;;(Length@SlotsOfTensor@#)]]))&/@(List@Tensors);
Tensors2=(#@@(ToExpression/@Alphabet[][[-(Length@SlotsOfTensor@#);;-1]]))&/@(List@Tensors);
CrossingRules={};(*start off without any rules*)
(*first the double derivatives*)
Table[(CrossingRules=CrossingRules~Join~
MakeRule[{Evaluate[Global`CD[-Global`q]@Tensor1 Global`CD[-Global`p]@Tensor2],Evaluate[Dagger@Tensor1 Global`P[-Global`p]Global`P[-Global`q]Tensor2]},MetricOn->All,ContractMetrics->True]),
{Tensor1,Tensors1},{Tensor2,Tensors2}];
(*then single derivatives*)
Table[(CrossingRules=CrossingRules~Join~
MakeRule[{Evaluate[Tensor1 Global`CD[-Global`p]@Tensor2],Evaluate[-I Dagger@Tensor1 Global`P[-Global`p]Tensor2]},MetricOn->All,ContractMetrics->True]),
{Tensor1,Tensors1},{Tensor2,Tensors2}];
(*and finally algebraic products*)
Table[(CrossingRules=CrossingRules~Join~
MakeRule[{Evaluate[Tensor1 Tensor2],Evaluate[Dagger@Tensor1 Tensor2]},MetricOn->All,ContractMetrics->True]),
{Tensor1,Tensors1},{Tensor2,Tensors2}];
ToMomentumExpr=Expr/.CrossingRules;(*now impose these rules to obtain Fourier space version*)
ToMomentumExpr=ToMomentumExpr//ToNewCanonical;
printer=printer~Append~PrintTemporary@ToMomentumExpr;
(*now move over to SO(3) decomposition*)
ToMomentumExpr=ToMomentumExpr/.Global`ToV;
ToMomentumExpr=ToMomentumExpr//ToNewCanonical;
ToMomentumExpr=ToMomentumExpr/.Global`GaugeDecompose//ToNewCanonical;
ToMomentumExpr=ToMomentumExpr/.Global`GaugePToGaugePO3/.Global`GaugePerpToGaugePO3//ToNewCanonical;
ToMomentumExpr=ToMomentumExpr//CollectTensors;
ToMomentumExpr=ToMomentumExpr/.Global`Patch2m;
ToMomentumExpr=ToMomentumExpr/.Global`ManualAll;
ToMomentumExpr=ToMomentumExpr/.Global`ManualAll;
ToMomentumExpr=ToMomentumExpr//ToNewCanonical;
ToMomentumExpr=ToMomentumExpr//CollectTensors;

Print@" ** FourierLagrangian: Lagrangian in Fourier space, decomposed among the SO(3) irreducible representations of the fields:";
Print["\!\(\*SuperscriptBox[OverscriptBox[\(\[Zeta]\), \(^\)], \(\[Dagger]\)]\)(\[ScriptK])\[CenterDot]\!\(\*OverscriptBox[\(\[ScriptCapitalO]\), \(^\)]\)(\[ScriptK])\[CenterDot]\!\(\*OverscriptBox[\(\[Zeta]\), \(^\)]\)(\[ScriptK]) = ",ToMomentumExpr];

NotebookDelete@printer;
ToMomentumExpr];


SaturateMe[Expr_]:=Catch@Module[{SymbolicLagrangian,Symbols,MatrixLagrangian,ImaginaryParts,RealParts,NullSpaces,SourceConstraints,MatrixPropagator,SaturatedPropagator,printer},
printer={};
printer=printer~Append~PrintTemporary@" ** SaturateMe...";

(*coefficient matrices*)
SymbolicLagrangian=Expr/.Global`cRules;(*remember the 2m mode turns out to vanish once you consider the cyclic identitiy on the indices!*)
Symbols=(#~Join~((Evaluate@Dagger[#])&/@#))&/@{Global`c0p,Global`c0m,Global`c1p,Global`c1m,Global`c2p,Global`c2m};(*lists of all the symbolic projected tensors*)
(*now transfer the Lagrangian to coefficient matrix form, accommodating for zero and dimension-one matrices*)
MatrixLagrangian=If[SparseArrayQ@Last@CoefficientArrays[SymbolicLagrangian,#,"Symmetric"->False],
Last@CoefficientArrays[SymbolicLagrangian,#,"Symmetric"->False],
SparseArray@ConstantArray[0,{Length@#,Length@#}]]&/@Symbols;
(*pick out the blocks of the coefficient arrays that are nonzero*)
MatrixLagrangian=#[[1;;(1/2)Length@#,(1/2)Length@#+1;;Length@#]]&/@MatrixLagrangian;
Print@" ** SaturateMe: Lagrangian as coefficient matrices for the HiGGS SO(3) decomposition of the gauge fields:";
Print@(MatrixForm/@MatrixLagrangian);

(*Hermitian versions of matrices*)
ImaginaryParts=Map[If[(MemberQ[Flatten@(Arg@#&/@FactorList[#]),Pi/2]||MemberQ[Flatten@(Arg@#&/@FactorList[#]),-Pi/2]),#,0]&,MatrixLagrangian,{3}];
RealParts=MatrixLagrangian-ImaginaryParts;
MatrixLagrangian=Simplify/@((1/2)(RealParts+Transpose/@RealParts)+(1/2)(ImaginaryParts-Transpose/@ImaginaryParts));
Print@" ** SaturateMe: Hermitian equivalent of these coefficient matrices:";
Print@(MatrixForm/@MatrixLagrangian);

(*rescaled versions of matrices*)
MatrixLagrangian=MapThread[MapThread[#1 #2&,{#1,#2}]&,{MatrixLagrangian,Global`rescmat}]/.Global`rescsols;
Print@" ** SaturateMe: SPO-rescaled equivalent of these coefficient matrices:";
Print@(MatrixForm/@MatrixLagrangian);

(*null spaces*)
NullSpaces=NullSpace@Transpose[#]&/@MatrixLagrangian;
Print@" ** SaturateMe: Null spaces of these coefficient matrices:";
Print@NullSpaces;

(*source constraints*)
SourceConstraints=Quiet@DeleteCases[Flatten@MapThread[#1 . #2&,{If[#=={},{0},#,#]&/@NullSpaces,MapThread[MapThread[(#2/#1)&,{#1,#2}]&,{{Global`r0p,Global`r0m,Global`r1p,Global`r1m,Global`r2p,Global`r2m},Global`Ups}]}],0,Infinity]/.Global`rescsols;
SourceConstraints=Numerator@Together[#/Sqrt[2^5*3^5*5^5*7^5]]&/@SourceConstraints;
Print@" ** SaturateMe: Corresponding source constraints:";
Print[#," = 0"]&/@SourceConstraints;

(*matrix form of the propagator*)
MatrixPropagator=FullSimplify@ComplexExpand@DrazinInverse[#]&/@MatrixLagrangian;
Print@" ** SaturateMe: Matrix propagator as the Drazin (Moore-Penrose) inverse of the Hermition, SPO-rescaled matrix Lagrangian:";
Print@(MatrixForm/@MatrixPropagator);

(*saturated form of the propagator*)
MatrixPropagator=MapThread[MapThread[#1 #2&,{#1,#2}]&,{MatrixPropagator,Global`invrescmat}]/.Global`rescsols;(*descale the propagator ready for multiplication by sources*)
SaturatedPropagator=MapThread[#1 . #2 . #3&,{Dagger/@Global`Ups,MatrixPropagator,Global`Downs}];
SaturatedPropagator=ToNewCanonical/@SaturatedPropagator;
SaturatedPropagator=CollectTensors/@SaturatedPropagator;
Print@" ** SaturateMe: Saturated propagator:";
Print["\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptJ]\), \(^\)], \(\[Dagger]\)]\)(\[ScriptK])\[CenterDot]\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalO]\), \(^\)], \(-1\)]\)(\[ScriptK])\[CenterDot]\!\(\*OverscriptBox[\(\[ScriptJ]\), \(^\)]\)(\[ScriptK]) = ",Evaluate@ToNewCanonical@Total@SaturatedPropagator];

NotebookDelete@printer;
{SourceConstraints,SaturatedPropagator}];


MakeConstraintComponentList[PropagatorConstraints_List,ManualConstraints_List:{}]:=Catch@Module[{AllConstraints,ConstraintComponents},
(*First join up the automatically and manually derived constraints lists*)
AllConstraints=PropagatorConstraints~Join~ManualConstraints;
(*Obtain nested lists of all the Cartesian components of the vanishing constraint functions*)
ConstraintComponents=If[Length@FindFreeIndices@#!=0,xAct`xCoba`ComponentArray[xAct`xCoba`FreeToBasis[Global`cartesian]@#],#]&/@AllConstraints;
(*Flatten them*)
ConstraintComponents=Flatten@ConstraintComponents;
(*Use the symmetries of the SO(3) irreps to "canonicalise" these component expressions via folded rules*)
(ConstraintComponents=ConstraintComponents/.xAct`xCoba`TensorValues@#)&/@{Global`TauP1p,Global`SigmaP1p,Global`SigmaPerp1p,Global`TauP1m,Global`SigmaP1m,Global`TauPerp1m,Global`SigmaPerp1m,Global`TauP2p,Global`SigmaP2p,Global`SigmaP2m};
(*Remove symmetry-vanishing and duplicate entries that the "canonicalisation" reveals*)
ConstraintComponents=ConstraintComponents~DeleteCases~0;
ConstraintComponents=ConstraintComponents//DeleteDuplicates;
ConstraintComponents];


ConstraintComponentToLightcone[ConstraintComponent_]:=Catch@Module[{Constraint},
Constraint=ConstraintComponent/.Global`SourcePO3Activate;
Constraint=Constraint/.Global`SourcePerpO3Activate;
Constraint=Constraint/.Global`PADMPiActivate;
Constraint=Constraint/.Global`PO3PiActivate;
Constraint=Constraint/.Global`PADMActivate;
Constraint=Constraint/.Global`SourceCompose;
Constraint=xAct`xCoba`SeparateBasis[AIndex][Constraint];
Constraint=Constraint//NoScalar;
Constraint=Constraint/.Global`ToP;
Constraint=Constraint/.Global`SourceCompose;
Constraint=xAct`xCoba`SeparateBasis[AIndex][Constraint];
Constraint=Constraint//NoScalar;
Constraint=Constraint/.Global`ToP;
Constraint=Constraint//ToNewCanonical;
Constraint=Constraint//NoScalar;
Constraint=Constraint/.Global`ToV;
Constraint=Constraint//ToNewCanonical;
Constraint=Constraint//NoScalar;
Constraint=Constraint/.Global`ToP;
Constraint=xAct`xCoba`SeparateBasis[AIndex][Constraint];
Constraint=Constraint//NoScalar;
Constraint=Constraint/.Global`ToP;
Constraint=Constraint//NoScalar;
Constraint=xAct`xCoba`SeparateBasis[Global`cartesian][Constraint];
Constraint=Constraint//NoScalar;
Constraint=Constraint/.Global`ToP;
Constraint=Constraint//xAct`xCoba`ContractBasis;
Constraint=Constraint//ScreenDollarIndices;
Constraint=Constraint//NoScalar;
Constraint=SeparateMetric[Global`G][Evaluate@Constraint];
Constraint=xAct`xCoba`SeparateBasis[Global`cartesian][Constraint];
Constraint=Constraint//NoScalar;
Constraint=Constraint//xAct`xCoba`ContractBasis;
Constraint=Constraint//NoScalar;
Constraint=Constraint//xAct`xCoba`TraceBasisDummy;
Constraint=Constraint/.xAct`xCoba`TensorValues[Global`P];
Constraint=Constraint/.xAct`xCoba`TensorValues[Global`G];
Constraint=Constraint/.xAct`xCoba`TensorValues[Global`Tau];
Constraint=Constraint/.xAct`xCoba`TensorValues[Global`Sigma];
Constraint=Constraint/.{Global`Def->Sqrt[Global`En^2-Global`Mo^2]};
Constraint=Constraint/(2*3*5*7*11*Global`En Global`Mo)^10;
Constraint=Constraint//Together;
Constraint=Constraint//Numerator;
Constraint=Constraint//CollectTensors;
Print@Constraint;
Constraint==0];


IndependentComponents[Tensors__]:=Catch@Module[{ComponentsList},
ComponentsList=xAct`xCoba`ComponentArray[xAct`xCoba`FreeToBasis[Global`cartesian]@#]&/@{Tensors};(*make a big nested array of components*)
ComponentsList=Flatten@ComponentsList;(*flatten it*)
ComponentsList=ComponentsList/.xAct`xCoba`TensorValues[Global`Sigma];
ComponentsList=ComponentsList/.xAct`xCoba`TensorValues[Global`Tau];
ComponentsList=ComponentsList~DeleteCases~0; (*get rid of zereos*)
ComponentsList=Sqrt[ComponentsList ComponentsList]//PowerExpand;(*we want to get rid of minus signs*)
ComponentsList=ComponentsList//DeleteDuplicates;(*clearly!*)
ComponentsList];


RescaleNullVector[NullVector_List]:=Catch@Module[{TrialPower,RescaledNullVector,Rescaled,UltravioletNullVector,NullVectorDegreeOfDivergence},
RescaledNullVector=NullVector;
(*First we get rid of infrared and lightcone singularities, i.e. those which are introduced by poles*)
TrialPower=10;(*start with a big power, and try smaller powers for "minimal power needed"*)
Rescaled=False;(*can we stop rescaling?*)
While[TrialPower>0&&!Rescaled,
If[Total@(Abs/@Residue[#,{Global`En,Global`Mo}]&/@Evaluate[(Global`En-Global`Mo)^(TrialPower-1)RescaledNullVector])==0,(*would the rescaled vector be okay yet?*)
Rescaled=False,(*no, it wouldn't*)
RescaledNullVector=((Global`En-Global`Mo)/Global`Mo)^TrialPower RescaledNullVector;Rescaled=True,(*yes, it would*)
RescaledNullVector=((Global`En-Global`Mo)/Global`Mo)^TrialPower RescaledNullVector;Rescaled=True];
TrialPower--];(*okay, try the next power down*)
(*now we get rid of the ultraviolet singularities*)
UltravioletNullVector=FullSimplify@(Total@(RescaledNullVector[[1;;Length@IndependentComponents[Global`Sigma[-Global`a,-Global`b,-Global`c]]]]/.{Global`En->Pi Global`Mo})+
Total@(RescaledNullVector[[Length@IndependentComponents[Global`Sigma[-Global`a,-Global`b,-Global`c]]+1;;Length@IndependentComponents[Global`Sigma[-Global`a,-Global`b,-Global`c],Global`Tau[-Global`a,-Global`b]]]]/Global`Mo/.{Global`En->Pi Global`Mo}));
NullVectorDegreeOfDivergence=Limit[Log[UltravioletNullVector]/Log[Global`Mo]//FullSimplify,Global`Mo->Infinity];(*how does the vector go at large momenta?*)
RescaledNullVector=RescaledNullVector Global`Mo^(-NullVectorDegreeOfDivergence);(*rescale that divergence away*)
RescaledNullVector];


MakeFreeSourceVariables[NullSpace_List,SourceComponents_List]:=Catch@Module[{NullSpaceDimension,FreeSourceVariables,SourceComponentsAsFreeSourceVariables,SourceComponentsToFreeSourceVariables},
NullSpaceDimension=(Dimensions@NullSpace)[[1]];
FreeSourceVariables=Table[Symbol["Global`X"<>ToString@i],{i,NullSpaceDimension}];
SourceComponentsAsFreeSourceVariables=(Transpose@FreeSourceVariables) . NullSpace;
SourceComponentsToFreeSourceVariables=Flatten@MapThread[#1->#2&,{SourceComponents,SourceComponentsAsFreeSourceVariables}];
SourceComponentsToFreeSourceVariables=SourceComponentsToFreeSourceVariables~Join~Flatten@MapThread[Evaluate@Dagger@#1->Evaluate@Dagger@#2&,{SourceComponents,SourceComponentsAsFreeSourceVariables}];
SourceComponentsToFreeSourceVariables];


MassiveAnalysisOfSector[RawSector_,SourceComponentsToFreeSourceVariables_List]:=Catch@Module[{printer,Sector},
printer={};
printer=printer~Append~PrintTemporary@" ** MassiveAnalysisOfSector...";
Sector=RawSector//NoScalar;
Sector=Sector/.Global`SourcePO3Activate;
Sector=Sector//NoScalar;
Sector=Sector//ToNewCanonical;
Sector=Sector/.Global`SourcePerpO3Activate;
Sector=Sector//NoScalar;
Sector=Sector//ToNewCanonical;
Sector=Sector/.Global`PADMPiActivate;
Sector=Sector//NoScalar;
Sector=Sector//ToNewCanonical;
Sector=Sector/.Global`PO3PiActivate;
Sector=Sector//NoScalar;
Sector=Sector//ToNewCanonical;
Sector=Sector/.Global`PADMActivate;
Sector=Sector//NoScalar;
Sector=Sector//ToNewCanonical;
Sector=Sector/.Global`SourceCompose;
Sector=xAct`xCoba`SeparateBasis[AIndex][Sector];
Sector=Sector/.Global`ToP;
Sector=Sector/.Global`SourceCompose;
Sector=xAct`xCoba`SeparateBasis[AIndex][Sector];
Sector=Sector/.Global`ToP;
Sector=Sector//NoScalar;
Sector=Sector//ToNewCanonical;
Sector=Sector/.Global`ToV;
Sector=Sector//ToNewCanonical;
Sector=Sector/.Global`ToP;
Sector=xAct`xCoba`SeparateBasis[AIndex][Sector];
Sector=Sector//NoScalar;
Sector=Sector/.Global`ToP;
Sector=Sector//ToNewCanonical;
Sector=Sector//NoScalar;
printer=printer~Append~PrintTemporary[" ** SeparateMetric..."];
Sector=SeparateMetric[Global`G][Evaluate@Sector];
printer=printer~Append~PrintTemporary[" ** SeparateBasis..."];
Sector=xAct`xCoba`SeparateBasis[Global`cartesian][Sector];
printer=printer~Append~PrintTemporary[" ** ContractBasis..."];
Sector=Sector//xAct`xCoba`ContractBasis;
printer=printer~Append~PrintTemporary[" ** TraceBasisDummy..."];
Sector=Sector//xAct`xCoba`TraceBasisDummy;
printer=printer~Append~PrintTemporary[" ** TensorValues..."];
Sector=Sector/.xAct`xCoba`TensorValues[Global`P];
Sector=Sector/.xAct`xCoba`TensorValues[Global`G];
Sector=Sector/.xAct`xCoba`TensorValues[Global`Tau];
Sector=Sector/.xAct`xCoba`TensorValues[Global`Sigma];
Sector=Sector/.xAct`xCoba`TensorValues[Dagger@Global`Tau];
Sector=Sector/.xAct`xCoba`TensorValues[Dagger@Global`Sigma];
Sector=Sector/.{Global`Def->Sqrt[Global`En^2-Global`Mo^2]};
Sector=Sector//Together;
printer=printer~Append~PrintTemporary[" ** Imposing conserved sources..."];
Sector=Sector/.SourceComponentsToFreeSourceVariables;
Sector=Sector//Together;
NotebookDelete@printer;
Print@" ** YunCherngLin: massive mode contribution from given spin-parity sector in the lightcone basis:";
Print@Sector;
Sector];


MasslessAnalysisOfTotal[LightconePropagator_List,NullSpace_List]:=Catch@Module[{printer,MasslessPropagaor,MasslessPropagaorResidue,NullSpaceDimension,FreeSourceVariables,NummeratorFreeSourceCoefficientMatrix,NummeratorFreeSourceEigenvalues},
MasslessPropagaor=Together@Total@LightconePropagator;
MasslessPropagaorResidue=Residue[MasslessPropagaor (Global`En-Global`Mo)^0,{Global`En,Global`Mo}]//Simplify;

NullSpaceDimension=(Dimensions@NullSpace)[[1]];
FreeSourceVariables=Table[Symbol["Global`X"<>ToString@i],{i,NullSpaceDimension}];
NummeratorFreeSourceCoefficientMatrix=Last@CoefficientArrays[Numerator@MasslessPropagaorResidue,FreeSourceVariables~Join~(Evaluate@Dagger[FreeSourceVariables]),"Symmetric"->False];
NummeratorFreeSourceCoefficientMatrix=NummeratorFreeSourceCoefficientMatrix[[1;;(1/2)Length@#,(1/2)Length@#+1;;Length@#]]&@NummeratorFreeSourceCoefficientMatrix;
NummeratorFreeSourceEigenvalues=Eigenvalues@NummeratorFreeSourceCoefficientMatrix;

Print@" ** YunCherngLin: residue of the massless propagator at the massless pole (unitarity reflected in the denominator):";
Print@MasslessPropagaorResidue;
Print@" ** YunCherngLin: current eigenvalues of the massless propagator residues (number of massless polarisations is number of positive-definite eigenvalues):";
Print@NummeratorFreeSourceEigenvalues;

{MasslessPropagaorResidue,NummeratorFreeSourceEigenvalues}];

SpinParityTensorHeads=<|
		Global`A-><|
			0-><|Even->{Global`AP0p},Odd->{Global`AP0m}|>,
			1-><|Even->{Global`AP1p,Global`APerp1p},Odd->{Global`AP1m,Global`APerp1m}|>,
			2-><|Even->{Global`AP2p},Odd->{Global`AP2m}|>
		|>,
		Global`F-><|
			0-><|Even->{Global`FP0p,Global`FPerp0p},Odd->{}|>,
			1-><|Even->{Global`FP1p},Odd->{Global`FP1m,Global`FPerp1m}|>,
			2-><|Even->{Global`FP2p},Odd->{}|>
		|>
|>;


ExecuteRules[]:=(
AutomaticRules[Global`AP2m,MakeRule[{Evaluate[Global`AP2m[-Global`a,-Global`c,-Global`b]Dagger@Global`AP2m[Global`a,Global`b,Global`c]],Evaluate[(1/2)Global`AP2m[-Global`a,-Global`b,-Global`c]Dagger@Global`AP2m[Global`a,Global`b,Global`c]]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[Evaluate[Dagger@Global`AP2m],MakeRule[{Evaluate[Dagger@Global`AP2m[-Global`a,-Global`c,-Global`b]Global`AP2m[Global`a,Global`b,Global`c]],Evaluate[(1/2)Dagger@Global`AP2m[-Global`a,-Global`b,-Global`c]Global`AP2m[Global`a,Global`b,Global`c]]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[Evaluate[Dagger@Global`AP2m],MakeRule[{Evaluate[Dagger@Global`AP2m[-Global`a,-Global`b,-Global`c]Global`Eps[Global`d,Global`b,Global`c]],Evaluate[-(1/2)Dagger@Global`AP2m[-Global`b,-Global`c,-Global`a]Global`Eps[Global`d,Global`b,Global`c]]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[Global`AP2m,MakeRule[{Evaluate[Global`AP2m[-Global`a,-Global`b,-Global`c]Global`Eps[Global`d,Global`b,Global`c]],Evaluate[-(1/2)Global`AP2m[-Global`b,-Global`c,-Global`a]Global`Eps[Global`d,Global`b,Global`c]]},MetricOn->All,ContractMetrics->True]];
);


QuadraticAnsatz[Tensors__]:=If[Evaluate@Total@((Length@SlotsOfTensor@#)&/@(List@Tensors))>0,
	AllContractions@IndexFree@Times@Tensors,
	Times@@((#[])&/@(List@Tensors))
];

SuadraticAnsatz[Tensors__]:=If[Evaluate@Total@((Length@SlotsOfTensor@#)&/@(List@Tensors))>0,
	AllContractions@IndexFree@((Times@Tensors)~Times~Global`Eps),
	Times@@((#[])&/@(List@Tensors))
];

GenerateAnsatz[Tensors__]:=Catch@Module[{},
	(*
	Print@MatrixForm@(Outer[QuadraticAnsatz,#,(Dagger/@#)]&@(Join@@(SpinParityTensorHeads[Tensor][Spin][Even]~Table~{Tensor,List@Tensors})))
	~Table~{Spin,0,2};
*)
	Print@MatrixForm@(Outer[QuadraticAnsatz,#,(Dagger/@#)]&@(Join@@(SpinParityTensorHeads[Tensor][Spin][Odd]~Table~{Tensor,List@Tensors})))
	~Table~{Spin,0,2};
	Print@MatrixForm@(Outer[SuadraticAnsatz,#[[1]],(Dagger@#)&/@#[[2]]]&@{
	Join@@(SpinParityTensorHeads[Tensor][Spin][Even]~Table~{Tensor,List@Tensors}),
	Join@@(SpinParityTensorHeads[Tensor][Spin][Odd]~Table~{Tensor,List@Tensors})
	})
	~Table~{Spin,0,2};
];

(*~Times~Global`Eps*)

(*
Tensors1=(#@@(ToExpression/@Alphabet[][[1;;(Length@SlotsOfTensor@#)]]))&/@(List@Tensors);
*)

YunCherngLin[Expr_,Tensors__]:=Catch@Module[{printer,FourierDecomposedLagrangian,SaturatedPropagator,ConstraintComponentList,SourceComponents,UnscaledNullSpace,LightconePropagator,RescaledNullSpace,SourceComponentsToFreeSourceVariables},
printer={};
printer=printer~Append~PrintTemporary@" ** YunCherngLin...";

FourierDecomposedLagrangian=FourierLagrangian[Expr,Tensors];
SaturatedPropagator=SaturateMe[FourierDecomposedLagrangian];

(*

Print@" ** YunCherngLin: null eigenvectors of the Lagrangian imply the following constraints on the source currents (stress-energy and spin tensors) expressed in the lightcone components where \[ScriptK]=(\!\(\*SubscriptBox[\(\[ScriptK]\), \(0\)]\),\!\(\*SubscriptBox[\(\[ScriptK]\), \(1\)]\),\!\(\*SubscriptBox[\(\[ScriptK]\), \(2\)]\),\!\(\*SubscriptBox[\(\[ScriptK]\), \(3\)]\))=(\[ScriptCapitalE],0,0,\[ScriptP]):";
ConstraintComponentList=MakeConstraintComponentList[SaturatedPropagator[[1]]];(*~Take~2*)
ConstraintComponentList=xAct`xCoba`SeparateBasis[AIndex][#]&/@ConstraintComponentList;
ConstraintComponentList=ConstraintComponentToLightcone/@ConstraintComponentList;
ConstraintComponentList=DeleteCases[ConstraintComponentList,True];
SourceComponents=IndependentComponents[Global`Sigma[-Global`a,-Global`b,-Global`c],Global`Tau[-Global`a,-Global`b]];
UnscaledNullSpace=NullSpace@Last@(ConstraintComponentList~CoefficientArrays~SourceComponents);
RescaledNullSpace=RescaleNullVector/@UnscaledNullSpace;
SourceComponentsToFreeSourceVariables=MakeFreeSourceVariables[RescaledNullSpace,SourceComponents];

LightconePropagator=MassiveAnalysisOfSector[#,SourceComponentsToFreeSourceVariables]&/@SaturatedPropagator[[2]];
MasslessAnalysisOfTotal[LightconePropagator,UnscaledNullSpace];


*)

NotebookDelete@printer;
];


(* ::Code::Initialization:: *)
End[];
EndPackage[];
