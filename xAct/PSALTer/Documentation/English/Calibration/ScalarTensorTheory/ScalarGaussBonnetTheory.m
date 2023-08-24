(*===========================*)
(*  ScalarGaussBonnetTheory  *)
(*===========================*)

Comment@"Here is the PECT parameter.";
DefConstantSymbol[Pw,PrintAs->"\[Lambda]"];
DisplayExpression@Pw;

Comment@"Define a Planck mass.";
DefConstantSymbol[MPl,PrintAs->"\(\*SubscriptBox[\(\[ScriptCapitalM]\), \(Pl\)]\)"];
DisplayExpression@MPl;

Comment@"Now we think about expanding the scalar around a constant background.";
DefConstantSymbol[Phi0,PrintAs->"\(\*SubscriptBox[\(\[Phi]\), \(0\)]\)"];
DisplayExpression@Phi0;

Comment@"Next think of a rule to rescale the Planck mass.";
DisplayExpression[{MPl->Sqrt[xAct`PSALTer`ScalarTensorTheory`Coupling1]/Phi0^(Pw/2)},EqnLabel->"MPlRescale"];
Comment@"Next think of a rule to rescale the quadratic Ricci scalar coupling.";
DisplayExpression[{xAct`PSALTer`ScalarTensorTheory`Coupling5->xAct`PSALTer`ScalarTensorTheory`Coupling5/Phi0^2},EqnLabel->"Coupling5Rescale"];
Comment@"Next think of a rule to rescale the quadratic Ricci tensor coupling.";
DisplayExpression[{xAct`PSALTer`ScalarTensorTheory`Coupling6->xAct`PSALTer`ScalarTensorTheory`Coupling6/Phi0^2},EqnLabel->"Coupling6Rescale"];
Comment@"Next think of a rule to rescale the quadratic Riemann tensor coupling.";
DisplayExpression[{xAct`PSALTer`ScalarTensorTheory`Coupling7->xAct`PSALTer`ScalarTensorTheory`Coupling7/Phi0^2},EqnLabel->"Coupling7Rescale"];
Comment@"Next a rescaling of the dynamical scalar.";
DisplayExpression[{ScalarTensorPhi[]->ScalarTensorPhi[]*Phi0},EqnLabel->"PhiRescale"];
Comment@"Finally a rescaling of the scalar vacuum itself.";
DisplayExpression[{Phi0->xAct`PSALTer`ScalarTensorTheory`Coupling3^(1/(Pw+2))},EqnLabel->"Phi0Rescale"];

Comment@{"So in summary, if we impose",Cref@{"Coupling5Rescale","Coupling6Rescale","Coupling7Rescale","PhiRescale","Phi0Rescale"}," on the linearised lagrangian, we can get it into the following form."};
LinearisedLagrangian=Get@FileNameJoin@{NotebookDirectory[],"Calibration","ScalarTensorTheory","ScalarGaussBonnet.txt"};
LinearisedLagrangian//=ToCanonical;
LinearisedLagrangian//=CollectTensors;
DisplayExpression@LinearisedLagrangian;
GeneralLinearisedLagrangian=LinearisedLagrangian;
(*
Get@FileNameJoin@{NotebookDirectory[],"Calibration","ScalarTensorTheory",
				"ScalarGaussBonnetTheory","GeneralLambda1.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","ScalarTensorTheory",
				"ScalarGaussBonnetTheory","GeneralLambda2.m"};
Get@FileNameJoin@{NotebookDirectory[],"Calibration","ScalarTensorTheory",
				"ScalarGaussBonnetTheory","GeneralLambda3.m"};
*)
Comment@"Here are the rules which we will use to impose the scalar-Gauss-Bonnet theory.";
ImposeGaussBonnet={
	xAct`PSALTer`ScalarTensorTheory`Coupling5->
		xAct`PSALTer`ScalarTensorTheory`Coupling5,
	xAct`PSALTer`ScalarTensorTheory`Coupling6->
		xAct`PSALTer`ScalarTensorTheory`Coupling6,
	xAct`PSALTer`ScalarTensorTheory`Coupling7->
		xAct`PSALTer`ScalarTensorTheory`Coupling7};
DisplayExpression@ImposeGaussBonnet;
