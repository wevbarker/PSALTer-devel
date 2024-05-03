(*==========================*)
(*  AsymmetricTensorTheory  *)
(*==========================*)

Title@"Asymmetric tensor field theory";

Comment@"Let's define an asymmetric tensor field.";
Code[
	DefField[AsymmetricF[-a,-b],PrintAs->"\[Theta]",PrintSourceAs->"\[Omega]"];
];
Comment@"Also define some more coupling constants.";
Code[
	DefConstantSymbol[EinsteinConstant,PrintAs->"\[Kappa]"];
];

Get@FileNameJoin@{$ThisDirectory,"Calibration","AsymmetricTensorTheory",
				"AsymmetricPartanenTulkkiTheory.m"};
