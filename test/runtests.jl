include("../src/CCSTwin.jl")
using Test

@testset "CCSTwin.jl" begin
    @test Main.CCSTwin.placeholderfunc() == "World"
end
