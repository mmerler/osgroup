#!/bin/sh

. ./grade-functions.sh

$make

pts=10
runtest	"hw6-test-functionality"	5

pts=0
runtest "hw6-test-prepare"		5
pts=10
runtest "hw6-test-persistency"		5

pts=10
runtest "hw6-test-permission"		5

pts=10
runtest "hw6-test-corner"		5

pts=15
runtest "hw6-test-concurrency"		10

showpart E

showfinal

