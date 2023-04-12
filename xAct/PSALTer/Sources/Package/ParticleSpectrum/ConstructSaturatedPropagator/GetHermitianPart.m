(*====================*)
(*  GetHermitianPart  *)
(*====================*)

GetHermitianPart[InputMatrix_,CouplingAssumptions_]:=Module[{
	ImaginaryPart,
	RealPart,
	HubblePart,
	HubblePartSurfaceTerm,
	MatrixExpr=InputMatrix},

(*		
	ImaginaryPart=Map[(If[
(MemberQ[Flatten@(Arg@#&/@FactorList[#]),Pi/2]||MemberQ[Flatten@(Arg@#&/@FactorList[#]),-Pi/2]),#,0]&),MatrixExpr,{2}];
*)
	ImaginaryPart=Map[(CouplingAssumptions~Assuming~(Refine@Im@#))&,MatrixExpr,{2}];
	Diagnostic@MatrixForm@ImaginaryPart;
	AntisymmetricImaginaryPart=(1/2)(ImaginaryPart-Transpose@ImaginaryPart)*I;
	AntisymmetricImaginaryPart//=Map[Simplify,#,{2}]&;
	Diagnostic@MatrixForm@AntisymmetricImaginaryPart;

	RealPart=Map[(CouplingAssumptions~Assuming~(Refine@Re@#))&,MatrixExpr,{2}];
	Diagnostic@MatrixForm@RealPart;
	SymmetricRealPart=(1/2)(RealPart+Transpose@RealPart);
	SymmetricRealPart//=Map[Simplify,#,{2}]&;
	Diagnostic@MatrixForm@SymmetricRealPart;

	HubblePart=Coefficient[MatrixExpr,HubbleScale,1];
	Diagnostic@MatrixForm@HubblePart;
	HubblePartSurfaceTerm=(HubbleScale^2/(-I*Def))*(-1/4)*(HubblePart+Transpose@HubblePart);
	HubblePartSurfaceTerm//=Map[Simplify,#,{2}]&;
	Diagnostic@MatrixForm@HubblePartSurfaceTerm;

	Diagnostic@MatrixForm@MatrixExpr;

	AMat=Coefficient[MatrixExpr,HubbleScale,0];
	AMat/=-Def^2;
	AMat//=Map[Simplify,#,{2}]&;
	Diagnostic@MatrixForm@AMat;

	BMat=Coefficient[MatrixExpr,HubbleScale,1];
	BMat/=-I*Def;
	BMat//=Map[Simplify,#,{2}]&;
	Diagnostic@MatrixForm@BMat;

	CMat=Coefficient[MatrixExpr,HubbleScale,2];
	CMat//=Map[Simplify,#,{2}]&;
	Diagnostic@MatrixForm@CMat;

	AMatU=((1/2)*(#+Transpose@#))&@AMat;
	AMatU//=Map[Simplify,#,{2}]&;
	Diagnostic@MatrixForm@AMatU;
	AMatO=((1/2)*(#-Transpose@#))&@AMat;
	AMatO//=Map[Simplify,#,{2}]&;
	Diagnostic@MatrixForm@AMatO;

	BMatU=((1/2)*(#+Transpose@#))&@BMat;
	BMatU//=Map[Simplify,#,{2}]&;
	Diagnostic@MatrixForm@BMatU;
	BMatO=((1/2)*(#-Transpose@#))&@BMat;
	BMatO//=Map[Simplify,#,{2}]&;
	Diagnostic@MatrixForm@BMatO;

	CMatU=((1/2)*(#+Transpose@#))&@CMat;
	CMatU//=Map[Simplify,#,{2}]&;
	Diagnostic@MatrixForm@CMatU;
	CMatO=((1/2)*(#-Transpose@#))&@CMat;
	CMatO//=Map[Simplify,#,{2}]&;
	Diagnostic@MatrixForm@CMatO;

	Ident=DiagonalMatrix@({-1,1,1,1,1,1}~Take~Length@BMatO);
	Ident//=Map[Simplify,#,{2}]&;
	Diagnostic@MatrixForm@Ident;

	BMatP=BMatO.Ident;
	BMatP//=Map[Simplify,#,{2}]&;
	Diagnostic@MatrixForm@BMatP;

	SMat=AMatU*(-Def^2)+BMatO*(-I*Def*HubbleScale)+(CMatU+(1/2)*BMatP)*(HubbleScale^2);
	SMat//=Map[Simplify,#,{2}]&;
	Diagnostic@MatrixForm@SMat;

	Diagnostic@Eigenvalues@SMat;
	Diagnostic@Eigenvalues@Transpose@SMat;

	HubblePartSurfaceTerm=(HubbleScale^2/(-I*Def))*(-1/4)*(HubblePart+Transpose@HubblePart);
	HubblePartSurfaceTerm//=Map[Simplify,#,{2}]&;
	Diagnostic@MatrixForm@HubblePartSurfaceTerm;

	MatrixExpr=SymmetricRealPart+AntisymmetricImaginaryPart+HubblePartSurfaceTerm;
	MatrixExpr//=Map[Simplify,#,{2}]&;
	Diagnostic@MatrixForm@MatrixExpr;
MatrixExpr];
