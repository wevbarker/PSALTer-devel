(*==================================*)
(*  ConstraintComponentToLightcone  *)
(*==================================*)

ConstraintComponentToLightcone[ClassName_?StringQ,ConstraintComponent_]:=Module[{
	Class,
	Constraint=ConstraintComponent},

	Class=Evaluate@Symbol@ClassName;

	Constraint//=Class@FirstSpeciousFunction;
(*
	Constraint//=xAct`xCoba`SeparateBasis[AIndex];
	Constraint//=NoScalar;
	Constraint=Constraint/.ToP;
	Constraint//=Class@SecondSpeciousFunction;
*)

	Constraint//=xAct`xCoba`SeparateBasis[AIndex];
	Constraint//=NoScalar;
	Constraint=Constraint/.ToP;
	Constraint//=ToNewCanonical;
	Constraint//=NoScalar;
	Constraint=Constraint/.ToV;
	Constraint//=ToNewCanonical;
	Constraint=Constraint//NoScalar;
	Constraint=Constraint/.ToP;
	Constraint//=xAct`xCoba`SeparateBasis[AIndex];
	Constraint//=NoScalar;
	Constraint=Constraint/.ToP;
	Constraint//=NoScalar;
	Constraint//=xAct`xCoba`SeparateBasis[xAct`PSALTer`cartesian];
	Constraint//=NoScalar;
	Constraint=Constraint/.ToP;
	Constraint//=xAct`xCoba`ContractBasis;
	Constraint//=ScreenDollarIndices;
	Constraint//=NoScalar;
	Constraint//=(SeparateMetric[G][Evaluate@#]&);
	Constraint//=xAct`xCoba`SeparateBasis[xAct`PSALTer`cartesian];
	Constraint//=NoScalar;
	Constraint//=xAct`xCoba`ContractBasis;
	Constraint//=NoScalar;
	Constraint//=xAct`xCoba`TraceBasisDummy;
	Constraint=Constraint/.xAct`xCoba`TensorValues[P];
	Constraint=Constraint/.xAct`xCoba`TensorValues[G];

	(Constraint=Constraint/.xAct`xCoba`TensorValues[#])&/@(Class@Sources);

	Constraint=Constraint/.{Def->Sqrt[En^2-Mo^2]};
	Constraint/=(2*3*5*7*11*En Mo)^10;
	Constraint//=Together;
	Constraint//=Numerator;
	Constraint//=CollectTensors;
Constraint==0];
