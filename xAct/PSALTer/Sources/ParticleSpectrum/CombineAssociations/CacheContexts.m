(*=================*)
(*  CacheContexts  *)
(*=================*)

CacheContexts[]:=Module[{NewContextList=$AllFieldContexts~Join~{
	"xAct`PSALTer`",
	"xAct`PSALTer`Private`",
	"xAct`xTensor`",
	"xAct`xTensor`Private`",
	"TangentM4`"},
	LoadContexts},

	LocalSummaryOfTheory=" ** DumpSave...";
	DumpSave[FileNameJoin@{$TemporaryDirectory,#<>".mx"},#]&/@NewContextList;

	Diagnostic@NewContextList;

	$KernelsLaunched=False;
	While[!$KernelsLaunched,
		TimeConstrained[
			LocalSummaryOfTheory=" ** LaunchKernels...";
			CloseKernels[];
			Off[LaunchKernels::nodef];
			LaunchKernels[];	
			On[LaunchKernels::nodef];

			LocalSummaryOfTheory=" ** Get...";
			LoadContexts=({$WorkingDirectory,NewContextList}~PSALTerParallelSubmit~(Off@(RuleDelayed::rhs);Get@FileNameJoin@{$TemporaryDirectory,#<>".mx"}&/@NewContextList;On@(RuleDelayed::rhs);))~Table~{TheKernel,$KernelCount};	
			LoadContexts//=MonitorParallel;	
			$KernelsLaunched=True;
		,
			360
		];
	];

];
