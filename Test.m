Print@"Now we want to test some syntax...";

Print/@{"look",Import[FileNameJoin@{Directory[],"PSALTer.txt"}]};
Print@Magnify[Import[FileNameJoin@{NotebookDirectory[],"xAct/PSALTer/Documentation/Logo/Logo.png"},ImageSize->Small],0.5];

Quit[];
