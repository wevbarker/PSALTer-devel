(*========*)
(*  Test  *)
(*========*)

Print@"Here is the test file.";

SymbolicMatrix={{x,y^3+4},{y^3+4,x^2}};
Print@MatrixForm@SymbolicMatrix;

SymbolicMatrixElements=First/@Tally@Flatten@SymbolicMatrix;
Print@SymbolicMatrixElements;

UniqueCoefficients=ToExpression/@Table["UniqueCoefficients"<>ToString@ii,{ii,Length@SymbolicMatrixElements}];
Print@UniqueCoefficients;

UniqueElementsToSymbols=MapThread[(#1->#2)&,{SymbolicMatrixElements,UniqueCoefficients}];
Print@UniqueElementsToSymbols;

SymbolsToUniqueElements=MapThread[(#1->#2)&,{UniqueCoefficients,SymbolicMatrixElements}];
Print@SymbolsToUniqueElements;

SymbolicMatrix=Replace[SymbolicMatrix,UniqueElementsToSymbols,{2}];
Print@MatrixForm@SymbolicMatrix;
SymbolicMatrix=SymbolicMatrix/.SymbolsToUniqueElements;
Print@MatrixForm@SymbolicMatrix;

Quit[];
