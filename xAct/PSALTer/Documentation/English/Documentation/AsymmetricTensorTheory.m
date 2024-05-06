(*==========================*)
(*  AsymmetricTensorTheory  *)
(*==========================*)

Section@"A single asymmetric rank-two tensor";
Comment@"Let's define an asymmetric tensor field:";
Code[
	DefField[AsymmetricF[-a,-b],PrintAs->"\[Theta]",PrintSourceAs->"\[Omega]"];
];
Comment@"Also define another coupling constant:";
Code[
	DefConstantSymbol[EinsteinConstant,PrintAs->"\[Kappa]"];
];
Get@FileNameJoin@{$ThisDirectory,"Documentation","AsymmetricTensorTheory",
				"AsymmetricPartanenTulkkiTheory.m"};
