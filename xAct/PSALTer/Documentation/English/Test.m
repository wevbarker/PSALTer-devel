(*========*)
(*  Test  *)
(*========*)

(*Get["Prototypes`"]*)

GetDiagram[FileName_]:=Module[{TemporaryFileName,Expr},
	TemporaryFileName=FileNameJoin@{NotebookDirectory[],"Feynman",FileName};
	(*Expr=TemporaryFileName~Import~{"PDF","PageGraphics"};*)
	(*Expr=TemporaryFileName//Import;*)
	(*Expr=TemporaryFileName~Import~{"SVG"};*)
	(*Expr=ResourceFunction["SVGImport"][TemporaryFileName];*)
	(*Expr=Import[TemporaryFileName,"SVG"];*)
	(*Expr=TemporaryFileName~Import~{"PDF","Pages"};*)
	Expr=Import[TemporaryFileName,{"PageImages"},RenderedElements->None];
	(*Expr//=First;*)
Expr];

Vectorize[InputExpr_]:=Module[{TemporaryFileName,Expr},
	TemporaryFileNamePDF=FileNameJoin@{NotebookDirectory[],"tmp/Vectorized"<>".pdf"};
	TemporaryFileNameEPS=FileNameJoin@{NotebookDirectory[],"tmp/Vectorized"<>".eps"};
	Export[TemporaryFileNamePDF,InputExpr,AllowRasterization->False];
	Run@("inkscape "<>TemporaryFileNamePDF<>" --export-filename="<>TemporaryFileNameEPS);
	Expr=TemporaryFileNameEPS~Import~"Graphics";
Expr];

Expr=GetDiagram@"Quadratic.pdf";
Print@Expr;

Quit[];

ParityEvenColor=RGBColor[255/255,204/255,204/255];
ParityOddColor=RGBColor[204/255,229/255,255/255];
ParityMixColor=RGBColor[255/255,204/255,255/255];
PanelColor=RGBColor[248/255,255/255,248/255];
DetailColor=LightGreen;
(*DetailColor=RGBColor[230/255,230/255,230/255];*)
Format[a]^="\!\(\*SubscriptBox[\(\[Alpha]\), \(0\)]\)";
Expr=Column[{
	Labeled[x,
		Text@"Massive particle"],
	Framed[Grid[
	{
		{Text@"Pole residue: ",Text@ShowIfSmall@(MassivePoleResidue>0)},
		{Text@"Square mass: ",Text@ShowIfSmall@(SquareMass>0)},
		{Text@"Spin: ",Text@(a)},
		{Text@"Parity: ",Text@(Parity)}
	},
	Dividers->Center,
	Alignment->Left,
	Background->DetailColor],
		Background->DetailColor,
		FrameStyle->Directive[DetailColor,Thickness[4]]]
},Alignment->Center];

Print@Expr;

Expr//=Vectorize;
Print@Expr;


Quit[];
