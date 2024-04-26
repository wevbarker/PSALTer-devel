(*======================*)
(*  RegisterFieldRank0  *)
(*======================*)

Options@RegisterFieldRank0={PrintAs->"\[Zeta]",PrintSourceAs->"\[ScriptJ]"};

RegisterFieldRank0[InputField_[],OptionsPattern[]]:=Module[{},

	DefTensor[Rank0[],M4,PrintAs->OptionValue@PrintAs,Dagger->Complex];
	DefTensor[SourceRank0[],M4,PrintAs->OptionValue@PrintSourceAs,Dagger->Complex];
	DefSO3Irrep[Rank00p[],Spin->0,Parity->Even,
		PrintAs->OptionValue@PrintAs,
		PrintSourceAs->OptionValue@PrintSourceAs];
	Rank0SpinParityToRank0=Join[
		MakeRule[{Rank00p[],Rank0[]},
			MetricOn->All,ContractMetrics->True],
		MakeRule[{Evaluate@Dagger@Rank00p[],Evaluate@Dagger[Rank0[]]},
			MetricOn->All,ContractMetrics->True]];
	SourceRank0SpinParityToSourceRank0=Join[
		MakeRule[{SourceRank00p[],SourceRank0[]},
			MetricOn->All,ContractMetrics->True],
		MakeRule[{Evaluate@Dagger@SourceRank00p[],Evaluate@Dagger[SourceRank0[]]},
			MetricOn->All,ContractMetrics->True]];
	Rank0ToRank0SpinParity=Join[
		MakeRule[{Rank0[],Rank00p[]},
			MetricOn->All,ContractMetrics->True],
		MakeRule[{Evaluate@Dagger@Rank0[],Evaluate@Dagger[Rank00p[]]},
			MetricOn->All,ContractMetrics->True]];
	SourceRank0ToSourceRank0SpinParity=Join[
		MakeRule[{SourceRank0[],SourceRank00p[]},
			MetricOn->All,ContractMetrics->True],
		MakeRule[{Evaluate@Dagger@SourceRank0[],Evaluate@Dagger[SourceRank00p[]]},
			MetricOn->All,ContractMetrics->True]];
];
