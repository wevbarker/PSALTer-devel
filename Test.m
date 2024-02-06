(*========*)
(*  Test  *)
(*========*)
(*
<<MaTeX`;

ConfigureMaTeX["pdfLaTeX" -> "/usr/bin/lualatex", "Ghostscript" -> "/usr/bin/gs"];
SetOptions[MaTeX, "Preamble" -> {"\\RequirePackage{luatex85,shellesc}\\usepackage[compat=1.1.0]{tikz-feynman}\\usepgflibrary{arrows,patterns}"}];

TikzSet="\\tikzset{
	Tensor/.style={decorate, decoration={snake, amplitude=.8mm, segment length=1.5mm, pre length=.5mm, post length=.5mm}, double},
	Spin3/.style={decorate, decoration={zigzag, amplitude=.8mm, segment length=1.5mm, pre length=.5mm, post length=.5mm}, double}
	}";
OpenDiagram="
	\\tikzfeynmanset{
	myblob/.style={
pattern=north east lines,
shape=circle,
draw=blue}
	}
	\\feynmandiagram[medium,horizontal=a to b]{
	i1[particle=\(?\),gray!50] --[thick,gray!50] a [crossed dot, thick,gray!50],

	i2[particle=\(?\),gray!50] --[thick,gray!50] a,
	a ";
CloseDiagram=" b[myblob],
		a --[draw=none, momentum={\\tiny{\(k^{\mu}=(p,0,0,p)\)}}] b,
		b --[thick,gray!50] f1[particle=\(?\),gray!50],
		b --[thick,gray!50] f2[particle=\(?\),gray!50],
		b --[thick,gray!50] f3[particle=\(?\),gray!50]};";	
Expr=MaTeX[TikzSet<>OpenDiagram<>"--[thick]"<>CloseDiagram,Magnification->1.3,"LogFileFunction" -> Print];
Print@Expr;
Expr//=Rasterize;
Print@Expr;

Quit[];
*)

ParityEvenColor=RGBColor[255/255,204/255,204/255];
ParityOddColor=RGBColor[204/255,229/255,255/255];
ParityMixColor=RGBColor[255/255,204/255,255/255];
PanelColor=RGBColor[248/255,255/255,248/255];
DetailColor=LightGreen;
(*DetailColor=RGBColor[230/255,230/255,230/255];*)

MakeLabel[SomeString_]:=Text@Style[SomeString,FontSize->18,Bold];

WignerGrid[AllMatrices_,Sizes_,Spins_,Sides_,Tops_]:=Module[{
SpinParities,
Mask,
AllElements,
EndCells,
StartCells,
Frames,
InnerFrames,
Cols
},

SpinParities=Table[Superscript[ToString@i,j],{i,Spins},{j,{"+","-"}}]~Take~Length@Spins;
TheSides=Sides~Take~Length@Spins;
TheTops=Tops~Take~Length@Spins;
Mask=ArrayPad[Normal@BlockDiagonalMatrix@Map[(True)&,AllMatrices,{3}],{{1,0},{1,0}}]/.{0->False};
AllElements=Normal@BlockDiagonalMatrix@AllMatrices;
AllElements=ArrayPad[AllElements,{{1,0},{1,0}}];
AllElements=MapThread[If[#2,#1,Null]&,{AllElements,Mask},2];

EndCells=(Accumulate@Flatten@Sizes)~Partition~2;
StartCells=EndCells-(Sizes/.{0->1});
StartCells=Map[(#+1)&,StartCells,{2}];

Alignments={};

MapThread[
(
Which[
#4[[1]]==0,
	Table[Alignments=Alignments~Join~{{#1[[2]]+j,#1[[1]]+1}->{Right,Center}},{j,Length@#5}];
	Table[Alignments=Alignments~Join~{{#1[[1]]+1,#1[[2]]+j}->{Center,Bottom}},{j,Length@#5}];
	Table[AllElements[[#1[[2]]+j,#1[[1]]+1]]=#5[[j]],{j,Length@#5}];
	Table[AllElements[[#1[[1]]+1,#1[[2]]+j]]=#6[[j]],{j,Length@#6}];,
#4[[2]]==0,
	Table[Alignments=Alignments~Join~{{#1[[1]]+j,#1[[1]]}->{Right,Center}},{j,Length@#5}];
	Table[Alignments=Alignments~Join~{{#1[[1]],#1[[1]]+j}->{Center,Bottom}},{j,Length@#5}];
	Table[AllElements[[#1[[1]]+j,#1[[1]]]]=#5[[j]],{j,Length@#5}];
	Table[AllElements[[#1[[1]],#1[[1]]+j]]=#6[[j]],{j,Length@#6}];,
(!(#4[[1]]==0))&&(!(#4[[2]]==0)),
	Table[Alignments=Alignments~Join~{{#1[[1]]+j,#1[[1]]}->{Right,Center}},{j,Length@#5}];
	Table[Alignments=Alignments~Join~{{#1[[1]],#1[[1]]+j}->{Center,Bottom}},{j,Length@#5}];
	Table[AllElements[[#1[[1]]+j,#1[[1]]]]=#5[[j]],{j,Length@#5}];
	Table[AllElements[[#1[[1]],#1[[1]]+j]]=#6[[j]],{j,Length@#6}];
];
)&,
{StartCells,EndCells,SpinParities,Sizes,TheSides,TheTops},1];

OuterDirective=Directive[Black,Thick];
InnerDirective=Directive[Black,Thickness@Medium];

Frames=MapThread[
(
Which[
#3[[1]]==0,
	{
	{{#1[[2]]+1,#2[[2]]+1},{#1[[2]]+1,#2[[2]]+1}}->OuterDirective
	},
#3[[2]]==0,
	{
	{{#1[[1]]+1,#2[[1]]+1},{#1[[1]]+1,#2[[1]]+1}}->OuterDirective
	},
(!(#3[[1]]==0))&&(!(#3[[2]]==0)),
	{
	{{#1[[1]]+1,#2[[2]]+1},{#1[[1]]+1,#2[[2]]+1}}->OuterDirective,
	{{#1[[1]]+1,#2[[1]]+1},{#1[[1]]+1,#2[[1]]+1}}->OuterDirective,
	{{#1[[2]]+1,#2[[2]]+1},{#1[[2]]+1,#2[[2]]+1}}->OuterDirective
	}
]
)&,
{StartCells,EndCells,Sizes}
];
Frames//=Flatten;

InnerFrames=MapThread[
(
Which[
#3[[1]]==0,
	Table[
	{
	{{#1[[2]]+1,#2[[2]]+1},{#1[[2]]+1,qf}}->InnerDirective,
	{{#1[[2]]+1,qf},{#1[[2]]+1,#2[[2]]+1}}->InnerDirective
	},
	{qf,#1[[2]]+1,#2[[2]]+1}]
	,
#3[[2]]==0,
	Table[
	{
	{{#1[[1]]+1,#2[[1]]+1},{#1[[1]]+1,qf}}->InnerDirective,
	{{#1[[1]]+1,qf},{#1[[1]]+1,#2[[1]]+1}}->InnerDirective
	},
	{qf,#1[[1]]+1,#2[[1]]+1}],
(!(#3[[1]]==0))&&(!(#3[[2]]==0)),
	Table[
	{
	{{#1[[1]]+1,#2[[2]]+1},{#1[[1]]+1,qf}}->InnerDirective,
	{{#1[[1]]+1,qf},{#1[[1]]+1,#2[[2]]+1}}->InnerDirective
	},
	{qf,#1[[1]]+1,#2[[2]]+1}]
]
)&,
{StartCells,EndCells,Sizes}
];
InnerFrames//=Flatten;

Cols=MapThread[
(
Which[
#3[[1]]==0,
	Table[{i,j}->ParityOddColor,{i,#1[[2]]+1,#2[[2]]+1},{j,#1[[2]]+1,#2[[2]]+1}],
#3[[2]]==0,
	Table[{i,j}->ParityEvenColor,{i,#1[[1]]+1,#2[[1]]+1},{j,#1[[1]]+1,#2[[1]]+1}],
(!(#3[[1]]==0))&&(!(#3[[2]]==0)),
	Join[
	Table[{i,j}->ParityEvenColor,{i,#1[[1]]+1,#2[[1]]+1},{j,#1[[1]]+1,#2[[1]]+1}],
	Table[{i,j}->ParityOddColor,{i,#1[[2]]+1,#2[[2]]+1},{j,#1[[2]]+1,#2[[2]]+1}],
	Table[{i,j}->ParityMixColor,{i,#1[[1]]+1,#2[[1]]+1},{j,#1[[2]]+1,#2[[2]]+1}],
	Table[{i,j}->ParityMixColor,{i,#1[[2]]+1,#2[[2]]+1},{j,#1[[1]]+1,#2[[1]]+1}]
	]
]
)&,
{StartCells,EndCells,Sizes}
];
	Cols//=Flatten;


Frames=InnerFrames~Join~Frames;

(*,ItemSize->All*)
Grid[Map[If[#==Null,Null,Text@#,Text@#]&,AllElements,{2}],Background->{None,None,Cols},Frame->{None,None,Frames},Alignment->{Center,Center,Alignments},ItemSize->Full]];

SplitWignerGrid[AllMatrices_,Sizes_,Spins_,Sides_,Tops_]:=(WignerGrid@@#)&/@MapThread[
	(List/@{#1,#2,#3,#4,#5})&,
	{AllMatrices,Sizes,Spins,Sides,Tops}];

Vectorize[InputExpr_]:=Module[{TemporaryFileName,Expr},
	TemporaryFileName=FileNameJoin@{NotebookDirectory[],"tmp/Vectorized"<>".pdf"};
	TemporaryFileName~Export~InputExpr;
	Expr=TemporaryFileName~Import~{"PDF","PageGraphics"};
	Expr//=First;
Expr];

<<JasonB`RectanglePacking`;


GraphicsCollage[InputExpr_]:=InputExpr;
GraphicsCollage[InputExpr__]:=GraphicsCollage[InputExpr,1];
GraphicsCollage[InputExpr__,CollageWidth_?IntegerQ]:=Module[{
		GraphicsDimensions,
		PackedGraphicsDimensions,
		FrameSize,
		Packing,
		Flipped,
		GraphicsContent,
		PackedGraphicsCoordinates,
		ScalingError,
		FinalGraphicsCollage},

	GraphicsDimensions=ImageDimensions/@(List@InputExpr);
	FrameSize={Ceiling[0.9*#],Ceiling[1.1*#]}&@(Max@(First/@GraphicsDimensions));
	Packing=PackRectangles[FrameSize,GraphicsDimensions,Method->$MaxRectangles];
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
	GraphicsContent=(If[#2,Rotate[#1,Pi/2],#1])&~MapThread~{{InputExpr}~Permute~Permutation,
								Flipped};
	PackedGraphicsCoordinates=(N/@Simplify@((1/2)*Plus@@#))&/@Packing;
	Insets=MapThread[Inset[Magnify[#1,1],#2]&,
				{GraphicsContent,PackedGraphicsCoordinates}];
	MakeGraphicsCollage[Insets_,ImageSizeScale_]:=Graphics[Insets,
			Background->PanelColor,
			Frame->False,
			PlotRange->{{0,CollageSize[[1]]},{0,CollageSize[[2]]}},
			ImagePadding->None,
			ImageSize->ImageSizeScale*CollageSize];
	FinalGraphicsCollage=MakeGraphicsCollage[Insets,1];
	ScalingError=(N@(#1/#2))&~MapThread~{CollageSize,ImageDimensions@FinalGraphicsCollage};
	ScalingError//=Total;
	ScalingError/=2;
	FinalGraphicsCollage=MakeGraphicsCollage[Insets,ScalingError];

FinalGraphicsCollage];

(*Print@$RectanglePackingMethods;*)


(*
	LowerHalf=Graphics[{Inset[img, {2, 3}],Inset[img, {2.5, 3}]}, Frame -> False];
*)


PSALTerResultsCollage[
		TheSummaryOfTheory_,
		TheWaveOperator_,
		TheSourceConstraints_,
		TheSpectrum_,
		TheMasslessSpectrum_,
		TheOverallUnitarity_]:=Module[{
	WaveOperatorGroup=TheWaveOperator,
	SpectrumGroup=Join[TheSpectrum,TheMasslessSpectrum],
	TheoryGroup=Join[TheSummaryOfTheory,TheSourceConstraints,TheOverallUnitarity],
	FinalImageResolution=100,
	FinalImageWidth=500,
	FinalImage,
	UpperHalf,
	LowerHalf,
	RasterFinalImage,
	$RasterIncomplete=True},

	UpperHalf={
			{MakeLabel@"Massive spectrum",MakeLabel@"Massless spectrum",MakeLabel@"Massless spectrum"},
			{SpectrumGroup,TheoryGroup,TheoryGroup}
		};

	IfNotSpanFromLeft[InputImage_,ApplyFunction_]:=(Map[If[!(#==SpanFromLeft),ApplyFunction@#,#,ApplyFunction@#]&,InputImage,{2}]);

(*
	UpperHalf=UpperHalf~IfNotSpanFromLeft~(If[ListQ@#,#,{#},{#}]&);
	UpperHalf=UpperHalf~IfNotSpanFromLeft~((Rasterize[#,
				Background->PanelColor,
				ImageResolution->FinalImageResolution]&/@#)&);
	UpperHalf=UpperHalf~IfNotSpanFromLeft~((ImageGraphics[#]&/@#)&);
	UpperHalf=UpperHalf~IfNotSpanFromLeft~(ImageCollage[
				MapThread[(#1->#2)&,
					{(Times@@#)&/@(ImageDimensions/@#),#}],
					Background->PanelColor,
					ImagePadding->4]&);
	UpperHalf=UpperHalf~IfNotSpanFromLeft~(Image[#,Magnification->1]&);
	UpperHalf//=Grid[#,
			Spacings->{0,0},
			BaselinePosition->Center,
			Background->PanelColor,
			Alignment->{Left,Center}]&;
	(*Print@UpperHalf;*)
*)
	LowerHalf={
			{MakeLabel@"PSALTer results panel",SpanFromLeft,SpanFromLeft},
			{MakeLabel@"Wave operator",SpanFromLeft,SpanFromLeft},
			{WaveOperatorGroup,SpanFromLeft,SpanFromLeft},
			{MakeLabel@"Massive spectrum",MakeLabel@"Massless spectrum",MakeLabel@"Massless spectrum"},
			{SpectrumGroup,TheoryGroup,TheoryGroup}
		};

	LowerHalf=LowerHalf~IfNotSpanFromLeft~(If[ListQ@#,#,{#},{#}]&);
(*
	LowerHalf=LowerHalf~IfNotSpanFromLeft~((Rasterize[#,
				Background->PanelColor,
				ImageResolution->FinalImageResolution]&/@#)&);
	LowerHalf=LowerHalf~IfNotSpanFromLeft~((ImageGraphics[#]&/@#)&);
*)
	LowerHalf=LowerHalf~IfNotSpanFromLeft~((Vectorize[#]&/@#)&);
	Print@LowerHalf;
(*
	LowerHalf=LowerHalf~IfNotSpanFromLeft~(ImageCollage[
				MapThread[(#1->#2)&,
					{(Times@@#)&/@(ImageDimensions/@#),#}],
					Background->PanelColor,
					ImagePadding->4]&);
*)
	LowerHalf=Vectorize/@WaveOperatorGroup;
	Print@LowerHalf;
	LowerHalf=GraphicsCollage@@LowerHalf;
	Print@LowerHalf;


Export[FileNameJoin@{NotebookDirectory[],"Test"<>".pdf"},
			LowerHalf
		];

	Quit[];
	(*LowerHalf=Graphics[{Inset[img, {2, 3}],Inset[img, {2.5, 3}]}, Frame -> False];*)
	LowerHalf=LowerHalf~IfNotSpanFromLeft~(WordCloud[
				MapThread[(#1->#2)&,
					{(1&)/@#,#}],
					Rectangle[{0,0},
						{Max@Flatten@(ImageDimensions/@#),
						Max@Flatten@(ImageDimensions/@#)}],
					ScalingFunctions->(#&),
					PreprocessingRules->{Expr_->Magnify[Expr,1]},
					Background->PanelColor,
					WordSpacings->0]&);
	Print@LowerHalf;
	(*LowerHalf=LowerHalf~IfNotSpanFromLeft~(Image[#,Magnification->1]&);*)
	Print@LowerHalf;
	LowerHalf//=Grid[#,
			Alignment->{Left,Center},
			Background->PanelColor,
			ImageSize->Small
			BaselinePosition->Center,
			Spacings->{0,0}]&;
	Print@LowerHalf;
(*
	FinalImage=Grid[{{LowerHalf},{UpperHalf}},
			Spacings->{0,0},
			Frame->True,
			BaselinePosition->Center,
			Background->PanelColor,
			Alignment->{Left,Center}];

(*
	FinalImageResolution=80;
	While[$RasterIncomplete,
		Check[
			$RasterIncomplete=False;
			Print@"trying...";
			RasterFinalImage=ImageGraphics@Rasterize[#,
						Background->PanelColor,
						ImageResolution->5*FinalImageResolution(*,
						ImageSize->FinalImageWidth*)]&@FinalImage;
		,	
			$RasterIncomplete=True;
			FinalImageResolution*=0.9;
			(*FinalImageWidth*=0.9;*)
		];	
	];
*)
Print@FinalImage;
*)
Export[FileNameJoin@{NotebookDirectory[],"Test"<>".pdf"},
			LowerHalf
		];

RasterFinalImage];



AllMatrices={{{a,b},{b,c}},{{d,0,0,0},{0,0,0,0},{0,0,0,0},{0,dsadfg-dsfd+gdg,a+b-c+r+f+g+hh+j+k,0}}};
Sizes={{2,0},{1,3}};
Spins={{0,0},{1,1}};
Sides={{i,d},{k,v,h,h}};
Tops={{x,y},{z,e,h,h}};

MainWignerGrid=WignerGrid[AllMatrices,Sizes,Spins,Sides,Tops];
(*Print@MainWignerGrid;*)

TheWaveOperator=SplitWignerGrid[AllMatrices,Sizes,Spins,Sides,Tops];
(*Print/@TheWaveOperator;*)
SmallMatrix=First@TheWaveOperator;
TheWaveOperator=Table[SmallMatrix,3]~Join~TheWaveOperator;

TheSummaryOfTheory=Total/@Partition[Alphabet[],3];
TheSourceConstraints=Total/@Partition[Alphabet[],3];
TheSpectrum=Total/@Partition[Alphabet[],3];
TheMasslessSpectrum=Total/@Partition[Alphabet[],3];
TheOverallUnitarity=Total/@Partition[Alphabet[],10];

Collage=PSALTerResultsCollage[
		TheSummaryOfTheory,
		TheWaveOperator,
		TheSourceConstraints,
		TheSpectrum,
		TheMasslessSpectrum,
		TheOverallUnitarity];
(*Print@Collage;*)

Quit[];
