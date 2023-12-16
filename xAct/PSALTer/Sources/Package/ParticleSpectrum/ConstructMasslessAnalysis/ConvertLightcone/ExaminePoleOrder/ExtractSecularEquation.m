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
	TheSecularEquationCoefficients=MapThread[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(GradualExpand[
							#1,#2,#3]))&,
		{
		(PoleResidue>0)~ConstantArray~(Length@TheSecularEquationCoefficients),
		TheSecularEquationCoefficients,
		TheSymbolicToUnique~ConstantArray~(Length@TheSecularEquationCoefficients)
		}];
	TheSecularEquationCoefficients//=MonitorParallel;
	Diagnostic@TheSecularEquationCoefficients;

	LocalMasslessSpectrum=" ** FullSimplify...";
	TheSecularEquation=(Reverse@TheSecularEquationCoefficients)~FromDigits~PoleResidue;
	Diagnostic@TheSecularEquation;
	TheSecularEquation//=Collect[#,PoleResidue,FullSimplify]&;
	Diagnostic@TheSecularEquation;
TheSecularEquation];
