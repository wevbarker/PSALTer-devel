(*================*)
(*  BuildPSALTer  *)
(*================*)

BuildPackage@"BuildPSALTer/SymbolBuild.m";
BuildPackage@"BuildPSALTer/ToNewCanonical.m";
BuildPackage@"BuildPSALTer/Diagnostic.m";

BuildPSALTer::built="PSALTer has already been loaded. If you think you've made a mess, best to quit the kernel and start over.";
BuildPSALTer[]:=Module[{},
	$PSALTerBuilt~If~(Throw@Message@BuildPSALTer::built);
	BuildRebuild@"BuildPSALTer.m";
	Begin@"xAct`PSALTer`Private`";
		BuildPSALTerPackage[];
	End[];
	$PSALTerBuilt=True;
];
