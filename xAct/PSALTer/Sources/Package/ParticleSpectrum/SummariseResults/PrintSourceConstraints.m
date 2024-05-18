(*==========================*)
(*  PrintSourceConstraints  *)
(*==========================*)

PrintSourceConstraints[]:=DetailCell@Text@"(No source constraints)";
PrintSourceConstraints[SpinParitySourceConstraints_,
	CovariantSourceConstraints_,
	Multiplicities_]:=Module[{FinalGrid},
	FinalGrid=Framed[Grid[
		(
		{{Text@"SO(3) irreps",Text@"Fundamental fields",Text@"Multiplicities"}}~Join~
		MapThread[{#1,#2,#3}&,{Text/@SpinParitySourceConstraints,
					Text/@CovariantSourceConstraints,
					Text/@Multiplicities}]
		)~Join~
		{{Text@"Total expected gauge generators:",SpanFromLeft,Text/@(Total@Multiplicities)}},
			Dividers->Center,
			Alignment->Left,
			Background->DetailColor],Background->DetailColor,FrameStyle->Directive[DetailColor,Thickness[4]]];
FinalGrid];
