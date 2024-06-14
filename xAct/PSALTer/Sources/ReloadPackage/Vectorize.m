(*=============*)
(*  Vectorize  *)
(*=============*)

Vectorize[InputExpr_]:=Module[{TemporaryFileNameEPS,TemporaryFileNamePDF,TemporaryFileNameTXT,Vectorized=ResourceFunction["RandomString"][10],Expr},

	TemporaryFileNamePDF=CreateFile[];
	TemporaryFileNamePDF//=(#~RenameFile~(#<>".pdf"))&;
	Export[TemporaryFileNamePDF,InputExpr,"PDF",AllowRasterization->False];

	Which[
		($OperatingSystem==="Unix")||($OperatingSystem==="MacOSX")
	,
		TemporaryFileNameEPS=CreateFile[];
		TemporaryFileNameEPS//=(#~RenameFile~(#<>".eps"))&;
		RunProcess@{"inkscape",TemporaryFileNamePDF,"--export-eps="<>TemporaryFileNameEPS};
		(*Run@("inkscape "<>TemporaryFileNamePDF<>" --export-eps="<>TemporaryFileNameEPS);*)
		TemporaryFileNamePDF//DeleteFile;
		Expr=TemporaryFileNameEPS~Import~{"EPS","Graphics"};
		TemporaryFileNameEPS//DeleteFile;
	,
		($OperatingSystem==="Windows")
	,
		Expr=TemporaryFileNamePDF~Import~{"PDF","PageGraphics"};
		TemporaryFileNamePDF//DeleteFile;
		Expr//=First;
		(*Run@("where /r \"C:\\Program Files\" inkscape.com > \""<>TemporaryFileNameTXT<>"\" & set /p myvar= < \""<>TemporaryFileNameTXT<>"\" & \"%myvar%\" "<>TemporaryFileNamePDF<>" --export-eps="<>TemporaryFileNameEPS);*)
	];
Expr];
