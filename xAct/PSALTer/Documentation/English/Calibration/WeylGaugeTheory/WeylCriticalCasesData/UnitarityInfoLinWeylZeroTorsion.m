(* ::Package:: *)

(*====================================*)
(*  UnitarityInfoLinWeylZeroTorsion  *)
(*====================================*)

(*Cases 14-52, need to set torsion T* to 0!*)
UnitarityInfoLinWeylZeroTorsionLegend={
	"Case number",
	"Massive modes",
	"Massless d.o.f.",(*d.o.f. or presence of dipole ghosts*)
	"Unitarity",(*Yes/No*)
	"Propagating power-counting renormalisability (PPCR)"(*Yes/No, or mixing b-matrices*)	
};

UnitarityInfoLinWeylZeroTorsion={
	{"1","0+,1-,2+","2","No","No"},
	{"2","1-","Dipole ghost","No","No"},
	{"3","2+","6","No","No"},
	{"4","1-","0","Yes","No"},
	{"5","1-","Dipole ghost","No","Yes"},
	{"6","None","Dipole ghost","No","Yes"},
	{"7","2+","4","No","No"},
	{"8","2+","2","No","No"},
	{"9","1-","0","Yes","Yes"},
	{"10","None","2","Yes","Yes"},
	{"11","None","Dipole ghost","No","Yes"},
	{"12","None","Dipole ghost","No","Yes"},
	{"13","2+","2","No","No"},
	{"14","None","2","Yes","Yes"},
	{"15","None","0","No","No"},
	{"16","None","Dipole ghost","No","Yes"},
	{"1-1","1-,2+","No info","No","Mixing b-matrices"},
	{"1-2","1-,2+","No info","No","No"},
	{"1-3","1-,2+","No info","No","No"},
	{"1-4","0+,2+","No info","No","Mixing b-matrices"},
	{"1-5","2+","No info","No","Mixing b-matrices"},
	{"1-6","2+","No info","No","No"},
	{"1-7","2+","No info","No","No"},
	{"1-8","0+,1-","No info","Yes","Mixing b-matrices"},
	{"1-9","1-","No info","Yes","Mixing b-matrices"},
	{"1-10","1-","No info","Yes","No"},
	{"1-11","1-","No info","Yes","No"},
	{"1-12","0+","No info","Yes","Mixing b-matrices"},
	{"1-13","None","No info","Yes","Mixing b-matrices"},
	{"1-14","None","No info","Yes","No"},
	{"1-15","None","No info","Yes","No"},
	{"2-1","None","No info","No","Mixing b-matrices"},
	{"3-1","None","No info","No","Mixing b-matrices"},
	{"4-1","None","0","No","No"},
	{"5-1","None","No info","No","Yes"},
	{"7-1","None","No info","Yes","No"},
	{"8-1","None","No info","Yes","Mixing b-matrices"},
	{"9-1","None","0","No","No"},
	{"13-1","None","No info","Yes","No"}
};

UnitarityInfoLinWeylZeroTorsionPrint[CaseNumber_,InfoTruncationNumber_Integer:5]:=Module[{j},
	For[j=1,j<(InfoTruncationNumber+1),j++,
	Comment@("| "<>ToString@UnitarityInfoLinWeylZeroTorsionLegend[[j]]<>": "<>ToString@UnitarityInfoLinWeylZeroTorsion[[CaseNumber,j]]<>" |")
	]];
