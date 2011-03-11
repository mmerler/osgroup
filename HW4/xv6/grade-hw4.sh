#!/bin/sh

. ./grade-functions.sh

$make


pts=10
runtest "hw4-test-err" 2 2
runtest "hw4-test-san" 5 2
runtest "hw4-test-sim" 10 1
runtest "hw4-test-str" 5 1
runtest "hw4-test-aff" 50 2
runtest "hw4-test-ast" 25 2

showpart E

showfinal

