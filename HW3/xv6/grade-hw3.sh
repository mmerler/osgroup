#!/bin/sh

. ./grade-functions.sh

$make

pts=7
runtest "hw3-test-single" 5
runtest "hw3-test-multiple" 5
pts=8
runtest "hw3-test-kill1" 5
runtest "hw3-test-kill2" 5
pts=10
runtest "hw3-test-fork" 5
showpart A

pts=5
runtest "hw3-test-readlock" 5
runtest "hw3-test-writelock" 15
pts=10
runtest "hw3-test-favorwriter" 30
showpart B

showfinal

