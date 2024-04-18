(*========*)
(*  Test  *)
(*========*)

Comment@"Trying to clone a field";

Expr=Names@"xAct`PSALTer`VectorTheory`*";
Print@Expr;
Print/@(DownValues/@Expr);
Print/@(UpValues/@Expr);

Throw@"Hold it here!";
