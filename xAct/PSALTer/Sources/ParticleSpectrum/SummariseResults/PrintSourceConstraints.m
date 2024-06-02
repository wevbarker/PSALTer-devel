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
		{Text@"Source constraints",SpanFromLeft},
		{Text@"SO(3) irreps",Text@"#"}}~Join~
		MapThread[{#1,#2}&,{Text/@SpinParitySourceConstraints,
					Text/@Multiplicities}]
		)~Join~
		{{Text@"Total #:",Text/@(Total@Multiplicities)}},
			Dividers->Center,
			Alignment->Left],Background->DetailColor,FrameStyle->Directive[DetailColor,Thickness[4]],RoundingRadius->$FrameRoundingRadius];
FinalGrid];
