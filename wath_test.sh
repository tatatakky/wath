#!/usr/bin/env bash

function error() {
	printf "[Error] $1\n"
	exit 1
}

function f_exists() {
	[[ -f "$1" ]]
}

function execute_test() {
	wasm_file="$1"
	wasmer run "$wasm_file" --dir=. --invoke wath_abs -- -2
	wasmer run "$wasm_file" --dir=. --invoke wath_labs -- -2
	wasmer run "$wasm_file" --dir=. --invoke wath_llabs -- -2
	wasmer run "$wasm_file" --dir=. --invoke wath_fabsf -- -2.0
	wasmer run "$wasm_file" --dir=. --invoke wath_fabs -- -2.0
	wasmer run "$wasm_file" --dir=. --invoke wath_expf 2.0
	wasmer run "$wasm_file" --dir=. --invoke wath_exp 2.0
	wasmer run "$wasm_file" --dir=. --invoke wath_exp2f 2.0
	wasmer run "$wasm_file" --dir=. --invoke wath_exp2 2.0
	wasmer run "$wasm_file" --dir=. --invoke wath_expm1f 2.0
	wasmer run "$wasm_file" --dir=. --invoke wath_expm1 2.0
	wasmer run "$wasm_file" --dir=. --invoke wath_logf 2.0
	wasmer run "$wasm_file" --dir=. --invoke wath_log 2.0
	wasmer run "$wasm_file" --dir=. --invoke wath_log10f 2.0
	wasmer run "$wasm_file" --dir=. --invoke wath_log10 2.0
	wasmer run "$wasm_file" --dir=. --invoke wath_log2f 2.0
	wasmer run "$wasm_file" --dir=. --invoke wath_log2 2.0
	wasmer run "$wasm_file" --dir=. --invoke wath_log1pf 2.0
	wasmer run "$wasm_file" --dir=. --invoke wath_log1p 2.0
	wasmer run "$wasm_file" --dir=. --invoke wath_sinhf 2.0
	wasmer run "$wasm_file" --dir=. --invoke wath_sinh 2.0
	wasmer run "$wasm_file" --dir=. --invoke wath_sqrtf 2.0
	wasmer run "$wasm_file" --dir=. --invoke wath_sqrt 2.0
	wasmer run "$wasm_file" --dir=. --invoke wath_sinf 2.0
	wasmer run "$wasm_file" --dir=. --invoke wath_sin 2.0
}

if [ $# -eq 0 ]; then
	error "not input wasm file."
	exit 1
else
	case "$1" in
		*.wasm)
			f_exists "$1" && execute_test "$1" || error "please input valid wasm file."
			exit
			;;
		*)
			error "please input wasm file."
			;;
	esac
fi
