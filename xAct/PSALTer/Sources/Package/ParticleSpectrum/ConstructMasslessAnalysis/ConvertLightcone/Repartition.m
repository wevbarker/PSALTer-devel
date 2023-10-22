(*===============*)
(*  Repartition  *)
(*===============*)

Repartition[InputExpr_List,PartitionLength_Integer]:=Module[{
	Expr=InputExpr},

	Expr//=Flatten;
	Expr//=Total;
	Expr//=Expand;
	Expr=(If[Head@#===Plus,List@@#,List@#])&@(Expr);
	Expr//=Flatten;
	Expr//=RandomSample;
	Expr//=Partition[#,UpTo@PartitionLength]&;
	Expr//=(Total/@#)&;	
	Print["Broken into ",Length@Expr," tasks, each of ",PartitionLength," terms."];
Expr];
