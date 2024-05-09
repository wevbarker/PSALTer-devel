(*====================*)
(*  CommonNullVector  *)
(*====================*)

BuildPackage@"ParticleSpectrum/ConstructSourceConstraints/ConjectureNullSpace/CommonNullVector/IsNullVectorOfSpace.m";

CommonNullVector[NullVector_,MinimalExampleCaseNullSpaces_]:=Module[{IsNullVectorOfExampleCaseNullSpaces},
	IsNullVectorOfExampleCaseNullSpaces=IsNullVectorOfSpace[NullVector,#]&/@MinimalExampleCaseNullSpaces;
And@@IsNullVectorOfExampleCaseNullSpaces];
