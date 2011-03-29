#!/bin/sh

. ./grade-functions.sh

$make

pts=0
if runtest "hw5-test-page" 5
then
	pts=5
	runtest "hw5-test-simple"        5
	runtest "hw5-test-error"         5
	pts=10
	runtest "hw5-test-many"          8
	runtest "hw5-test-toomany"       8
	runtest "hw5-test-stress"        5
	pts=20
	runtest "hw5-test-comp"          30
else
	echo "We don't grade any further it hw5-test-page fails."
fi

showpart E

showfinal

