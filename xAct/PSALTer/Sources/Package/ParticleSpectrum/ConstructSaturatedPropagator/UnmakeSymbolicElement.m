(*=========================*)
(*  UnmakeSymbolicElement  *)
(*=========================*)

UnmakeSymbolicElement[SymbolicElement_,SymbolicRules_]:=Module[{FullElement=SymbolicElement},
	(*(FullElement=Simplify@(FullElement/.#))&@SymbolicRules;*)
	(FullElement=Simplify@(FullElement/.#))&/@Table[Take[SymbolicRules,i],{i,Length@SymbolicRules}];
	(*(FullElement=FullSimplify@(FullElement/.#))&/@Table[Take[SymbolicRules,i],{i,Length@SymbolicRules}];*)
FullElement];
