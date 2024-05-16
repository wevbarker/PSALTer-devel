(*========*)
(*  Test  *)
(*========*)

GetDiagram[FileName_]:=Module[{TemporaryFileName,Expr},
	TemporaryFileName=FileNameJoin@{NotebookDirectory[],"Feynman",FileName};
	Expr=TemporaryFileName~Import~{"SVG","Graphics"};
	(*Expr=TemporaryFileName~Import~{"EPS"};*)
	(*Expr=TemporaryFileName~Import~{"PDF","PageGraphics"};*)
	(*Expr//=First;*)
Expr];

Vectorize[InputExpr_]:=Module[{TemporaryFileName,Expr},
	TemporaryFileName=FileNameJoin@{NotebookDirectory[],"tmp/Vectorized"<>".pdf"};
	TemporaryFileName~Export~InputExpr;
	Expr=TemporaryFileName~Import~{"PDF","PageGraphics"};
	Expr//=First;
Expr];

Print@"Hi there";
Expr=GetDiagram@"Even0.svg";

Print@Expr;


ParityEvenColor=RGBColor[255/255,204/255,204/255];
ParityOddColor=RGBColor[204/255,229/255,255/255];
ParityMixColor=RGBColor[255/255,204/255,255/255];
PanelColor=RGBColor[248/255,255/255,248/255];
DetailColor=LightGreen;
(*DetailColor=RGBColor[230/255,230/255,230/255];*)
Format[a]^="\!\(\*SubscriptBox[\(\[Alpha]\), \(0\)]\)";
Expr=Column[Text/@{a,b,c,d},
		Alignment->{Left,Center},
		Background->PanelColor,
		Frame->True,
		Spacings->{1,1}];

Expr//=Vectorize;
Print@Expr;


Quit[];
