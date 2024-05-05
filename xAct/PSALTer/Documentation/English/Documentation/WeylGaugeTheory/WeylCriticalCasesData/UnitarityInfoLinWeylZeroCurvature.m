(* ::Package:: *)

(*=====================================*)
(*  UnitarityInfoLinWeylZeroCurvature  *)
(*=====================================*)

(*Cases 53-71, Section VI.B: lLambda==lNu==0*)
UnitarityInfoLinWeylZeroCurvatureLegend={
	"Case number",
	"Massive modes",
	"Massless d.o.f.",(*d.o.f. or presence of dipole ghosts*)
	"Unitarity",(*Yes/No*)
	"Propagating power-counting renormalisability (PPCR)"(*Yes/No, or mixing b-matrices*)	
};

UnitarityInfoLinWeylZeroCurvature={
	{"1","1-","7","No","No"},
	{"2","None","3","Yes","No"},
	{"3","1-","2","Yes","No"},
	{"4","None","9","No","No"},
	{"5","None","1","Yes","No"},
	{"6","None","2","Yes","No"},
	{"7","None","3","Yes","No"},
	{"8","None","4","Yes","No"},
	{"9","None","7","No","No"},
	{"10","None","0","No","No"},
	{"11","None","2","Yes","Yes"},
	{"12","None","1","Yes","No"},
	{"13","None","2","Yes","No"},
	{"1-1","None","No info","No","Mixing b-matrices"},
	{"1-2","None","No info","No","Mixing b-matrices"},
	{"1-3","None","No info","No","Mixing b-matrices"},
	{"3-1","None","No info","Yes","Mixing b-matrices"},
	{"3-2","None","No info","Yes","Mixing b-matrices"},
	{"3-3","None","No info","Yes","Mixing b-matrices"}
};

UnitarityInfoLinWeylZeroCurvaturePrint[CaseNumber_,InfoTruncationNumber_Integer:5]:=Module[{j},
	For[j=1,j<(InfoTruncationNumber+1),j++,
	Comment@("| "<>ToString@UnitarityInfoLinWeylZeroCurvatureLegend[[j]]<>": "<>ToString@UnitarityInfoLinWeylZeroCurvature[[CaseNumber,j]]<>" |")
	]];
