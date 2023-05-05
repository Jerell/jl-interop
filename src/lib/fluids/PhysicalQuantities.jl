module PhysicalQuantities

using Unitful

const Pressure = Quantity{Float64,dimension(u"bar"),typeof(u"bar")}
const Temperature = Quantity{Float64,dimension(u"°C"),typeof(u"°C")}
const MassFlowrate = Quantity{Float64,dimension(u"kg/s"),typeof(u"kg/s")}
const Viscosity = Quantity{Float64,dimension(u"m^3 / kg"),typeof(u"m^3 / kg")}
const Density = Quantity{Float64,dimension(u"kg/m^3"),typeof(u"kg/m^3")}
const MassSpecificEnthalpy = Quantity{Float64,dimension(u"J/kg"),typeof(u"J/kg")}
const MassSpecificEntropy = Quantity{Float64,dimension(u"J/kg/K"),typeof(u"J/kg/K")}

export Pressure,
    Temperature,
    MassFlowrate,
    Viscosity,
    Density,
    MassSpecificEnthalpy,
    MassSpecificEntropy

end