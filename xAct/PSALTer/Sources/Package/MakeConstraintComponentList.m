(*===============================*)
(*  MakeConstraintComponentList  *)
(*===============================*)

MakeConstraintComponentList[PropagatorConstraints_List,ManualConstraints_List:{}]:=Catch@Module[{AllConstraints,ConstraintComponents},
(*First join up the automatically and manually derived constraints lists*)
AllConstraints=PropagatorConstraints~Join~ManualConstraints;
(*Obtain nested lists of all the Cartesian components of the vanishing constraint functions*)
ConstraintComponents=If[Length@FindFreeIndices@#!=0,xAct`xCoba`ComponentArray[xAct`xCoba`FreeToBasis[cartesian]@#],#]&/@AllConstraints;
(*Flatten them*)
ConstraintComponents=Flatten@ConstraintComponents;
(*Use the symmetries of the SO(3) irreps to "canonicalise" these component expressions via folded rules*)
(ConstraintComponents=ConstraintComponents/.xAct`xCoba`TensorValues@#)&/@{TauP1p,SigmaP1p,SigmaPerp1p,TauP1m,SigmaP1m,TauPerp1m,SigmaPerp1m,TauP2p,SigmaP2p,SigmaP2m};
(*Remove symmetry-vanishing and duplicate entries that the "canonicalisation" reveals*)
ConstraintComponents=ConstraintComponents~DeleteCases~0;
ConstraintComponents=ConstraintComponents//DeleteDuplicates;
ConstraintComponents];
