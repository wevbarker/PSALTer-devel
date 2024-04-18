(*=================*)
(*  DefKinematics  *)
(*=================*)

BuildPackage@"DefKinematics/AppendToKinematics.m";

DefKinematics[InputKinematics_,{InputCouplings__}]:=Module[{},
	DefConstantSymbol/@{InputCouplings};
	AppendToKinematics[InputKinematics,LagrangianCouplings,{InputCouplings}];
];
