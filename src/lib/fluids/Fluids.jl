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

    # The equations of state are based on T and ρ as state variables,
    # so T,ρ will always be the fastest inputs. P,T will be a bit slower (3-10 times), 
    # followed by input pairs where neither T nor ρ are specified, like P,H; these will be much slower. 
    # If speed is an issue, you can look into table-based interpolation methods using TTSE or bicubic interpolation;
    Fluid(p::Pressure, t::Temperature) = new(
        p,
        t,
        PropsSI("V", "P", p, "T", t, compositions.co2pure),
        PropsSI("D", "P", p, "T", t, compositions.co2pure),
        PropsSI("H", "P", p, "T", t, compositions.co2pure),
        PropsSI("S", "P", p, "T", t, compositions.co2pure),
        PropsSI("Phase", "P", p, "T", t, compositions.co2pure),
    )

    Fluid(p::Pressure, h::MassSpecificEnthalpy) = new(
        p,
        PropsSI("T", "P", p, "H", h, compositions.co2pure),
        PropsSI("V", "P", p, "H", h, compositions.co2pure),
        PropsSI("D", "P", p, "H", h, compositions.co2pure),
        PropsSI("H", "P", p, "H", h, compositions.co2pure),
        PropsSI("S", "P", p, "H", h, compositions.co2pure),
        PropsSI("Phase", "P", p, "H", h, compositions.co2pure),
    )
end

export Fluid

end