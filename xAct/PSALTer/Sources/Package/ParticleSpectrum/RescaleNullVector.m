(*=====================*)
(*  RescaleNullVector  *)
(*=====================*)

RescaleNullVector[ClassName_?StringQ,SourceComponents_List,NullVector_List]:=Module[{
	Class,
	TrialPower,
	RescaledNullVector=NullVector,
	Rescaled,
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

	UltravioletNullVector=FullSimplify@(

FullSimplify@

Total@(Abs)


		Total@(Abs/@(RescaledNullVector[[1;;Length@IndependentComponents[ClassName,Sigma[-a,-b,-c]]]]/.{En->Pi Mo}))+
	Total@(Abs/@(RescaledNullVector[[Length@IndependentComponents[ClassName,Sigma[-a,-b,-c]]+1;;Length@IndependentComponents[ClassName,Sigma[-a,-b,-c],Tau[-a,-b]]]]/Mo/.{En->Pi Mo}))
);

	NullVectorDegreeOfDivergence=Limit[Log[UltravioletNullVector]/Log[Mo]//FullSimplify,Mo->Infinity];

	RescaledNullVector*=Mo^(-NullVectorDegreeOfDivergence);
RescaledNullVector];
