(*==================*)
(*  SummariseClass  *)
(*==================*)

BuildPackage@"DefClass/SummariseClass/ExpansionTable.m";
BuildPackage@"DefClass/SummariseClass/DecompositionTable.m";
BuildPackage@"DefClass/SummariseClass/PSALTerClassCollage.m";

SummariseClass[ClassName_?StringQ]:=Module[{
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

	Class=Evaluate@Symbol@ClassName;

	FieldSpinParityTensors=Flatten@Values@(Flatten/@(Values/@(Values/@(Class@FieldSpinParityTensorHeads))));
	FieldSpinParityTensors//=((FromIndexFree@ToIndexFree@#)&/@#)&;
	FieldSpinParityTensorsSymmetries=SymmetryGroupOfTensor/@FieldSpinParityTensors;
	FieldSpinParityTensorsExpanded=(Class@ExpandFields)/@FieldSpinParityTensors;
	SourceSpinParityTensors=Flatten@Values@(Flatten/@(Values/@(Values/@(Class@SourceSpinParityTensorHeads))));
	SourceSpinParityTensors//=((FromIndexFree@ToIndexFree@#)&/@#)&;

	TheExpansionTable=ExpansionTable[FieldSpinParityTensors,
		FieldSpinParityTensorsSymmetries,
		FieldSpinParityTensorsExpanded,
		SourceSpinParityTensors];

	FieldTensors=Class@Tensors;
	FieldTensors//=((FromIndexFree@ToIndexFree@#)&/@#)&;
	FieldTensorsSymmetries=SymmetryGroupOfTensor/@FieldTensors;
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

	If[$ExportPDF,

		ThePSALTerClassCollage=PSALTerClassCollage[
					BasicInfo,
					TheDecompositionTable,
					TheExpansionTable];
		Print@ThePSALTerClassCollage;
		Export[FileNameJoin@{$WorkingDirectory,ClassName<>".pdf"},
			ThePSALTerClassCollage
		];
	];
];
