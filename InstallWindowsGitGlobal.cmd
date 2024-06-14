cd "C:\Users\user"
rm -rf "C:\Program Files\Wolfram Research\Mathematica\14.0\AddOns\Applications\xAct\PSALTer"
rm -rf "C:\Users\user\AppData\Roaming\Mathematica\Applications\xAct\PSALTer"
rm -rf "C:\Users\user\PSALTer-devel"

git clone https://github.com/wevbarker/PSALTer-devel
cd PSALTer\xAct
xcopy /e /k /h /i PSALTer "C:\Program Files\Wolfram Research\Mathematica\14.0\AddOns\Applications\xAct"
