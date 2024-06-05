(*=============*)
(*  Vectorize  *)
(*=============*)

Vectorize[InputExpr_]:=Module[{TemporaryFileNameEPS,TemporaryFileNamePDF,TemporaryFileNameTXT,Vectorized=ResourceFunction["RandomString"][10],Expr},

	TemporaryFileNamePDF=FileNameJoin@{$TemporaryDirectory,Vectorized<>".pdf"};
	Export[TemporaryFileNamePDF,InputExpr,AllowRasterization->False];

	Which[
		($OperatingSystem==="Unix")||($OperatingSystem==="MacOSX")
	,
		TemporaryFileNameEPS=FileNameJoin@{$TemporaryDirectory,Vectorized<>".eps"};
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
