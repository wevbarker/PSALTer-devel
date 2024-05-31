(*=============*)
(*  Vectorize  *)
(*=============*)

Vectorize[InputExpr_]:=Module[{TemporaryFileNameEPS,TemporaryFileNamePDF,TemporaryFileNameTXT,Expr},
	TemporaryFileNamePDF=FileNameJoin@{$WorkingDirectory,"tmp","Vectorized"<>".pdf"};
	TemporaryFileNameEPS=FileNameJoin@{$WorkingDirectory,"tmp","Vectorized"<>".eps"};
	TemporaryFileNameTXT=FileNameJoin@{$WorkingDirectory,"tmp","Vectorized"<>".txt"};
	Export[TemporaryFileNamePDF,InputExpr,AllowRasterization->False];
	Run@("where /r \"C:\\Program Files\" inkscape.com > \""<>TemporaryFileNameTXT<>"\" & set /p myvar= < \""<>TemporaryFileNameTXT<>"\" & \"%myvar%\" "<>TemporaryFileNamePDF<>" --export-eps="<>TemporaryFileNameEPS);
	Run@("inkscape "<>TemporaryFileNamePDF<>" --export-eps="<>TemporaryFileNameEPS);
	Expr=TemporaryFileNameEPS~Import~"Graphics";
Expr];
