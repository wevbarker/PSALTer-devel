cd "C:\Users\user"
ls "C:\Program Files\Wolfram Research\Mathematica\14.0\AddOns\Applications\xAct"
rm -rf "C:\Program Files\Wolfram Research\Mathematica\14.0\AddOns\Applications\xAct\PSALTer"
ls "C:\Program Files\Wolfram Research\Mathematica\14.0\AddOns\Applications\xAct"
ls "C:\Users\user\AppData\Roaming\Mathematica\Applications\xAct"
rm -rf "C:\Users\user\AppData\Roaming\Mathematica\Applications\xAct\PSALTer"
ls "C:\Users\user\AppData\Roaming\Mathematica\Applications\xAct"
rm -rf "C:\Users\user\PSALTer-devel"

git clone https://github.com/wevbarker/PSALTer-devel
cd PSALTer-devel
git checkout README
xcopy /e /k /h /i xAct\ "C:\Users\user\AppData\Roaming\Mathematica\Applications\xAct\"
ls "C:\Users\user\AppData\Roaming\Mathematica\Applications\xAct"
cd "C:\Users\user\Documents\PSALTer-devel"
