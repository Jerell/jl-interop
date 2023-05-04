module Fluids

using CoolProp, Unitful

const Pressure = Quantity{Float64,dimension(u"bar"),typeof(u"bar")}
const Temperature = Quantity{Float64,dimension(u"°C"),typeof(u"°C")}
const MassFlowrate = Quantity{Float64,dimension(u"kg/s"),typeof(u"kg/s")}
const Viscosity = Quantity{Float64,dimension(u"m^3 / kg"),typeof(u"m^3 / kg")}
const Density = Quantity{Float64,dimension(u"kg/m^3"),typeof(u"kg/m^3")}
const MassSpecificEnthalpy = Quantity{Float64,dimension(u"J/kg"),typeof(u"J/kg")}
const MassSpecificEntropy = Quantity{Float64,dimension(u"J/kg/K"),typeof(u"J/kg/K")}

compositions = Dict("96%CO2" => "REFPROP::CarbonDioxide[0.969696970]&Hydrogen[0.010101010]&Nitrogen[0.010101010]&Argon[0.009090909]&CarbonMonoxide[0.001010101]", "100%CO2" => "CarbonDioxide[1.0]")

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
        PropsSI("V", "P", p, "T", t, compositions["100%CO2"]),
        PropsSI("D", "P", p, "T", t, compositions["100%CO2"]),
        PropsSI("H", "P", p, "T", t, compositions["100%CO2"]),
        PropsSI("S", "P", p, "T", t, compositions["100%CO2"]),
        PropsSI("Phase", "P", p, "T", t, compositions["100%CO2"]),
    )

    Fluid(p::Pressure, h::MassSpecificEnthalpy) = new(
        p,
        PropsSI("T", "P", p, "H", h, compositions["100%CO2"]),
        PropsSI("V", "P", p, "H", h, compositions["100%CO2"]),
        PropsSI("D", "P", p, "H", h, compositions["100%CO2"]),
        PropsSI("H", "P", p, "H", h, compositions["100%CO2"]),
        PropsSI("S", "P", p, "H", h, compositions["100%CO2"]),
        PropsSI("Phase", "P", p, "H", h, compositions["100%CO2"]),
    )
end


p = 10.0u"bar"
p2 = 8.0u"bar"
t = 20.0u"°C"

a = Fluid(p, t)
println(a)

b = Fluid(p2, a.massSpecificEnthalpy)
println(b)

end
