(*============================*)
(*  ConstructMassiveAnalysis  *)
(*============================*)

BuildPackage@"ParticleSpectrum/ConstructMassiveAnalysis/MassiveAnalysisOfSector.m";
BuildPackage@"ParticleSpectrum/ConstructMassiveAnalysis/MassiveGhost.m";

ConstructMassiveAnalysis[Couplings_,ValuesSaturatedPropagator_,ValuesInverseBMatricesValues_,BlockMassSigns_]:=Module[{	
	SignedInverseBMatrices
	},

	LocalSpectrum=" ** ConstructMassiveAnalysis...";

	MassiveAnalysis=MapThread[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(MassiveAnalysisOfSector[#1,#2]))&,
		{(ValuesSaturatedPropagator),
		Couplings~ConstantArray~(Length@(ValuesSaturatedPropagator))}];
	MassiveAnalysis=WaitAll@MassiveAnalysis;

	SignedInverseBMatrices=Times~MapThread~{(ValuesInverseBMatricesValues),(BlockMassSigns)};

	MassiveGhostAnalysis=MapThread[
		(xAct`PSALTer`Private`PSALTerParallelSubmit@(MassiveGhost[#1,#2]))&,
		{SignedInverseBMatrices,
		MassiveAnalysis}];
	MassiveGhostAnalysis=WaitAll@MassiveGhostAnalysis;
];
