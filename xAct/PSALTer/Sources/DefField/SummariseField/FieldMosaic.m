(*===============*)
(*  FieldMosaic  *)
(*===============*)

FieldMosaic[
		TheDecompositionTable_]:=Module[{
	DecompositionGroup=TheDecompositionTable,
	FinalGraphic},
	
	DecompositionGroup//=Vectorize;

	FinalGraphic={
			DecompositionGroup
	};

	FinalGraphic//=Column[#,
			Alignment->{Left,Center},
			Background->$PanelColor,
			Frame->False,
			Spacings->{1,1}]&;
FinalGraphic];
