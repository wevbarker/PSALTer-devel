(*=======*)
(*  PGT  *)
(*=======*)

xAct`PSALTer`Private`FieldSpinParityTensorHeadsPGT=<|
		A-><|
			0-><|Even->{AP0p},Odd->{AP0m}|>,
			1-><|Even->{AP1p,APerp1p},Odd->{AP1m,APerp1m}|>,
			2-><|Even->{AP2p},Odd->{AP2m}|>
		|>,
		F-><|
			0-><|Even->{FP0p,FPerp0p},Odd->{}|>,
			1-><|Even->{FP1p},Odd->{FP1m,FPerp1m}|>,
			2-><|Even->{FP2p},Odd->{}|>
		|>
|>;

xAct`PSALTer`Private`SourceSpinParityTensorHeadsPGT=<|
		Sigma-><|
			0-><|Even->{SigmaP0p},Odd->{SigmaP0m}|>,
			1-><|Even->{SigmaP1p,SigmaPerp1p},Odd->{SigmaP1m,SigmaPerp1m}|>,
			2-><|Even->{SigmaP2p},Odd->{SigmaP2m}|>
		|>,
		Tau-><|
			0-><|Even->{TauP0p,TauPerp0p},Odd->{}|>,
			1-><|Even->{TauP1p},Odd->{TauP1m,TauPerp1m}|>,
			2-><|Even->{TauP2p},Odd->{}|>
		|>
|>;

xAct`PSALTer`Private`EngineeringDimensionsPGT=<|
		Sigma->0,
		Tau->1
|>;

PatchA2m=MakeRule[{AP2m[-a,-c,-b]AP2m[a,b,c],(1/2)AP2m[-a,-b,-c]AP2m[a,b,c]},MetricOn->All,ContractMetrics->True];
PatchA2mD1=MakeRule[{Evaluate[Dagger@AP2m[-a,-c,-b]AP2m[a,b,c]],Evaluate[(1/2)Dagger@AP2m[-a,-b,-c]AP2m[a,b,c]]},MetricOn->All,ContractMetrics->True];
PatchA2mD2=MakeRule[{Evaluate[AP2m[-a,-c,-b]Dagger@AP2m[a,b,c]],Evaluate[(1/2)AP2m[-a,-b,-c]Dagger@AP2m[a,b,c]]},MetricOn->All,ContractMetrics->True];
PatchSigma2m=MakeRule[{SigmaP2m[-a,-c,-b]SigmaP2m[a,b,c],(1/2)SigmaP2m[-a,-b,-c]SigmaP2m[a,b,c]},MetricOn->All,ContractMetrics->True];
Patch2m=Join[PatchA2m,PatchA2mD1,PatchA2mD2,PatchSigma2m];

AutomaticRules[AP2m,MakeRule[{Evaluate[AP2m[-a,-c,-b]Dagger@AP2m[a,b,c]],Evaluate[(1/2)AP2m[-a,-b,-c]Dagger@AP2m[a,b,c]]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[Evaluate[Dagger@AP2m],MakeRule[{Evaluate[Dagger@AP2m[-a,-c,-b]AP2m[a,b,c]],Evaluate[(1/2)Dagger@AP2m[-a,-b,-c]AP2m[a,b,c]]},MetricOn->All,ContractMetrics->True]];

(*
AutomaticRules[Evaluate[Dagger@AP2m],MakeRule[{Evaluate[Dagger@AP2m[-a,-b,-c]Eps[d,b,c]],Evaluate[-(1/2)Dagger@AP2m[-b,-c,-a]Eps[d,b,c]]},MetricOn->All,ContractMetrics->True]];
AutomaticRules[AP2m,MakeRule[{Evaluate[AP2m[-a,-b,-c]Eps[d,b,c]],Evaluate[-(1/2)AP2m[-b,-c,-a]Eps[d,b,c]]},MetricOn->All,ContractMetrics->True]];
*)

xAct`PSALTer`Private`DecomposeFieldsPGT[InputExpr_]:=Module[{Expr=InputExpr},
	Expr=Expr/.GaugePO3Activate;
	Expr//=ToNewCanonical;
	Expr=Expr/.GaugePerpO3Activate;
	Expr//=ToNewCanonical;
	Expr=Expr/.PADMPiActivate;
	Expr//=ToNewCanonical;
	Expr=Expr/.PO3PiActivate;
	Expr//=ToNewCanonical;
	Expr=Expr/.PADMActivate;
	Expr//=ToNewCanonical;
	Expr//=ToNewCanonical;
	Expr=Expr/.GaugeCompose;
	Expr//=ToNewCanonical;
	Expr//=CollectTensors;
Expr];

xAct`PSALTer`Private`FourierDecomposePGT[InputExpr_]:=Module[{Expr=InputExpr},
	Expr//=ToNewCanonical;
	Expr=Expr/.GaugeDecompose;
	Expr//=ToNewCanonical;
	Expr=Expr/.GaugePToGaugePO3/.GaugePerpToGaugePO3;
	Expr//=ToNewCanonical;
	Expr//=CollectTensors;
	Expr=Expr/.Patch2m;
	Expr=Expr/.ManualAll;
	Expr=Expr/.ManualAll;
	Expr//=ToNewCanonical;
	Expr//=CollectTensors;
Expr];

xAct`PSALTer`Private`FirstSpeciousFunctionPGT[InputExpr_]:=Module[{Constraint=InputExpr},
	Constraint=Constraint/.SourcePO3Activate;
	Constraint=Constraint/.SourcePerpO3Activate;
	Constraint=Constraint/.PADMPiActivate;
	Constraint=Constraint/.PO3PiActivate;
	Constraint=Constraint/.PADMActivate;
	Constraint=Constraint/.SourceCompose;
Constraint];

xAct`PSALTer`Private`SecondSpeciousFunctionPGT[InputExpr_]:=Module[{Constraint=InputExpr},
	Constraint=Constraint/.SourceCompose;
Constraint];

xAct`PSALTer`Private`ThirdSpeciousFunctionPGT[InputExpr_]:=Module[{Sector=InputExpr},
	Sector//=NoScalar;
	Sector=Sector/.SourcePO3Activate;
	Sector//=NoScalar;
	Sector//=ToNewCanonical;
	Sector=Sector/.SourcePerpO3Activate;
	Sector//=NoScalar;
	Sector//=ToNewCanonical;
	Sector=Sector/.PADMPiActivate;
	Sector//=NoScalar;
	Sector//=ToNewCanonical;
	Sector=Sector/.PO3PiActivate;
	Sector//=NoScalar;
	Sector//=ToNewCanonical;
	Sector=Sector/.PADMActivate;
	Sector//=NoScalar;
	Sector//=ToNewCanonical;
	Sector=Sector/.SourceCompose;
Sector];
