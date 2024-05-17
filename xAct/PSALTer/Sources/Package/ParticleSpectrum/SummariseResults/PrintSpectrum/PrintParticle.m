(*=================*)
(*  PrintParticle  *)
(*=================*)

BuildPackage@"ParticleSpectrum/SummariseResults/PrintSpectrum/PrintParticle/GetDiagram.m";

Options@PrintParticle={LaurentDepth->1};
PrintParticle[
	MassivePoleResidue_,
	SquareMass_,
	Spin_,
	Parity_,
	Polarisations_,
	OptionsPattern[]]:=Module[{TempGraphics},

	If[SquareMass===0,

	Switch[OptionValue@LaurentDepth,
		1,	
		(
		TempGraphics=Column[{
			Labeled[GetDiagram@"Quadratic.pdf",
				Text@"Massless particle"],
			Framed[Grid[
			{
				{Text@"Pole residue: ",Text@ShowIfSmall@(MassivePoleResidue>0)},
				{Text@"Polarisations: ",Text@ShowIfSmall@(Polarisations)}
			},
			Dividers->Center,
			Alignment->Left,
			Background->DetailColor],
				Background->DetailColor,
				FrameStyle->Directive[DetailColor,Thickness[4]]]
		},Alignment->Center];
		),
		2,
		(
		TempGraphics=Column[{
			Labeled[GetDiagram@"Quartic.pdf",
				Text@"Quartic pole"],
			Framed[Grid[
			{
				{Text@"Pole residue: ",Text@ShowIfSmall@(0<MassivePoleResidue>0)},
				{Text@"Polarisations: ",Text@ShowIfSmall@(Polarisations)}
			},
			Dividers->Center,
			Alignment->Left,
			Background->DetailColor],
				Background->DetailColor,
				FrameStyle->Directive[DetailColor,Thickness[4]]]
		},Alignment->Center];
		),
		3,
		(
		TempGraphics=Column[{
			Labeled[GetDiagram@"Hexic.pdf",
				Text@"Hexic pole"],
			Framed[Grid[
			{
				{Text@"Pole residue: ",Text@ShowIfSmall@(0<MassivePoleResidue>0)},
				{Text@"Polarisations: ",Text@ShowIfSmall@(Polarisations)}
			},
			Dividers->Center,
			Alignment->Left,
			Background->DetailColor],
				Background->DetailColor,
				FrameStyle->Directive[DetailColor,Thickness[4]]]
		},Alignment->Center];
		)
	];
	,
	TempGraphics=Column[{
		Labeled[GetDiagram@((ToString@Parity)<>(ToString@Spin)<>".pdf"),
			Text@"Massive particle"],
		Framed[Grid[
		{
			{Text@"Pole residue: ",Text@ShowIfSmall@(MassivePoleResidue>0)},
			{Text@"Square mass: ",Text@ShowIfSmall@(SquareMass>0)},
			{Text@"Spin: ",Text@(Spin)},
			{Text@"Parity: ",Text@(Parity)}
		},
		Dividers->Center,
		Alignment->Left,
		Background->DetailColor],
			Background->DetailColor,
			FrameStyle->Directive[DetailColor,Thickness[4]]]
	},Alignment->Center];
	];
TempGraphics];
