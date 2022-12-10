(*=====================*)
(*  RescaleNullVector  *)
(*=====================*)

RescaleNullVector[NullVector_List]:=Catch@Module[{TrialPower,RescaledNullVector,Rescaled,UltravioletNullVector,NullVectorDegreeOfDivergence},
RescaledNullVector=NullVector;
(*First we get rid of infrared and lightcone singularities, i.e. those which are introduced by poles*)
TrialPower=10;(*start with a big power, and try smaller powers for "minimal power needed"*)
Rescaled=False;(*can we stop rescaling?*)
While[TrialPower>0&&!Rescaled,
If[Total@(Abs/@Residue[#,{En,Mo}]&/@Evaluate[(En-Mo)^(TrialPower-1)RescaledNullVector])==0,(*would the rescaled vector be okay yet?*)
Rescaled=False,(*no, it wouldn't*)
RescaledNullVector=((En-Mo)/Mo)^TrialPower RescaledNullVector;Rescaled=True,(*yes, it would*)
RescaledNullVector=((En-Mo)/Mo)^TrialPower RescaledNullVector;Rescaled=True];
TrialPower--];(*okay, try the next power down*)
(*now we get rid of the ultraviolet singularities*)
UltravioletNullVector=FullSimplify@(Total@(RescaledNullVector[[1;;Length@IndependentComponents[Sigma[-a,-b,-c]]]]/.{En->Pi Mo})+
Total@(RescaledNullVector[[Length@IndependentComponents[Sigma[-a,-b,-c]]+1;;Length@IndependentComponents[Sigma[-a,-b,-c],Tau[-a,-b]]]]/Mo/.{En->Pi Mo}));
NullVectorDegreeOfDivergence=Limit[Log[UltravioletNullVector]/Log[Mo]//FullSimplify,Mo->Infinity];(*how does the vector go at large momenta?*)
RescaledNullVector=RescaledNullVector Mo^(-NullVectorDegreeOfDivergence);(*rescale that divergence away*)
RescaledNullVector];
