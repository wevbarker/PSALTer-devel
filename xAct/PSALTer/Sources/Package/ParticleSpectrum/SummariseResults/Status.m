(*==========*)
(*  Status  *)
(*==========*)

Status[InputExpr_]:=Module[{TextPending="Pending...",TextDone="Done!",OutputString},
	If[InputExpr==Null,
		OutputString=TextPending,
		If[StringQ@InputExpr,
			OutputString=InputExpr,
			OutputString=TextDone,
			OutputString=TextDone
		];,
		If[StringQ@InputExpr,
			OutputString=InputExpr,
			OutputString=TextDone,
			OutputString=TextDone
		];
	];
OutputString];
