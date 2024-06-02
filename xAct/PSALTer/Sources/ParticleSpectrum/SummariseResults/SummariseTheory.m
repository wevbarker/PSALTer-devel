(*===================*)
(*  SummariseTheory  *)
(*===================*)

SummariseTheory[Theory_?StringQ]:=Theory;
NotStringQ[InputExpr_]:=!StringQ@InputExpr;
PlasticBox[InputExpr_,PlasticBoxSize_]:=Framed[Grid[{{InputExpr}},
					Background->DetailColor,
					ItemSize->PlasticBoxSize],
						Background->DetailColor,
						FrameStyle->Directive[DetailColor,Thickness[4]]];
RigidBox[InputExpr_]:=Framed[
				Grid[
					{{Text@"Quadratic (free) action"},{InputExpr}},
						ItemStyle->{LineIndent->0},	
						Dividers->Center,
						Alignment->Left],
				Background->DetailColor,
				FrameStyle->Directive[DetailColor,Thickness[4]],
				RoundingRadius->$FrameRoundingRadius];
PlasticBoxAspect[PlasticBoxFinal_]:=N@ImageAspectRatio@Rasterize@PlasticBoxFinal;
SummariseTheory[Theory_?NotStringQ]:=Module[{
		PlasticBoxFinal,
		PlasticBoxContent,
		PlasticBoxSize},
	PlasticBoxSize=50*Floor@Sqrt@(Length@(Expand@Theory/.{Plus->List}));
	PlasticBoxContent=(Action==Integrate@@({((Theory))@@#}~Join~(#[[1;;4]]))&@{TCoordinate,XCoordinate,YCoordinate,ZCoordinate});
	PlasticBoxContent//=Evaluate;
	(*PlasticBoxContent//=TraditionalForm;*)
	PlasticBoxContent//=Text;
	PlasticBoxFinal=RigidBox[PlasticBoxContent];
PlasticBoxFinal];
