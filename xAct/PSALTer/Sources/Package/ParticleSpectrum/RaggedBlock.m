(*===============*)
(*  RaggedBlock  *)
(*===============*)

RaggedBlock[SomeList_,SomeWidth_]:=Module[{DataArray,PaddedArray,FrameRules,Expr},
	If[SomeList==={},
	Expr={},
	DataArray=SomeList~Partition~(UpTo@SomeWidth);
	FrameRules=DeleteCases[Flatten@Map[((First@Evaluate@Position[Evaluate@DataArray,#])->True)&,DataArray,{2}],Null];
	Expr=TextGrid[DataArray,Frame->{None,None,FrameRules}];	
	];
Expr];
