(*=========================*)
(*  IosifidisBarkerTheory  *)
(*=========================*)

Section@"Iosifidis-Barker theory";

Comment@"We now examine the most general case for which all the quadratic curvature parameters are present, but none of the explicit masses.";

AllRules={
{A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0,C2->0,C3->0,C4->0,C5->0,C6->0,C7->0,C8->0,C9->0,C10->0,C11->0,C12->0,C13->0,C14->0,C15->0,C16->0},
{A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0,C3->0,C4->0,C5->0,C6->0,C7->0,C8->0,C9->0,C10->0,C11->0,C12->0,C13->0,C14->0,C15->0,C16->0},
{A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0,C4->0,C5->0,C6->0,C7->0,C8->0,C9->0,C10->0,C11->0,C12->0,C13->0,C14->0,C15->0,C16->0},
{A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0,C5->0,C6->0,C7->0,C8->0,C9->0,C10->0,C11->0,C12->0,C13->0,C14->0,C15->0,C16->0},
{A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0,C6->0,C7->0,C8->0,C9->0,C10->0,C11->0,C12->0,C13->0,C14->0,C15->0,C16->0},
{A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0,C7->0,C8->0,C9->0,C10->0,C11->0,C12->0,C13->0,C14->0,C15->0,C16->0},
{A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0,C8->0,C9->0,C10->0,C11->0,C12->0,C13->0,C14->0,C15->0,C16->0},
{A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0,C9->0,C10->0,C11->0,C12->0,C13->0,C14->0,C15->0,C16->0},
{A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0,C10->0,C11->0,C12->0,C13->0,C14->0,C15->0,C16->0},
{A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0,C11->0,C12->0,C13->0,C14->0,C15->0,C16->0},
{A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0,C12->0,C13->0,C14->0,C15->0,C16->0},
{A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0,C13->0,C14->0,C15->0,C16->0},
{A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0,C14->0,C15->0,C16->0},
{A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0,C15->0,C16->0},
{A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0C16->0}
};

TestTheory[InputRules_]:=Module[{NewLinearLagrangian},
	NewLinearLagrangian=Measure*NonlinearLagrangian/.InputRules;
	DisplayExpression[NewLinearLagrangian,EqnLabel->"NewMetricAffineEinsteinHilbertTheory"];
	NewLinearLagrangian//=LineariseLagrangian;
	DisplayExpression@InputRules;
	ParticleSpectrum[NewLinearLagrangian,
			ClassName->"MetricAffineGravity",
			TheoryName->"MetricAffineEinsteinHilbertTheory"<>ToString@Length@InputRules,	
			Method->"Hard",
			MaxLaurentDepth->1];	
];

TestTheory@{A1->0,A2->0,A3->0,A4->0,A5->0,A6->0,A7->0,A8->0,A9->0,A10->0,A11->0,C1->0,C2->0,C3->0,C4->0,C5->0,C6->0,C7->0,C8->0,C9->0,C10->0,C11->0,C12->0,C13->0,C14->0,C15->0,C16->0};
