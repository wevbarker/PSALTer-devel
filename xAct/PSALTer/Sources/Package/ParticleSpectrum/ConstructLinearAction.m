(*=========================*)
(*  ConstructLinearAction  *)
(*=========================*)

ConstructLinearAction[ClassName_?StringQ,Expr_]:=Module[{
	Class,
	TheTensors,
	TensorList,
	SourceCoupling
	},

	LocalSummaryOfTheory=" ** ConstructLinearAction...";
	
	Class=Evaluate@Symbol@ClassName;
	TheTensors=Class@Tensors;
	TensorList=(FromIndexFree@ToIndexFree@#)&/@(TheTensors);
	SourceCoupling=MapThread[((#1@@(-List@@#2))*#2)&,{Class@Sources,TensorList}];
	SourceCoupling//=Total;
	SourceCoupling//=ToNewCanonical;
	LocalSummaryOfTheory=Expr+SourceCoupling;
];
