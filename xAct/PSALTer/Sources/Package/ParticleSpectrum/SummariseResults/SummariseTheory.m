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
PlasticBoxAspect[PlasticBoxFinal_]:=N@ImageAspectRatio@Rasterize@PlasticBoxFinal;
SummariseTheory[Theory_?NotStringQ]:=Module[{
		PlasticBoxFinal,
		PlasticBoxContent,
		PlasticBoxSize},
	PlasticBoxSize=25*Floor@Sqrt@(Length@(Expand@Theory/.{Plus->List}));
	PlasticBoxContent=(Action==Integrate@@({((CollectConstants@Theory))@@#}~Join~(#[[1;;4]]))&@{TCoordinate,XCoordinate,YCoordinate,ZCoordinate});
	PlasticBoxContent//=Evaluate;
	PlasticBoxContent//=Text;

	PlasticBoxFinal=PlasticBox[PlasticBoxContent,PlasticBoxSize];
	While[PlasticBoxAspect@PlasticBoxFinal<=0.6,
		PlasticBoxSize-=10;
		PlasticBoxFinal=PlasticBox[PlasticBoxContent,PlasticBoxSize];
	];
PlasticBoxFinal];
