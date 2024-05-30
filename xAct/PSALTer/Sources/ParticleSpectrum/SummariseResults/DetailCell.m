(*==============*)
(*  DetailCell  *)
(*==============*)

DetailCell[InputExpr_]:=Framed[Grid[{{InputExpr}},Background->DetailColor],Background->DetailColor,FrameStyle->Directive[DetailColor,Thickness[4]]];
