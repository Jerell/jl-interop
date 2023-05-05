using Test, Unitful
include("../src/CCSTwin.jl")
include("../src/lib/fluids/Fluids.jl")
using .Fluids

@testset "CCSTwin.jl" begin
    @test Main.CCSTwin.placeholderfunc() == "World"
end

@testset "Fluids.jl" begin
    p = 10.0u"bar"
    p2 = 8.0u"bar"
    t = 20.0u"°C"

    a = Main.Fluids.Fluid(p, t)
    b = Main.Fluids.Fluid(p2, a.massSpecificEnthalpy)

    println(a)
    println(b)

    @test a.pressure > b.pressure
    @test a.temperature > b.temperature
end