(*======================*)
(*  DecompositionTable  *)
(*======================*)

DecompositionTable[FieldTensors_,
	FieldTensorsSymmetries_,
	FieldTensorsExpanded_,
	SourceTensors_]:=Module[{FinalGrid},
	FinalGrid=Framed[Grid[
		(
		{{Text@"Fundamental field",Text@"Symmetries",Text@"Decomposition in SO(3) irreps",Text@"Source"}}~Join~
		MapThread[{#1,#2,#3,#4}&,{Text/@FieldTensors,
					Text/@FieldTensorsSymmetries,
					Text/@FieldTensorsExpanded,
					Text/@SourceTensors}]
		),
			ItemSize->{Full,Full,{1,3}->70},
			Dividers->Center,
			Alignment->{Left,Center}],Background->DetailColor,FrameStyle->Directive[DetailColor,Thickness[4]],RoundingRadius->$FrameRoundingRadius];
FinalGrid];
