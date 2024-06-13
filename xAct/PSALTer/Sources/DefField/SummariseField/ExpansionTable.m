(*==================*)
(*  ExpansionTable  *)
(*==================*)

ExpansionTable[FieldSpinParityTensors_,
	FieldSpinParityTensorsSymmetries_,
	FieldSpinParityTensorsExpanded_,
	SourceSpinParityTensors_]:=Module[{FinalGrid},
	FinalGrid=(
		{{Text@"SO(3) irrep",Text@"Symmetries",Text@"Expansion in terms of the fundamental field",Text@"Source"}}~Join~
		MapThread[{#1,#2,#3,#4}&,{Text/@FieldSpinParityTensors,
					Text/@FieldSpinParityTensorsSymmetries,
					Text/@FieldSpinParityTensorsExpanded,
					Text/@SourceSpinParityTensors}]
		);
FinalGrid];
