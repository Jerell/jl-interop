# CCSTwin

[![Build Status](https://github.com/jerell/jl-interop/actions/workflows/buildAndTestJl.yml/badge.svg?branch=main)](https://github.com/jerell/jl-interop/actions/workflows/buildAndTestJl.yml?query=branch%3Amain)

## Setup

### Modelling engine - Julia

[Install Julia 1.8](https://julialang.org/downloads/)

Install dependencies through Julia REPL:

```bash
using Pkg; Pkg.instantiate()
```

or

```bash
]
activate .
instantiate
```

### .NET API

See [api/README.md](api/README.md)

## Run

Start the Julia process

```bash
julia src/main.jl
```

That's it. [Start the .NET API](api/README.md) and make a GET request to `https://localhost:7004/WeatherForecast`. The response will include a value returned from the Julia process.
