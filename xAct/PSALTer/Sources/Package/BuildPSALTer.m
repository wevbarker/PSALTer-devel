(*================*)
(*  BuildPSALTer  *)
(*================*)

BuildPackage@"BuildPSALTer/SymbolBuild.m";
BuildPackage@"BuildPSALTer/ToNewCanonical.m";
BuildPackage@"BuildPSALTer/Diagnostic.m";

BuildPSALTer[]:=Module[{},
	If[$NotLoaded,
		BuildRebuild@"BuildPSALTer.m";
		Begin@"xAct`PSALTer`Private`";
			BuildPSALTerPackage[];
		End[];
		$NotLoaded=False;,Null,
		BuildRebuild@"BuildPSALTer.m";
		Begin@"xAct`PSALTer`Private`";
			BuildPSALTerPackage[];
		End[];
		$NotLoaded=False;
	];
];
