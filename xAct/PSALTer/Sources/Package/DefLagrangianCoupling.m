(*=========================*)
(*  DefLagrangianCoupling  *)
(*=========================*)

Options@DefLagrangianCoupling={
	CouplingSymbol->"\[ScriptC]",
	CouplingIndex->None	
	};

DefLagrangianCoupling[SymbName_,OptionsPattern[]]:=Module[{
	CouplingSymbolValue=OptionValue@CouplingSymbol,
	CouplingIndexValue=OptionValue@CouplingIndex,
	Symb
	},

	If[CouplingIndexValue==None,		
		DefConstantSymbol[SymbName,PrintAs->CouplingSymbolValue];
	,
		Symb=SymbolBuild[
			CouplingSymbolValue,
			CouplingIndexSuffices@CouplingIndexValue,
			IsConstantSymbol->True];	
		DefConstantSymbol[SymbName,PrintAs->Symb];
	,
		Symb=SymbolBuild[
			CouplingSymbolValue,
			CouplingIndexSuffices@CouplingIndexValue,
			IsConstantSymbol->True];	
		DefConstantSymbol[SymbName,PrintAs->Symb];
	];
];
