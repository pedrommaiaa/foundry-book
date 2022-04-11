## cast abi-encode

### NAME

cast-abi-encode - ABI encode the given function arguments, excluding the selector.

### SYNOPSIS

``cast abi-encode`` [*options*] *sig* [*args...*]

### DESCRIPTION

ABI encode the given function, excluding the selector.

{{#include sig-description.md}}

### OPTIONS

{{#include common-options.md}}

### EXAMPLES

1. ABI-encode the arguments for a call to `someFunc(address,uint256)`:

       cast abi-encode "someFunc(address,uint256)" 0x... 1

### SEE ALSO

[cast](./cast.md)