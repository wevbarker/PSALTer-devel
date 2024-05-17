(*=============*)
(*  Vectorize  *)
(*=============*)
(*
Vectorize[InputExpr_]:=Module[{TemporaryFileName,Expr},
	TemporaryFileName=FileNameJoin@{$WorkingDirectory,"tmp/Vectorized"<>".pdf"};
	TemporaryFileName~Export~InputExpr;
	Expr=TemporaryFileName~Import~{"PDF","Pages"};
	Expr//=First;
Expr];
*)
Vectorize[InputExpr_]:=Module[{TemporaryFileName,Expr},
	TemporaryFileNamePDF=FileNameJoin@{$WorkingDirectory,"tmp/Vectorized"<>".pdf"};
	TemporaryFileNameEPS=FileNameJoin@{$WorkingDirectory,"tmp/Vectorized"<>".eps"};
	Export[TemporaryFileNamePDF,InputExpr,AllowRasterization->False];
	Run@("inkscape "<>TemporaryFileNamePDF<>" --export-filename="<>TemporaryFileNameEPS);
	Expr=TemporaryFileNameEPS~Import~"Graphics";
Expr];
