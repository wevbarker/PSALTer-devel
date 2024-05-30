(*=================*)
(*  ReloadPackage  *)
(*=================*)

IncludeHeader@"SymbolBuild";
IncludeHeader@"ToNewCanonical";
IncludeHeader@"Diagnostic";
ReadAtRuntime@"DefGeometry";

ReloadPackage[]:=Module[{},
	If[$NotLoaded,
		DefGeometry[];
		Begin@"xAct`PSALTer`Private`";
			RereadSources[];
		End[];
		$NotLoaded=False;,Null,
		DefGeometry[];
		Begin@"xAct`PSALTer`Private`";
			RereadSources[];
		End[];
		$NotLoaded=False;
	];
];
