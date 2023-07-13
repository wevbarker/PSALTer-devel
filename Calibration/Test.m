(*========*)
(*  Test  *)
(*========*)

<<MaTeX`;

ConfigureMaTeX["pdfLaTeX" -> "/usr/bin/lualatex", "Ghostscript" -> "/usr/bin/gs"];
SetOptions[MaTeX, "Preamble" -> {"\\usepackage{tikz}\\usepackage{tikz-feynman}"}];

Options@PrintParticle={
	LaurentDepth->1
	};

PrintParticle[MassivePoleResidue_,SquareMass_,Spin_,Parity_,Polarisations_,OptionsPattern[]]:=Module[{TempGraphics},

	SpinStyles=<|0->"scalar",1->"photon",2->"Tensor",3->"Spin3"|>;
	SpinStyle=Evaluate@SpinStyles@Spin;
	ParityColours=<|Even->"red",Odd->"blue"|>;	
	ParityColour=Evaluate@ParityColours@Parity;
	ToParity=<|Even->"+",Odd->"-"|>;

	TikzSet="\\tikzset{
			Tensor/.style={decorate, decoration={snake, amplitude=.8mm, segment length=1.5mm, pre length=.5mm, post length=.5mm}, double},
			Spin3/.style={decorate, decoration={zigzag, amplitude=.8mm, segment length=1.5mm, pre length=.5mm, post length=.5mm}, double}
			}";
	OpenDiagram="
			\\tikzfeynmanset{every vertex/.style={large}}
			\\feynmandiagram[medium,horizontal=a to b]{
			i1[particle=\(j\),gray!50] --[thick,gray!50] a [crossed dot, thick,gray!50],

			i2[particle=\(j\),gray!50] --[thick,gray!50] a,
			a ";
	If[SquareMass===0,

	Switch[OptionValue@LaurentDepth,
		1,	
		(
		CloseDiagram=" b[crossed dot, thick,gray!50],
				a --[draw=none, momentum={\\tiny{\(k^{\mu}=(p,0,0,p)\)}}] b,
				b --[thick,gray!50] f1[particle=\(j\),gray!50],
				b --[thick,gray!50] f2[particle=\(j\),gray!50],
				b --[thick,gray!50] f3[particle=\(j\),gray!50]};";	
		TempGraphics=Column[{
			Labeled[MaTeX[TikzSet<>OpenDiagram<>"--[thick]"<>CloseDiagram,Magnification->1.3],"Massless particle"],
			Grid[
			{
				{Text@"Pole residue: ",Text@(MassivePoleResidue>0)},
				{Text@"Polarisations: ",Text@(Polarisations)}
			},
			Frame->All,Alignment->Left,Background->RGBColor@{240/255,255/255,204/255}]
		},Alignment->Center];
		),
		2,
		(
		CloseDiagram=" b[crossed dot, thick,gray!50],
				b --[ghost, thick, half left, looseness=1.3, momentum={[arrow shorten=0.3]\\tiny{\(k^{\mu}=(\\mathcal{E},0,0,p)\)}}] a,
				b --[thick,gray!50] f1[particle=\(j\),gray!50],
				b --[thick,gray!50] f2[particle=\(j\),gray!50],
				b --[thick,gray!50] f3[particle=\(j\),gray!50]};";	
		TempGraphics=Column[{
			Labeled[MaTeX[TikzSet<>OpenDiagram<>"--[thick, half left, looseness=1.3,momentum={[arrow shorten=0.3]\\tiny{\(k^{\mu}=(p,0,0,p)\)}}]"<>CloseDiagram,Magnification->1.3],"Quartic pole"],
			Grid[
			{
				{Text@"Pole residue: ",Text@(0<MassivePoleResidue>0)},
				{Text@"Polarisations: ",Text@(Polarisations)}
			},
			Frame->All,Alignment->Left,Background->RGBColor@{240/255,255/255,204/255}]
		},Alignment->Center];
		),
		3,
		(
		CloseDiagram=" b[crossed dot, thick,gray!50],
				b --[ghost, thick, half left, looseness=1.8, momentum={[arrow shorten=0.3]\\tiny{\(k^{\mu}=(\\mathcal{E},0,0,p)\)}}] a,
				b --[ghost, thick, half left, looseness=0.9,momentum'={[arrow shorten=0.35]}] a,
				a --[thick, half left, looseness=0.9,momentum'={[arrow shorten=0.35]}] b,
				b --[thick,gray!50] f1[particle=\(j\),gray!50],
				b --[thick,gray!50] f2[particle=\(j\),gray!50],
				b --[thick,gray!50] f3[particle=\(j\),gray!50]};";	
		TempGraphics=Column[{
			Labeled[MaTeX[TikzSet<>OpenDiagram<>"--[thick, half left, looseness=1.8,momentum={[arrow shorten=0.3]\\tiny{\(k^{\mu}=(p,0,0,p)\)}}]"<>CloseDiagram,Magnification->1.3],"Hexic pole"],
			Grid[
			{
				{Text@"Pole residue: ",Text@(0<MassivePoleResidue>0)},
				{Text@"Polarisations: ",Text@(Polarisations)}
			},
			Frame->All,Alignment->Left,Background->RGBColor@{240/255,255/255,204/255}]
		},Alignment->Center];
		)
	];

	,

	CloseDiagram=" b[crossed dot, thick,gray!50],
			a --[draw=none,"<>ParityColour<>",  momentum'={[arrow style="<>ParityColour<>"]\\tiny{\(k^{\mu}=(\\mathcal{E},0,0,p)\)}}] b,
			a --[draw=none,"<>ParityColour<>", half left, looseness=0.3,  edge label = {\\scriptsize{\(J^{P}="<>ToString@Spin<>"^{"<>ToString@Evaluate@ToParity@Parity<>"}\)}\\vspace{1cm}}] b,
			b --[thick,gray!50] f1[particle=\(j\),gray!50],
			b --[thick,gray!50] f2[particle=\(j\),gray!50],
			b --[thick,gray!50] f3[particle=\(j\),gray!50]};";	
	TempGraphics=Column[{
		Labeled[MaTeX[TikzSet<>OpenDiagram<>"--["<>ParityColour<>", "<>SpinStyle<>", thick]"<>CloseDiagram,Magnification->1.3],"Massive particle"],
		Grid[
		{
			{Text@"Pole residue: ",Text@(MassivePoleResidue>0)},
			{Text@"Square mass: ",Text@(SquareMass>0)},
			{Text@"Spin: ",Text@(Spin)},
			{Text@"Parity: ",Text@(Parity)}
		},
		Frame->All,Alignment->Left,Background->RGBColor@{240/255,255/255,204/255}]
	},Alignment->Center];

	];

TempGraphics];

PrintMassiveSpectrum[SquareMasses_,MassivePropagatorResidues_]:=Print@Row@(MapThread[If[!(#1==={}),
			PrintParticle[First@#1,First@#2,#4,#3,2*#4+1],
			0
	]&,{
		MassivePropagatorResidues,
		SquareMasses,
		{Even,Odd,Even,Odd,Even,Odd,Even,Odd}~Take~Length@SquareMasses,
		{0,0,1,1,2,2,3,3}~Take~Length@SquareMasses
	}]~DeleteCases~0);

StripFactors[MasslessEigenvalue_]:=Module[{Expr,
	MasslessEigenvalueNumerator=Numerator@Normal@MasslessEigenvalue,
	MasslessEigenvalueDenominator=Denominator@Normal@MasslessEigenvalue},
	MasslessEigenvalueNumerator/=(2*3*5*7*11)^10;
	MasslessEigenvalueNumerator//=Simplify;
	MasslessEigenvalueNumerator//=Numerator;
	MasslessEigenvalueDenominator/=(2*3*5*7*11)^10;
	MasslessEigenvalueDenominator//=Simplify;
	MasslessEigenvalueDenominator//=Numerator;
	Expr=MasslessEigenvalueNumerator/MasslessEigenvalueDenominator;
	Expr//=FullSimplify;
Expr];

PrintMasslessSpectrum[MasslessEigenvalues_]:=Print@Row@(PrintParticle[First@#,0,0,0,Length@#]&/@Gather@(StripFactors/@MasslessEigenvalues));

PrintSpectrum[SquareMasses_,MassivePropagatorResidues_,MasslessEigenvalues_,QuarticAnalysisValue_,HexicAnalysisValue_]:=Row[
(
	(*
(MapThread[If[!(#1==={}),
			PrintParticle[First@#1,First@#2,#4,#3,2*#4+1],
			0
	]&,{
		MassivePropagatorResidues,
		SquareMasses,
		{Even,Odd,Even,Odd,Even,Odd,Even,Odd}~Take~Length@SquareMasses,
		{0,0,1,1,2,2,3,3}~Take~Length@SquareMasses
	}]~DeleteCases~0)
)~Join~(
	*)
Join[
	(PrintParticle[First@#,0,0,0,Length@#,LaurentDepth->1]&/@Gather@(StripFactors/@MasslessEigenvalues)),
	(PrintParticle[First@#,0,0,0,Length@#,LaurentDepth->2]&/@Gather@(StripFactors/@QuarticAnalysisValue)),
	(PrintParticle[First@#,0,0,0,Length@#,LaurentDepth->3]&/@Gather@(StripFactors/@HexicAnalysisValue))
]
)
];

Print@"Hi there!";
Print@PrintSpectrum[{{},{}},{{},{}},{a,b},{s,2s},{v}];


Quit[];

(**)
<<xAct`PSALTer`;

Get@FileNameJoin@{NotebookDirectory[],"AllMatrices.mx"};

Print@"Hi there";

Print/@xAct`PSALTer`Private`AllMatrices;

