(*===============*)
(*  FieldMosaic  *)
(*===============*)

FieldMosaic[
		BasicInfo_,
		TheDecompositionTable_,
		TheExpansionTable_]:=Module[{
	BasicInfoGroup=BasicInfo,
	DecompositionGroup=TheDecompositionTable,
	ExpansionGroup=TheExpansionTable,
	FinalGraphic},
	
	BasicInfoGroup//=Vectorize;
	DecompositionGroup//=Vectorize;
	ExpansionGroup//=Vectorize;

	FinalGraphic={
			BasicInfoGroup,
			DecompositionGroup,
			ExpansionGroup	
	};

	FinalGraphic//=Column[#,
			Alignment->{Left,Center},
			Background->$PanelColor,
			Frame->False,
			Spacings->{1,1}]&;
FinalGraphic];
