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

(*=========================*)
(*  xAct`PSALTer`Private`  *)
(*=========================*)

Begin["xAct`Priam`Private`"];

BuildPackage[FileName_String]:=Get[FileNameJoin@{$GeoHiGGSInstallDirectory,"Sources","Package",FileName}];

(*-------------------------*)
(*  Registry of functions  *)
(*-------------------------*)

BuildPSALTerPackage[]:=BuildPackage/@{
	"BuildGeoHiGGS.m",
};

BuildPSALTerPackage[];

End[];
EndPackage[];

(*=============================*)
(*  End of current rewriting!  *)
(*=============================*)

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

(*---------------------*)
(*  FourierLagrangian  *)
(*---------------------*)

(*--------------*)
(*  SaturateMe  *)
(*--------------*)

(*-------------------------------*)
(*  MakeConstraintComponentList  *)
(*-------------------------------*)

(*----------------------------------*)
(*  ConstraintComponentToLightcone  *)
(*----------------------------------*)

(*-------------------------*)
(*  IndependentComponents  *)
(*-------------------------*)

(*---------------------*)
(*  RescaleNullVector  *)
(*---------------------*)

(*---------------------------*)
(*  MakeFreeSourceVariables  *)
(*---------------------------*)

(*---------------------------*)
(*  MassiveAnalysisOfSector  *)
(*---------------------------*)

(*---------------------------*)
(*  MasslessAnalysisOfTotal  *)
(*---------------------------*)


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
