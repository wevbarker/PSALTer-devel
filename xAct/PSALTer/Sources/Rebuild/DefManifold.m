(*===============*)
(*  DefManifold  *)
(*===============*)

DefManifold[M4,4,IndexRange[{a,z}]];

Quiet@DefMetric[-1,G[-a,-c],CD,{",","\[PartialD]"},PrintAs->"\[Gamma]",FlatMetric->True,SymCovDQ->True];

xAct`PSALTer`Private`StandardIndices=ToExpression/@Alphabet[];

xAct`PSALTer`Private`StandardIndicesSymb=ToString@ToExpression@("\\[Gothic"<>ToUpperCase@ToString@#<>"]")&/@Alphabet[];

(PrintAs@Evaluate@#1^=Evaluate@#2)&~MapThread~{xAct`PSALTer`Private`StandardIndices,xAct`PSALTer`Private`StandardIndicesSymb};
