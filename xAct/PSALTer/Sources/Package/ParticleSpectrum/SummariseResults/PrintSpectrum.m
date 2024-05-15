(*=================*)
(*  PrintSpectrum  *)
(*=================*)

BuildPackage@"ParticleSpectrum/SummariseResults/PrintSpectrum/PrintParticle.m";
BuildPackage@"ParticleSpectrum/SummariseResults/PrintSpectrum/PrintMassiveSpectrum.m";
BuildPackage@"ParticleSpectrum/SummariseResults/PrintSpectrum/StripFactors.m";
BuildPackage@"ParticleSpectrum/SummariseResults/PrintSpectrum/PrintMasslessSpectrum.m";
BuildPackage@"ParticleSpectrum/SummariseResults/PrintSpectrum/PrintSecularEquation.m";

PrintSpectrumMassive[Args___]:=PrintSpectrum[Args,ShellType->Massive];
PrintSpectrumMassless[Args___]:=PrintSpectrum[Args,ShellType->Massless];

Options@PrintSpectrum={ShellType->Massive};

PrintSpectrum[
		SquareMasses_,
		MassivePropagatorResidues_,
		MasslessEigenvalues_,
		QuarticAnalysisValue_,
		HexicAnalysisValue_,
		SecularEquation_,
		OptionsPattern[]]:=Module[{ContentList},
	ContentList=(
		(MapThread[If[!(#1==={}),
					PrintParticle[First@#1,First@#2,#4,#3,2*#4+1],
					0
			]&,{
				MassivePropagatorResidues,
				SquareMasses,
				{Even,Odd,Even,Odd,Even,Odd,Even,Odd}~Take~Length@SquareMasses,
				{0,0,1,1,2,2,3,3}~Take~Length@SquareMasses
			}]~DeleteCases~0)
		)~Join~(
		Join[
			(PrintParticle[First@#,0,0,0,Length@#,LaurentDepth->1]&/@Gather@(StripFactors/@MasslessEigenvalues)),
			(PrintParticle[First@#,0,0,0,Length@#,LaurentDepth->2]&/@Gather@(StripFactors/@QuarticAnalysisValue)),
			(PrintParticle[First@#,0,0,0,Length@#,LaurentDepth->3]&/@Gather@(StripFactors/@HexicAnalysisValue))(*,
			(PrintSecularEquation/@SecularEquation)*)
		]
	);
	If[ContentList=={}&&(OptionValue@ShellType===Massless),
		ContentList=DetailCell@Text@"(No massless particles)"];
	If[ContentList=={}&&(OptionValue@ShellType===Massive),
		ContentList=DetailCell@Text@"(No massive particles)"];
ContentList];
