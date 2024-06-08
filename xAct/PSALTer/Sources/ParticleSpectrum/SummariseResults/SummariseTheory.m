(*===================*)
(*  SummariseTheory  *)
(*===================*)

SummariseTheory[Theory_?StringQ]:=Theory;
NotStringQ[InputExpr_]:=!StringQ@InputExpr;
RigidBox[InputExpr_]:=Framed[
				Grid[
					{{Text@"Lagrangian density",SpanFromLeft},
					{InputExpr[[1]],SpanFromLeft},
					{Text@"Added source term:",InputExpr[[2]]}},
						ItemStyle->{LineIndent->0},	
						Dividers->Center,
						Alignment->Left],
				Background->$DetailColor,
				FrameStyle->Directive[$DetailColor,Thickness[4]],
				RoundingRadius->$FrameRoundingRadius];
PlasticBoxAspect[PlasticBoxFinal_]:=N@ImageAspectRatio@Rasterize@PlasticBoxFinal;
SummariseTheory[Theory_?NotStringQ]:=Module[{
		PlasticBoxFinal,
		PlasticBoxContent,
		PlasticBoxSize},
	PlasticBoxSize=50*Floor@Sqrt@(Length@(Expand@Theory/.{Plus->List}));
	PlasticBoxContent=Theory;
	PlasticBoxContent//=(Evaluate/@#)&;
	PlasticBoxContent//=(ExpandAll/@#)&;
	PlasticBoxContent//=(Text/@#)&;
	PlasticBoxFinal=RigidBox[PlasticBoxContent];
PlasticBoxFinal];
