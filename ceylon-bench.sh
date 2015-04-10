if [ "$1" == "" ]; then
  WHAT=run
else
  WHAT=$1
fi

echo Compiling JS
../ceylon-dist/dist/bin/ceylon compile-js --rep=../ceylon-sdk/modules --rep=../jsonsl/modules source/json/bench/* resource/json/bench/*
echo Compiling JVM
../ceylon-dist/dist/bin/ceylon compile --rep=../ceylon-sdk/modules --rep=../jsonsl/modules source/json/bench/* resource/json/bench/*
echo JAVASCRIPT $WHAT
../ceylon-dist/dist/bin/ceylon run-js --rep=../ceylon-sdk/modules --rep=../jsonsl/modules --run $WHAT json.bench/0.1
echo JVM $WHAT
../ceylon-dist/dist/bin/ceylon run --rep=../ceylon-sdk/modules --rep=../jsonsl/modules --run json.bench::$WHAT json.bench/0.1
