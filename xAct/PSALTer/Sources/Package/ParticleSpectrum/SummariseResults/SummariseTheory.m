(*===================*)
(*  SummariseTheory  *)
(*===================*)

SummariseTheory[Theory_?StringQ]:=Theory;
NotStringQ[InputExpr_]:=!StringQ@InputExpr;
SummariseTheory[Theory_?NotStringQ]:=Module[{DisplayVersion,RowsOfExpression},
	RowsOfExpression=25*Floor@Sqrt@(Length@(Expand@Theory/.{Plus->List}));
	DisplayVersion=(Action==Integrate@@({((CollectConstants@Theory))@@#}~Join~(#[[1;;4]]))&@{TCoordinate,XCoordinate,YCoordinate,ZCoordinate});
	DisplayVersion//=Evaluate;
	DisplayVersion//=Text;
	DisplayVersion=Framed[Grid[{{DisplayVersion}},Background->DetailColor,ItemSize->RowsOfExpression],Background->DetailColor,FrameStyle->Directive[DetailColor,Thickness[4]]];
DisplayVersion];
