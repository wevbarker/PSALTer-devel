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
	DumpSave[FileNameJoin@{$WorkingDirectory,#<>".mx"},#]&/@NewContextList;

	LocalSummaryOfTheory=" ** LaunchKernels...";
	LaunchKernels[];	

	LocalSummaryOfTheory=" ** Get...";
	LoadContexts=({$WorkingDirectory,NewContextList}~PSALTerParallelSubmit~(Off@(RuleDelayed::rhs);Get@FileNameJoin@{$WorkingDirectory,#<>".mx"}&/@NewContextList;On@(RuleDelayed::rhs);))~Table~{TheKernel,$KernelCount};	
	LoadContexts//=MonitorParallel;	
];
