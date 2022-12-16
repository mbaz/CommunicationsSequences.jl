# CommunicationsSequences

This Julia package provides functions to generate data sequences that are
frequently used in digital communications.

### Roadmap to v1.0

- [x] Linear shift-register sequences
- [x] Barker sequences
- [ ] Golay complementary sequences
- [ ] Zadoff-Chu sequences
- [ ] Frank sequences
- [ ] Other sequences?
- [ ] Expand documentation
- [ ] Improve tests

### Examples

#### Generate a linear-shift register sequence

LFSR sequences are implemented as stateful, infinite iterators. The sequence is defined by the
feedback taps, specified in Fibonacci notation, from largest to smallest degree. The package
pre-defines feedback taps for maximum-length sequences of degrees 2 to 24. While the LFSR
produces boolean output by default, it is possible to define arbitrary outputs.

Example:

```julia
# Instantiate an LFSR iterator with taps (10, 7, 5)
l = LFSR((10, 7, 5))

# Instantiate a maximum-length LFSR iterator with period 2^16-1
l = LFSR(lfsrtaps[16])

# Specify the outputs to be 1.0 and -1.0
l = LFSR(lfsrtaps[16], mapping = (1.0, -1.0))

# Obtain the first 20 values of the sequence
first(l, 20)

# Obtain the next 20 values -- recall that the iterator is stateful
first(l, 20)
```

The iterator is quite fast. On an IceLake i5 laptop:

```julia
using BenchmarkTools
l = LFSR(lfsrtaps[16], mapping = (1.0, -1.0))
@btime iterate($l, nothing)
```

results in

```julia
  15.192 ns (0 allocations: 0 bytes)
```

or almost 66 million iterations per second.

#### Barker sequences

Barker sequences (or "codes"), being quite short, are provided as tuples that can be
accessed from a dictionary. For example,

```julia
barker["7"]
```

returns the tuple

```julia
(1, 1, 1, -1, -1, 1, -1)
```

The full list of sequences and their keys is:

```julia
    "2a" => (1, 1)
    "2b" => (1, -1)
    "3"  => (1, 1, -1)
    "4a" => (1, 1, -1, 1)
    "4b" => (1, 1, 1, -1)
    "5"  => (1, 1, 1, -1, 1)
    "7"  => (1, 1, 1, -1, -1, 1, -1)
    "11" => (1, 1, 1, -1, -1, -1, 1, -1, -1, 1, -1)
    "13" => (1, 1, 1, 1, 1, -1, -1, 1, 1, -1, 1, -1 , 1)
```
