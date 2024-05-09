<<xAct`xPlain`;

Comment@"Now we will try to look for new solutions to the vector system.";

NewTheoryConditions={	
	(2Bet1+Bet2+3Bet3)(6Alp1+2Alp3-2Alp4+2Alp6+Chi0^2/Xi0)==0,
	4Alp2+12Alp4-2Chi0^2/Xi0==0,
	(Alp2-Alp3+4Alp4-4Alp6)(2Bet1-Bet2)==0,
	(2Bet1+Bet2)(3Alp2-Alp3+4Alp4-4Alp6-2Chi0^2/Xi0)==0,
	4Alp2-2Chi0^2/Xi0==0,
	Chi0!=0
};
Comment@"From the general mass parameters, here are the conditions which must be true in order for only the parity-odd vector to propagate.";
DisplayExpression/@NewTheoryConditions;
Comment@"Now we obtain the following solutions.";
NewTheoryRules=Solve@NewTheoryConditions;
(*NewTheoryRules=NewTheoryRules/.{Chi0^2->Xi0*kT1*kT3^2};*)
NewTheoryRules//=FullSimplify;
DisplayExpression/@NewTheoryRules;

TryTheory[TheTheory_]:=Module[{
		TheoryName="TrialeWGT"<>ToString@TheTheory,
		TheoryRule=NewTheoryRules[[TheTheory]]},

	Comment@"Trying a new theory.";
	DisplayExpression@TheoryRule;
	DisplayExpression@TheoryName;
	SuperRules={Alp5->Chi0^2/Xi0-(2*Alp2+4*Alp4)}~Join~TheoryRule;
	SuperRules=SuperRules/.{Rule->Equal};
	SuperRules//=Reduce;
	DisplayExpression@SuperRules;
];

TryTheory/@Table[i,{i,1,6}];

Quit[];
