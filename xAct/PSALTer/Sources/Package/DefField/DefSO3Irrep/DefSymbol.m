(*=============*)
(*  DefSymbol  *)
(*=============*)

Options@DefSymbol={
	Spin->0,	
	Parity->Even,
	Duplicate->1};

$CouplingColour=RGBColor[0,0,0];
$TensorColour=RGBColor[0,0,0];
$IrrepColour=RGBColor[0,0,0];

DefSymbol[TensorSymbol_,OptionsPattern[]]:=Module[{
	ParitySymbols=<|Even->"+",Odd->"-"|>,
	ParitySymbol,
	SpinSymbol,
	IrrepSymbol,
	FullSymbol},

	ParitySymbol=ParitySymbols@(OptionValue@Parity);
	SpinSymbol=ToString@(OptionValue@Spin);

	IrrepSymbol="\!\(\*OverscriptBox[SuperscriptBox[\("<>SpinSymbol<>"\), \("<>ParitySymbol<>"\)],\(#"<>ToString@OptionValue@Duplicate<>"\)]\)";
	FullSymbol=ColorString[IrrepSymbol,$IrrepColour]~StringJoin~ColorString[TensorSymbol,$TensorColour];
FullSymbol];
