(*=========================*)
(*  ConstructWaveOperator  *)
(*=========================*)

BuildPackage@"ParticleSpectrum/ConstructWaveOperator/FourierLagrangian.m";
BuildPackage@"ParticleSpectrum/ConstructWaveOperator/ConstructOperator.m";

ConstructWaveOperator[ClassName_?StringQ,Expr_,Couplings_]:=Module[{
	DecomposeFieldsdLagrangian,
	Class,
	TheTensors
	},

	LocalWaveOperator=" ** ConstructWaveOperator...";
	
	Class=Evaluate@Symbol@ClassName;
	TheTensors=Class@Tensors;

	DecomposeFieldsdLagrangian=FourierLagrangian[ClassName,Expr,TheTensors];
	Diagnostic@DecomposeFieldsdLagrangian;

	ConstructOperator[ClassName,DecomposeFieldsdLagrangian,Couplings];
];
