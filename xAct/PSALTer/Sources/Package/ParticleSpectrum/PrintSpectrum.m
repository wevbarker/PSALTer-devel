(*=================*)
(*  PrintSpectrum  *)
(*=================*)

ConfigureMaTeX["pdfLaTeX" -> "/usr/bin/lualatex", "Ghostscript" -> "/usr/bin/gs"];
SetOptions[MaTeX, "Preamble" -> {"\\usepackage{tikz}\\usepackage{tikz-feynman}"}];

PrintParticle[MassivePoleResidue_,SquareMass_,Spin_,Parity_,Polarisations_]:=Module[{TempGraphics},

	SpinStyles=<|0->"scalar",1->"photon",2->"Tensor",3->"Spin3"|>;
	SpinStyle=Evaluate@SpinStyles@Spin;
	ParityColours=<|Even->"red",Odd->"blue"|>;	
	ParityColour=Evaluate@ParityColours@Parity;
	ToParity=<|Even->"+",Odd->"-"|>;

	TikzSet="\\tikzset{
			Tensor/.style={decorate, decoration={snake, amplitude=.8mm, segment length=1.5mm, pre length=.5mm, post length=.5mm}, double},
			Spin3/.style={decorate, decoration={zigzag, amplitude=.8mm, segment length=1.5mm, pre length=.5mm, post length=.5mm}, double}
			}";
	OpenDiagram="\\feynmandiagram[medium,horizontal=a to b]{
			i1[particle=\(j\),gray!30] --[thick,gray!30] a [crossed dot, thick,gray!30],

			i2[particle=\(j\),gray!30] --[thick,gray!30] a,
			a ";
	If[SquareMass===0,

	CloseDiagram=" b[crossed dot, thick,gray!30],
			a --[draw=none, momentum={\\tiny{\(k^{\mu}=(p,0,0,p)\)}}] b,
			b --[thick,gray!30] f1[particle=\(j\),gray!30],
			b --[thick,gray!30] f2[particle=\(j\),gray!30],
			b --[thick,gray!30] f3[particle=\(j\),gray!30]};";	
	TempGraphics=Column[{
		Labeled[MaTeX[TikzSet<>OpenDiagram<>"--[thick]"<>CloseDiagram,Magnification->1.3],"Massless particle"],
		Grid[
		{
			{Text@"Pole residue: ",Text@(MassivePoleResidue>0)},
			{Text@"Polarisations: ",Text@(Polarisations)}
		},
		Frame->All,Alignment->Left,Background->RGBColor@{240/255,255/255,204/255}]
	},Alignment->Center];,

	CloseDiagram=" b[crossed dot, thick,gray!30],
			a --[draw=none,"<>ParityColour<>",  momentum'={[arrow style="<>ParityColour<>"]\\tiny{\(k^{\mu}=(\\mathcal{E},0,0,p)\)}}] b,
			a --[draw=none,"<>ParityColour<>", half left, looseness=0.3,  edge label = {\\scriptsize{\(J^{P}="<>ToString@Spin<>"^{"<>ToString@Evaluate@ToParity@Parity<>"}\)}\\vspace{1cm}}] b,
			b --[thick,gray!30] f1[particle=\(j\),gray!30],
			b --[thick,gray!30] f2[particle=\(j\),gray!30],
			b --[thick,gray!30] f3[particle=\(j\),gray!30]};";	
	TempGraphics=Column[{
		Labeled[MaTeX[TikzSet<>OpenDiagram<>"--["<>ParityColour<>", "<>SpinStyle<>", thick]"<>CloseDiagram,Magnification->1.3],"Massive particle"],
		Grid[
		{
			{Text@"Pole residue: ",Text@(MassivePoleResidue>0)},
			{Text@"Square mass: ",Text@(SquareMass>0)},
			{Text@"Spin: ",Text@(Spin)},
			{Text@"Parity: ",Text@(Parity)}
		},
		Frame->All,Alignment->Left,Background->RGBColor@{240/255,255/255,204/255}]
	},Alignment->Center];

	];

TempGraphics];

PrintMassiveSpectrum[SquareMasses_,MassivePropagatorResidues_]:=Print@Row@(MapThread[If[!(#1==={}),
			PrintParticle[First@#1,First@#2,#4,#3,2*#4+1],
			0
	]&,{
		MassivePropagatorResidues,
		SquareMasses,
		{Even,Odd,Even,Odd,Even,Odd,Even,Odd}~Take~Length@SquareMasses,
		{0,0,1,1,2,2,3,3}~Take~Length@SquareMasses
	}]~DeleteCases~0);

StripFactors[MasslessEigenvalue_]:=Module[{Expr,
	MasslessEigenvalueNumerator=Numerator@Normal@MasslessEigenvalue,
	MasslessEigenvalueDenominator=Denominator@Normal@MasslessEigenvalue},
	MasslessEigenvalueNumerator/=(2*3*5*7*11)^10;
	MasslessEigenvalueNumerator//=Simplify;
	MasslessEigenvalueNumerator//=Numerator;
	MasslessEigenvalueDenominator/=(2*3*5*7*11)^10;
	MasslessEigenvalueDenominator//=Simplify;
	MasslessEigenvalueDenominator//=Numerator;
	Expr=MasslessEigenvalueNumerator/MasslessEigenvalueDenominator;
	Expr//=FullSimplify;
Expr];

PrintMasslessSpectrum[MasslessEigenvalues_]:=Print@Row@(PrintParticle[First@#,0,0,0,Length@#]&/@Gather@(StripFactors/@MasslessEigenvalues));

PrintSpectrum[SquareMasses_,MassivePropagatorResidues_,MasslessEigenvalues_]:=Row[
(
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
(PrintParticle[First@#,0,0,0,Length@#]&/@Gather@(StripFactors/@MasslessEigenvalues))
)];
