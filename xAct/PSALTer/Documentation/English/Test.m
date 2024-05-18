If[(ReadList@OpenRead@("!if ! command -v inkscape &> /dev/null then echo "1" exit 1 else echo "0" exit 0 fi"))===1,Throw@Message[Get::noopen,"inkscape"]];
Quit[];
