module Fluids

using CoolProp, Unitful

const Pressure = Quantity{Float64,dimension(u"bar"),typeof(u"bar")}
const Temperature = Quantity{Float64,dimension(u"°C"),typeof(u"°C")}
const MassFlowrate = Quantity{Float64,dimension(u"kg/s"),typeof(u"kg/s")}
const Viscosity = Quantity{Float64,dimension(u"m^3 / kg"),typeof(u"m^3 / kg")}
const Density = Quantity{Float64,dimension(u"kg/m^3"),typeof(u"kg/m^3")}
const MassSpecificEnthalpy = Quantity{Float64,dimension(u"J/kg"),typeof(u"J/kg")}
const MassSpecificEntropy = Quantity{Float64,dimension(u"J/kg/K"),typeof(u"J/kg/K")}

struct Fluid
    pressure::Quantity{Float64,dimension(u"bar"),typeof(u"bar")}
    temperature::Quantity{Float64,dimension(u"K"),typeof(u"K")}
    # # massFlowrate::Quantity{Float64,dimension(u"kg/s"),typeof(u"kg/s")}
    viscosity::Quantity{Float64,dimension(u"m^3 / kg"),typeof(u"m^3 / kg")}
    density::Quantity{Float64,dimension(u"kg/m^3"),typeof(u"kg/m^3")}
    massSpecificEnthalpy::Quantity{Float64,dimension(u"J/kg"),typeof(u"J/kg")}
    massSpecificEntropy::Quantity{Float64,dimension(u"J/kg/K"),typeof(u"J/kg/K")}
    phase::Float64

    # The equations of state are based on T and ρ as state variables,
    # so T,ρ will always be the fastest inputs. P,T will be a bit slower (3-10 times), 
    # followed by input pairs where neither T nor ρ are specified, like P,H; these will be much slower. 
    # If speed is an issue, you can look into table-based interpolation methods using TTSE or bicubic interpolation;
    Fluid(p::Pressure, t::Temperature) = new(
        p,
        t,
        PropsSI("V", "P", p, "T", t, "Water"),
        PropsSI("D", "P", p, "T", t, "Water"),
        PropsSI("H", "P", p, "T", t, "Water"),
        PropsSI("S", "P", p, "T", t, "Water"),
        PropsSI("Phase", "P", p, "T", t, "Water"),
    )

    Fluid(p::Pressure, h::MassSpecificEnthalpy) = new(
        p,
        PropsSI("T", "P", p, "H", h, "Water"),
        PropsSI("V", "P", p, "H", h, "Water"),
        PropsSI("D", "P", p, "H", h, "Water"),
        PropsSI("H", "P", p, "H", h, "Water"),
        PropsSI("S", "P", p, "H", h, "Water"),
        PropsSI("Phase", "P", p, "H", h, "Water"),
    )
end


p = 1.0u"bar"
t = 20.0u"°C"

a = Fluid(p, t)
println(a)

b = Fluid(p, a.massSpecificEnthalpy)
println(b)

end
