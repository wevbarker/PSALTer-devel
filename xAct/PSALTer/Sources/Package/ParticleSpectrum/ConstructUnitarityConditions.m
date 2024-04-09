(*================================*)
(*  ConstructUnitarityConditions  *)
(*================================*)

ConstructUnitarityConditions[ClassName_?StringQ,MassiveAnalysis_,MassiveGhostAnalysis_,MasslessAnalysisValue_,QuarticAnalysisValue_,HexicAnalysisValue_]:=Module[{
	Couplings,
	Class,
	PositiveSystem=Join[MassiveAnalysis,MassiveGhostAnalysis,MasslessAnalysisValue],
	PathologicalSystem=Join[QuarticAnalysisValue,HexicAnalysisValue],
	CouplingAssumptions,
	UnitarityTime=10
	},

	LocalOverallUnitarity=" ** ConstructUnitarityConditions...";

	Class=Evaluate@Symbol@ClassName;
	Couplings=Class@LagrangianCouplings;
	
	CouplingAssumptions=(#~Element~Reals)&/@Couplings;
	Diagnostic@CouplingAssumptions;
	CouplingAssumptions~AppendTo~(xAct`PSALTer`Mo>0);
	Diagnostic@CouplingAssumptions;

	PathologicalSystem//=Flatten;
	Diagnostic@PathologicalSystem;
	PathologicalSystem=(0<#>0)&/@PathologicalSystem;
	Diagnostic@PathologicalSystem;

	PositiveSystem//=Flatten;
	Diagnostic@PositiveSystem;
	PositiveSystem=(#>0)&/@PositiveSystem;
	Diagnostic@PositiveSystem;

	PositiveSystem=PositiveSystem~Join~PathologicalSystem;

	PositiveSystem=PositiveSystem/.{Mo->1,En->1,Def->1};	

	If[LeafCount@MasslessAnalysisValue>=5000,
		LocalOverallUnitarity=Text@"(Hidden for brevity)";
		PositiveSystemValue=Text@"(Hidden for brevity)";,

		TimeConstrained[
		(
			PositiveSystem//=Assuming[CouplingAssumptions,Reduce[#,Couplings,Reals]]&;
			Diagnostic@PositiveSystem;
(*
			PositiveSystem//=LogicalExpand;
			Diagnostic@PositiveSystem;
			PositiveSystem=PositiveSystem/.{Or->List};
			Diagnostic@PositiveSystem;
*)
			If[PositiveSystem===False,
				LocalOverallUnitarity=Text@"(Demonstrably impossible)";
				,
				If[ListQ@PositiveSystem,
					LocalOverallUnitarity=PositiveSystem;
					,
					LocalOverallUnitarity={PositiveSystem};
				];
			];
		)
		,
		UnitarityTime,
		(
			LocalOverallUnitarity=Text@("(Timeout after "<>ToString@UnitarityTime<>" seconds)");
		)
		];
	];
];
