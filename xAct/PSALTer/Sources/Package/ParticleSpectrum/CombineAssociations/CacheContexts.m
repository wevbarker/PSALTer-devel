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
	DumpSave[FileNameJoin@{$WorkingDirectory,"tmp",#<>".mx"},#]&/@NewContextList;

	Diagnostic@NewContextList;

	LocalSummaryOfTheory=" ** LaunchKernels...";
	CloseKernels[];
	Off[LaunchKernels::nodef];
	LaunchKernels[];	
	On[LaunchKernels::nodef];

	LocalSummaryOfTheory=" ** Get...";
	LoadContexts=({$WorkingDirectory,NewContextList}~PSALTerParallelSubmit~(Off@(RuleDelayed::rhs);Get@FileNameJoin@{$WorkingDirectory,"tmp",#<>".mx"}&/@NewContextList;On@(RuleDelayed::rhs);))~Table~{TheKernel,$KernelCount};	
	LoadContexts//=MonitorParallel;	
];
