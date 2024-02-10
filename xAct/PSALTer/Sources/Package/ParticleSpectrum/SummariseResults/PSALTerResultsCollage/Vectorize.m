(*=============*)
(*  Vectorize  *)
(*=============*)

Vectorize[InputExpr_]:=Module[{TemporaryFileName,Expr},
	TemporaryFileName=FileNameJoin@{NotebookDirectory[],"tmp/Vectorized"<>".pdf"};
	TemporaryFileName~Export~InputExpr;
	Expr=TemporaryFileName~Import~{"PDF","PageGraphics"};
	Expr//=First;
Expr];
