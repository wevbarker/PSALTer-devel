(*=========================*)
(*  IndependentComponents  *)
(*=========================*)

IndependentComponents[Tensors__]:=Catch@Module[{ComponentsList},
ComponentsList=xAct`xCoba`ComponentArray[xAct`xCoba`FreeToBasis[Global`cartesian]@#]&/@{Tensors};(*make a big nested array of components*)
ComponentsList=Flatten@ComponentsList;(*flatten it*)
ComponentsList=ComponentsList/.xAct`xCoba`TensorValues[Global`Sigma];
ComponentsList=ComponentsList/.xAct`xCoba`TensorValues[Global`Tau];
ComponentsList=ComponentsList~DeleteCases~0; (*get rid of zereos*)
ComponentsList=Sqrt[ComponentsList ComponentsList]//PowerExpand;(*we want to get rid of minus signs*)
ComponentsList=ComponentsList//DeleteDuplicates;(*clearly!*)
ComponentsList];
