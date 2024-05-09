(*=============================*)
(*  BarkerKarananasZellTheory  *)
(*=============================*)

Section@"Ricci-square theory";

Comment@"We will study the square of the metric-affine Ricci scalar.";

LinearLagrangian=xAct`PSALTer`MetricAffineGravity`C1*MetricAffineRicciScalar[]*MetricAffineRicciScalar[]+xAct`PSALTer`MetricAffineGravity`C2*(2*MetricPerturbation[z,y]*MetricPerturbation[-z,-y]-MetricPerturbation[x,-x]*MetricPerturbation[y,-y]);
DisplayExpression[LinearLagrangian,EqnLabel->"BarkerKarananasZellTheory"];

Comment@{"First we study",Cref@"BarkerKarananasZellTheory"," in the first-order formulation."};
LinearLagrangian*=Measure;
LinearLagrangian//=MetricAffineLineariseLagrangian;
DisplayExpression[LinearLagrangian];
ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"BarkerKarananasZellTheoryFirstOrder",	
		Method->"Hard",
		MaxLaurentDepth->1];
Comment@{"We study",Cref@"BarkerKarananasZellTheory"," in the second-order formulation."};
LinearLagrangian=MetricAffineLineariseLagrangian[LinearLagrangian,Formulation->SecondOrder];
ParticleSpectrum[LinearLagrangian,
		ClassName->"MetricAffineGravity",
		TheoryName->"BarkerKarananasZellTheorySecondOrder",	
		Method->"Hard",
		MaxLaurentDepth->1];
Supercomment@{"Some comments."};
