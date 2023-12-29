(*==============*)
(*  Experiment  *)
(*==============*)

Comment@"here is some extra material";

ExtractDenominator[InputMatrix_]:=Module[{OverallDenominator,Expr},
	OverallDenominator=InputMatrix;
	OverallDenominator//=Flatten;
	OverallDenominator//=Total;
	OverallDenominator//=Together;
	OverallDenominator//=Denominator;
OverallDenominator];

ExtractReparameterisationMatrix[InputMatrix_]:=Module[{ReparameterisationMatrix},
	ReparameterisationMatrix=InputMatrix;
	ReparameterisationMatrix//=Diagonal;
	ReparameterisationMatrix//=(FactorList/@#)&;
	ReparameterisationMatrix//=(DeleteCases[#,{TheExpression___,Num_?OddQ}]&/@#)&;
	ReparameterisationMatrix//=((1/PowerExpand@Sqrt@(Times@@((Power@@#)&/@#)))&/@#)&;
	ReparameterisationMatrix//=DiagonalMatrix;
ReparameterisationMatrix];

(*ExtractDenominator*)
(*ExtractReparameterisationMatrix*)
ReparameteriseSources[InputMatrix_]:=Module[{
	ReparameterisedMatrix=InputMatrix,
	OverallDenominator,
	ReparameterisationMatrix	
	},

	OverallDenominator=ExtractDenominator@ReparameterisedMatrix;
	Print@MatrixForm@ReparameterisedMatrix;

	ReparameterisedMatrix*=OverallDenominator;
	ReparameterisedMatrix//=Simplify;

	ReparameterisationMatrix=ExtractReparameterisationMatrix@ReparameterisedMatrix;
	ReparameterisedMatrix=ReparameterisationMatrix.ReparameterisedMatrix.ReparameterisationMatrix;
	ReparameterisedMatrix//=Simplify;	
{ReparameterisedMatrix,OverallDenominator}];

ExtractPart[InputMatrix_,InputDenominator_,OrderInteger_]:=Module[{
	NSeriesMapped,
	Expr,
	PerturbationRules,
	PerturbationParameter,
	AllCouplings
	},

	AllCouplings=Variables@InputDenominator;
	PerturbationRules=(#->PerturbationParameter*#)&/@AllCouplings;
	If[OrderInteger==Infinity,
		MyNSeriesMapped[InputExpr_]:=InputExpr;
	,
		MyNSeriesMapped[InputExpr_]:=Normal@Series[InputExpr/.PerturbationRules,
			{PerturbationParameter,0,OrderInteger}]/.{PerturbationParameter->1};
	];
	Expr=Map[MyNSeriesMapped,InputMatrix,{2}];

	Expr//=Eigenvalues;
	Expr//=DeleteCases[#,0,Infinity]&;
	Expr/=InputDenominator;
Expr];

(*ReparameteriseSources*)
(*ExtractPart*)
MasslessAnalysisOfTotal[ValuesNumeratorFreeSourceCoefficientMatrix_]:=Module[{
	NumeratorFreeSourceCoefficientMatrix=ValuesNumeratorFreeSourceCoefficientMatrix,
	InputMatrix,
	InputDenominator,
	NumeratorFreeSourceEigenvalues,
	StillComputing=True,
	NewOrder=0
	},

	Diagnostic@NumeratorFreeSourceCoefficientMatrix;

	{InputMatrix,InputDenominator}=ReparameteriseSources@Expr;
	Print@MatrixForm@InputMatrix;

	TimeConstrained[
	(
		Print@"ExtractPart Infinity";
		NumeratorFreeSourceEigenvalues=ExtractPart[InputMatrix,InputDenominator,Infinity];
	),
	10,
	(
		While[StillComputing&&(NewOrder<=2),
			TimeConstrained[
			(
				Print@("ExtractPart "<>ToString@NewOrder);
				NumeratorFreeSourceEigenvalues=ExtractPart[InputMatrix,InputDenominator,NewOrder];
				NewOrder+=1;
			)
			,
			10,
			(
				StillComputing=False;
			)
			];
			
		];
	)
	];

NumeratorFreeSourceEigenvalues];


(*
Get@FileNameJoin@{NotebookDirectory[],"TypeII.mx"};
Get@FileNameJoin@{NotebookDirectory[],"MetricAffineRicciTypeTheory.mx"};
*)
Get@FileNameJoin@{NotebookDirectory[],"ExtendedProjectiveTheory.mx"};
Expr=ExtendedProjectiveTheory@xAct`PSALTer`Private`SecularSystem;
Print@Keys@Expr;
Expr=Expr@1;
Expr=Expr/.{Conjugate[Anything___]->Anything};



(**)
Expr=Expr/.{
xAct`PSALTer`MetricAffineGravity`A2->xAct`PSALTer`MetricAffineGravity`A1,
xAct`PSALTer`MetricAffineGravity`A3->xAct`PSALTer`MetricAffineGravity`A1,
xAct`PSALTer`MetricAffineGravity`A4->xAct`PSALTer`MetricAffineGravity`A1(*,
xAct`PSALTer`MetricAffineGravity`A5->xAct`PSALTer`MetricAffineGravity`A1,
xAct`PSALTer`MetricAffineGravity`A6->xAct`PSALTer`MetricAffineGravity`A1,
xAct`PSALTer`MetricAffineGravity`A7->xAct`PSALTer`MetricAffineGravity`A1,
xAct`PSALTer`MetricAffineGravity`A8->xAct`PSALTer`MetricAffineGravity`A1,
xAct`PSALTer`MetricAffineGravity`A9->xAct`PSALTer`MetricAffineGravity`A1,
xAct`PSALTer`MetricAffineGravity`A10->xAct`PSALTer`MetricAffineGravity`A1,
xAct`PSALTer`MetricAffineGravity`A11->xAct`PSALTer`MetricAffineGravity`A1
*)
};
(**)
(*Expr=Expr/.{xAct`PSALTer`MetricAffineGravity`A1->xAct`PSALTer`MetricAffineGravity`A0
};*)


Expr=Expr/.{xAct`PSALTer`MetricAffineGravity`A9->-3*xAct`PSALTer`MetricAffineGravity`A1};

Expr=(Expr@xAct`PSALTer`Private`UniqueMatrix);

Expr=MasslessAnalysisOfTotal@Expr;
Print@Expr;

AllSols=Expr;

Expr=(Evaluate[Numerator@First@Expr]/.{Sqrt->Zero});
Expr=Expr/.{Sqrt[Exprs___]->Zero[Exprs]};
Expr//=Simplify;
Expr//=Solve[#==0]&;
Print@Expr;
TrialSolution=Expr[[2]];
Print@Expr;
Comment@"Now we sub this into the full solutions.";
AllSols=AllSols/.{TrialSolution};
AllSols//=Simplify;
Print@AllSols;
AllSols2=(Numerator@AllSols[[1]]);

Print@AllSols2;

NewSol=Solve[AllSols2==0];
Print@NewSol;
NewSol=NewSol[[1]];
AllSols=AllSols/.NewSol;
AllSols//=Simplify;
Print@AllSols;
