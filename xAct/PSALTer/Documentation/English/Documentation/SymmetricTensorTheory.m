(*=========================*)
(*  SymmetricTensorTheory  *)
(*=========================*)

Title@"Symmetric tensor field theory";

Comment@"Let's define a symmetric tensor field.";
Code[
	DefField[SymmTensor[-a,-b],Symmetric[{-a,-b}],PrintAs->"\[Psi]",PrintSourceAs->"\[Chi]"];
];
Comment@"Also define some more coupling constants.";
Code[
	DefConstantSymbol[EinsteinConstant,PrintAs->"\[Kappa]"];
];

Get@FileNameJoin@{$ThisDirectory,"Documentation","SymmetricTensorTheory",
				"SymmetricPartanenTulkkiTheory.m"};
