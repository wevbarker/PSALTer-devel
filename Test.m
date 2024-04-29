<<xAct`xPlain`;

Comment@"Now we will try to look for new solutions to the vector system.";

CellPrint@ExpressionCell@NewVar;

ClearAll[gencode];
SetAttributes[gencode, HoldAll];
gencode[code_, opts : OptionsPattern[Cell]] :=
 CellPrint@ExpressionCell[Defer@code, "Input", opts];

gencode[Total[{2,3}]];

Quit[];
