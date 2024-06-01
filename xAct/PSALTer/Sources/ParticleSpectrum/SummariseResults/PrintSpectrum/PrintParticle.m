(*=================*)
(*  PrintParticle  *)
(*=================*)

IncludeHeader@"GetDiagram";

Options@PrintParticle={LaurentDepth->1};
PrintParticle[
	MassivePoleResidue_,
	SquareMass_,
	Spin_,
	Parity_,
	Polarisations_,
	OptionsPattern[]]:=Module[{TempGraphics,TheParity},

	TheParity=Switch[Parity,Even,"Even",Odd,"Odd"];

	If[SquareMass===0,

	Switch[OptionValue@LaurentDepth,
		1,	
		(
		TempGraphics=Row[{
			GetDiagram@"Quadratic.pdf",
			Framed[Grid[
			{
				{Text@"Quadratic pole",SpanFromLeft},
				{Text@"Pole residue: ",Text@ShowIfSmall@(MassivePoleResidue>0)},
				{Text@"Polarisations: ",Text@ShowIfSmall@(Polarisations)}
			},
			Dividers->Center,
			Alignment->Left],
				Background->DetailColor,
				FrameStyle->Directive[DetailColor,Thickness[4]],RoundingRadius->$FrameRoundingRadius]
		},Alignment->Center];
		),
		2,
		(
		TempGraphics=Row[{
			GetDiagram@"Quartic.pdf",
			Framed[Grid[
			{
				{Text@"Quartic pole",SpanFromLeft},
				{Text@"Pole residue: ",Text@ShowIfSmall@(0<MassivePoleResidue>0)},
				{Text@"Polarisations: ",Text@ShowIfSmall@(Polarisations)}
			},
			Dividers->Center,
			Alignment->Left],
				Background->DetailColor,
				FrameStyle->Directive[DetailColor,Thickness[4]],RoundingRadius->$FrameRoundingRadius]
		},Alignment->Center];
		),
		3,
		(
		TempGraphics=Row[{
			GetDiagram@"Hexic.pdf",
			Framed[Grid[
			{
				{Text@"Hexic pole",SpanFromLeft},
				{Text@"Pole residue: ",Text@ShowIfSmall@(0<MassivePoleResidue>0)},
				{Text@"Polarisations: ",Text@ShowIfSmall@(Polarisations)}
			},
			Dividers->Center,
			Alignment->Left],
				Background->DetailColor,
				FrameStyle->Directive[DetailColor,Thickness[4]],RoundingRadius->$FrameRoundingRadius]
		},Alignment->Center];
		)
	];
	,
	TempGraphics=Row[{
		GetDiagram@(TheParity<>(ToString@Spin)<>".pdf"),
		Framed[Grid[
		{
			{Text@"Massive particle",SpanFromLeft},
			{Text@"Pole residue: ",Text@ShowIfSmall@(MassivePoleResidue>0)},
			{Text@"Polarisations: ",Text@(2*Spin+1)},
			{Text@"Square mass: ",Text@ShowIfSmall@(SquareMass>0)},
			{Text@"Spin: ",Text@(Spin)},
			{Text@"Parity: ",Text@TheParity}
		},
		Dividers->Center,
		Alignment->Left],
			Background->DetailColor,
			FrameStyle->Directive[DetailColor,Thickness[4]],RoundingRadius->$FrameRoundingRadius]
	},Alignment->Center];
	];
TempGraphics];
