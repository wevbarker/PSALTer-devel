Print@"The purpose of this script is to determine whether Mathematica has been correctly configured on the system. The need for this test is driven by some unexpected poor performace on CSD3 jobs.";
Print["The variable $MaxLicenseProcesses is set to ",$MaxLicenseProcesses];
Print["The protected variable $ProcessorCount is set to ",$ProcessorCount];
Print["The variable $KernelCount is set to ",$KernelCount];
WaitOnNumberOfTasks[WaitTime_Integer,NumberOfTasks_Integer]:=Module[{ParallelTask,TimeTaken},
	ParallelTask=ParallelSubmit[Pause@#]&/@(WaitTime~ConstantArray~NumberOfTasks);
	ParallelTask=AbsoluteTiming@WaitAll@ParallelTask;
	TimeTaken=First@ParallelTask;
	Print["It takes ",TimeTaken," seconds to wait for ",WaitTime," seconds for ",NumberOfTasks," times in parallel."];
];
Print@"Now we execute LaunchKernels[]";
LaunchKernels[];
Print["The variable $KernelCount is set to ",$KernelCount];
WaitOnNumberOfTasks[1,#]&/@Range@200;
Quit[];
