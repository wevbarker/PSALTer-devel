(*========*)
(*  Test  *)
(*========*)

IncludeHeader[FunctionName_]:=Module[{PathName},
	PathName=$InputFileName~StringDrop~(-2);
	Print@PathName;
	PathName=FileNameJoin@{PathName,FunctionName<>".m"};
	Print@PathName;
	PathName//=Get;
];

Get@"Test/NewFunction.m";

Expr=2;
Print@Expr;
Expr//=DependentFunction;
Print@Expr;

Quit[];
