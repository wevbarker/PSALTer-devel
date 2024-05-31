(*=============*)
(*  Vectorize  *)
(*=============*)

Vectorize[InputExpr_]:=Module[{TemporaryFileName,Expr},
	TemporaryFileNamePDF=FileNameJoin@{$WorkingDirectory,"tmp","Vectorized"<>".pdf"};
	TemporaryFileNameEPS=FileNameJoin@{$WorkingDirectory,"tmp","Vectorized"<>".eps"};
	Export[TemporaryFileNamePDF,InputExpr,AllowRasterization->False];
	Run@("inkscape "<>TemporaryFileNamePDF<>" --export-eps="<>TemporaryFileNameEPS);
	Expr=TemporaryFileNameEPS~Import~"Graphics";
Expr];
