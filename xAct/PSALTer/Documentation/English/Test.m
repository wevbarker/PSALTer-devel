(*========*)
(*  Test  *)
(*========*)


GetDiagram[FileName_]:=Module[{TemporaryFileName,Expr},
	TemporaryFileName=FileNameJoin@{NotebookDirectory[],"Feynman",FileName};
	Expr=TemporaryFileName~Import~{"PDF","PageGraphics"};
	(*Expr=TemporaryFileName//Import;*)
	(*Expr=TemporaryFileName~Import~{"SVG"};*)
	(*Expr=ResourceFunction["SVGImport"][TemporaryFileName];*)
	(*Expr=Import[TemporaryFileName,"SVG"];*)
	(*Expr=TemporaryFileName~Import~{"PDF","Pages"};*)
	Expr//=First;
Expr];

Num=3;

(*
LabelGraphics=Graphics[{Thick,{Arrowheads[Large],Arrow[{{0,0},{1,-1}},0.2]},Inset[Num,{Left,Top},{Left,Top}]}];
*)
LabelGraphics[Num_]:=Module[{Expr=Num},
	Expr=Graphics[{Thickness@0.1,{Arrowheads[1.],
		Arrow[{{0,0},{0.5,-0.5}},0.15]},
		Inset[Text@Style[Num,Black,FontSize->20],{0,0},{0,0}]}];
	Expr];
Print@LabelGraphics@3;

LabelledResult[InputExpr_,Num_]:=Module[{Expr=InputExpr},
	Exp2=LabelGraphics[Num];
	Expr=Graphics[{
		Inset@Expr,
		Inset[Graphics[{Text@Num,Circle[],Thick},ImageSize->20],{Left,Top},{Left,Top}]
		(*Inset[Text@Framed[Style[Num,Black,FontSize->20],RoundingRadius->30],{Left,Top},{Left,Top}]*)
		}];
Expr];

Expr=LabelledResult[GetDiagram@"Quadratic.pdf",3];
Print@Expr;
Expr=LabelledResult[GetDiagram@"Hexic.pdf",3];
Print@Expr;
Expr=GetDiagram@"FieldKinematicsAsymmetricF.pdf"

Print@Expr;
Expr=LabelledResult[GetDiagram@"FieldKinematicsAsymmetricF.pdf",3];
Print@Expr;

Quit[];

ParityEvenColor=RGBColor[255/255,204/255,204/255];
ParityOddColor=RGBColor[204/255,229/255,255/255];
ParityMixColor=RGBColor[255/255,204/255,255/255];
PanelColor=RGBColor[248/255,255/255,248/255];
DetailColor=LightGreen;
