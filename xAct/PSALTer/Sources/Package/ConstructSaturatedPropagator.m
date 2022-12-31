(*================================*)
(*  ConstructSaturatedPropagator  *)
(*================================*)

NonTrivialDot[LeftOperand_,RightOperand_]:=If[((LeftOperand=={})||(LeftOperand=={})),
		0,
		LeftOperand~Dot~RightOperand,
		LeftOperand~Dot~RightOperand];

ConstructSaturatedPropagator[Expr_,Couplings_]:=Module[{
	CouplingAssumptions,
	SymbolicLagrangian,
	Symbols,
	MatrixLagrangian,
	ImaginaryParts,
	RealParts,
	BMatricesValues,
	NullSpaces,
	SourceConstraints,
	MatrixPropagator,
	InverseBMatricesValues,
	SaturatedPropagator,
	PrintVariable},

	PrintVariable={};
	PrintVariable=PrintVariable~Append~PrintTemporary@" ** ConstructSaturatedPropagator...";

	(*coefficient matrices*)
	(*remember the 2m mode turns out to vanish once you consider the cyclic
	identitiy on the indices!*)
	SymbolicLagrangian=Expr/.cRules;
	(*lists of all the symbolic projected tensors*)
	Symbols=(#~Join~((Evaluate@Dagger[#])&/@#))&/@{c0p,c0m,c1p,c1m,c2p,c2m};
	(*now transfer the Lagrangian to coefficient matrix form, accommodating
	for zero and dimension-one matrices*)
	MatrixLagrangian=If[
		SparseArrayQ@Last@CoefficientArrays[SymbolicLagrangian,#,"Symmetric"->False],
		Last@CoefficientArrays[SymbolicLagrangian,#,"Symmetric"->False],
		SparseArray@ConstantArray[0,{Length@#,Length@#}]
		]&/@Symbols;

	(*pick out the blocks of the coefficient arrays that are nonzero*)
	MatrixLagrangian=#[[1;;(1/2)Length@#,(1/2)Length@#+1;;Length@#]]&/@MatrixLagrangian;

	(*Lagrangian as coefficient matrices for the
HiGGS SO(3) decomposition of the gauge fields*)

	(*Hermitian versions of matrices*)
	ImaginaryParts=Map[If[(MemberQ[Flatten@(Arg@#&/@FactorList[#]),Pi/2]||MemberQ[Flatten@(Arg@#&/@FactorList[#]),-Pi/2]),#,0]&,MatrixLagrangian,{3}];
	RealParts=MatrixLagrangian-ImaginaryParts;
	MatrixLagrangian=Simplify/@((1/2)(RealParts+Transpose/@RealParts)+(1/2)(ImaginaryParts-Transpose/@ImaginaryParts));

	(* Hermitian equivalent of these coefficient
matrices*)

	(*rescaled versions of matrices*)
	MatrixLagrangian=MapThread[MapThread[#1 #2&,{#1,#2}]&,{MatrixLagrangian,rescmat}]/.rescsols;

	(*SPO-rescaled equivalent of these coefficient matrices*)
	BMatricesValues=MatrixLagrangian;

	(*null spaces*)
	NullSpaces=NullSpace@Transpose[#]&/@MatrixLagrangian;
	(*Null spaces of these coefficient matrices*)

	(*source constraints*)
	SourceConstraints=Quiet@DeleteCases[
		Flatten@MapThread[(#1~NonTrivialDot~#2)&,
			{NullSpaces,MapThread[MapThread[(#2/#1)&,{#1,#2}]&,{{r0p,r0m,r1p,r1m,r2p,r2m},Ups}]}
		],0,Infinity]/.rescsols;
	SourceConstraints=Numerator@Together[#/Sqrt[2^5*3^5*5^5*7^5]]&/@SourceConstraints;
	(*Corresponding source constraints*)
	((Print@(#==0))&)/@SourceConstraints;

	(*matrix form of the propagator*)
	CouplingAssumptions=(#~Element~Reals)&/@Couplings;
	CouplingAssumptions~AppendTo~(xAct`PSALTer`Def~Element~Reals);
	(*Sometimes the Drazin inverse is failing*)
	(*MatrixPropagator=FullSimplify@ComplexExpand@DrazinInverse[#]&/@MatrixLagrangian;*)
	(*So we use the Moore-Penrose inverse*)
	MatrixPropagator=Assuming[CouplingAssumptions,((PseudoInverse@#))&/@MatrixLagrangian];
	MatrixPropagator=((#)~FullSimplify~CouplingAssumptions)&/@MatrixPropagator;
	(*Matrix propagator as the Drazin (Moore-Penrose) inverse of the Hermition, SPO-rescaled matrix Lagrangian*)
	InverseBMatricesValues=MatrixPropagator;

	(*saturated form of the propagator*)
	MatrixPropagator=MapThread[MapThread[#1 #2&,{#1,#2}]&,{MatrixPropagator,invrescmat}]/.rescsols;(*descale the propagator ready for multiplication by sources*)
	SaturatedPropagator=MapThread[#1 . #2 . #3&,{Dagger/@Ups,MatrixPropagator,Downs}];
	SaturatedPropagator=ToNewCanonical/@SaturatedPropagator;
	SaturatedPropagator=CollectTensors/@SaturatedPropagator;
	(*"\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptJ]\), \(^\)], \(\[Dagger]\)]\)(\[ScriptK])\[CenterDot]\!\(\*SuperscriptBox[OverscriptBox[\(\[ScriptCapitalO]\), \(^\)], \(-1\)]\)(\[ScriptK])\[CenterDot]\!\(\*OverscriptBox[\(\[ScriptJ]\), \(^\)]\)(\[ScriptK])"*)

	NotebookDelete@PrintVariable;
{SourceConstraints,SaturatedPropagator,BMatricesValues,InverseBMatricesValues}];
