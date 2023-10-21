Print@"Now we want to test some syntax...";

Options@ParticleSpectrum={
	TheoryName->False
	};

ParticleSpectrum[OptionsPattern[]]:=Catch@Module[{},
	Print@"looks like you just passed an option:";
	Print@OptionValue@TheoryName;
];

ParticleSpectrum[Expr_,OptionsPattern[]]:=Catch@Module[{},
	Print@"looks like you passed a theory:";
	Print@Expr;
];

CreateDirectory[FileNameJoin@{Directory[],"tmp"}];

ParticleSpectrum[args,TheoryName->"ZTheory"];
ParticleSpectrum[TheoryName->"ZTheory"];
