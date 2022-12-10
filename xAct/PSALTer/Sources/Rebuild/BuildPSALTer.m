(*================*)
(*  BuildPSALTer  *)
(*================*)

PSymb="\[ScriptK]";
DefConstantSymbol[Def,PrintAs->PSymb];

DefTensor[P[i],M4,PrintAs->PSymb];
AutomaticRules[P,MakeRule[{CD[-a][P[-b]],0},MetricOn->All,ContractMetrics->True]];
ToV=MakeRule[{P[-i],Def V[-i]},MetricOn->All,ContractMetrics->True];
ToP=MakeRule[{V[-i],P[-i]/Def},MetricOn->All,ContractMetrics->True];

PatchA2m=MakeRule[{AP2m[-a,-c,-b]AP2m[a,b,c],(1/2)AP2m[-a,-b,-c]AP2m[a,b,c]},MetricOn->All,ContractMetrics->True];
PatchA2mD1=MakeRule[{Evaluate[Dagger@AP2m[-a,-c,-b]AP2m[a,b,c]],Evaluate[(1/2)Dagger@AP2m[-a,-b,-c]AP2m[a,b,c]]},MetricOn->All,ContractMetrics->True];
PatchA2mD2=MakeRule[{Evaluate[AP2m[-a,-c,-b]Dagger@AP2m[a,b,c]],Evaluate[(1/2)AP2m[-a,-b,-c]Dagger@AP2m[a,b,c]]},MetricOn->All,ContractMetrics->True];
PatchSigma2m=MakeRule[{SigmaP2m[-a,-c,-b]SigmaP2m[a,b,c],(1/2)SigmaP2m[-a,-b,-c]SigmaP2m[a,b,c]},MetricOn->All,ContractMetrics->True];
Patch2m=Join[PatchA2m,PatchA2mD1,PatchA2mD2,PatchSigma2m];

