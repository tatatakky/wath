# WATH
<b>W</b>eb<b>A</b>ssembly for using ma<b>TH</b> functions in the libc.

## Prerequisites
- [wasi-sdk](https://github.com/WebAssembly/wasi-sdk)
- [wasmer](https://github.com/wasmerio/wasmer)

## Compile
You can compile with `make`.
```
$ make
```

## Test
You can do test with `make test`.
```
$ make test
```
You also can do test with `wasmer` directly, like the following.
```
$ wasmer run wath.wasm --dir=. --invoke wath_exp 2.0
```
