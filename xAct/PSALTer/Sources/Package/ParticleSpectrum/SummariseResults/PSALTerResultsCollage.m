(*=========================*)
(*  PSALTerResultsCollage  *)
(*=========================*)

PSALTerResultsCollage[
		TheSummaryOfTheory_,
		TheWaveOperator_,
		ThePropagator_,
		TheSourceConstraints_,
		TheSpectrum_,
		TheMasslessSpectrum_,
		TheOverallUnitarity_]:=Module[{
	WaveOperatorGroup=TheWaveOperator,
	SpectrumGroup=TheSpectrum,
	MasslessSpectrumGroup=TheMasslessSpectrum,
	FinalImageResolution=200,
	FinalImageWidth=500,
	GridSpacing=Scaled[0.01],
	UpperHalf,
	LowerHalf,
	FinalImage,
	RasterFinalImage,
	$RasterIncomplete=True},
	
	UpperHalf={
		{MakeLabel@"PSALTer results panel",	
			SpanFromLeft,
			SpanFromLeft},
		{MakeLabel@"Wave operator",
			SpanFromLeft,
			SpanFromLeft},
		{WaveOperatorGroup,
			SpanFromLeft,
			SpanFromLeft}
	};

	LowerHalf={
		{MakeLabel@"Source constraints",
			MakeLabel@"Massive spectrum",
			MakeLabel@"Massless spectrum"},
		{TheSourceConstraints,
			SpectrumGroup,
			MasslessSpectrumGroup},
		{MakeLabel@"Unitarity conditions",
			SpanFromLeft,
			SpanFromLeft},
		{TheOverallUnitarity,
			SpanFromLeft,
			SpanFromLeft}
	};

	IfNotSpanFromLeft[InputImage_,ApplyFunction_]:=(Map[If[!(#==SpanFromLeft),ApplyFunction@#,#,ApplyFunction@#]&,InputImage,{2}]);

	UpperHalf=UpperHalf~IfNotSpanFromLeft~(If[ListQ@#,#,{#},{#}]&);
	UpperHalf=UpperHalf~IfNotSpanFromLeft~((Rasterize[#,
				Background->PanelColor,
				ImageResolution->UpperHalfResolution]&/@#)&);
	UpperHalf=UpperHalf~IfNotSpanFromLeft~(ImageCollage[
				MapThread[(#1->#2)&,
					{(Times@@#)&/@(ImageDimensions/@#),#}],
					Background->PanelColor,
					ImagePadding->4]&);
	UpperHalf=UpperHalf~IfNotSpanFromLeft~(Image[#,Magnification->1]&);
	UpperHalf//=Grid[#,
			Spacings->{GridSpacing,GridSpacing},
			Background->PanelColor,
			Alignment->{Left,Center}]&;

	LowerHalf=LowerHalf~IfNotSpanFromLeft~(If[ListQ@#,#,{#},{#}]&);
	LowerHalf=LowerHalf~IfNotSpanFromLeft~((Rasterize[#,
				Background->PanelColor,
				ImageResolution->LowerHalfResolution]&/@#)&);
	LowerHalf=LowerHalf~IfNotSpanFromLeft~(ImageCollage[
				MapThread[(#1->#2)&,
					{(Times@@#)&/@(ImageDimensions/@#),#}],
					Background->PanelColor,
					ImagePadding->4]&);
	LowerHalf=LowerHalf~IfNotSpanFromLeft~(Image[#,Magnification->1]&);
	LowerHalf//=Grid[#,
			Spacings->{GridSpacing,GridSpacing},
			Background->PanelColor,
			Alignment->{Left,Center}]&;

	FinalImage=Grid[{{UpperHalf},{LowerHalf}},
			Spacings->{GridSpacing,GridSpacing},
			Frame->True,
			BaselinePosition->Center,
			Background->PanelColor,
			Alignment->{Left,Center}];
	FinalImageResolution=400;
	While[$RasterIncomplete,
		Check[
			$RasterIncomplete=False;
			RasterFinalImage=Rasterize[#,
						Background->PanelColor,
						ImageResolution->FinalImageResolution]&@FinalImage;
		,	
			$RasterIncomplete=True;
			FinalImageResolution*=0.9;
		];	
	];
RasterFinalImage];
