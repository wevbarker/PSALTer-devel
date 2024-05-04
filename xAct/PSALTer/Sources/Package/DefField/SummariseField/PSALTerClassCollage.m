(*=======================*)
(*  PSALTerClassCollage  *)
(*=======================*)

PSALTerClassCollage[
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
			MakeLabel["Field kinematics",20],
			BasicInfoGroup,
			MakeLabel@"Fundamental fields",
			DecompositionGroup,
			MakeLabel@"SO(3) irreps",
			ExpansionGroup	
	};

	FinalGraphic//=Column[#,
			Alignment->{Left,Center},
			Background->PanelColor,
			Frame->True,
			Spacings->{1,1}]&;
FinalGraphic];
