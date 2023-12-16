(*==========================*)
(*  ExtractSecularEquation  *)
(*==========================*)

ExtractSecularEquation[InputMatrix_]:=Module[{
	TheInputMatrix=InputMatrix,
	TheSecularEquation,
	TheSymbolicToUnique,
	TheSecularEquationCoefficients
	},

	Diagnostic@TheInputMatrix;

	TheSymbolicInputMatrix=TheInputMatrix//MatrixToSymbolic;
	Diagnostic@TheSymbolicInputMatrix;
	TheSecularEquation=(
		Det@(#-PoleResidue*IdentityMatrix@Length@#)
			)&@(TheSymbolicInputMatrix@SymbolicMatrix);
	Diagnostic@TheSecularEquation;
	TheSecularEquationCoefficients=TheSecularEquation~CoefficientList~PoleResidue;
	Diagnostic@TheSecularEquationCoefficients;

	LocalMasslessSpectrum=" ** GradualExpand...";
	TheSymbolicToUnique=TheSymbolicInputMatrix@SymbolicToUnique;
	Diagnostic@TheSymbolicToUnique;
	TheSecularEquationCoefficients=Map[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(GradualExpand[
							PoleResidue>0,#,TheSymbolicToUnique]))&,
	({#})&/@(TheSecularEquationCoefficients),{2}];
	TheSecularEquationCoefficients//=MonitorParallel;
	Diagnostic@TheSecularEquationCoefficients;
	TheSecularEquationCoefficients=First/@TheSecularEquationCoefficients;
	Diagnostic@TheSecularEquationCoefficients;

	LocalMasslessSpectrum=" ** FullSimplify...";
	TheSecularEquation=(Reverse@TheSecularEquationCoefficients)~FromDigits~PoleResidue;
	Diagnostic@TheSecularEquation;
	TheSecularEquation//=Collect[#,PoleResidue,FullSimplify]&;
	Diagnostic@TheSecularEquation;
TheSecularEquation];
