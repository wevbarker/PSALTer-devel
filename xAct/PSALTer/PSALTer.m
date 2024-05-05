(*===========*)
(*  PSALTer  *)
(*===========*)

(*===========*)
(*  Version  *)
(*===========*)

(*
xAct`PSALTer`$Version={"1.0.0",{2022,11,4}};
*)
xAct`PSALTer`$Version={"1.0.0-developer",DateList@FileDate@$InputFileName~Drop~(-3)};
If[Unevaluated[xAct`xCore`Private`$LastPackage]===xAct`xCore`Private`$LastPackage,xAct`xCore`Private`$LastPackage="xAct`PSALTer`"];
Off@(Solve::fulldim);

(*=================*)
(*  xAct`PSALTer`  *)
(*=================*)

BeginPackage["xAct`PSALTer`",{"xAct`xTensor`","xAct`SymManipulator`","xAct`xPerm`","xAct`xCore`","xAct`xTras`","xAct`xCoba`","MaTeX`","JasonB`RectanglePacking`"}];
ParallelNeeds["xAct`PSALTer`"];
Print[xAct`xCore`Private`bars];
Print["Package xAct`PSALTer` version ",$Version[[1]],", ",$Version[[2]]];
Print["CopyRight \[Copyright] 2022, Will Barker, Stephanie Buttigieg, Carlo Marzo, Cillian Rew, Claire Rigouzzo, Zhiyuan Wei, David Yallup and Haoyang Ye, under the General Public License."];

(*====================*)
(*  Global variables  *)
(*====================*)

Quiet@If[NotebookDirectory[]==$Failed,$CLI=True,$CLI=False,$CLI=False];
If[$CLI,$WorkingDirectory=Directory[],$WorkingDirectory=NotebookDirectory[]];
$Path~AppendTo~$WorkingDirectory;
$PSALTerInstallDirectory=Select[FileNameJoin[{#,"xAct/PSALTer"}]&/@$Path,DirectoryQ][[1]];
$PSALTerBuilt=False;
If[$CLI,	
	Print@Import@FileNameJoin@{$PSALTerInstallDirectory,
				"Documentation","Logo","ASCIILogo.txt"},
	Print@Magnify[Import@FileNameJoin@{$PSALTerInstallDirectory,
				"Documentation","Logo","GitLabLogo.png"},0.3]];
$DiagnosticMode=False;
$MonitorParallel=False;
$ExportPDF=False;
$ReadOnly=False;

(*==============*)
(*  Disclaimer  *)
(*==============*)

If[xAct`xCore`Private`$LastPackage==="xAct`PSALTer`",
Unset[xAct`xCore`Private`$LastPackage];
Print[xAct`xCore`Private`bars];
Print["These packages come with ABSOLUTELY NO WARRANTY; for details type Disclaimer[]. This is free software, and you are welcome to redistribute it under certain conditions. See the General Public License for details."];
Print[xAct`xCore`Private`bars]];

(*========================================*)
(*  Declaration of functions and options  *)
(*========================================*)

DefField::usage="DefField[F[Inds],SymmExpr,Options] defines a tensorial field F with indices Inds and index symmetries given by SymmExpr. Options are PrintAs and PrintSourceAs.";
PrintSourceAs::usage="PrintSourceAs is an option for DefField which acts as the PrintAs option for the conjugate source.";
ParticleSpectrum::usage="ParticleSpectrum[L,Options] performs the whole propagator analysis on a scalar Lagrangian density L, which is quadratic in the perturbed fields and their derivatives, and linear in the couplings. Options are TheoryName, Method and MaxLaurentDepth.";
TheoryName::usage="TheoryName is a mandatory option for ParticleSpectrum which associates a name with the linearised Lagrangian density. The option must be passed as a (string) name for the new theory.";
MaxLaurentDepth::usage="MaxLaurentDepth is an option for ParticleSpectrum which sets the maximum positive integer n for which the 1/k^(2n) null pole residues are requested. The default is 1, from which the massless spectrum can be obtained. Setting higher n naturally leads to longer runtimes, but also allows potential (pathological) higher-order/non-simple propagator poles to be identified, down to the requested depth.";

(*===========================*)
(*  Declaration of geometry  *)
(*===========================*)

M4::usage="M4 is the flat, four-dimensional Lorentzian spacetime manifold.";
G::usage="G[-a,-b] is the Minkowski spacetime metric in rectilinear Cartesian coordinates on M4, with the West Coast signature (1,-1,-1,-1).";
CD::usage="CD[-a] is the partial derivative in rectilinear Cartesian coordinates on M4.";
V::usage="V[-a] is a unit timelike vector V[-a]V[a]=1, which is assumed to be proportional to the momentum P[-a], and which functions as the four-velocity of an observer in whose rest frame all massive particles in the spectrum are also taken to be at rest.";
P::usage="P[-a] is the timelike momentum used in the massive particle analysis, which approaches the null cone in the limit of the massless analysis.";
Def::usage="Def is the constant symbol which represents the positive square root of the norm of the timelike momentum.";
En::usage="En is the constant symbol which represents the energy, i.e. the time component of the timelike momentum.";
Mo::usage="Mo is the constant symbol which represents the relativistic momentum, i.e. the z-component of the timelike momentum.";

(*===================================*)
(*  Declaration of global variables  *)
(*===================================*)

$DiagnosticMode::usage="$DiagnosticMode is a boolean variable which controls whether internal variables are displayed during a computation. Default is False.";
$MonitorParallel::usage="$MonitorParallel is a boolean variable which controls whether the progress of parallel computations is displayed. Default is False.";
$ExportPDF::usage="$ExportPDF is a boolean variable which controls whether PDF files of the analysis are exported. Default is False.";
$ReadOnly::usage="$ReadOnly is a boolean variable which controls whether the analysis is actually performed or simply read in from a PDF file. Default is False.";

(*===============*)
(*  Depreciated  *)
(*===============*)

Spin::usage="Spin is an option for DefSO3Irrep.";
Parity::usage="Parity is an option for DefSO3Irrep.";
Even::usage="Even is an association key which refers to even-parity spin states.";
Odd::usage="Odd is an association key which refers to odd-parity spin states.";

(*=========================*)
(*  xAct`PSALTer`Private`  *)
(*=========================*)

Begin["xAct`PSALTer`Private`"];
BuildPackage[FileName_String]:=Get[FileNameJoin@{$PSALTerInstallDirectory,"Sources","Package",FileName}];
BuildRebuild[FileName_String]:=Get[FileNameJoin@{$PSALTerInstallDirectory,"Sources","Rebuild",FileName}];

BuildPSALTerPackage[]:=BuildPackage/@{
	"BuildPSALTer.m",
	"DefField.m",
	"ParticleSpectrum.m"
};
BuildPSALTerPackage[];
Begin["xAct`PSALTer`"];
	xAct`PSALTer`Private`BuildPSALTer[];
	Quiet@If[NotebookDirectory[]==$Failed,$CLI=True,$CLI=False,$CLI=False];
End[];
End[];
EndPackage[];
