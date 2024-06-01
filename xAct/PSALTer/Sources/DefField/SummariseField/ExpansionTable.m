(*==================*)
(*  ExpansionTable  *)
(*==================*)

ExpansionTable[FieldSpinParityTensors_,
	FieldSpinParityTensorsSymmetries_,
	FieldSpinParityTensorsExpanded_,
	SourceSpinParityTensors_]:=Module[{FinalGrid},
	FinalGrid=Framed[Grid[
		(
		{{Text@"SO(3) irrep",Text@"Symmetries",Text@"Expansion in terms of the fundamental field",Text@"Source"}}~Join~
		MapThread[{#1,#2,#3,#4}&,{Text/@FieldSpinParityTensors,
					Text/@FieldSpinParityTensorsSymmetries,
					Text/@FieldSpinParityTensorsExpanded,
					Text/@SourceSpinParityTensors}]
		),
			ItemSize->{Full,Full,{1,3}->50},
			Dividers->Center,
			Alignment->{Left,Center},
			Background->DetailColor],Background->DetailColor,FrameStyle->Directive[DetailColor,Thickness[4]]];
FinalGrid];
