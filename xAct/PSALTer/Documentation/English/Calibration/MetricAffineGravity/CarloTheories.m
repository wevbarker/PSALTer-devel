(*=================*)
(*  CarloTheories  *)
(*=================*)

Section@"Carlo's list of theories";

DeparameterisationRules={
C11-C12-4*C14+2*C7-2*C8,
C11-C12-32*C13+4*C15+2*C7-2*C8,
C11-C12-4*C14+2*C7-2*C8,
C10-2*C14+2*C15+C7-C8-C9,
C10-16*C13+4*C15+C7-C8-C9,
C10+16*C13-4*C14+C7-C8-C9,
C10-2*C14+2*C15+C7-C8-C9,
C10-16*C13+4*C15+C7-C8-C9,
C10+16*C13-4*C14+C7-C8-C9,
2*C10-C11+C12+4*C15-2*C9,
C11-C12-4*C14+2*C7-2*C8,
2*C10-C11+C12+4*C15-2*C9,
2*C10-C11+C12+4*C15-2*C9,
C11-C12-4*C14+2*C7-2*C8,
2*C10-C11+C12+4*C15-2*C9,
2*C10-C11+C12+4*C15-2*C9,
C11-C12-32*C13+4*C15+2*C7-2*C8,
2*C10-C11+C12+32*C13-4*C14-2*C9,
2*C10-C11+C12+32*C13-4*C14-2*C9,
C11-C12-4*C14+2*C7-2*C8
};

DeparameterisationRules=(First@Solve[#==0])&/@DeparameterisationRules;

CarloSolutions={
	{C10->C11-C12-2C14-2C15+C7-C8+C9,
	C13->(C14+C15)/8},
	{C10->C11-C12-16C13+C7-C8+C9,
	C14->8C13-C15},
	{C10->C11-C12-16C13+C7-C8+C9,
	C15->8C13-C14},
	{C11->C10+C12+2C14+2C15-C7+C8-C9,
	C13->(C14+C15)/8},
	{C11->C10+C12+16C13-C7+C8-C9,
	C14->8C13-C15},
	{C11->C10+C12+16C13-C7+C8-C9,
	C15->8C13-C14},
	{C12->-C10+C11-2C14-2C15+C7-C8+C9,
	C13->(C14+C15)/8},
	{C12->-C10+C11-16C13+C7-C8+C9,
	C14->8C13-C15},
	{C12->-C10+C11-16C13+C7-C8+C9,
	C15->8C13-C14},
	{C13->1/16(-C10+C11-C12+C7-C8+C9),
	C14->1/2(-C10+C11-C12-2C15+C7-C8+C9)},
	{C13->1/16(-C10+C11-C12+C7-C8+C9),
	C15->1/2(-C10+C11-C12-2C14+C7-C8+C9)},
	{C13->(C14+C15)/8,
	C7->C10-C11+C12+2C14+2C15+C8-C9},
	{C13->(C14+C15)/8,
	C8->-C10+C11-C12-2C14-2C15+C7+C9},
	{C13->(C14+C15)/8,
	C9->C10-C11+C12+2C14+2C15-C7+C8},
	{C14->8C13-C15,
	C7->C10-C11+C12+16C13+C8-C9},
	{C14->8C13-C15,
	C8->-C10+C11-C12-16C13+C7+C9},
	{C14->8C13-C15,
	C9->C10-C11+C12+16C13-C7+C8},
	{C15->8C13-C14,
	C7->C10-C11+C12+16C13+C8-C9},
	{C15->8C13-C14,
	C8->-C10+C11-C12-16C13+C7+C9},
	{C15->8C13-C14,
	C9->C10-C11+C12+16C13-C7+C8}
};

Comment@"Now we will study the batch of theories sent by Carlo.";
DisplayExpression/@CarloSolutions;
(*DisplayExpression/@DeparameterisationRules;*)

TheNonlinearLagrangian=NonlinearLagrangian/.{
	A1->0,
	A2->0,
	A3->0,
	A4->0,
	A5->0,
	A6->0,
	A7->0,
	A8->0,
	A9->0,
	A10->0,
	A11->0,
	C1->0,
	C2->0,
	C3->0,
	C4->0,
	C5->0,
	C6->0,
	C16->0};

Comment@"Here is the most general Ricci-type theory.";
DisplayExpression[TheNonlinearLagrangian,EqnLabel->"MetricAffineRicciTypeTheory"];

CaseNumber=1;

CarloTestTheory[RuleSet_,DeparameterisationRuleSet_]:=Module[{LinearLagrangian},
	LinearLagrangian=TheNonlinearLagrangian;

	Comment@"Here is a new case defined by Carlo.";
	DisplayExpression[RuleSet,EqnLabel->("RuleSet"<>ToString@CaseNumber)];
	Comment@{"But",Cref@("RuleSet"<>ToString@CaseNumber)," by itself results in a parameterised symmetry. To get rid of it, we need one further constraint which does not change the overall number of gauge generators."};	
	DisplayExpression[DeparameterisationRuleSet,EqnLabel->("DeparameterisationRuleSet"<>ToString@CaseNumber)];
	Comment@{"So by imposing",Cref@("RuleSet"<>ToString@CaseNumber)," and",Cref@("DeparameterisationRuleSet"<>ToString@CaseNumber)," on the theory in",Cref@"MetricAffineRicciTypeTheory"," we obtain the following."};
	LinearLagrangian=LinearLagrangian/.RuleSet;
	LinearLagrangian=LinearLagrangian/.DeparameterisationRuleSet;
	DisplayExpression[LinearLagrangian,EqnLabel->("CarloTheory"<>ToString@CaseNumber)];

	Comment@{"We first perform the spectral analysis of",Cref@("CarloTheory"<>ToString@CaseNumber)," in the first-order formulation (Palatini basis, in which the connection is independent of the metric)."};
	LinearLagrangian*=Measure;
	LinearLagrangian//=LineariseLagrangian;
(*
	ParticleSpectrum[LinearLagrangian,
			ClassName->"MetricAffineGravity",
			TheoryName->("CarloTheory"<>ToString@CaseNumber),	
			Method->"Hard",
			MaxLaurentDepth->1];
*)

	Comment@{"We next perform the spectral analysis of",Cref@("CarloTheory"<>ToString@CaseNumber)," in the second-order formulation (distortion basis, in which the distortion, i.e. contortion and disformation or torsion and non-metricity, are independent of the metric)."};
	LinearLagrangian=LineariseLagrangian[LinearLagrangian,Formulation->SecondOrder];
	ParticleSpectrum[LinearLagrangian,
			ClassName->"MetricAffineGravity",
			TheoryName->("CarloTheory"<>ToString@CaseNumber<>"SecondOrder"),	
			Method->"Hard",
			MaxLaurentDepth->1];

	Supercomment@{"So, the theory",Cref@("CarloTheory"<>ToString@CaseNumber)," cannot be viable."};
	CaseNumber+=1;
];

MapThread[CarloTestTheory[#1,#2]&,{CarloSolutions,DeparameterisationRules}];
