../ceylon-dist/dist/bin/ceylon compile-js --rep=../ceylon-sdk/modules --rep=../jsonsl/modules source/json/bench/*
../ceylon-dist/dist/bin/ceylon compile --rep=../ceylon-sdk/modules --rep=../jsonsl/modules source/json/bench/*
echo #########################
echo # RUNNING ON JAVASCRIPT #
echo #########################
../ceylon-dist/dist/bin/ceylon run-js --rep=../ceylon-sdk/modules --rep=../jsonsl/modules json.bench/0.1
echo #########################
echo # RUNNING ON JVM        #
echo #########################
../ceylon-dist/dist/bin/ceylon run --rep=../ceylon-sdk/modules --rep=../jsonsl/modules json.bench/0.1
