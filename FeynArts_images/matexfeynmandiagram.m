(* ::Package:: *)

(* ::Input:: *)
(*Needs["MaTeX`"]*)
(**)
(*ConfigureMaTeX["pdfLaTeX" -> "/usr/bin/lualatex", "Ghostscript" -> "/usr/bin/gs"*)
(*    ];*)
(**)
(*SetOptions[MaTeX, "Preamble" -> {"\\usepackage{tikz}\\usepackage{tikz-feynman}"*)
(*    }];*)
(**)
(*conditions = {noghost, spin partity, mass};*)
(**)
(*MaTeX["\\tikzset{graviton/.style={decorate, decoration={snake, amplitude=.4mm, segment length=1.5mm, pre length=.5mm, post length=.5mm}, double}}"*)
(*    ];*)
(**)
(*Show[MaTeX["\\tikzset{graviton/.style={decorate, decoration={snake, amplitude=.4mm, segment length=1.5mm, pre length=.5mm, post length=.5mm}, double}}\\feynmandiagram[vertical=a to b,node distance=4cm][large] {i1--[fermion] a--[fermion] i2,a--[graviton] b,f1--[fermion] b--[fermion] f2,}; "*)
(*    ], PlotLabel -> conditions, ImageSize -> Small]*)
(**)
