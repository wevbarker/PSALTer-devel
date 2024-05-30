(*===========================*)
(*  MakeFreeSourceVariables  *)
(*===========================*)

MakeFreeSourceVariables[NullSpace_List,SourceComponents_List]:=Module[{
	NullSpaceDimension,
	FreeSourceVariables,
	SourceComponentsAsFreeSourceVariables,
	SourceComponentsToFreeSourceVariables},

	NullSpaceDimension=(Dimensions@NullSpace)[[1]];
	Diagnostic@NullSpaceDimension;
	FreeSourceVariables=Table[Symbol["xAct`PSALTer`Private`X"<>ToString@i],
		{i,NullSpaceDimension}];
	Diagnostic@FreeSourceVariables;
	SourceComponentsAsFreeSourceVariables=(Transpose@FreeSourceVariables) . NullSpace;
	Diagnostic@NullSpace;
	Diagnostic@SourceComponents;
	Diagnostic@SourceComponentsAsFreeSourceVariables;
	SourceComponentsToFreeSourceVariables=Flatten@MapThread[#1->#2&,
		{SourceComponents,SourceComponentsAsFreeSourceVariables}];
	Diagnostic@SourceComponentsAsFreeSourceVariables;
	SourceComponentsToFreeSourceVariables=SourceComponentsToFreeSourceVariables~Join~Flatten@MapThread[Evaluate@Dagger@#1->Evaluate@Dagger@#2&,
		{SourceComponents,SourceComponentsAsFreeSourceVariables}];
	Diagnostic@SourceComponentsAsFreeSourceVariables;
SourceComponentsToFreeSourceVariables];
