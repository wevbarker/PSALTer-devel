(*==============*)
(*  SaturateMe  *)
(*==============*)

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
