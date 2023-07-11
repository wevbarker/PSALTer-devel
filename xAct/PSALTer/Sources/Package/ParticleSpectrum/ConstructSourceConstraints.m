(*==============================*)
(*  ConstructSourceConstraints  *)
(*==============================*)

BuildPackage@"ParticleSpectrum/ConstructSourceConstraints/NonTrivialDot.m";

Options@ConstructSourceConstraints={
	Method->"Careful"};

ConstructSourceConstraints[ClassName_?StringQ,CouplingAssumptions_,Rescalings_,RaisedIndexSources_,MatrixLagrangian_,OptionsPattern[]]:=Module[{
	SourceSpinParityTensorHeadsValue,
	SymbolicLagrangian,
	Symbols,
	RaisedIndexFields,
	LoweredIndexFields,
	SpinParityConstantSymbols,
	SpinParityRescalingSymbols,
	ImaginaryParts,
	RealParts,
	NullSpaces,
	MatrixPropagator,
	Class},

	LocalSourceConstraints=" ** ConstructSourceConstraints...";

	Class=Evaluate@Symbol@ClassName;

	NullSpaces=Assuming[CouplingAssumptions,NullSpace[Transpose[#]]&/@(MatrixLagrangian)];
	Diagnostic@NullSpaces;
	NullSpaces=((#)~FullSimplify~CouplingAssumptions)&/@NullSpaces;
	Diagnostic@NullSpaces;

	ValuesOfSourceConstraints=Quiet@DeleteCases[
		Flatten@Values@MapThread[(#1~NonTrivialDot~#2)&,
			{NullSpaces,
			MapThread[
				MapThread[(#2/#1)&,{#1,#2}]&,
					{Rescalings,
					RaisedIndexSources}
				]}
		],0,Infinity]/.Class@RescalingSolutions;
	ValuesOfSourceConstraints=Numerator@Together[#/Sqrt[2^5*3^5*5^5*7^5]]&/@ValuesOfSourceConstraints;
	Diagnostic@ValuesOfSourceConstraints;
];
