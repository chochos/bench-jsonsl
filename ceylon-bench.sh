echo Compiling JS
../ceylon-dist/dist/bin/ceylon compile-js --rep=../ceylon-sdk/modules --rep=../jsonsl/modules source/json/bench/* resource/json/bench/*
echo Compiling JVM
../ceylon-dist/dist/bin/ceylon compile --rep=../ceylon-sdk/modules --rep=../jsonsl/modules source/json/bench/* resource/json/bench/*
echo RUNNING ON JAVASCRIPT
../ceylon-dist/dist/bin/ceylon run-js --rep=../ceylon-sdk/modules --rep=../jsonsl/modules json.bench/0.1
echo RUNNING ON JVM
../ceylon-dist/dist/bin/ceylon run --rep=../ceylon-sdk/modules --rep=../jsonsl/modules json.bench/0.1

echo JSON benchmark JS
../ceylon-dist/dist/bin/ceylon run-js --rep=../ceylon-sdk/modules --rep=../jsonsl/modules --run json json.bench/0.1
echo RUNNING ON JVM
../ceylon-dist/dist/bin/ceylon run --rep=../ceylon-sdk/modules --rep=../jsonsl/modules --run json.bench::json json.bench/0.1
