(*=======*)
(*  Run  *)
(*=======*)

Print@"First we import some formatting...";

Get@FileNameJoin@{NotebookDirectory[],"Calibration","VimFormat.m"};

Comment@"...okay, that's better, from now on any commentary written inside this Calibration.m wrapper will present as blue text (i.e. this text is not part of PSALTer, it is just a use-case). Next we load the PSALTer package:";

<<xAct`PSALTer`;

Comment@"PSALTer should now be loaded, let's try a theory.";

DefConstantSymbol[Kp,PrintAs->"\[Kappa]"];
LinearisedLagrangian=(-1/(2*Kp))*(A[-a,-j,-i]*A[a,i,j]+A[a,i,-a]*A[-i,j,-j]+2*F[a,i]*CD[-i]@A[-a,j,-j]-2*F[a,i]*CD[-j]@A[-a,j,-i]);

Catch@ParticleSpectrum[
	"PGT",
	"EinsteinCartanTheory",
	LinearisedLagrangian,
	TensorFields->{F,A},
	CouplingConstants->{Kp},
	ExportTheory->True
];

Throw@"Current end of script!";
