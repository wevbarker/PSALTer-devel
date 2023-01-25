(*=======*)
(*  Run  *)
(*=======*)

Print@"First we import some formatting...";

Get@FileNameJoin@{NotebookDirectory[],"Calibration","VimFormat.m"};

Comment@"...okay, that's better, from now on any commentary written inside this Calibration.m wrapper will present as blue text (i.e. this text is not part of PSALTer, it is just a use-case). Next we load the PSALTer package:";
(**)
(**)
<<xAct`PSALTer`;

Comment@"Now we want to explore the ansatz approach.";
xAct`PSALTer`Private`ExecuteRules[];
xAct`PSALTer`Private`GenerateAnsatz[F,A];
xAct`PSALTer`Private`NormaliseRescalings[];

(*
Print@xAct`PSALTer`Private`SpinParityConstantSymbols;
Print@xAct`PSALTer`Private`InvariantToConstantRules;
*)
(**)
(*

Expr=Map[Values,<|aa-><|a->1,b->2|>,bb-><|a->3,b->4|>|>,{0,1}];
Print@Flatten@Expr;

Expr=MapThread[{#1->#2}&,{<|a->1,b->2|>,<|a->3,b->4|>},1]
Print@Expr;
Print@Flatten@Values@Expr;

Expr=Outer[silly[#1[[1]],#1[[2]],#2[[1]],#2[[2]]]&,{{a,b},{c,d}},{{e,f},{g,h}},1];
Print@Expr;
*)
