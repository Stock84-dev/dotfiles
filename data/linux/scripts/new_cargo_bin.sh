#!/bin/bash
#

mkdir $1
mkdir $1/src
touch $1/src/$1.rs

cat > $1/Cargo.toml <<- EOM
[package]
name = "$1"
version = "1.0.0"
authors = ["Stock84-dev <leontk8@gmail.com>"]
edition = "2021"

[[bin]]
name = "$1"
path = "src/$1.rs"

[dependencies]
EOM
