(*===============*)
(*  DefSO3Irrep  *)
(*===============*)

BuildPackage@"DefField/DefSO3Irrep/MakeAutomaticallyTraceless.m";
BuildPackage@"DefField/DefSO3Irrep/MakeAutomaticallyNotAntisymmetric.m";
BuildPackage@"DefField/DefSO3Irrep/MakeUniqueQuadratic.m";

Options@DefSO3Irrep={
	MultiTermSymmetries->{},
	Spin->0,	
	Parity->Even,
	PrintAs->"\[Zeta]",
	PrintSourceAs->"\[ScriptJ]"
};

DefSO3Irrep[FieldSpinParityName_[Inds___],Opts___?OptionQ]:=DefSO3Irrep[FieldSpinParityName[Inds],GenSet[],Opts];

DefSO3Irrep[FieldSpinParityName_[Inds___],SymmExpr_,OptionsPattern[]]:=Module[{
	Symb,
	PrintAsValue,
	PrintSourceAsValue,
	SpinValue,
	ParityValue,
	SourceSpinParityName},

	MultiTermSymmetriesOf@FieldSpinParityName^=OptionValue@MultiTermSymmetries;

	PrintAsValue=OptionValue@PrintAs;
	PrintSourceAsValue=OptionValue@PrintSourceAs;
	SpinValue=OptionValue@Spin;
	ParityValue=OptionValue@Parity;
	Symb=SymbolBuild[PrintAsValue,
			(SpinParityPreffices@(SpinValue))@(ParityValue)
			];
	
	DefTensor[
		FieldSpinParityName[Inds],
		xAct`PSALTer`M4,
		SymmExpr,
		PrintAs->Symb,
		OrthogonalTo->((V@Minus@#)&/@(List@Inds)),
		Dagger->Complex];
	
	MakeAutomaticallyTraceless@FieldSpinParityName;	
	MakeAutomaticallyNotAntisymmetric@FieldSpinParityName;
	MakeUniqueQuadratic@FieldSpinParityName;

	SourceSpinParityName=ToExpression@("Source"<>(ToString@FieldSpinParityName));
	MultiTermSymmetriesOf@SourceSpinParityName^=((OptionValue@MultiTermSymmetries)/.{FieldSpinParityName->SourceSpinParityName});

	Symb=SymbolBuild[PrintSourceAsValue,
			(SpinParityPreffices@(SpinValue))@(ParityValue)
			];

	DefTensor[
		SourceSpinParityName[Inds],
		xAct`PSALTer`M4,
		SymmExpr,
		PrintAs->Symb,
		OrthogonalTo->(V@Minus@#)&/@(List@Inds),
		Dagger->Complex];
		
	MakeAutomaticallyTraceless@SourceSpinParityName;
	MakeAutomaticallyNotAntisymmetric@SourceSpinParityName;
	MakeUniqueQuadratic@SourceSpinParityName;
];
