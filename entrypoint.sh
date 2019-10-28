#!/bin/sh -l

echo "Hello $1"
time=$(ansible --version)
echo ::set-output name=time::$time