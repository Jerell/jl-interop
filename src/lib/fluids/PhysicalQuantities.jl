module PhysicalQuantities

using Unitful

pq(ustring) = Quantity{Float64,dimension(ustring),typeof(ustring)}

const Pressure = pq(u"bar")
const Temperature = pq(u"°C")
const MassFlowrate = pq(u"kg/s")
const Viscosity = pq(u"m^3 / kg")
const Density = pq(u"kg/m^3")
const MassSpecificEnthalpy = pq(u"J/kg")
const MassSpecificEntropy = pq(u"J/kg/K")

export Pressure,
    Temperature,
    MassFlowrate,
    Viscosity,
    Density,
    MassSpecificEnthalpy,
    MassSpecificEntropy

end