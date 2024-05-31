(*=============*)
(*  Vectorize  *)
(*=============*)

Vectorize[InputExpr_]:=Module[{TemporaryFileNameEPS,TemporaryFileNamePDF,TemporaryFileNameTXT,Expr},
	TemporaryFileNamePDF=FileNameJoin@{$WorkingDirectory,"tmp","Vectorized"<>".pdf"};
	TemporaryFileNameEPS=FileNameJoin@{$WorkingDirectory,"tmp","Vectorized"<>".eps"};
	TemporaryFileNameTXT=FileNameJoin@{$WorkingDirectory,"tmp","Vectorized"<>".txt"};
	Export[TemporaryFileNamePDF,InputExpr,AllowRasterization->False];
	Print@("where /r \"C:\" inkscape.com > \""<>TemporaryFileNameTXT<>"\" & set /p myvar= < \""<>TemporaryFileNameTXT<>"\" & \"%myvar%\" "<>TemporaryFileNamePDF<>" --export-eps="<>TemporaryFileNameEPS);
	Run@("where /r \"C:\" inkscape.com > \""<>TemporaryFileNameTXT<>"\" & set /p myvar= < \""<>TemporaryFileNameTXT<>"\" & \"%myvar%\" "<>TemporaryFileNamePDF<>" --export-eps="<>TemporaryFileNameEPS);
	Print@("where /r \"C:\" inkscape.com > \""<>TemporaryFileNameTXT<>"\" & set /p myvar= < \""<>TemporaryFileNameTXT<>"\" & \"%myvar%\" "<>TemporaryFileNamePDF<>" --export-eps="<>TemporaryFileNameEPS);
	Run@("inkscape "<>TemporaryFileNamePDF<>" --export-eps="<>TemporaryFileNameEPS);
	Expr=TemporaryFileNameEPS~Import~"Graphics";
Expr];
