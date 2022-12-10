(*===============================*)
(*  MakeConstraintComponentList  *)
(*===============================*)

MakeConstraintComponentList[PropagatorConstraints_List,ManualConstraints_List:{}]:=Catch@Module[{AllConstraints,ConstraintComponents},
(*First join up the automatically and manually derived constraints lists*)
AllConstraints=PropagatorConstraints~Join~ManualConstraints;
(*Obtain nested lists of all the Cartesian components of the vanishing constraint functions*)
ConstraintComponents=If[Length@FindFreeIndices@#!=0,xAct`xCoba`ComponentArray[xAct`xCoba`FreeToBasis[Global`cartesian]@#],#]&/@AllConstraints;
(*Flatten them*)
ConstraintComponents=Flatten@ConstraintComponents;
(*Use the symmetries of the SO(3) irreps to "canonicalise" these component expressions via folded rules*)
(ConstraintComponents=ConstraintComponents/.xAct`xCoba`TensorValues@#)&/@{Global`TauP1p,Global`SigmaP1p,Global`SigmaPerp1p,Global`TauP1m,Global`SigmaP1m,Global`TauPerp1m,Global`SigmaPerp1m,Global`TauP2p,Global`SigmaP2p,Global`SigmaP2m};
(*Remove symmetry-vanishing and duplicate entries that the "canonicalisation" reveals*)
ConstraintComponents=ConstraintComponents~DeleteCases~0;
ConstraintComponents=ConstraintComponents//DeleteDuplicates;
ConstraintComponents];
