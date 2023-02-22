(*=====================*)
(*  RescaleNullVector  *)
(*=====================*)

RescaleNullVector[ClassName_?StringQ,SourceComponents_List,NullVector_List]:=Module[{
	Class,
	TrialPower,
	RescaledNullVector=NullVector,
	Rescaled,
	LocalEngineeringDimensions,
	SourceEngineeringDimensions,
	UltravioletNullVector,
	NullVectorDegreeOfDivergence},

	Class=Evaluate@Symbol@ClassName;

	(*First we get rid of infrared and lightcone singularities, i.e. those
which are introduced by poles*)
	TrialPower=10;
	Rescaled=False;

	While[TrialPower>0&&!Rescaled,
		If[Total@(Abs/@Residue[#,{En,Mo}]&/@Evaluate[RescaledNullVector*(En-Mo)^(TrialPower-1)])==0,
			Rescaled=False,
			RescaledNullVector*=((En-Mo)/Mo)^TrialPower;Rescaled=True,
			RescaledNullVector*=((En-Mo)/Mo)^TrialPower;Rescaled=True
		];
		TrialPower--
	];

	LocalEngineeringDimensions=Class@EngineeringDimensions;

	SourceEngineeringDimensions=(LocalEngineeringDimensions@(Head@#))&/@SourceComponents;

	UltravioletNullVector=FullSimplify@Total@MapThread[(Abs@((#1/(Mo^#2))/.{En->Pi Mo}))&,
		{RescaledNullVector,
		SourceEngineeringDimensions}
	];

	NullVectorDegreeOfDivergence=(Log@UltravioletNullVector/Log@Mo//FullSimplify)~Limit~(Mo->Infinity);

	RescaledNullVector*=Mo^(-NullVectorDegreeOfDivergence);
RescaledNullVector];
