(*==============*)
(*  WignerGrid  *)
(*==============*)

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

ParityEvenColor=RGBColor[255/255,255/255,204/255];
ParityOddColor=RGBColor[204/255,255/255,255/255];
ParityMixColor=RGBColor[204/255,255/255,204/255];

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
(*,ItemSize->All*)

Grid[AllElements,Background->{None,None,Cols},Frame->{None,None,Frames}]];
