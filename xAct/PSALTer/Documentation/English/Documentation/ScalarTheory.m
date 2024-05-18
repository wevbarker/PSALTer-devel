(*================*)
(*  ScalarTheory  *)
(*================*)

Section@"A single scalar";
Comment@"Let's define a scalar field:";
Code[
	DefField[Phi[],PrintAs->"\[Phi]",PrintSourceAs->"\[Rho]"];
];
Comment@"Also, we define various coupling constants:";
Code[
	DefConstantSymbol[Coupling1,PrintAs->"\[Alpha]"];
	DefConstantSymbol[Coupling2,PrintAs->"\[Beta]"];
	DefConstantSymbol[Coupling3,PrintAs->"\[Gamma]"];
	DefConstantSymbol[Coupling4,PrintAs->"\[Delta]"];
	DefConstantSymbol[Coupling5,PrintAs->"\[Epsilon]"];
	DefConstantSymbol[Coupling6,PrintAs->"\[Zeta]"];
];
Get@FileNameJoin@{$ThisDirectory,"Documentation","ScalarTheory","MasslessScalarTheory.m"};
Get@FileNameJoin@{$ThisDirectory,"Documentation","ScalarTheory","MassiveScalarTheory.m"};
