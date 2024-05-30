(*============================*)
(*  PrintUnitarityConditions  *)
(*============================*)

PrintUnitarityConditionsList[InputExpr_]:=Module[{
	FinalGrid,
	OptionNames=Table["Unitarity option "<>ToString@OptionNumber<>":",
				{OptionNumber,1,Length@InputExpr}]
	},
	FinalGrid=Framed[
			Grid[
			(
			{{Text@("Number of ways to achieve unitarity: "<>ToString@Length@InputExpr),
				SpanFromLeft}}~Join~
			MapThread[{#1,#2}&,{Text/@OptionNames,Text/@InputExpr}]
			),
			Dividers->Center,
			Alignment->Left,
			Background->DetailColor],
		Background->DetailColor,
		FrameStyle->Directive[DetailColor,Thickness[4]]];
FinalGrid];

PrintUnitarityConditions[InputExpr_]:=If[ListQ@InputExpr,
						(*PrintUnitarityConditionsList[InputExpr],*)
						(*Map[Text,First@InputExpr,Infinity],*)
						Map[Text,First@InputExpr],
						InputExpr];
