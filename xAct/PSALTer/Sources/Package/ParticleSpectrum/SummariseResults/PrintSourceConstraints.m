(*==========================*)
(*  PrintSourceConstraints  *)
(*==========================*)

PrintSourceConstraints[]:=DetailCell@Text@"(No source constraints)";
PrintSourceConstraints[SpinParitySourceConstraints_,
	CovariantSourceConstraints_,
	Multiplicities_]:=Module[{FinalGrid},
	FinalGrid=Framed[Grid[
		(
		{{Text@"Spin-parity form",Text@"Covariant form",Text@"Multiplicities"}}~Join~
		MapThread[{#1,#2,#3}&,{SpinParitySourceConstraints,
					CovariantSourceConstraints,
					Multiplicities}]
		)~Join~
		{{Text@"Total expected gauge generators:",SpanFromLeft,Total@Multiplicities}},
			Dividers->Center,
			Alignment->Left,
			Background->DetailColor],Background->DetailColor,FrameStyle->Directive[DetailColor,Thickness[4]]];
FinalGrid];
