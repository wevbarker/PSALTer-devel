(*==============*)
(*  DetailCell  *)
(*==============*)

DetailCell[InputExpr_]:=Framed[Grid[{{InputExpr}}],Background->DetailColor,FrameStyle->Directive[DetailColor,Thickness[4]],RoundingRadius->$FrameRoundingRadius];
