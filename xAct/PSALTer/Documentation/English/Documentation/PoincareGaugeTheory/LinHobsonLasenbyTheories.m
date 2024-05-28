(*============================*)
(*  LinHobsonLasenbyTheories  *)
(*============================*)

Comment@"Next we will study the power-counting renormalisable and unitary catalogue of 58 theories in arXiv:1910.14197.";
Get@FileNameJoin@{$ThisDirectory,"Documentation","PoincareGaugeTheory",
					"LinHobsonLasenbyTheories","CriticalCases.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","PoincareGaugeTheory",
					"LinHobsonLasenbyTheories","Unitarity.m"};
Off[Solve::svars];
CriticalCasesSolutions=First/@(Solve[#,{kR1,kR2,kR3,kR4,kR5,kT1,kT2,kT3,kLambda}]&/@CriticalCases);
On[Solve::svars];
Get@FileNameJoin@{$ThisDirectory,"Documentation","PoincareGaugeTheory",
					"LinHobsonLasenbyTheories","CalibrateCase.m"};

DocumentationTimingData=MapThread[
		AbsoluteTiming@CalibrateCase[#1,#2,#3]&,
		{
			Table[i,{i,16,58}],
			CriticalCasesSolutions[[16;;58]],
			Unitarity[[16;;58]]
		}];
(*
Section@"How long did this take?";
Comment@"Okay, that's all the cases. You can see from the timing below (in seconds) that each theory takes about a minute to process:";
DisplayExpression@DocumentationTimingData;
*)
