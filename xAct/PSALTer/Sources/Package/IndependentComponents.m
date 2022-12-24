(*=========================*)
(*  IndependentComponents  *)
(*=========================*)

IndependentComponents[Tensors__]:=Module[{ComponentsList},
	(*make a big nested array of components*)
	ComponentsList=xAct`xCoba`ComponentArray[xAct`xCoba`FreeToBasis[cartesian]@#]&/@{Tensors};
	(*flatten it*)
	ComponentsList=Flatten@ComponentsList;
	ComponentsList=ComponentsList/.xAct`xCoba`TensorValues[Sigma];
	ComponentsList=ComponentsList/.xAct`xCoba`TensorValues[Tau];
	(*get rid of zereos*)
	ComponentsList=ComponentsList~DeleteCases~0; 
	(*we want to get rid of minus signs*)
	ComponentsList=Sqrt[ComponentsList ComponentsList]//PowerExpand;
	ComponentsList=ComponentsList//DeleteDuplicates;
ComponentsList];