DefConstantSymbol[#,Dagger->Complex]&/@{rFP0p,rFP1p,rFP1m,rFP2p,rAP0p,rAP0m,rAP1p,rAP1m,rAP2p,rAP2m,rFPerp0p,rFPerp1m,rAPerp1p,rAPerp1m};
rescaleFP0p=MakeRule[{FP0p[],rFP0p FP0p[]},MetricOn->All,ContractMetrics->True];
rescaleFP1p=MakeRule[{FP1p[-a,-b],rFP1p FP1p[-a,-b]},MetricOn->All,ContractMetrics->True];
rescaleFP1m=MakeRule[{FP1m[-a],rFP1m FP1m[-a]},MetricOn->All,ContractMetrics->True];
rescaleFP2p=MakeRule[{FP2p[-a,-b],rFP2p FP2p[-a,-b]},MetricOn->All,ContractMetrics->True];
rescaleAP0p=MakeRule[{AP0p[],rAP0p AP0p[]},MetricOn->All,ContractMetrics->True];rescaleAP0m=MakeRule[{AP0m[],rAP0m AP0m[]},MetricOn->All,ContractMetrics->True];
rescaleAP1p=MakeRule[{AP1p[-a,-b],rAP1p AP1p[-a,-b]},MetricOn->All,ContractMetrics->True];
rescaleAP1m=MakeRule[{AP1m[-a],rAP1m AP1m[-a]},MetricOn->All,ContractMetrics->True];rescaleAP2p=MakeRule[{AP2p[-a,-b],rAP2p AP2p[-a,-b]},MetricOn->All,ContractMetrics->True];rescaleAP2m=MakeRule[{AP2m[-a,-b,-c],rAP2m AP2m[-a,-b,-c]},MetricOn->All,ContractMetrics->True];
rescaleFPerp0p=MakeRule[{FPerp0p[],rFPerp0p FPerp0p[]},MetricOn->All,ContractMetrics->True];
rescaleFPerp1m=MakeRule[{FPerp1m[-a],rFPerp1m FPerp1m[-a]},MetricOn->All,ContractMetrics->True];
rescaleAPerp1p=MakeRule[{APerp1p[-a,-b],rAPerp1p APerp1p[-a,-b]},MetricOn->All,ContractMetrics->True];
rescaleAPerp1m=MakeRule[{APerp1m[-a],rAPerp1m APerp1m[-a]},MetricOn->All,ContractMetrics->True];

rescaleFP0pD=MakeRule[{Evaluate@Dagger@FP0p[],rFP0p Evaluate@Dagger[ FP0p[]]},MetricOn->All,ContractMetrics->True];
rescaleFP1pD=MakeRule[{Evaluate@Dagger@FP1p[-a,-b],rFP1p Evaluate@Dagger[ FP1p[-a,-b]]},MetricOn->All,ContractMetrics->True];
rescaleFP1mD=MakeRule[{Evaluate@Dagger@FP1m[-a],rFP1m  Evaluate@Dagger[FP1m[-a]]},MetricOn->All,ContractMetrics->True];
rescaleFP2pD=MakeRule[{Evaluate@Dagger@FP2p[-a,-b],rFP2p Evaluate@Dagger[ FP2p[-a,-b]]},MetricOn->All,ContractMetrics->True];
rescaleAP0pD=MakeRule[{Evaluate@Dagger@AP0p[],rAP0p Evaluate@Dagger[AP0p[]]},MetricOn->All,ContractMetrics->True];rescaleAP0mD=MakeRule[{Evaluate@Dagger@AP0m[],rAP0m Evaluate@Dagger[ AP0m[]]},MetricOn->All,ContractMetrics->True];
rescaleAP1pD=MakeRule[{Evaluate@Dagger@AP1p[-a,-b],rAP1p Evaluate@Dagger[ AP1p[-a,-b]]},MetricOn->All,ContractMetrics->True];
rescaleAP1mD=MakeRule[{Evaluate@Dagger@AP1m[-a],rAP1m Evaluate@Dagger[ AP1m[-a]]},MetricOn->All,ContractMetrics->True];rescaleAP2pD=MakeRule[{Evaluate@Dagger@AP2p[-a,-b],rAP2p Evaluate@Dagger[ AP2p[-a,-b]]},MetricOn->All,ContractMetrics->True];rescaleAP2mD=MakeRule[{Evaluate@Dagger@AP2m[-a,-b,-c],rAP2m Evaluate@Dagger[ AP2m[-a,-b,-c]]},MetricOn->All,ContractMetrics->True];
rescaleFPerp0pD=MakeRule[{Evaluate@Dagger@FPerp0p[],rFPerp0p  Evaluate@Dagger[FPerp0p[]]},MetricOn->All,ContractMetrics->True];
rescaleFPerp1mD=MakeRule[{Evaluate@Dagger@FPerp1m[-a],rFPerp1m Evaluate@Dagger[ FPerp1m[-a]]},MetricOn->All,ContractMetrics->True];
rescaleAPerp1pD=MakeRule[{Evaluate@Dagger@APerp1p[-a,-b],rAPerp1p Evaluate@Dagger[ APerp1p[-a,-b]]},MetricOn->All,ContractMetrics->True];
rescaleAPerp1mD=MakeRule[{Evaluate@Dagger@APerp1m[-a],rAPerp1m Evaluate@Dagger[ APerp1m[-a]]},MetricOn->All,ContractMetrics->True];

rescale=Join[rescaleFP0p,rescaleFP1p,rescaleFP1m,rescaleFP2p,rescaleAP0p,rescaleAP0m,rescaleAP1p,rescaleAP1m,rescaleAP2p,rescaleAP2m,rescaleFPerp0p,rescaleFPerp1m,rescaleAPerp1p,rescaleAPerp1m,rescaleFP0pD,rescaleFP1pD,rescaleFP1mD,rescaleFP2pD,rescaleAP0pD,rescaleAP0mD,rescaleAP1pD,rescaleAP1mD,rescaleAP2pD,rescaleAP2mD,rescaleFPerp0pD,rescaleFPerp1mD,rescaleAPerp1pD,rescaleAPerp1mD];

DefConstantSymbol[#,Dagger->Complex]&/@{cFP0p,cFP1p,cFP1m,cFP2p,cAP0p,cAP0m,cAP1p,cAP1m,cAP2p,cAP2m,cFPerp0p,cFPerp1m,cAPerp1p,cAPerp1m};
Up0p={FP0p[],AP0p[],FPerp0p[]};
Up0m={AP0m[]};
Up1p={FP1p[a,b],AP1p[a,b],APerp1p[a,b]};
Up1m={FP1m[a],AP1m[a],FPerp1m[a],APerp1m[a]};
Up2p={FP2p[a,b],AP2p[a,b]};
Up2m={AP2m[a,b,c]};
Down0p={FP0p[],AP0p[],FPerp0p[]};
Down0m={AP0m[]};
Down1p={FP1p[-a,-b],AP1p[-a,-b],APerp1p[-a,-b]};
Down1m={FP1m[-a],AP1m[-a],FPerp1m[-a],APerp1m[-a]};
Down2p={FP2p[-a,-b],AP2p[-a,-b]};
Down2m={AP2m[-a,-b,-c]};

SourceUp0p={TauP0p[],SigmaP0p[],TauPerp0p[]};
SourceUp0m={SigmaP0m[]};
SourceUp1p={TauP1p[a,b],SigmaP1p[a,b],SigmaPerp1p[a,b]};
SourceUp1m={TauP1m[a],SigmaP1m[a],TauPerp1m[a],SigmaPerp1m[a]};
SourceUp2p={TauP2p[a,b],SigmaP2p[a,b]};
SourceUp2m={SigmaP2m[a,b,c]};
SourceDown0p={TauP0p[],SigmaP0p[],TauPerp0p[]};
SourceDown0m={SigmaP0m[]};
SourceDown1p={TauP1p[-a,-b],SigmaP1p[-a,-b],SigmaPerp1p[-a,-b]};
SourceDown1m={TauP1m[-a],SigmaP1m[-a],TauPerp1m[-a],SigmaPerp1m[-a]};
SourceDown2p={TauP2p[-a,-b],SigmaP2p[-a,-b]};
SourceDown2m={SigmaP2m[-a,-b,-c]};

Ups={SourceUp0p,SourceUp0m,SourceUp1p,SourceUp1m,SourceUp2p,SourceUp2m};
Downs={SourceDown0p,SourceDown0m,SourceDown1p,SourceDown1m,SourceDown2p,SourceDown2m};
AllSource={TauP1p[a,b],SigmaP1p[a,b],SigmaPerp1p[a,b],TauP1m[a],SigmaP1m[a],TauPerp1m[a],SigmaPerp1m[a],TauP2p[a,b],SigmaP2p[a,b],SigmaP2m[a,b,c],TauP1p[-a,-b],SigmaP1p[-a,-b],SigmaPerp1p[-a,-b],TauP1m[-a],SigmaP1m[-a],TauPerp1m[-a],SigmaPerp1m[-a],TauP2p[-a,-b],SigmaP2p[-a,-b],SigmaP2m[-a,-b,-c]};

c0p={cFP0p,cAP0p,cFPerp0p};
c0m={cAP0m};
c1p={cFP1p,cAP1p,cAPerp1p};
c1m={cFP1m,cAP1m,cFPerp1m,cAPerp1m};
c2p={cFP2p,cAP2p};
c2m={cAP2m};

r0p={1/rFP0p,1/rAP0p,1/rFPerp0p};
r0m={1/rAP0m};
r1p={1/rFP1p,1/rAP1p,1/rAPerp1p};
r1m={1/rFP1m,1/rAP1m,1/rFPerp1m,1/rAPerp1m};
r2p={1/rFP2p,1/rAP2p};
r2m={1/rAP2m};


rescmat=TensorProduct[#,#]&/@{r0p,r0m,r1p,r1m,r2p,r2m};
invrescmat=TensorProduct[1/#,1/#]&/@{r0p,r0m,r1p,r1m,r2p,r2m};
MatrixForm/@rescmat;
MatrixForm/@invrescmat;

cRules={};
For[ii=1,ii<(Length@#[[1]]+1),ii++,For[jj=1,jj<(Length@#[[1]]+1),jj++,
cRules=Join[cRules,MakeRule[{Evaluate@(#[[1]][[ii]]Evaluate@Dagger[#[[2]][[jj]]]),Evaluate@(#[[3]][[ii]]Evaluate@Dagger[#[[3]][[jj]]])},MetricOn->All,ContractMetrics->True]];
]]&/@{{Up0p,Down0p,c0p},
{Up0m,Down0m,c0m},
{Up1p,Down1p,c1p},
{Up1m,Down1m,c1m},
{Up2p,Down2p,c2p},
{Up2m,Down2m,c2m}};

res=(Transpose@#[[1]]) . ((Evaluate@Dagger[#])&/@#[[2]])&/@{{Up0p,Down0p},
{Up0m,Down0m},
{Up1p,Down1p},
{Up1m,Down1m},
{Up2p,Down2p},
{Up2m,Down2m}}//Total;

res=res-Evaluate@Dagger@F[-a,-b]F[a,b]-Evaluate@Dagger@A[-a,-b,-c]A[a,b,c];
res=res/.rescale;

res=res/.GaugePO3Activate;
res=res//ToNewCanonical;
res=res/.GaugePerpO3Activate;
res=res//ToNewCanonical;
res=res/.PADMPiActivate;
res=res//NoScalar
res=res//ToNewCanonical;
res=res/.PO3PiActivate;
res=res//ToNewCanonical;
res=res/.PADMActivate;
res=res//NoScalar;
res=res//ToNewCanonical;
res=res//NoScalar;
res=res//ToNewCanonical;
res=res//NoScalar;
res=res//ToNewCanonical;
res=res/.GaugeCompose;
res=res//ToNewCanonical;
res=res//CollectTensors;

sys=res==0//ToConstantSymbolEquations;
sols=Solve@sys;

rescsols=sols[[1]];

xAct`PSALTer`Private`BuildRebuild@"Lightcone.m";
