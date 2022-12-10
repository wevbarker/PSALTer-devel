(*=====================*)
(*  RescaleNullVector  *)
(*=====================*)

RescaleNullVector[NullVector_List]:=Catch@Module[{TrialPower,RescaledNullVector,Rescaled,UltravioletNullVector,NullVectorDegreeOfDivergence},
RescaledNullVector=NullVector;
(*First we get rid of infrared and lightcone singularities, i.e. those which are introduced by poles*)
TrialPower=10;(*start with a big power, and try smaller powers for "minimal power needed"*)
Rescaled=False;(*can we stop rescaling?*)
While[TrialPower>0&&!Rescaled,
If[Total@(Abs/@Residue[#,{Global`En,Global`Mo}]&/@Evaluate[(Global`En-Global`Mo)^(TrialPower-1)RescaledNullVector])==0,(*would the rescaled vector be okay yet?*)
Rescaled=False,(*no, it wouldn't*)
RescaledNullVector=((Global`En-Global`Mo)/Global`Mo)^TrialPower RescaledNullVector;Rescaled=True,(*yes, it would*)
RescaledNullVector=((Global`En-Global`Mo)/Global`Mo)^TrialPower RescaledNullVector;Rescaled=True];
TrialPower--];(*okay, try the next power down*)
(*now we get rid of the ultraviolet singularities*)
UltravioletNullVector=FullSimplify@(Total@(RescaledNullVector[[1;;Length@IndependentComponents[Global`Sigma[-Global`a,-Global`b,-Global`c]]]]/.{Global`En->Pi Global`Mo})+
Total@(RescaledNullVector[[Length@IndependentComponents[Global`Sigma[-Global`a,-Global`b,-Global`c]]+1;;Length@IndependentComponents[Global`Sigma[-Global`a,-Global`b,-Global`c],Global`Tau[-Global`a,-Global`b]]]]/Global`Mo/.{Global`En->Pi Global`Mo}));
NullVectorDegreeOfDivergence=Limit[Log[UltravioletNullVector]/Log[Global`Mo]//FullSimplify,Global`Mo->Infinity];(*how does the vector go at large momenta?*)
RescaledNullVector=RescaledNullVector Global`Mo^(-NullVectorDegreeOfDivergence);(*rescale that divergence away*)
RescaledNullVector];
