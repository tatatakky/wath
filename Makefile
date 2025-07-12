TARGET_WASM = wath.wasm

ifeq ($(shell uname), Linux)
	WASI_SDK_PATH = $(shell which clang | sed -e 's/\/bin\/clang//g')
else ifeq ($(shell uname), Darwin)
	WASI_SDK_PATH = $(shell which clang | sed -e 's/\/bin\/clang//g')
else
endif

WASI_CLANG_VERSION = $(shell $(WASI_SDK_PATH)/bin/clang --version | grep -oE 'clang version [0-9]+' | cut -d ' ' -f3)

LDFLAGS := -strip-all -gc-sections
LDFLAGS += --no-entry --export-all -allow-undefined
LDFLAGS += -export=__wasm_call_ctors -export=malloc -export=free -export=main

OBJ_FILE = Functions.o \
	   Basic.o \
	   Exponential.o \
	   Power.o \
	   Trigonometric.o \
	   Hyperbolic.o \

all: build

build: $(OBJ_FILE)
	$(WASI_SDK_PATH)/bin/wasm-ld \
		$(LDFLAGS) $(OBJ_FILE) \
		$(WASI_SDK_PATH)/lib/clang/$(WASI_CLANG_VERSION)/lib/wasi/libclang_rt.builtins-wasm32.a \
		$(WASI_SDK_PATH)/share/wasi-sysroot/lib/wasm32-wasi/libc.a \
		-o $(TARGET_WASM)

Functions.o: src/Functions.c
	$(WASI_SDK_PATH)/bin/clang -Wall -Wmissing-prototypes --target=wasm32-wasi -O3 -c src/Functions.c -o Functions.o

Basic.o: src/Basic.c
	$(WASI_SDK_PATH)/bin/clang -Wall -Wmissing-prototypes --target=wasm32-wasi -O3 -c src/Basic.c -o Basic.o

Exponential.o: src/Exponential.c
	$(WASI_SDK_PATH)/bin/clang -Wall -Wmissing-prototypes --target=wasm32-wasi -O3 -c src/Exponential.c -o Exponential.o

Power.o: src/Power.c
	$(WASI_SDK_PATH)/bin/clang -Wall -Wmissing-prototypes --target=wasm32-wasi -O3 -c src/Power.c -o Power.o

Trigonometric.o: src/Trigonometric.c
	$(WASI_SDK_PATH)/bin/clang -Wall -Wmissing-prototypes --target=wasm32-wasi -O3 -c src/Trigonometric.c -o Trigonometric.o

Hyperbolic.o: src/Hyperbolic.c
	$(WASI_SDK_PATH)/bin/clang -Wall -Wmissing-prototypes --target=wasm32-wasi -O3 -c src/Hyperbolic.c -o Hyperbolic.o

check:
	@echo "[Path and Version of clang]"
	which clang && clang --version
	@echo ""
	@echo "[Path and Version of lld for Wasm]"
	which wasm-ld && wasm-ld --version
	@echo ""
	@echo "[Path and Version of wasmer]"
	which wasmer && wasmer --version

test:
	./wath_test.sh $(TARGET_WASM)

clean:
	rm -rf *.o

help:
	@echo "make		build to C to Wasm"
	@echo "make test	test with wasmer"
	@echo "make clean	delete object file(*.o)"
	@echo "make check	check path and version of clang, wasm-ld, wasmer"
