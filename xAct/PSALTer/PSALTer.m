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

BeginPackage["xAct`PSALTer`",{"xAct`xTensor`","xAct`xPerm`","xAct`xCore`","xAct`xTras`","xAct`HiGGS`","xAct`xCoba`"}];

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
ParticleSpectrum::usage="ParticleSpectrum[TheoryName,Expr,Tensor1,Tensor2,...,Options] performs the whole propagator analysis on a scalar Lagrangian Expr, which is quadratic in the given perturbed fields whose xTensor heads are Tensor1 and Tensor2 into its Fourier form. 
Both Expr and at least one field must be provided. Do not include indices in the fields, just list the xTensor heads (i.e. the tensor names). If these names do not correspond to gauge field perturbations that are already known to PSALTer, an error will be thrown. The string TheoryName must not contain spaces, it will be converted to a symbol set to an association which contains the results of the analysis, and (if the option Export->True is passed) it will be used to construct the file \"TheoryName.thr.mx\".";
ViewParticleSpectrum::usage="ViewParticleSpectrum[TheoryName] displays the results of the analysis.";
Even::usage="Even is an association key which refers to even-parity spin states.";
Odd::usage="Odd is an association key which refers to odd-parity spin states.";
MomentumSpaceLagrangian::usage="MomentumSpaceLagrangian is an association key which refers to the quadratically expanded Lagrangian in momentum space.";
BMatrices::usage="BMatrices is an association key which refers to the b-matrices.";
InverseBMatrices::usage="InverseBMatrices is an association key which refers to the inverses of the b-matrices.";
SourceConstraintComponents::usage="SourceConstraintComponents is an association key which refers to the list of components of source constraints.";
SquareMasses::usage="SquareMasses is an association key which refers to the list of square masses.";
MasslessEigenvalues::usage="MasslessEigenvalues is an association key which refers to the list of source current eignevalues in the residue of the massless pole.";

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
	"UpdateTheoryAssociation.m",
	"ParticleSpectrum.m",
	"ViewParticleSpectrum.m"
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
