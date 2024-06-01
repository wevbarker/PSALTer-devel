(*==================*)
(*  SummariseField  *)
(*==================*)

IncludeHeader@"ExpansionTable";
IncludeHeader@"DecompositionTable";
IncludeHeader@"PSALTerClassCollage";

SummariseField[]:=Module[{
	Class,
	BasicInfo,
	FieldSpinParityTensors,
	FieldSpinParityTensorsSymmetries,
	FieldSpinParityTensorsExpanded,
	SourceSpinParityTensors,
	TheExpansionTable,
	FieldTensors,
	FieldTensorsSymmetries,
	FieldTensorsDecomposed,
	SourceTensors,
	TheDecompositionTable,
	ThePSALTerClassCollage
	},

	Class=FieldAssociation@Context[];

	FieldSpinParityTensors=Flatten@Values@(Flatten/@(Values/@(Values/@(Class@FieldSpinParityTensorHeads))));
	FieldSpinParityTensors//=((FromIndexFree@ToIndexFree@#)&/@#)&;
	FieldSpinParityTensorsSymmetries=SymmetryOf/@FieldSpinParityTensors;
	(*FieldSpinParityTensorsSymmetries=SymmetryGroupOfTensor/@FieldSpinParityTensors;*)
	FieldSpinParityTensorsExpanded=(Class@ExpandFields)/@FieldSpinParityTensors;
	SourceSpinParityTensors=Flatten@Values@(Flatten/@(Values/@(Values/@(Class@SourceSpinParityTensorHeads))));
	SourceSpinParityTensors//=((FromIndexFree@ToIndexFree@#)&/@#)&;

	TheExpansionTable=ExpansionTable[FieldSpinParityTensors,
		FieldSpinParityTensorsSymmetries,
		FieldSpinParityTensorsExpanded,
		SourceSpinParityTensors];

	FieldTensors=Class@Tensors;
	FieldTensors//=((FromIndexFree@ToIndexFree@#)&/@#)&;
	FieldTensorsSymmetries=SymmetryOf/@FieldTensors;
	(*FieldTensorsSymmetries=SymmetryGroupOfTensor/@FieldTensors;*)
	FieldTensorsDecomposed=(Class@DecomposeFields)/@FieldTensors;
	SourceTensors=Class@Sources;
	SourceTensors//=((FromIndexFree@ToIndexFree@#)&/@#)&;

	BasicInfo=Framed[Grid[{{Text@"Momentum",
		Text@"Norm",
		Text@"Frame"},
		{Text@(P[m]),
		Text@(Def^2==P[m]*P[-m]),
		Text@(V[m]==P[m]/Def)}},
		ItemSize->Large,
		Dividers->Center,
		Alignment->Left,
		Background->DetailColor],Background->DetailColor,
			FrameStyle->Directive[DetailColor,Thickness[4]]];

	TheDecompositionTable=DecompositionTable[FieldTensors,
		FieldTensorsSymmetries,
		FieldTensorsDecomposed,
		SourceTensors];
	If[!$CLI,
		ThePSALTerClassCollage=PSALTerClassCollage[
					BasicInfo,
					TheDecompositionTable,
					TheExpansionTable];
		Export[FileNameJoin@{$WorkingDirectory,"FieldKinematics"<>(StringReplace[Context[],{"xAct"->"","PSALTer"->"","`"->""}])<>".pdf"},
			ThePSALTerClassCollage
		];
		Print@ThePSALTerClassCollage;
	];
];
