(*=================*)
(*  NewExperiment  *)
(*=================*)

Get@FileNameJoin@{NotebookDirectory[],"TypeII.mx"};
Get@FileNameJoin@{NotebookDirectory[],"MetricAffineRicciTypeTheory.mx"};
Expr=MetricAffineRicciTypeTheory@xAct`PSALTer`Private`SecularSystem;
Expr=Expr/.{Conjugate[Anything___]->Anything};
Expr=(Expr@xAct`PSALTer`Private`UniqueMatrix);

Expr=MasslessAnalysisOfTotal@Expr;
Print@Expr;
