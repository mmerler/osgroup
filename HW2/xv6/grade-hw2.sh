#!/bin/sh

. ./grade-functions.sh

$make

pts=5

runtest "hw2-test-skip" 5
runtest "hw2-test-invalid" 5

pts=10
runtest "hw2-test-pause" 5
runtest "hw2-test-truncate" 5
runtest "hw2-test-fork" 5
runtest "hw2-test-string" 5
runtest "hw2-test-pointer" 5

showpart E

showfinal

