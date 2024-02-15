(*======================*)
(*  DecompositionTable  *)
(*======================*)

DecompositionTable[FieldTensors_,
	FieldTensorsSymmetries_,
	FieldTensorsExpanded_,
	SourceTensors_]:=Module[{FinalGrid},
	FinalGrid=Framed[Grid[
		(
		{{Text@"Fields",Text@"Symmetries",Text@"SO(3)",Text@"Sources"}}~Join~
		MapThread[{#1,#2,#3,#4}&,{Text/@FieldTensors,
					Text/@FieldTensorsSymmetries,
					Text/@FieldTensorsExpanded,
					Text/@SourceTensors}]
		),

			ItemSize->{Full,Full,{1,3}->90},
			Dividers->Center,
			Alignment->Left,
			Background->DetailColor],Background->DetailColor,FrameStyle->Directive[DetailColor,Thickness[4]]];
FinalGrid];
