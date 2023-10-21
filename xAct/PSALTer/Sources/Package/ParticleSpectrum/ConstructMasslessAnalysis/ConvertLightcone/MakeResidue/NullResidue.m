(*===============*)
(*  NullResidue  *)
(*===============*)

NullResidue[LightconePropagator_,LaurentDepth_]:=Module[{
	MasslessPropagaor=LightconePropagator,
	MasslessPropagaorResidue},

	MasslessPropagaor//=Together;
	MasslessPropagaor//=Simplify;
	MasslessPropagaorResidue=((2*Mo)^LaurentDepth)*Residue[MasslessPropagaor*((En-Mo)^(LaurentDepth-1)),{En,Mo}]//Simplify;
MasslessPropagaorResidue];
