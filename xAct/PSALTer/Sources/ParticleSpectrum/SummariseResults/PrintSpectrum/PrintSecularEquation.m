(*========================*)
(*  PrintSecularEquation  *)
(*========================*)

PrintSecularEquation[InputExpr_]:=Module[{FinalGrid},
	FinalGrid=Framed[Grid[
		{{Text@"Secular equation"},{InputExpr==0}},
			Dividers->Center,
			Alignment->Left,
			Background->$DetailColor],Background->$DetailColor,FrameStyle->Directive[$DetailColor,Thickness[4]]];
FinalGrid];
