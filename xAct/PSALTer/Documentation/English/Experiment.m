(*==============*)
(*  Experiment  *)
(*==============*)

Comment@"here is some extra material";


Expr=EnsureLinearInCouplings/@Expr;
Print@Expr;
(*
Expr=ParameterisedNullVectorQ/@Expr;
Print@Expr;
*)



Expr//=CarefullyOrthogonalise;
Print@Expr;
