(*========*)
(*  Test  *)
(*========*)

WignerGrid[AllMatrices_,Sizes_,Spins_]:=Module[{
SpinParities,
Mask,
AllElements,
ParityEvenColor,
ParityOddColor,
ParityMixColor,
EndCells,
StartCells,
Frames,
Cols
},

SpinParities=Table[Superscript[ToString@i,j],{i,Spins},{j,{"+","-"}}]~Take~Length@Spins;
Mask=ArrayPad[Normal@BlockDiagonalMatrix@Map[(True)&,AllMatrices,{3}],{{1,0},{1,0}}]/.{0->False};
AllElements=Normal@BlockDiagonalMatrix@AllMatrices;
AllElements=ArrayPad[AllElements,{{1,0},{1,0}}];
AllElements=MapThread[If[#2,#1,Null]&,{AllElements,Mask},2];

ParityEvenColor=RGBColor[255/255,200/255,200/255];
ParityOddColor=RGBColor[200/255,220/255,255/255];
ParityMixColor=RGBColor[225/255,230/255,245/255];

EndCells=(Accumulate@Flatten@Sizes)~Partition~2;
StartCells=EndCells-(Sizes/.{0->1});
StartCells=Map[(#+1)&,StartCells,{2}];

MapThread[
(
Which[
#4[[1]]==0,
	AllElements[[#1[[2]]+1,#1[[1]]+1]]=#3[[2]];
	AllElements[[#1[[1]]+1,#1[[2]]+1]]=#3[[2]];,
#4[[2]]==0,
	AllElements[[#1[[1]]+1,#1[[1]]]]=#3[[1]];
	AllElements[[#1[[1]],#1[[1]]+1]]=#3[[1]];,
(!(#4[[1]]==0))&&(!(#4[[2]]==0)),
	AllElements[[#1[[1]]+1,#1[[1]]]]=#3[[1]];
	AllElements[[#1[[2]]+1,#1[[1]]]]=#3[[2]];
	AllElements[[#1[[1]],#1[[1]]+1]]=#3[[1]];
	AllElements[[#1[[1]],#1[[2]]+1]]=#3[[2]];
];
)&,
{StartCells,EndCells,SpinParities,Sizes}];

Frames=MapThread[
(
Which[
#3[[1]]==0,
	{
	{{#1[[2]]+1,#2[[2]]+1},{#1[[2]]+1,#2[[2]]+1}}->True
	},
#3[[2]]==0,
	{
	{{#1[[1]]+1,#2[[1]]+1},{#1[[1]]+1,#2[[1]]+1}}->True
	},
(!(#3[[1]]==0))&&(!(#3[[2]]==0)),
	{
	{{#1[[1]]+1,#2[[2]]+1},{#1[[1]]+1,#2[[2]]+1}}->True,
	{{#1[[1]]+1,#2[[1]]+1},{#1[[1]]+1,#2[[1]]+1}}->True,
	{{#1[[2]]+1,#2[[2]]+1},{#1[[2]]+1,#2[[2]]+1}}->True
	}
]
)&,
{StartCells,EndCells,Sizes}
];
Frames//=Flatten;

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

Grid[AllElements,Background->{None,None,Cols},Frame->{None,None,Frames},ItemSize->All]];

MyRaggedBlock[SomeList_,SomeWidth_]:=Module[{DataArray,PaddedArray,FrameRules},
	DataArray=SomeList~Partition~(UpTo@SomeWidth);
	FrameRules=DeleteCases[Flatten@Map[((First@Evaluate@Position[Evaluate@DataArray,#])->True)&,DataArray,{2}],Null];
	TextGrid[DataArray,Frame->{None,None,FrameRules}]];

SummariseResults[WaveOperator_,Propagator_,SourceConstraints_,Spectrum_]:=Module[{
	Computing,
	TheWaveOperator,
	ThePropagator,
	TheSourceConstraints,
	TheSpectrum,
	SummaryOfResults
	},

	Computing=Magnify["(Computing...)",450/First@Rasterize["(Computing...)","RasterSize"]];
	If[WaveOperator===Null,
		TheWaveOperator=Computing,
		TheWaveOperator=Magnify[WaveOperator,450/First@Rasterize[WaveOperator,"RasterSize"]]];
	If[Propagator===Null,
		ThePropagator=Computing,
		ThePropagator=Magnify[Propagator,450/First@Rasterize[Propagator,"RasterSize"]]];
	If[SourceConstraints===Null,
		TheSourceConstraints=Computing,
		TheSourceConstraints=Magnify[SourceConstraints,450/First@Rasterize[SourceConstraints,"RasterSize"]]];
	If[Spectrum===Null,
		TheSpectrum=Computing,
		TheSpectrum=Magnify[Spectrum,450/First@Rasterize[Spectrum,"RasterSize"]]];

	SummaryOfResults=GraphicsGrid[{
		{Labeled[TheWaveOperator,"Wave operator",Top,LabelStyle->Large],
		Labeled[ThePropagator,"Propagator",Top,LabelStyle->Large]},
		{Labeled[TheSourceConstraints,"Source constraints",Top,LabelStyle->Large],
		Labeled[TheSpectrum,"Spectrum",Top,LabelStyle->Large]}},ImageSize->Full,Frame->All];
SummaryOfResults];

(*=================*)
(*  Small example  *)
(*=================*)

Spin0={{a,b,0},{c,d,0},{0,0,g}};
Spin1={{a,0},{0,d}};
Spin2={{d,0},{0,g}};
Spin3={{d}};
Spin4={{d}};
Spin5={{a,b,0},{c,d,0},{0,0,g}};
Spin6=Table[1,{i,1,20},{j,1,20}];

AllMatrices={Spin0,Spin1,Spin2,Spin3,Spin4,Spin5,Spin6};
Sizes={{2,1},{1,1},{1,1},{0,1},{1,0},{3,0},{10,10}};
Spins={0,1,2,3,5,5,8};

Print@SummariseResults[WignerGrid[AllMatrices,Sizes,Spins],Null,Null,Null];

AllMatrices={Spin0};
Sizes={{2,1}};
Spins={0};

Print@SummariseResults[WignerGrid[AllMatrices,Sizes,Spins],Null,Null,Null];

AllMatrices={Spin3};
Sizes={{0,1}};
Spins={8};
SourceConstraints={a,b,c,d,e,r,f,t};
Expr=MyRaggedBlock[SourceConstraints,5];

Print@SummariseResults[WignerGrid[AllMatrices,Sizes,Spins],WignerGrid[AllMatrices,Sizes,Spins],Expr,Null];
