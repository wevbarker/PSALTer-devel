(*=========================*)
(*  RemoveVFromLagrangian  *)
(*=========================*)

RemoveVFromTerm[InputExpr_,TensorFields_List,CouplingConstants_List]:=Module[{
	Expr=InputExpr,
	ReverseTerm,
	TensorPart,
	RemovedExpr,
	SquareTensors,
	ScalarPart,
	ReversedTerm
	},
	xAct`PSALTer`Private`Diagnostic@"New term";
	ReverseTerm=False;
	Block[CouplingConstants,
		(#=1)&/@CouplingConstants;
		Block[{HubbleNumber,ScaleFactor},
			(#=1)&/@{HubbleNumber,ScaleFactor[]};
			TensorPart=Expr;
			xAct`PSALTer`Private`Diagnostic@TensorPart;
			RemovedExpr=Expr/.{xTensor1_?(MemberQ[TensorFields,#]&)[Inds1___]*CD[Ind_]@xTensor2_?(MemberQ[TensorFields,#]&)[Inds2___]->-CD[Ind]@xTensor1[Inds1]*xTensor2[Inds2]};
			xAct`PSALTer`Private`Diagnostic@RemovedExpr;
			If[ToCanonical[RemovedExpr+TensorPart]==0,
				SquareTensors=Expr/.{xTensor1_?(MemberQ[TensorFields,#]&)[Inds1___]*CD[Ind_]@xTensor2_?(MemberQ[TensorFields,#]&)[Inds2___]->xTensor1[Inds1]*xTensor2[Inds2]};
				xAct`PSALTer`Private`Diagnostic@SquareTensors;
				ReverseTerm=True;
			];
		];
	];
	ReversedTerm=Expr;
	If[ReverseTerm,
		ScalarPart=Expr/TensorPart;
		xAct`PSALTer`Private`Diagnostic@ScalarPart;
		ReversedTerm=-(1/2)*SquareTensors*CD[-First@(List@@(FindFreeIndices@Evaluate@SquareTensors))]@ScalarPart;
		xAct`PSALTer`Private`Diagnostic@ReversedTerm;
	];
ReversedTerm];

RemoveVFromLagrangian[InputExpr_,TensorFields_List,CouplingConstants_List]:=Module[{Expr=InputExpr},
	Expr=Expr/.{Plus->List};
	Expr=RemoveVFromTerm[#,TensorFields,CouplingConstants]&/@Expr;
	Expr//=Total;
Expr];
