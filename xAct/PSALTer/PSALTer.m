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

BeginPackage["xAct`PSALTer`",{"xAct`xTensor`","xAct`SymManipulator`","xAct`xPerm`","xAct`xCore`","xAct`xTras`","xAct`xCoba`","MaTeX`","JasonB`RectanglePacking`"}];

ParallelNeeds["xAct`PSALTer`"];

(*========================================================================*)
(*  The output can be long, we prefer to scroll automatically to the end  *)
(*========================================================================*)

SetOptions[$FrontEndSession,EvaluationCompletionAction->"ScrollToOutput"];

Print[xAct`xCore`Private`bars];
Print["Package xAct`PSALTer` version ",$Version[[1]],", ",$Version[[2]]];
Print["CopyRight \[Copyright] 2022, Will Barker, Stephanie Buttigieg, Carlo Marzo, Cillian Rew, Claire Rigouzzo, Zhiyuan Wei, David Yallup and Haoyang Ye, under the General Public License."];

(*-------------------------------------------------------------------*)
(*  Modify the path to accommodate notebook and install directories  *)
(*-------------------------------------------------------------------*)

Quiet@If[NotebookDirectory[]==$Failed,
	$CLI=True,
	$CLI=False,
	$CLI=False];

If[$CLI,
	$WorkingDirectory=Directory[],
	$WorkingDirectory=NotebookDirectory[]];

$Path~AppendTo~$WorkingDirectory;
$PSALTerInstallDirectory=Select[FileNameJoin[{#,"xAct/PSALTer"}]&/@$Path,DirectoryQ][[1]];

If[$CLI,	
	Print@Import@FileNameJoin@{$PSALTerInstallDirectory,
				"Documentation","Logo","ASCIILogo.txt"},
	Print@Magnify[Import@FileNameJoin@{$PSALTerInstallDirectory,
				"Documentation","Logo","GitLabLogo.png"},0.3]];

$DiagnosticMode=False;
$MonitorParallel=False;
$ExportPDF=False;
$ReadOnly=False;

(*--------------*)
(*  Disclaimer  *)
(*--------------*)

If[xAct`xCore`Private`$LastPackage==="xAct`PSALTer`",
Unset[xAct`xCore`Private`$LastPackage];
Print[xAct`xCore`Private`bars];
Print["These packages come with ABSOLUTELY NO WARRANTY; for details type Disclaimer[]. This is free software, and you are welcome to redistribute it under certain conditions. See the General Public License for details."];
Print[xAct`xCore`Private`bars]];

(*===============================*)
(*  Functions and their options  *)
(*===============================*)

DefField::usage="DefField[Field[Inds],K,SymmExpr,Options] populates the kinematics K with a tensorial field Field with indices Inds and index symmetries given by SymmExpr. Options include PrintAs and PrintSourceAs";
PrintSourceAs::usage="PrintSourceAs is an option for DefField which acts as the PrintAs option for the conjugate source.";

ParticleSpectrum::usage="ParticleSpectrum[L,Options] performs the whole propagator analysis on a scalar Lagrangian L, which is quadratic in the perturbed fields and their derivatives, and linear in the couplings. Options include ClassName, TheoryName and MaxLaurentDepth";
ClassName::usage="Kinematics is a mandatory option for ParticleSpectrum which identifies the kinematics to which the linearised Lagrangian belongs. The option must be passed as the (string) name of defined kinematics.";
TheoryName::usage="TheoryName is a mandatory option for ParticleSpectrum which associates a name with the linearised Lagrangian. The option must be passed as a (string) name of the new theory.";
MaxLaurentDepth::usage="MaxLaurentDepth is an option for ParticleSpectrum which sets the maximum positive integer n for which the 1/k^(2n) null pole residues are requested. The default is 1, from which the massless spectrum can be obtained. Setting higher n naturally leads to longer runtimes, but also allows potential (pathological) higher-order/non-simple propagator poles to be identified, down to the requested depth.";

(*============*)
(*  Geometry  *)
(*============*)

M4::usage="M4 is the flat, four-dimensional Lorentzian spacetime manifold.";
G::usage="G[-a,-b] is the Minkowski spacetime metric in rectilinear Cartesian coordinates, with the West Coast signature (1,-1,-1,-1).";
CD::usage="CD[-a] is the partial derivative in rectilinear Cartesian coordinates.";
V::usage="V[-a] is a unit timelike vector V[-a]V[a]=1, which is assumed to be proportional to the momentum P[-a], and which functions as the four-velocity of an observer in whose rest frame all massive particles in the spectrum are also taken to be at rest.";
P::usage="P[-a] is the timelike momentum used in the massive particle analysis, which approaches the null cone in the limit of the massless analysis.";
Def::usage="Def is the constant symbol which represents the positive square root of the norm of the timelike momentum.";
En::usage="En is the constant symbol which represents the energy, i.e. the time component of the timelike momentum.";
Mo::usage="Mo is the constant symbol which represents the relativistic momentum, i.e. the z-component of the timelike momentum.";

(*===================*)
(*  Global settings  *)
(*===================*)

$DiagnosticMode::usage="$DiagnosticMode is a boolean variable which controls whether internal variables are displayed during a computation. Default is False.";
$MonitorParallel::usage="$MonitorParallel is a boolean variable which controls whether the progress of parallel computations is displayed. Default is False.";
$ExportPDF::usage="$ExportPDF is a boolean variable which controls whether PDF files of the analysis are exported. Default is False.";
$ReadOnly::usage="$ReadOnly is a boolean variable which controls whether the analysis is actually performed or simply read in from a PDF file. Default is False.";

(*===============*)
(*  Depreciated  *)
(*===============*)

(**)
DefClass::usage="DefClass[FieldSpinParityTensorHeads,SourceSpinParityTensorHeads] defines a class of models.";
ExportClass::usage="ExportClass is an option for DefClass.";
ImportClass::usage="ImportClass is an option for DefClass.";
DefSpinParityMode::usage="DefSpinParityMode[FieldSpinParityName[Inds],SymmExpr] defines a reduced-index spin parity mdoe.";
MultiTermSymmetries::usage="MultiTermSymmetries is an option for DefSpinParityMode.";
Spin::usage="Spin is an option for DefSpinParityMode.";
Parity::usage="Parity is an option for DefSpinParityMode.";
FieldSymbol::usage="FieldSpinParitySymbol is an option for DefSpinParityMode.";
SourceSymbol::usage="FieldSpinParitySymbol is an option for DefSpinParityMode.";
DefLagrangianCoupling::usage="DefLagrangianCoupling[] defines a lagrangian coupling.";
CouplingSymbol::usage="CouplingSymbol is an option for DefLagrangianCoupling.";
CouplingIndex::usage="CouplingIndex is an option for DefLagrangianCoupling.";
Even::usage="Even is an association key which refers to even-parity spin states.";
Odd::usage="Odd is an association key which refers to odd-parity spin states.";
MomentumSpaceLagrangian::usage="MomentumSpaceLagrangian is an association key which refers to the quadratically expanded Lagrangian in momentum space.";
SourceConstraints::usage="SourceConstraints is an association key which refers to the gauge constraints on the source currents.";
BMatrices::usage="BMatrices is an association key which refers to the b-matrices.";
InverseBMatrices::usage="InverseBMatrices is an association key which refers to the inverses of the b-matrices.";
SourceConstraintComponents::usage="SourceConstraintComponents is an association key which refers to the list of components of source constraints.";
SquareMasses::usage="SquareMasses is an association key which refers to the list of square masses.";
MasslessEigenvalues::usage="MasslessEigenvalues is an association key which refers to the list of source current eignevalues in the residue of the massless pole.";
(**)

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
	"DefField.m",
	"DefClass.m",
	"ParticleSpectrum.m"
};

BuildPSALTerPackage[];

ContextList={	
	"xAct`PSALTer`",
	"xAct`PSALTer`Private`",
	"xAct`PSALTer`ScalarTheory`",
	"xAct`PSALTer`ScalarTheory`Private`",
	"xAct`PSALTer`VectorTheory`",
	"xAct`PSALTer`VectorTheory`Private`",
(*
	"xAct`PSALTer`BiScalarVectorTensorTheory`",
	"xAct`PSALTer`BiScalarVectorTensorTheory`Private`",
	"xAct`PSALTer`TensorTheory`",
	"xAct`PSALTer`TensorTheory`Private`",
	"xAct`PSALTer`SymmetricTensorTheory`",
	"xAct`PSALTer`SymmetricTensorTheory`Private`",
	"xAct`PSALTer`AsymmetricTensorTheory`",
	"xAct`PSALTer`AsymmetricTensorTheory`Private`",
	"xAct`PSALTer`BimetricTensorTheory`",
	"xAct`PSALTer`BimetricTensorTheory`Private`",
	"xAct`PSALTer`ScalarTensorTheory`",
	"xAct`PSALTer`ScalarTensorTheory`Private`",
	"xAct`PSALTer`PoincareGaugeTheory`",
	"xAct`PSALTer`PoincareGaugeTheory`Private`",
	"xAct`PSALTer`WeylGaugeTheory`",
	"xAct`PSALTer`WeylGaugeTheory`Private`",
	"xAct`PSALTer`WeylEinsteinGaugeTheory`",
	"xAct`PSALTer`WeylEinsteinGaugeTheory`Private`",
	"xAct`PSALTer`WeylNaturalGaugeTheory`",
	"xAct`PSALTer`WeylNaturalGaugeTheory`Private`",
	"xAct`PSALTer`WeylSIVGaugeTheory`",
	"xAct`PSALTer`WeylSIVGaugeTheory`Private`",
	"xAct`PSALTer`MetricAffineGravity`",
	"xAct`PSALTer`MetricAffineGravity`Private`",
	"xAct`PSALTer`ZeroTorsionPalatini`",
	"xAct`PSALTer`ZeroTorsionPalatini`Private`",
*)
	"xAct`xTensor`",
	"xAct`xTensor`Private`",
	"TangentM4`",
	"xAct`PSALTer`"
};

Begin["xAct`PSALTer`"];
	xAct`PSALTer`Private`BuildPSALTer[xAct`PSALTer`Private`Recompile->False];
	Quiet@If[NotebookDirectory[]==$Failed,
		$CLI=True,
		$CLI=False,
		$CLI=False];
End[];

End[];
EndPackage[];
