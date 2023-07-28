(*===================*)
(*  MonitorParallel  *)
(*===================*)

MonitorParallel[ParallelisedArray_]:=Module[{
	PrintVariable,
	ParallelisedArrayValue},
	PrintVariable=PrintTemporary@Column[{
		MakeLabel@"Parallel computation",
		ReMagnify@ParallelGrid@ParallelisedArray
		},Spacings->{2,2},Frame->True,Background->PanelColor,Alignment->{Left,Center}];
	ParallelisedArrayValue=WaitAll@ParallelisedArray;
	NotebookDelete@PrintVariable;
ParallelisedArrayValue];
