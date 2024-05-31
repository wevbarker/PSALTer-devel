(*==========================*)
(*  PrintSourceConstraints  *)
(*==========================*)

PrintSourceConstraints[]:=DetailCell@Text@"(No source constraints)";
PrintSourceConstraints[SpinParitySourceConstraints_,
	CovariantSourceConstraints_,
	Multiplicities_]:=Module[{FinalGrid},
	FinalGrid=Framed[Grid[
		(
		{
		{Text@"Source constraints/gauge generators",SpanFromLeft},
		{Text@"SO(3) irreps",Text@"Multiplicities"}}~Join~
		MapThread[{#1,#2}&,{Text/@SpinParitySourceConstraints,
					Text/@Multiplicities}]
		)~Join~
		{{Text@"Total constraints:",Text/@(Total@Multiplicities)}},
			Dividers->Center,
			Alignment->Left,
			Background->DetailColor],Background->DetailColor,FrameStyle->Directive[DetailColor,Thickness[4]]];
FinalGrid];
