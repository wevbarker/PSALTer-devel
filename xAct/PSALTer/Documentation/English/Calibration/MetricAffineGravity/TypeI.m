(*=========*)
(*  TypeI  *)
(*=========*)

Section@"Type I";

Comment@"We will study Type I.";

DefiningSystem=(1/2(-3xAct`PSALTer`MetricAffineGravity`A11-xAct`PSALTer`MetricAffineGravity`A2-3xAct`PSALTer`MetricAffineGravity`A3-xAct`PSALTer`MetricAffineGravity`A9)==xAct`PSALTer`MetricAffineGravity`A1&&1/4(-xAct`PSALTer`MetricAffineGravity`A11-4xAct`PSALTer`MetricAffineGravity`A5-4xAct`PSALTer`MetricAffineGravity`A7-8xAct`PSALTer`MetricAffineGravity`A8+xAct`PSALTer`MetricAffineGravity`A9)==xAct`PSALTer`MetricAffineGravity`A10&&1/8(9xAct`PSALTer`MetricAffineGravity`A11+16xAct`PSALTer`MetricAffineGravity`A4+4xAct`PSALTer`MetricAffineGravity`A5+36xAct`PSALTer`MetricAffineGravity`A7+3xAct`PSALTer`MetricAffineGravity`A9)==xAct`PSALTer`MetricAffineGravity`A0&&xAct`PSALTer`MetricAffineGravity`C10==0&&xAct`PSALTer`MetricAffineGravity`C11==0&&xAct`PSALTer`MetricAffineGravity`C12==0&&xAct`PSALTer`MetricAffineGravity`C14==0&&xAct`PSALTer`MetricAffineGravity`C15==0&&xAct`PSALTer`MetricAffineGravity`C16==0&&-2xAct`PSALTer`MetricAffineGravity`C6==xAct`PSALTer`MetricAffineGravity`C5&&-xAct`PSALTer`MetricAffineGravity`C6==xAct`PSALTer`MetricAffineGravity`C3&&-(xAct`PSALTer`MetricAffineGravity`C6/2)==xAct`PSALTer`MetricAffineGravity`C1&&xAct`PSALTer`MetricAffineGravity`C6/2==xAct`PSALTer`MetricAffineGravity`C2&&xAct`PSALTer`MetricAffineGravity`C6==xAct`PSALTer`MetricAffineGravity`C4&&xAct`PSALTer`MetricAffineGravity`C7==0&&xAct`PSALTer`MetricAffineGravity`C8==0&&xAct`PSALTer`MetricAffineGravity`C9==0)

DefiningSystem=First@Solve[DefiningSystem,{xAct`PSALTer`MetricAffineGravity`A0,xAct`PSALTer`MetricAffineGravity`A1,xAct`PSALTer`MetricAffineGravity`A2,xAct`PSALTer`MetricAffineGravity`A3,xAct`PSALTer`MetricAffineGravity`A4,xAct`PSALTer`MetricAffineGravity`A5,xAct`PSALTer`MetricAffineGravity`A6,xAct`PSALTer`MetricAffineGravity`A7,xAct`PSALTer`MetricAffineGravity`A8,xAct`PSALTer`MetricAffineGravity`A9,xAct`PSALTer`MetricAffineGravity`A10,xAct`PSALTer`MetricAffineGravity`A11,xAct`PSALTer`MetricAffineGravity`C1,xAct`PSALTer`MetricAffineGravity`C2,xAct`PSALTer`MetricAffineGravity`C3,xAct`PSALTer`MetricAffineGravity`C4,xAct`PSALTer`MetricAffineGravity`C5,xAct`PSALTer`MetricAffineGravity`C6,xAct`PSALTer`MetricAffineGravity`C7,xAct`PSALTer`MetricAffineGravity`C8,xAct`PSALTer`MetricAffineGravity`C9,xAct`PSALTer`MetricAffineGravity`C10,xAct`PSALTer`MetricAffineGravity`C11,xAct`PSALTer`MetricAffineGravity`C12,xAct`PSALTer`MetricAffineGravity`C13,xAct`PSALTer`MetricAffineGravity`C14,xAct`PSALTer`MetricAffineGravity`C15,xAct`PSALTer`MetricAffineGravity`C16}];

(*012345689*)

AugmentedRules=(#->0)&/@{xAct`PSALTer`MetricAffineGravity`A1,xAct`PSALTer`MetricAffineGravity`A2,xAct`PSALTer`MetricAffineGravity`A3,xAct`PSALTer`MetricAffineGravity`A4,xAct`PSALTer`MetricAffineGravity`A5,xAct`PSALTer`MetricAffineGravity`A6,xAct`PSALTer`MetricAffineGravity`A7,xAct`PSALTer`MetricAffineGravity`A8,xAct`PSALTer`MetricAffineGravity`A9,xAct`PSALTer`MetricAffineGravity`A10,xAct`PSALTer`MetricAffineGravity`A11};

AllAugmentedRules=Reverse@Subsets@AugmentedRules;

LinearLagrangian=Measure*NonlinearLagrangian/.DefiningSystem;
DisplayExpression[LinearLagrangian,EqnLabel->"MetricAffineEinsteinHilbertTheory"];
LinearLagrangian//=LineariseLagrangian;

TestRestrictedCase[TheAugmentedRules_]:=Module[{RestrictedLinearLagrangian},
Comment@{"Now we restrict the theory",Cref@"MetricAffineEinsteinHilbertTheory"," with the following (quite arbitrary) condition to simplify the computations."};
DisplayExpression@TheAugmentedRules;
RestrictedLinearLagrangian=LinearLagrangian/.TheAugmentedRules;
ParticleSpectrum[RestrictedLinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"TypeI",	
		Method->"Hard",
		MaxLaurentDepth->1];
Comment@{"Some comments can be made about the theory..."};	
];

TestRestrictedCase/@AllAugmentedRules;
