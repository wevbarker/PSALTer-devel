(*==============================*)
(*  ConstructSourceConstraints  *)
(*==============================*)

BuildPackage@"ParticleSpectrum/ConstructSourceConstraints/NonTrivialDot.m";

ConstructSourceConstraints[ClassName_?StringQ,CouplingAssumptions_,Rescalings_,RaisedIndexSources_,MatrixLagrangian_]:=Module[{
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
	InverseBMatricesValues,
	BlockMassSigns,
	Sizes,
	TheSpins,
	CombinedSectors,
	Class},

	LocalSourceConstraints=" ** ConstructSourceConstraints...";

	Class=Evaluate@Symbol@ClassName;

	NullSpaces=Assuming[CouplingAssumptions,NullSpace[Transpose[#]]&/@(MatrixLagrangian)];
	Diagnostic@NullSpaces;
	NullSpaces=((#)~FullSimplify~CouplingAssumptions)&/@NullSpaces;
	Diagnostic@NullSpaces;

	SourceConstraints=Quiet@DeleteCases[
		Flatten@Values@MapThread[(#1~NonTrivialDot~#2)&,
			{NullSpaces,
			MapThread[
				MapThread[(#2/#1)&,{#1,#2}]&,
					{Rescalings,
					RaisedIndexSources}
				]}
		],0,Infinity]/.Class@RescalingSolutions;
	SourceConstraints=Numerator@Together[#/Sqrt[2^5*3^5*5^5*7^5]]&/@SourceConstraints;
	Diagnostic@SourceConstraints;
];
