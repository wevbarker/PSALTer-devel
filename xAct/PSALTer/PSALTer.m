(*===========*)
(*  PSALTer  *)
(*===========*)

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

BeginPackage["xAct`PSALTer`",{"xAct`xTensor`","xAct`xPerm`","xAct`xCore`","xAct`xTras`","xAct`HiGGS`","xAct`FieldsX`","xAct`xCoba`"}];

ParallelNeeds["xAct`PSALTer`"];

Print[xAct`xCore`Private`bars];
Print["Package xAct`PSALTer` version ",$Version[[1]],", ",$Version[[2]]];
Print["CopyRight \[Copyright] 2022, Will E. V. Barker, under the General Public License."];

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

FourierLagrangian::usage="FourierLagrangian[Expr,Tensor1,Tensor2,...] transfers a scalar expression Expr which is quadratic in the given perturbed fields whose xTensor heads are Tensor1 and Tensor2 into its Fourier form. 
Both Expr and at least one field must be provided. Do not include indices in the fields, just list the xTensor heads (i.e. the tensor names).";
SaturateMe::usage="SaturateMe[Expr] produces the saturated propagator from the Lagrangian Expr, which must be a scalar of the form output by FourierLagrangian[].";
ParticleSpectrum::usage="ParticleSpectrum[Expr,Tensor1,Tensor2,...] performs the whole propagator analysis on a scalar Lagrangian Expr, which is quadratic in the given perturbed fields whose xTensor heads are Tensor1 and Tensor2 into its Fourier form. 
Both Expr and at least one field must be provided. Do not include indices in the fields, just list the xTensor heads (i.e. the tensor names). If these names do not correspond to gauge field perturbations that are already known to PSALTer, an error will be thrown."
Even::usage="Even is an association key which refers to even-parity spin states.";
Odd::usage="Odd is an association key which refers to odd-parity spin states.";

(*=========================*)
(*  xAct`PSALTer`Private`  *)
(*=========================*)

Begin["xAct`PSALTer`Private`"];

BuildPackage[FileName_String]:=Get[FileNameJoin@{$PSALTerInstallDirectory,"Sources","Package",FileName}];
BuildRebuild[FileName_String]:=Get[FileNameJoin@{$PSALTerInstallDirectory,"Sources","Rebuild",FileName}];

(*-------------------------*)
(*  Registry of functions  *)
(*-------------------------*)

BuildPSALTerPackage[]:=BuildPackage/@{
	"BuildPSALTer.m",
	"FourierLagrangian.m",
	"SaturateMe.m",
	"MakeConstraintComponentList.m",
	"ConstraintComponentToLightcone.m",
	"IndependentComponents.m",
	"RescaleNullVector.m",
	"MakeFreeSourceVariables.m",
	"MassiveAnalysisOfSector.m",
	"MasslessAnalysisOfTotal.m",
	"ParticleSpectrum.m"
};

BuildPSALTerPackage[];

ContextList={	
	"xAct`HiGGS`",
	"xAct`HiGGS`Private`",
	"xAct`PSALTer`",
	"xAct`PSALTer`Private`"
};

Begin["xAct`PSALTer`"];
	xAct`PSALTer`Private`BuildPSALTer[xAct`PSALTer`Private`Recompile->False];
End[];

End[];
EndPackage[];
