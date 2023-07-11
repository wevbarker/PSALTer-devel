(*===============*)
(*  NullResidue  *)
(*===============*)

NullResidue[LightconePropagator_]:=Module[{
	MasslessPropagaor=LightconePropagator,
	MasslessPropagaorResidue},

	MasslessPropagaor//=Together;
	MasslessPropagaorResidue=2*Mo*Residue[MasslessPropagaor,{En,Mo}]//Simplify;
MasslessPropagaorResidue];
