(*=============*)
(*  Vectorize  *)
(*=============*)

Vectorize[InputExpr_]:=Module[{TemporaryFileNameEPS,TemporaryFileNamePDF,TemporaryFileNameTXT,Expr},
	TemporaryFileNamePDF=FileNameJoin@{$WorkingDirectory,"tmp","Vectorized"<>".pdf"};
	TemporaryFileNameEPS=FileNameJoin@{$WorkingDirectory,"tmp","Vectorized"<>".eps"};
	Export[TemporaryFileNamePDF,InputExpr,AllowRasterization->False];
	Which[
		($OperatingSystem==="Unix")||($OperatingSystem==="MacOSX")
	,
		Run@("inkscape "<>TemporaryFileNamePDF<>" --export-eps="<>TemporaryFileNameEPS);
		Expr=TemporaryFileNameEPS~Import~"Graphics";
	,
		$OperatingSystem==="Windows"
	,
		Expr=TemporaryFileNamePDF~Import~"PageGraphics";
		Expr//=First;
	(*Run@("where /r \"C:\\Program Files\" inkscape.com > \""<>TemporaryFileNameTXT<>"\" & set /p myvar= < \""<>TemporaryFileNameTXT<>"\" & \"%myvar%\" "<>TemporaryFileNamePDF<>" --export-eps="<>TemporaryFileNameEPS);*)
	];
Expr];
