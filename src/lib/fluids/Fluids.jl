module Fluids

using CoolProp, Unitful

include("PhysicalQuantities.jl")
include("Compositions.jl")

using .PhysicalQuantities
using .Compositions

struct Fluid
    pressure::Pressure
    temperature::Temperature
    # # massFlowrate::MassFlowrate
    viscosity::Viscosity
    density::Density
    massSpecificEnthalpy::MassSpecificEnthalpy
    massSpecificEntropy::MassSpecificEntropy
    phase::Float64

    Fluid(lookupfunc::Function, p::Pressure, t::Temperature) = new(
        p,
        t,
        lookupfunc("V", "P", p, "T", t, compositions["100%CO2"]),
        lookupfunc("D", "P", p, "T", t, compositions["100%CO2"]),
        lookupfunc("H", "P", p, "T", t, compositions["100%CO2"]),
        lookupfunc("S", "P", p, "T", t, compositions["100%CO2"]),
        lookupfunc("Phase", "P", p, "T", t, compositions["100%CO2"]),
    )

    Fluid(lookupfunc::Function, p::Pressure, h::MassSpecificEnthalpy) = new(
        p,
        lookupfunc("T", "P", p, "H", h, compositions["100%CO2"]),
        lookupfunc("V", "P", p, "H", h, compositions["100%CO2"]),
        lookupfunc("D", "P", p, "H", h, compositions["100%CO2"]),
        h,
        lookupfunc("S", "P", p, "H", h, compositions["100%CO2"]),
        lookupfunc("Phase", "P", p, "H", h, compositions["100%CO2"]),
    )

    # The equations of state are based on T and ρ as state variables,
    # so T,ρ will always be the fastest inputs. P,T will be a bit slower (3-10 times), 
    # followed by input pairs where neither T nor ρ are specified, like P,H; these will be much slower. 
    # If speed is an issue, you can look into table-based interpolation methods using TTSE or bicubic interpolation;
    Fluid(p::Pressure, t::Temperature) = new(
        PropsSI,
        p,
        t
    )

    Fluid(p::Pressure, h::MassSpecificEnthalpy) = new(
        PropsSI,
        p,
        h
    )
end

export Fluid

end