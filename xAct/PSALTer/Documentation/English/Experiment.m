(*==============*)
(*  Experiment  *)
(*==============*)

Comment@"here is some extra material";




(*
Get@FileNameJoin@{NotebookDirectory[],"TypeII.mx"};
Get@FileNameJoin@{NotebookDirectory[],"MetricAffineRicciTypeTheory.mx"};
*)
Get@FileNameJoin@{NotebookDirectory[],"ExtendedProjectiveTheory.mx"};
Expr=ExtendedProjectiveTheory@xAct`PSALTer`Private`SecularSystem;
Print@Keys@Expr;
Expr=Expr@1;
Expr=Expr/.{Conjugate[Anything___]->Anything};



(**)
Expr=Expr/.{
xAct`PSALTer`MetricAffineGravity`A2->xAct`PSALTer`MetricAffineGravity`A1,
xAct`PSALTer`MetricAffineGravity`A3->xAct`PSALTer`MetricAffineGravity`A1,
xAct`PSALTer`MetricAffineGravity`A4->xAct`PSALTer`MetricAffineGravity`A1(*,
xAct`PSALTer`MetricAffineGravity`A5->xAct`PSALTer`MetricAffineGravity`A1,
xAct`PSALTer`MetricAffineGravity`A6->xAct`PSALTer`MetricAffineGravity`A1,
xAct`PSALTer`MetricAffineGravity`A7->xAct`PSALTer`MetricAffineGravity`A1,
xAct`PSALTer`MetricAffineGravity`A8->xAct`PSALTer`MetricAffineGravity`A1,
xAct`PSALTer`MetricAffineGravity`A9->xAct`PSALTer`MetricAffineGravity`A1,
xAct`PSALTer`MetricAffineGravity`A10->xAct`PSALTer`MetricAffineGravity`A1,
xAct`PSALTer`MetricAffineGravity`A11->xAct`PSALTer`MetricAffineGravity`A1
*)
};
(**)
(*Expr=Expr/.{xAct`PSALTer`MetricAffineGravity`A1->xAct`PSALTer`MetricAffineGravity`A0
};*)


Expr=Expr/.{xAct`PSALTer`MetricAffineGravity`A9->-3*xAct`PSALTer`MetricAffineGravity`A1};

Expr=(Expr@xAct`PSALTer`Private`UniqueMatrix);

Expr=MasslessAnalysisOfTotal@Expr;
Print@Expr;

AllSols=Expr;

Expr=(Evaluate[Numerator@First@Expr]/.{Sqrt->Zero});
Expr=Expr/.{Sqrt[Exprs___]->Zero[Exprs]};
Expr//=Simplify;
Expr//=Solve[#==0]&;
Print@Expr;
TrialSolution=Expr[[2]];
Print@Expr;
Comment@"Now we sub this into the full solutions.";
AllSols=AllSols/.{TrialSolution};
AllSols//=Simplify;
Print@AllSols;
AllSols2=(Numerator@AllSols[[1]]);

Print@AllSols2;

NewSol=Solve[AllSols2==0];
Print@NewSol;
NewSol=NewSol[[1]];
AllSols=AllSols/.NewSol;
AllSols//=Simplify;
Print@AllSols;
