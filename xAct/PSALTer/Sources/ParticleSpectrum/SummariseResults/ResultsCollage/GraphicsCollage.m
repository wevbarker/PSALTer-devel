(*===================*)
(*  GraphicsCollage  *)
(*===================*)

IncludeHeader@"ShrinkPackRectangles";

GraphicsCollage[InputExpr_?ListQ,CollageWidth_?IntegerQ]:=Module[{
		GraphicsDimensions,
		MaxWidth,
		PackedGraphicsDimensions,
		FrameSize,
		Packing,
		Flipped,
		GraphicsContent,
		PackedGraphicsCoordinates,
		ScalingError,
		FinalGraphicsCollage},

	GraphicsDimensions=ImageDimensions/@(InputExpr);
	MaxWidth=Max@{CollageWidth,500};
	FrameSize={Ceiling[5.*#],Ceiling[1.01*#]}&@(MaxWidth);
	{FrameSize,Packing}=ShrinkPackRectangles[FrameSize,GraphicsDimensions];
	CollageSize=Max/@Transpose@((#[[2]])&/@Packing);
	DummyPacking=Graphics[{FaceForm[LightYellow],
				EdgeForm[Black],
				{LightBlue,
				Rectangle[{0,0},FrameSize],
				LightYellow}~Join~(Rectangle@@@Packing)},
				Frame->True];
	PackedGraphicsDimensions=(Minus@(Subtract@@#))&/@Packing;
	Permutation=(Sort/@GraphicsDimensions)~FindPermutation~(Sort/@PackedGraphicsDimensions);
	Flipped=MapThread[(If[#1==#2,False,True,True])&,
				{GraphicsDimensions~Permute~Permutation,PackedGraphicsDimensions}];
	GraphicsContent=(If[#2,Rotate[#1,Pi/2],#1])&~MapThread~{InputExpr~Permute~Permutation,
								Flipped};
	PackedGraphicsCoordinates=(N/@Simplify@((1/2)*Plus@@#))&/@Packing;
	Insets=MapThread[Inset[Magnify[#1,0.95],#2]&,
				{GraphicsContent,PackedGraphicsCoordinates}];
	MakeGraphicsCollage[Insets_,ImageSizeScale_]:=Graphics[Insets,
			Background->$PanelColor,
			Frame->False,
			PlotRange->{{0,CollageSize[[1]]},{0,CollageSize[[2]]}},
			ImagePadding->None,
			ImageSize->ImageSizeScale*CollageSize];
	FinalGraphicsCollage=MakeGraphicsCollage[Insets,1];
	ScalingError=(N@(#1/#2))&~MapThread~{CollageSize,ImageDimensions@FinalGraphicsCollage};
	ScalingError//=Total;
	ScalingError/=2;
	FinalGraphicsCollage=MakeGraphicsCollage[Insets,ScalingError];
	If[(ImageDimensions@FinalGraphicsCollage)[[2]]>=(ImageDimensions@FinalGraphicsCollage)[[1]],
		FinalGraphicsCollage//=Rotate[#,-Pi/2]&];

FinalGraphicsCollage];