Throw@"the javelin";

Expr={{3*xAct`PSALTer`C1*xAct`PSALTer`C16^3,I*xAct`PSALTer`A3},{-I*xAct`PSALTer`A3,Sqrt[2/3]}};

ExportMatrixToMaple[InputExpr_,InputName_?StringQ]:=Module[{
	ExportString=InputExpr},
	Print@MatrixForm@ExportString;
	ExportString//=InputForm;
	ExportString//=ToString;
	WriteLine[FileNameJoin@{NotebookDirectory[],"StringStore.mpl"},(InputName<>":=Matrix("<>ExportString<>");")~StringReplace~{"xAct`PSALTer`"->"","{"->"[","}"->"]","Sqrt"->"sqrt","["->"(","]"->")"}];
];

ExportMatrixToMaple[Expr,"var3"];
ExportMatrixToMaple[Expr,"var2"];

Quit[];
	(**)

WignerGrid[AllMatrices_,Sizes_,Spins_,Sides_,Tops_]:=Module[{
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
TheSides=Sides~Take~Length@Spins;
TheTops=Tops~Take~Length@Spins;
Mask=ArrayPad[Normal@BlockDiagonalMatrix@Map[(True)&,AllMatrices,{3}],{{1,0},{1,0}}]/.{0->False};
AllElements=Normal@BlockDiagonalMatrix@AllMatrices;
AllElements=ArrayPad[AllElements,{{1,0},{1,0}}];
AllElements=MapThread[If[#2,#1,Null]&,{AllElements,Mask},2];

ParityEvenColor=RGBColor[255/255,255/255,153/255];
ParityOddColor=RGBColor[200/255,255/255,255/255];
ParityMixColor=RGBColor[153/255,255/255,153/255];

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
Grid[AllElements,Background->{None,None,Cols},Frame->{None,None,Frames},Alignment->{Center,Center,Alignments},ItemSize->Full]];

RaggedBlock[SomeList_,SomeWidth_]:=Module[{DataArray,PaddedArray,FrameRules,Expr},
	If[SomeList==={},
	Expr={},
	DataArray=SomeList~Partition~(UpTo@SomeWidth);
	FrameRules=DeleteCases[Flatten@Map[((First@Evaluate@Position[Evaluate@DataArray,#])->True)&,DataArray,{2}],Null];
	Expr=TextGrid[DataArray,Frame->{None,None,FrameRules}];	
	];
Expr];

ParallelGrid[Expr_]:=Quiet@Check[Grid[((#~Partition~(Ceiling@(0.5*Sqrt@Length@#)))&@Flatten@{Expr}),Frame->All],Null];

ReMagnify[Object_]:=Module[{
	FullWidth,
	DesiredWidth,
	ActualWidth,
	RequiredMagnification},

FullWidth=First@Rasterize[Show[Graphics[Circle[]],ImageSize->Full],"RasterSize"];
DesiredWidth=0.4*FullWidth;
ActualWidth=First@Rasterize[Object,"RasterSize"];
RequiredMagnification=Piecewise[{{1,ActualWidth<=DesiredWidth},{DesiredWidth/ActualWidth,ActualWidth>DesiredWidth}}];
Magnify[Object,RequiredMagnification]];

SummariseTheory[Theory_]:=(Action==Integrate@@({((CollectConstants@Theory))@@#}~Join~(#[[1;;4]]))&@{TCoordinate,XCoordinate,YCoordinate,ZCoordinate});

SummariseResults[WaveOperator_,Propagator_,SourceConstraints_,Spectrum_,OverallUnitarity_,SummaryOfTheory_]:=Module[{
	Computing,
	TheWaveOperator,
	ThePropagator,
	TheSourceConstraints,
	TheSpectrum,
	TheOverallUnitarity,
	SummaryOfResults
	},

(*Computing=HoldForm@(DynamicModule[{StartTime=AbsoluteTime[]},Dynamic@Refresh[ProgressIndicator[Tanh[N@(AbsoluteTime[]-StartTime)/100],Appearance->"Necklace"],UpdateInterval->1]]);*)

	MakeLabel[SomeString_]:=Style[SomeString,Large];
	Computing=Row[{ProgressIndicator[Appearance->"Necklace",ImageSize->Large],MakeLabel@"Pending..."},Invisible@MakeLabel@"  ",Alignment->{Left,Center}];
	FullWidth=First@Rasterize[Show[Graphics[Circle[]],ImageSize->Full],"RasterSize"];

	If[WaveOperator===Null,
		TheWaveOperator=Computing,
		TheWaveOperator=ReMagnify[WaveOperator]];
	If[Propagator===Null,
		ThePropagator=Computing,
		ThePropagator=ReMagnify[Propagator]];
	If[SourceConstraints===Null,
		TheSourceConstraints=Computing,
		If[SourceConstraints==={},
			TheSourceConstraints=MakeLabel["(None)"],
			TheSourceConstraints=ReMagnify[SourceConstraints]];
		];
	If[Spectrum===Null,
		TheSpectrum=Computing,
		TheSpectrum=ReMagnify[Spectrum]];
	If[OverallUnitarity===Null,
		TheOverallUnitarity=Computing,
		If[OverallUnitarity===False,
			TheOverallUnitarity=MakeLabel["(Impossible)"],
			TheOverallUnitarity=ReMagnify[OverallUnitarity]];
	];

	SummaryOfResults=Grid[{
		{MakeLabel["PSALTer results panel"],SpanFromLeft},
		{SummariseTheory[SummaryOfTheory],SpanFromLeft},
		{MakeLabel["Wave operator"],
		MakeLabel["Saturated propagator"]},
		{TheWaveOperator,
		ThePropagator},
		{MakeLabel["Source constraints"],
		MakeLabel["Particle spectrum"]},
		{TheSourceConstraints,
		TheSpectrum},
		{MakeLabel["Gauge symmetries"],
		SpanFromAbove},
		{MakeLabel["(Not yet implemented)"],
		SpanFromAbove},
		{MakeLabel["Unitarity conditions"],MakeLabel["Assumptions"]},
		{TheOverallUnitarity,MakeLabel["(Not yet implemented)"]}
		},Spacings->{2,2},Frame->True,Background->RGBColor[240/255,240/255,240/255],Alignment->{Center,Center}];
SummaryOfResults];


(*=================*)
(*  Small example  *)
(*=================*)

Spin0={{1/a^3,b,0},{c,d,0},{0,0,g}};
Spin1={{a,0},{0,d}};
Spin2={{d,0},{0,g}};
Spin3={{d}};
Spin4={{d}};
Spin5={{a,b,0},{Integrate[(f[b]/a),b],Integrate[(f[b]/a),b],0},{0,0,Integrate[(f[b]/a),b]}};
Spin6=Table[c,{i,1,20},{j,1,20}];

AllMatrices={Spin0,Spin1,Spin2,Spin3,Spin4,Spin5,Spin6};
Sizes={{2,1},{1,1},{1,1},{0,1},{1,0},{3,0},{10,10}};
Spins={0,1,2,3,5,5,8};
Fields={{a,a,a},{a,a},{a,a},{a},{a},{a,a,a},{a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a,a}};

ParticleSpectrum[]:=Module[{
(*
LocalWaveOperator=Null,
LocalPropagator=Null,
LocalSourceConstraints=Null,
LocalSpectrum=Null,
LocalOverallUnitarity=Null,
LocalSummaryOfTheory=Null,
*)
	Expr
	},

LocalWaveOperator=Null;
LocalPropagator=Null;
LocalSourceConstraints=Null;
LocalSpectrum=Null;
LocalOverallUnitarity=Null;
LocalSummaryOfTheory=Null;

OngoingEval=PrintTemporary@Dynamic[Refresh[SummariseResults[LocalWaveOperator,LocalPropagator,LocalSourceConstraints,LocalSpectrum,LocalOverallUnitarity,LocalSummaryOfTheory],TrackedSymbols->{LocalWaveOperator,LocalPropagator,LocalSourceConstraints,LocalSpectrum,LocalOverallUnitarity,LocalSummaryOfTheory}]];
LocalWaveOperator=WignerGrid[AllMatrices,Sizes,Spins,Fields,Fields];
Expr=Table[ParallelSubmit[{i},Total[FactorList[x^(i+150)+1][[2;;,2]]]],{i,15,90}];
WaitAll@Expr;
LocalPropagator=WignerGrid[AllMatrices,Sizes,Spins,Fields,Fields];
Expr=Table[ParallelSubmit[{i},Total[FactorList[x^(i+150)+1][[2;;,2]]]],{i,15,90}];
WaitAll@Expr;
LocalSourceConstraints=3563456;
Expr=Table[ParallelSubmit[{i},Total[FactorList[x^(i+150)+1][[2;;,2]]]],{i,15,90}];
WaitAll@Expr;
LocalSpectrum=34523456;
LocalSummaryOfTheory=34523456;
LocalOverallUnitarity=90480567349;

FinishDynamic[];
NotebookDelete@OngoingEval;
Print@SummariseResults[LocalWaveOperator,LocalPropagator,LocalSourceConstraints,LocalSpectrum,LocalOverallUnitarity,LocalSummaryOfTheory];
];


ParticleSpectrum[];
ParticleSpectrum[];
ParticleSpectrum[];

Quit[];

(*
Expr=Table[ParallelSubmit[{i},Total[FactorList[x^(i+900)+1][[2;;,2]]]],{i,15,90}];
(*
LocalPropagator=ParallelGrid@Expr;
*)
WaitAll@Expr;
*)
(*
Pause@2;
xv=1;
SmallPrint=Module[{tmp},tmp=Dynamic[xv+1];{Dynamic@xv,tmp}];
Print@SmallPrint;
*)
(*
AllMatrices={Spin0};
Sizes={{2,1}};
Spins={0};
Fields={{a,a,a}};

Print@SummariseResults[WignerGrid[AllMatrices,Sizes,Spins,Fields,Fields],Null,Null,Null,Null,g];

AllMatrices={Spin3};
Sizes={{0,1}};
Spins={8};
Fields={{a}};

SourceConstraints={a,b,c,d,e,r,f,t};
Expr=MyRaggedBlock[SourceConstraints,5];

Print@SummariseResults[WignerGrid[AllMatrices,Sizes,Spins,Fields,Fields],WignerGrid[AllMatrices,Sizes,Spins,Fields,Fields],Expr,Null,False,g];


Print@ParallelGrid@Null;
Print@ParallelGrid@a;
Print@ParallelGrid@{a};
Print@ParallelGrid@{a,b,c,d,e};
Print@ParallelGrid@{{a,b},{c,d},{e,f}};

Throw@"soybean";
(*
Expr=Table[ParallelSubmit[{i},Total[FactorList[x^(i+900)+1][[2;;,2]]]],{i,15,90}];
*)
Expr=3;
Print@Dynamic@TheOutput;

SummariseResults[WignerGrid[AllMatrices,Sizes,Spins,Fields,Fields],WignerGrid[AllMatrices,Sizes,Spins,Fields,Fields],Null,ParallelGrid@Expr,False,g];

WaitAll@Expr;
NotebookDelete@Expr;

*)
